AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_buildings/watertower_001c.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
end

function ENT:Use( ply )
	if ply:GetThirst() < 100 then
		local length = ply.Status and ply.Status["poison"] and (ply.Status["poison"].time - CurTime()) + 5 or 5
		ply:AddStatus( "poison", length )
		ply:AddThirst( 15 )
		ply:ResyncSatiation()
		ply:ResyncStatuses()
		ply:EmitSound( "npc/barnacle/barnacle_gulp1.wav" )
	end
end