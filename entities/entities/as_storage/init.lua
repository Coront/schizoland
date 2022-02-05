AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

util.AddNetworkString( "as_storage_open" )

function ENT:Initialize()
	self:SetModel( "models/Items/ammocrate_ar2.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
end

function ENT:Use( ply )
    net.Start( "as_storage_open" )
		net.WriteEntity(self)
	net.Send( ply )
end