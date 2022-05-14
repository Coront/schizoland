AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel("models/props_junk/wood_crate001a_chunk05.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self.FireActive = false
	self.FireSound = "ambient/fire/mtov_flame2.wav"
	self:StartFire()
end

function ENT:StartFire()
	if self.FireActive then return end --Fire has already been created.
	self.FireActive = true
	self:EmitSound(self.FireSound)

	self.fire = ents.Create("env_fire")
	self.fire:SetPos( self:GetPos() + Vector( 0, 0, 0 ) )
	self.fire:SetKeyValue("firesize", "30")
	self.fire:SetKeyValue("firetype", "0")
	self.fire:SetKeyValue("LoopSound", "ambient/fire/fire_small_loop1.wav")
	self.fire:Fire("StartFire")
	self.fire:Spawn()
	self.fire:Activate()
	self.fire:SetParent(self)

	self:EmitSound("ambient/fire/fire_med_loop1.wav", 55)
end

function ENT:OnRemove()
	self.fire:Remove()
	self:StopSound("ambient/fire/fire_med_loop1.wav")
end