AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/Items/item_item_crate.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
end

function ENT:Use( ply )
	if not self:GetPlayers()[ply:SteamID()] then
		self:AddPlayer( ply:SteamID() )
		if self:GetScrap() > 0 then
			ply:AddItemToInventory( "misc_scrap", self:GetScrap() )
		end
		if self:GetSmallParts() > 0 then
			ply:AddItemToInventory( "misc_smallparts", self:GetSmallParts() )
		end
		if self:GetChemical() > 0 then
			ply:AddItemToInventory( "misc_chemical", self:GetChemical() )
		end
		ply:EmitSound("entities/resources_" .. math.random( 1, 3 ) .. ".wav")
		ply:ChatPrint("You have collected " .. self:GetScrap() .. " Scrap, " .. self:GetSmallParts() .. " Small Parts, " .. self:GetChemical() .. " Chemicals from this reward box.")

		plogs.PlayerLog(ply, "Items", ply:NameID() .. " took " .. self:GetScrap() .. " Scrap, " .. self:GetSmallParts() .. " Small Parts, " .. self:GetChemical() .. " Chemicals from a resource reward box.", {
			["Name"] 	= ply:Name(),
			["SteamID"]	= ply:SteamID(),
		})
	else
		ply:ChatPrint("You have already redeemed your resources and cannot take any more.")
	end
end