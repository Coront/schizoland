AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_trainstation/trainstation_clock001.mdl" )
	self:SetMaterial( "models/debug/debugwhite" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )

	self.Enabled = false
end

function ENT:Use( ply )
	if not self.Enabled and ply:IsAdmin() then
		self.Enabled = true 
		ply:ChatPrint("You have enabled this checkpoint. Players will now automatically respawn here.")
		self:EmitSound("buttons/blip1.wav")
		self:SetColor( Color( 45, 150, 0 ) )
	end
end