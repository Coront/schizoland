AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_junk/cardboard_box003a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:GetPhysicsObject():Wake()
end

function ENT:Use( ply )
	self:Remove()
	if self:GetScrap() > 0 then
		ply:AddItemToInventory( "misc_scrap", self:GetScrap() )
	end
	if self:GetSmallParts() > 0 then
		ply:AddItemToInventory( "misc_smallparts", self:GetSmallParts() )
	end
	if self:GetChemicals() > 0 then
		ply:AddItemToInventory( "misc_chemical", self:GetChemicals() )
	end
	ply:EmitSound("entities/resources_" .. math.random( 1, 3 ) .. ".wav")

	ply:ChatPrint("You have picked up " .. self:GetScrap() .. " Scrap, " .. self:GetSmallParts() .. " Small Parts, " .. self:GetChemicals() .. " Chemicals from this package.")

	plogs.PlayerLog(ply, "Items", ply:NameID() .. " picked up a resource pack ( " .. self:GetScrap() .. " Scrap, " .. self:GetSmallParts() .. " Small Parts, " .. self:GetChemicals() .. " Chemicals )", {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
        ["Amt"]	= self:GetScrap() .. " | " .. self:GetSmallParts() .. " | " .. self:GetChemicals(),
    })
end