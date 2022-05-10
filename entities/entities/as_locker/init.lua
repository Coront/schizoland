AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "menu.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_c17/Lockers001a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )

	self.Broken = false
end

function ENT:Use( ply )
	local profiles = ply:FetchLockerProfiles()

	if self:GetObjectOwner() == ply then
		net.Start( "as_locker_open" )
			net.WriteEntity( self )
			net.WriteTable( profiles )
		net.Send( ply )

		self:EmitSound( self.Sounds.Access, 60 )
	else
		if self:GetProfile() == 0 then
			ply:ChatPrint("This storage doesn't have a set profile yet, therefore there is nothing to break into.")
			return
		end

		if not self.Broken then
			if not ply.Breaking then
				ply.Breaking = true
				self:EmitSound(self.Sounds.BreakInto, 150)
				ply:StartTimedEvent( 20, true, function()
					ply.Breaking = false
					if IsValid( self ) then
						self.Broken = true
						self:EmitSound(self.Sounds.Broken, 100)
						net.Start( "as_locker_open" )
							net.WriteEntity( self )
							net.WriteTable( profiles )
						net.Send( ply )
					end
				end)
			else
				ply.Breaking = false 
				ply:CancelTimedEvent()
			end
		else
			net.Start( "as_locker_open" )
				net.WriteEntity( self )
				net.WriteTable( profiles )
			net.Send( ply )
		end
	end
end

function ENT:QuickPlayRandomSound( tbl, vol )
	local snd = table.Random(tbl)
	self:EmitSound( snd, vol )
end

-- ██████╗ ██████╗  ██████╗ ███████╗██╗██╗     ███████╗███████╗
-- ██╔══██╗██╔══██╗██╔═══██╗██╔════╝██║██║     ██╔════╝██╔════╝
-- ██████╔╝██████╔╝██║   ██║█████╗  ██║██║     █████╗  ███████╗
-- ██╔═══╝ ██╔══██╗██║   ██║██╔══╝  ██║██║     ██╔══╝  ╚════██║
-- ██║     ██║  ██║╚██████╔╝██║     ██║███████╗███████╗███████║
-- ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

function PlayerMeta:FetchLockerProfiles()
	local query = sql.Query("SELECT * FROM as_lockers WHERE pid = " .. self.pid .. " AND deleted IS NULL")
	query = query or {}
	return query
end

function PlayerMeta:EstablishLockerProfile( name )
	sql.Query("INSERT INTO as_lockers VALUES ( NULL, " .. self.pid .. ", " .. SQLStr( name ) .. ", NULL, NULL )")
	self:ChatPrint("New profile established: " .. name)
end

function PlayerMeta:DeleteLockerProfile( lockerid )
	sql.Query("UPDATE as_lockers SET deleted = " .. SQLStr( os.date( "%m/%d/%y - %I:%M %p", os.time() ) ) .. " WHERE lid = " .. lockerid)
	self:ChatPrint("Deleted profile (" .. lockerid .. ")")
end

function PlayerMeta:RenameLockerProfile( lockerid, name )
	sql.Query("UPDATE as_lockers SET name = " .. SQLStr( name ) .. " WHERE lid = " .. lockerid)
	self:ChatPrint("Renamed profile to " .. name .. " (" .. lockerid .. ")")
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_locker_open")
util.AddNetworkString("as_locker_createprofile")
util.AddNetworkString("as_locker_deleteprofile")
util.AddNetworkString("as_locker_renameprofile")
util.AddNetworkString("as_locker_setprofile")
--util.AddNetworkString("as_locker_unloadprofile")
util.AddNetworkString("as_locker_invtolocker")
util.AddNetworkString("as_locker_lockertoinv")

net.Receive( "as_locker_createprofile", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	local name = net.ReadString()

	if ent:GetClass() != "as_locker" then return end
	if ent:GetObjectOwner() != ply then return end
	if string.len( name ) <= 2 then ply:ChatPrint("Your profile name is not long enough.") return end
	for k, v in pairs(SET.BannedWords) do
        if string.find(name:lower(), v) then ply:Kick("Inappropriate name usage") return end
    end
	if ent:GetPos():Distance(ply:GetPos()) > 300 then ply:ChatPrint("You're too far to manage this.") return end

	local profiles = ply:FetchLockerProfiles()

	if #profiles <= 0 then --First profile is always free.
		ply:EstablishLockerProfile( name )
	else --Players will have to pay a price for making more.
		for k, v in pairs( ent.ProfileCost ) do
			if not ply:HasInInventory( k, v ) then
				ply:ChatPrint("You do not have enough " .. AS.Items[k].name .. " to make a profile.")
				return
			end
		end

		for k, v in pairs( ent.ProfileCost ) do
			ply:TakeItemFromInventory( k, v )
		end

		ply:EstablishLockerProfile( name )
	end
end)

net.Receive( "as_locker_deleteprofile", function( _, ply ) 
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	local lid = net.ReadInt( 32 )

	if ent:GetClass() != "as_locker" then return end
	if ent:GetObjectOwner() != ply then return end
	if ent:GetPos():Distance(ply:GetPos()) > 300 then ply:ChatPrint("You're too far to manage this.") return end

	local profile = sql.QueryValue("SELECT pid FROM as_lockers WHERE lid = " .. lid)
	if tonumber(profile) != ply.pid then ply:ChatPrint("This is not your profile.") return end

	for k, v in pairs( ents.FindByClass("as_locker") ) do
		if v:GetProfile() == lid then
			v:SetProfile( 0, "" )
			v:SetInventory( {} )
		end
	end

	ply:DeleteLockerProfile( lid )
end)

