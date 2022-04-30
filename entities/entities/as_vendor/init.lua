AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "menu.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_interiors/vendingmachinesoda01a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
end

function ENT:Use( ply )
	local profiles = ply:FetchVendorProfiles()
	net.Start( "as_vendor_open" )
		net.WriteEntity( self )
		net.WriteTable( profiles )
	net.Send( ply )
end

-- ██████╗ ██████╗  ██████╗ ███████╗██╗██╗     ███████╗███████╗
-- ██╔══██╗██╔══██╗██╔═══██╗██╔════╝██║██║     ██╔════╝██╔════╝
-- ██████╔╝██████╔╝██║   ██║█████╗  ██║██║     █████╗  ███████╗
-- ██╔═══╝ ██╔══██╗██║   ██║██╔══╝  ██║██║     ██╔══╝  ╚════██║
-- ██║     ██║  ██║╚██████╔╝██║     ██║███████╗███████╗███████║
-- ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

function PlayerMeta:FetchVendorProfiles()
	local query = sql.Query("SELECT * FROM as_vendors WHERE pid = " .. self.pid .. " AND deleted IS NULL")
	query = query or {}
	return query
end

function PlayerMeta:EstablishVendorProfile( name )
	sql.Query("INSERT INTO as_vendors VALUES ( NULL, " .. self.pid .. ", " .. SQLStr( name ) .. ", NULL, NULL, NULL )")
	self:ChatPrint("New profile established: " .. name)
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_vendor_open")
util.AddNetworkString("as_vendor_createprofile")
util.AddNetworkString("as_vendor_deleteprofile")
util.AddNetworkString("as_vendor_setprofile")

net.Receive( "as_vendor_createprofile", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	local name = net.ReadString()

	if ent:GetClass() != "as_vendor" then return end
	if ent:GetObjectOwner() != ply then return end
	if string.len( name ) <= 2 then ply:ChatPrint("Your profile name is not long enough.") return end
	for k, v in pairs(SET.BannedWords) do
        if string.find(name:lower(), v) then ply:Kick("Inappropriate name usage") return end
    end

	local profiles = ply:FetchVendorProfiles()

	if #profiles <= 0 then --First profile is always free.
		ply:EstablishVendorProfile( name )
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
		ply:EstablishVendorProfile( name )
	end
end)

net.Receive( "as_vendor_setprofile", function( _, ply ) 
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if ent:GetClass() != "as_vendor" then return end
	if ent:GetObjectOwner() != ply then return end

	local vid = net.ReadInt( 32 )
	local profile = sql.Query("SELECT * FROM as_vendors WHERE vid = " .. vid)[1]
	if tonumber(profile.pid) != ply.pid then ply:ChatPrint("You do not own this profile.") return end

	ply:ChatPrint("You have loaded the profile: " .. profile.name)
end)