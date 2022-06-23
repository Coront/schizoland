AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "menu.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props/CS_militia/footlocker01_closed.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:GetPhysicsObject():EnableMotion( false )

    self.Broken = false
    self:DataTableCheck()
end

function ENT:Use( ply )
	if self:GetCommunity() == ply:GetCommunity() then
		net.Start("as_cstorage_open")
			net.WriteEntity( self )
		net.Send(ply)
		self:EmitSound( self.Sounds.Access, 60 )
	else
		if not self.Broken then
			if not ply.Breaking then
				ply.Breaking = true
				self:EmitSound(self.Sounds.BreakInto, 150)
				ply:StartTimedEvent( 20, true, function()
					ply.Breaking = false
					if IsValid( self ) then
						self.Broken = true
						self:EmitSound(self.Sounds.Broken, 100)
						net.Start("as_cstorage_open")
                            net.WriteEntity( self )
                        net.Send( ply )

                        if ply:InCommunity() and CurTime() > (ply.NextWarRequest or 0) then
                            community.CreateDiplomacy( self:GetCommunity(), "war", {
                                cid = ply:GetCommunity(),
                                cname = ply:GetCommunityName(),
                                text = "The community, " .. ply:GetCommunityName() .. ", has committed an act of war!\n\n" .. ply:Nickname() .. " broke into the community locker on " .. os.date( "%m/%d/%y - %I:%M %p", os.time() ) .. ".",
                            })
                            ply:ChatPrint("You have committed an act of war.")
                            ply.NextWarRequest = CurTime() + 900
                        end
					end
				end)
			else
				ply.Breaking = false 
				ply:CancelTimedEvent()
			end
		else
			net.Start("as_cstorage_open")
				net.WriteEntity( self )
			net.Send( ply )

            if ply:InCommunity() and CurTime() > (ply.NextWarRequest or 0) then
                community.CreateDiplomacy( self:GetCommunity(), "war", {
                    cid = ply:GetCommunity(),
                    cname = ply:GetCommunityName(),
                    text = "The community, " .. ply:GetCommunityName() .. ", has committed an act of war!\n\n" .. ply:Nickname() .. " broke into the community locker on " .. os.date( "%m/%d/%y - %I:%M %p", os.time() ) .. ".",
                })
                ply:ChatPrint("You have committed an act of war.")
                ply.NextWarRequest = CurTime() + 900
            end

            self:EmitSound( self.Sounds.Access, 60 )
		end

		plogs.PlayerLog(ply, "Entities", ply:NameID() .. " interacted with a community storage (" .. self:GetCommunityName() .. ")", {
			["Name"] 	= ply:Name(),
			["SteamID"]	= ply:SteamID(),
		})
	end
end

function ENT:QuickPlayRandomSound( tbl, vol )
	local snd = table.Random(tbl)
	self:EmitSound( snd, vol )
end

-- ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗
-- ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝
-- ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗
-- ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝
-- ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗
-- ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝

if ( SERVER ) then

    function ENT:DataTableCheck()
        local data = sql.Query( "SELECT * FROM as_communities_storage WHERE cid = " .. self:GetCommunity() )
        if not data then
            sql.Query( "INSERT INTO as_communities_storage VALUES ( " .. self:GetCommunity() .. ", NULL, NULL )" )
        else
            local inv = sql.QueryValue( "SELECT inv FROM as_communities_storage WHERE cid = " .. self:GetCommunity() )
            inv = util.JSONToTable( inv )

            self:SetInventory( inv )
        end
    end

    function ENT:SaveInventory()
        sql.Query( "UPDATE as_communities_storage SET inv = " .. SQLStr( util.TableToJSON( self:GetInventory(), true ) ) .. " WHERE cid = " .. self:GetCommunity() )
    end

end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString( "as_cstorage_open" )
util.AddNetworkString( "as_cstorage_deposititem" )
util.AddNetworkString( "as_cstorage_withdrawitem" )
util.AddNetworkString( "as_cstorage_hide" )

net.Receive( "as_cstorage_deposititem", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then ply:ResyncInventory() ent:ResyncInventory() return end
	if ent:GetClass() != "as_community_storage" then ply:ResyncInventory() ent:ResyncInventory() return end
	if ent:GetCommunity() != ply:GetCommunity() and not ent.Broken then ply:ResyncInventory() ent:ResyncInventory() return end
	if ent:GetPos():Distance(ply:GetPos()) > 300 then ply:ChatPrint("You're too far to deposit.") ply:ResyncInventory() ent:ResyncInventory() return end


	local item = net.ReadString()
	local amt = net.ReadUInt( NWSetting.ItemAmtBits )
	if amt <= 0 then amt = 1 end
	if amt > ply:GetItemCount( item ) then amt = ply:GetItemCount( item ) end
	if amt == 0 then ply:ChatPrint("You dont have this.") ply:ResyncInventory() ent:ResyncInventory() return end

	if not ent:CanStoreItem( ply, item, amt ) then return end

	ent:QuickPlayRandomSound( ent.Sounds.Manage, 55 )
	ent:PlayerStoreItem( ply, item, amt )
end)

net.Receive( "as_cstorage_withdrawitem", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then ply:ResyncInventory() ent:ResyncInventory() return end
	if ent:GetClass() != "as_community_storage" then ply:ResyncInventory() ent:ResyncInventory() return end
	if ent:GetCommunity() != ply:GetCommunity() and not ent.Broken then ply:ResyncInventory() ent:ResyncInventory() return end
	if ent:GetPos():Distance(ply:GetPos()) > 300 then ply:ChatPrint("You're too far to withdraw.") ply:ResyncInventory() ent:ResyncInventory() return end

	local item = net.ReadString()
	local amt = net.ReadUInt( NWSetting.ItemAmtBits )
	if amt <= 0 then amt = 1 end
	if amt > ent:GetItemCount( item ) then amt = ent:GetItemCount( item ) end
	if amt == 0 then ply:ChatPrint("Item doesn't exist in locker.") ply:ResyncInventory() ent:ResyncInventory() return end

	if not ent:CanWithdrawItem( ply, item, amt ) then return end

	ent:QuickPlayRandomSound( ent.Sounds.Manage, 55 )
	ent:PlayerTakeItem( ply, item, amt )
end)

net.Receive("as_cstorage_hide", function( _, ply )
    local ent = net.ReadEntity()
    if not IsValid( ent ) then return end
    if ent:GetClass() != "as_community_storage" then return end
    if ply:GetPos():Distance( ent:GetPos() ) > 300 then ply:ChatPrint("You are too far away.") return end
    if ent:GetCommunity() != ply:GetCommunity() then ply:ChatPrint("This is not your community's storage.") return end
    if ent.Hiding then ply:ChatPrint("This is already actively being hidden.") return end

    ply:ChatPrint("You are actively hiding the storage. It will take 60 seconds to despawn.")
    ent.Hiding = true
    timer.Simple( 60, function()
        if IsValid(ent) then
            ent:Remove()
        end
    end)
end)