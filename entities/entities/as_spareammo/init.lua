AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Initialize()
	--self:SetModel( "models/hunter/blocks/cube025x025x025.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:GetPhysicsObject():Wake()
end

function ENT:Use( ply )
	self:Remove()
	ply:GiveAmmo( self:GetAmmoAmount(), self:GetAmmoType(), true )
	ply:ChatPrint("Equipped " .. AS.Items[translateAmmoNameID( self:GetAmmoType() )].name .. " (" .. self:GetAmmoAmount() .. ")")

	plogs.PlayerLog(ply, "Items", ply:NameID() .. " picked up unboxed ammo " .. AS.Items[translateAmmoNameID(self:GetAmmoType())].name .. " (" .. self:GetAmmoAmount() .. ")", {
		["Name"] 	= ply:Name(),
		["SteamID"]	= ply:SteamID(),
		["Item"]	= AS.Items[translateAmmoNameID(self:GetAmmoType())].name .. " (" .. self:GetAmmoAmount() .. ")",
	})
end