net.Receive( "as_locker_renameprofile", function( _, ply ) 
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	local name = net.ReadString()

	if ent:GetClass() != "as_locker" then return end
	if ent:GetObjectOwner() != ply then return end
	if string.len( name ) <= 2 then ply:ChatPrint("Your profile name is not long enough.") return end
	for k, v in pairs(SET.BannedWords) do
        if string.find(name:lower(), v) then ply:Kick("Inappropriate name usage") return end
    end
	if ent:GetPos():Distance(ply:GetPos()) > 300 then ply:ChatPrint("You're too far to manage this.") return end

	local lockerid = ent:GetProfile()
	if lockerid == 0 then ply:ChatPrint("No profile.") return end
	local profile = sql.QueryValue("SELECT pid FROM as_lockers WHERE lid = " .. lockerid)
	if tonumber(profile) != ply.pid then ply:ChatPrint("This is not your profile.") return end

	ply:RenameLockerProfile( lockerid, name )
	ent:SetProfile( lockerid, name )
end)

net.Receive( "as_locker_setprofile", function( _, ply ) 
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if ent:GetClass() != "as_locker" then return end
	if ent:GetObjectOwner() != ply then return end
	if ent:GetProfile() != 0 then ply:ChatPrint("This locker already has a profile selected.") return end
	if ent:GetPos():Distance(ply:GetPos()) > 300 then ply:ChatPrint("You're too far to manage this.") return end

	local lid = net.ReadInt( 32 )
	local profile = sql.Query("SELECT * FROM as_lockers WHERE lid = " .. lid)[1]
	if tonumber(profile.pid) != ply.pid then ply:ChatPrint("You do not own this profile.") return end
	if profile.deleted != "NULL" then ply:ChatPrint("This profile is deleted.") return end
	for k, v in pairs( ents.FindByClass("as_lockers") ) do
		if v:GetProfile() == lid then
			ply:ChatPrint("A locker with this profile is already active.")
			return
		end
	end

	local inv = profile.items == "NULL" and {} or util.JSONToTable( profile.items )

	ply:ChatPrint("You have loaded the profile: " .. profile.name)
	ent:SetProfile( lid, profile.name )
	ent:SetInventory( inv )
end)

--[[
net.Receive( "as_locker_unloadprofile", function( _, ply ) 
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if ent:GetClass() != "as_locker" then return end
	if ent:GetObjectOwner() != ply then return end
	if ent:GetProfile() == 0 then ply:ChatPrint("No profile to unload.") return end

	ply:ChatPrint("You have unloaded this locker's profile.")
	ent:SetProfile( 0, "" )
	ent:SetInventory( {} )
end)
]]

net.Receive( "as_locker_invtolocker", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then ply:ResyncInventory() ent:ResyncInventory() return end
	if ent:GetClass() != "as_locker" then ply:ResyncInventory() ent:ResyncInventory() return end
	if ent:GetObjectOwner() != ply and not ent.Broken then ply:ResyncInventory() ent:ResyncInventory() return end
	if ent:GetProfile() == 0 then ply:ChatPrint("No profile active.") ply:ResyncInventory() ent:ResyncInventory() return end
	if ent:GetPos():Distance(ply:GetPos()) > 300 then ply:ChatPrint("You're too far to deposit.") ply:ResyncInventory() ent:ResyncInventory() return end

	local item = net.ReadString()
	local amt = net.ReadInt( 32 )
	if amt <= 0 then amt = 1 end
	if amt > ply:GetItemCount( item ) then amt = ply:GetItemCount( item ) end
	if amt == 0 then ply:ChatPrint("You dont have this.") ply:ResyncInventory() ent:ResyncInventory() return end

	if not ent:CanStoreItem( ply, item, amt ) then return end

	ent:QuickPlayRandomSound( ent.Sounds.Manage, 55 )
	ent:StoreItem( ply, item, amt )
end)

net.Receive( "as_locker_lockertoinv", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then ply:ResyncInventory() ent:ResyncInventory() return end
	if ent:GetClass() != "as_locker" then ply:ResyncInventory() ent:ResyncInventory() return end
	if ent:GetObjectOwner() != ply and not ent.Broken then ply:ResyncInventory() ent:ResyncInventory() return end
	if ent:GetProfile() == 0 then ply:ChatPrint("No profile active.") ply:ResyncInventory() ent:ResyncInventory() return end
	if ent:GetPos():Distance(ply:GetPos()) > 300 then ply:ChatPrint("You're too far to withdraw.") ply:ResyncInventory() ent:ResyncInventory() return end

	local item = net.ReadString()
	local amt = net.ReadInt( 32 )
	if amt <= 0 then amt = 1 end
	if amt > ent:GetItemCount( item ) then amt = ent:GetItemCount( item ) end
	if amt == 0 then ply:ChatPrint("Item doesn't exist in locker.") ply:ResyncInventory() ent:ResyncInventory() return end

	if not ent:CanWithdrawItem( ply, item, amt ) then return end

	ent:QuickPlayRandomSound( ent.Sounds.Manage, 55 )
	ent:WithdrawItem( ply, item, amt )
end)