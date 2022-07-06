AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "menu.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props/cs_office/Crates_indoor.mdl" )
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
        net.Start("as_stockpile_open")
            net.WriteEntity( self )
        net.Send( ply )

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
						net.Start("as_stockpile_open")
                            net.WriteEntity( self )
                        net.Send( ply )

                        if ply:InCommunity() and CurTime() > (ply.NextWarRequest or 0) then
                            community.CreateDiplomacy( self:GetCommunity(), "war", {
                                cid = ply:GetCommunity(),
                                cname = ply:GetCommunityName(),
                                text = "The community, " .. ply:GetCommunityName() .. ", has committed an act of war!\n\n" .. ply:Nickname() .. " broke into the community stockpile on " .. os.date( "%m/%d/%y - %I:%M %p", os.time() ) .. ".",
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
			net.Start("as_stockpile_open")
                net.WriteEntity( self )
            net.Send( ply )

            if ply:InCommunity() and CurTime() > (ply.NextWarRequest or 0) then
                community.CreateDiplomacy( self:GetCommunity(), "war", {
                    cid = ply:GetCommunity(),
                    cname = ply:GetCommunityName(),
                    text = "The community, " .. ply:GetCommunityName() .. ", has committed an act of war!\n\n" .. ply:Nickname() .. " broke into the community stockpile on " .. os.date( "%m/%d/%y - %I:%M %p", os.time() ) .. ".",
                })
                ply:ChatPrint("You have committed an act of war.")
                ply.NextWarRequest = CurTime() + 900
            end

            self:EmitSound( self.Sounds.Access, 60 )
		end

        plogs.PlayerLog(ply, "Entities", ply:NameID() .. " interacted with a community stockpile (" .. self:GetCommunityName() .. ")", {
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

function ENT:DataTableCheck()
    local data = sql.Query( "SELECT * FROM as_communities_storage WHERE cid = " .. self:GetCommunity() )
    if not data then
        sql.Query( "INSERT INTO as_communities_storage VALUES ( " .. self:GetCommunity() .. ", NULL, NULL )" )
    else
        local res = sql.QueryValue( "SELECT res FROM as_communities_storage WHERE cid = " .. self:GetCommunity() )
        res = util.JSONToTable( res )

        self:SetResources( res )
    end
end

function ENT:SaveResources()
    sql.Query( "UPDATE as_communities_storage SET res = " .. SQLStr( util.TableToJSON( self:GetResources(), true ) ) .. " WHERE cid = " .. self:GetCommunity() )
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_stockpile_open")
util.AddNetworkString("as_stockpile_addresource")
util.AddNetworkString("as_stockpile_takeresource")
util.AddNetworkString("as_stockpile_hide")

net.Receive("as_stockpile_addresource", function( _, ply )
    local ent = net.ReadEntity()
    if not IsValid( ent ) then return end
    if ent:GetClass() != "as_community_stockpile" then return end
    if ply:GetPos():Distance(ent:GetPos()) > 300 then ply:ChatPrint("You are too far away.") return end
    if ent:GetCommunity() != ply:GetCommunity() and not ent.Broken then ply:ChatPrint("Unable to store.") return end

    if not ply:Alive() then return end

    local scrap = net.ReadUInt( NWSetting.ItemAmtBits )
    if scrap < 0 then scrap = 0 end
    if scrap > ply:GetItemCount( "misc_scrap" ) then scrap = ply:GetItemCount( "misc_scrap" ) end

    local smallp = net.ReadUInt( NWSetting.ItemAmtBits )
    if smallp < 0 then smallp = 0 end
    if smallp > ply:GetItemCount( "misc_smallparts" ) then smallp = ply:GetItemCount( "misc_smallparts" ) end
    
    local chem = net.ReadUInt( NWSetting.ItemAmtBits )
    if chem < 0 then chem = 0 end
    if chem > ply:GetItemCount( "misc_chemical" ) then chem = ply:GetItemCount( "misc_chemical" ) end

    if scrap > 0 then
        ent:PlayerAddResource( ply, "misc_scrap", scrap )
        ply:ChatPrint( "Stored " .. scrap .. " " .. AS.Items["misc_scrap"].name .. ".")
    end
    if smallp > 0 then
        ent:PlayerAddResource( ply, "misc_smallparts", smallp )
        ply:ChatPrint( "Stored " .. smallp .. " " .. AS.Items["misc_smallparts"].name .. ".")
    end
    if chem > 0 then
        ent:PlayerAddResource( ply, "misc_chemical", chem )
        ply:ChatPrint( "Stored " .. chem .. " " .. AS.Items["misc_chemical"].name .. ".")
    end

    ent:QuickPlayRandomSound( ent.Sounds.Manage, 55 )
end)

net.Receive("as_stockpile_takeresource", function( _, ply ) 
    local ent = net.ReadEntity()
    if not IsValid( ent ) then return end
    if ent:GetClass() != "as_community_stockpile" then return end
    if ply:GetPos():Distance( ent:GetPos() ) > 300 then ply:ChatPrint("You are too far away.") return end
    if ent:GetCommunity() != ply:GetCommunity() and not ent.Broken then ply:ChatPrint("Unable to withdraw.") return end

    if not ply:Alive() then return end

    local scrap = net.ReadUInt( NWSetting.ItemAmtBits )
    if scrap < 0 then scrap = 0 end
    if scrap > ent:GetResourceAmount( "misc_scrap" ) then scrap = ent:GetResourceAmount( "misc_scrap" ) end

    local smallp = net.ReadUInt( NWSetting.ItemAmtBits )
    if smallp < 0 then smallp = 0 end
    if smallp > ent:GetResourceAmount( "misc_smallparts" ) then smallp = ent:GetResourceAmount( "misc_smallparts" ) end

    local chem = net.ReadUInt( NWSetting.ItemAmtBits )
    if chem < 0 then chem = 0 end
    if chem > ent:GetResourceAmount( "misc_chemical" ) then chem = ent:GetResourceAmount( "misc_chemical" ) end

    if scrap > 0 then
        ent:PlayerTakeResource( ply, "misc_scrap", scrap )
        ply:ChatPrint( "Withdrew " .. scrap .. " " .. AS.Items["misc_scrap"].name .. ".")
    end
    if smallp > 0 then
        ent:PlayerTakeResource( ply, "misc_smallparts", smallp )
        ply:ChatPrint( "Withdrew " .. smallp .. " " .. AS.Items["misc_smallparts"].name .. ".")
    end
    if chem > 0 then
        ent:PlayerTakeResource( ply, "misc_chemical", chem )
        ply:ChatPrint( "Withdrew " .. chem .. " " .. AS.Items["misc_chemical"].name .. ".")
    end

    ent:QuickPlayRandomSound( ent.Sounds.Manage, 55 )
end)

net.Receive("as_stockpile_hide", function( _, ply )
    local ent = net.ReadEntity()
    if not IsValid( ent ) then return end
    if ent:GetClass() != "as_community_stockpile" then return end
    if ply:GetPos():Distance( ent:GetPos() ) > 300 then ply:ChatPrint("You are too far away.") return end
    if ent:GetCommunity() != ply:GetCommunity() then ply:ChatPrint("This is not your community's stockpile.") return end
    if ent.Hiding then ply:ChatPrint("This is already actively being hidden.") return end

    ply:ChatPrint("You are actively hiding the stockpile. It will take 60 seconds to despawn.")
    ent.Hiding = true
    timer.Simple( 60, function()
        if IsValid(ent) then
            ent:Remove()
        end
    end)
end)