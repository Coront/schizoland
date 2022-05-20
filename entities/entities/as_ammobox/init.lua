AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "menu.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/items/ammocrate_smg1.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
end

function ENT:Use( ply )
	if not self:GetPlayers()[ply:SteamID()] then
		net.Start("as_ammobox_open")
			net.WriteEntity( self )
		net.Send(ply)
	else
		ply:ChatPrint("You have already redeemed your ammo resupply and cannot take any more.")
	end
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString( "as_ammobox_open" )
util.AddNetworkString( "as_ammobox_take" )

net.Receive("as_ammobox_take", function( _, ply )
	local ent = net.ReadEntity()
	if not ent:GetClass() == "as_ammobox" then return end
	if ply:GetPos():Distance(ent:GetPos()) > 300 then return end

	local ammo = net.ReadString()
	if not ent.Items[ammo] then ply:ChatPrint( "This isn't a selectable item." ) return end

	if ent:GetPlayers()[ply:SteamID()] then ply:ChatPrint("You have already redeemed your ammo resupply.") return end

	ent:AddPlayer( ply:SteamID() )
	ply:AddItemToInventory( ammo, ent.Amount )
	ply:ChatPrint("You have taken " .. AS.Items[ammo].name .. " (" .. ent.Amount .. ") from the resupply box.")

	plogs.PlayerLog(ply, "Items", ply:NameID() .. " took " .. AS.Items[ammo].name .. " (" .. ent.Amount .. ") from a resupply box.", {
		["Name"] 	= ply:Name(),
		["SteamID"]	= ply:SteamID(),
		["Item"]	= AS.Items[ammo].name .. " (" .. ent.Amount .. ")",
	})
end)