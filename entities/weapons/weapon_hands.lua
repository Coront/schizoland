AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Hands"
    SWEP.Slot = 0
    SWEP.SlotPos = 0
	
	SWEP.AimPos = Vector(-3.412, -6.4, -2.238)
	SWEP.AimAng = Vector(7.353, 0, 0)
		
	SWEP.WMAng = Vector(0, 180, 180)
	SWEP.WMPos = Vector(1, -3, 0.25)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(0, 0, 0)
	SWEP.MoveType = 3
	SWEP.MuzzleName = "2"
	SWEP.NoNearWall = true
end

SWEP.HoldType = "fist"
SWEP.RunHoldType = "fist"
SWEP.NoProficiency = true
SWEP.BulletLength = 7.62
SWEP.CaseLength = 39
SWEP.EmptySound = Sound("weapons/empty_assaultrifles.wav")
SWEP.NoAttachmentMenu = true
SWEP.UseHands = true

SWEP.Anims = {}
SWEP.Anims.Draw_First = "fists_draw"
SWEP.Anims.Draw = "fists_draw"
SWEP.Anims.Holster = "fists_holster"
SWEP.Anims.Slash = {"fists_left", "fists_right"}
SWEP.Anims.Stab = {"stab_1", "stab_1"}
SWEP.Anims.Idle = "fists_idle_01"
SWEP.Anims.Idle_Aim = "fists_idle_01"
SWEP.Anims.PrepBackstab = "backstab_draw"
SWEP.Anims.UnPrepBackstab = "backstab_holster"
SWEP.Anims.Backstab = "backstab_stab"

SWEP.Sounds = {}
SWEP.FireModes = {"semi"}

SWEP.Category = "FA:S 2 Weapons"
SWEP.Base = "fas2_base"
SWEP.Author            = "Spy"

SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions    = "PRIMARY ATTACK KEY - Slash\nSECONDARY ATTACK KEY - Stab"

SWEP.ViewModelFOV    = 50
SWEP.ViewModelFlip    = false

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true

SWEP.VM = "models/weapons/c_arms_citizen.mdl"
SWEP.WM = "models/weapons/w_dv2.mdl"
SWEP.WorldModel   = "models/weapons/w_dv2.mdl"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic       = true
SWEP.Primary.Ammo             = ""

-- Secondary Fire Attributes --
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic       = false
SWEP.Secondary.Ammo         = "none"

-- Deploy related
SWEP.FirstDeployTime = 1
SWEP.DeployTime = 1
SWEP.HolsterTime = 0.7
SWEP.DeployAnimSpeed = 1

SWEP.BackstabWait = 0
SWEP.DamageWait = 0 
local nade, EA, pos, mag, CT, tr, force, phys, pos, vel, ent, dmg, tr2
local td = {}

local SP = game.SinglePlayer()

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	self.Class = self:GetClass()
	
	if CLIENT then
		self.BlendPos = Vector(0, 0, 0)
		self.BlendAng = Vector(0, 0, 0)
		
		self.NadeBlendPos = Vector(0, 0, 0)
		self.NadeBlendAng = Vector(0, 0, 0)
		self.ViewModelFOV_Orig = self.ViewModelFOV
		
		if not self.Wep then
			self.Wep = self:createManagedCModel(self.VM, RENDERGROUP_BOTH)
			self.Wep:SetNoDraw(true)
		end

		self:Deploy()
	end
end

function SWEP:Reload()
	return
end

local BackStabExclusions = {["npc_antlionguard"] = true,
	["npc_antlion"] = true,
	["npc_antlionguardian"] = true,
	["npc_antlion_worker"] = true,
	["npc_barnacle"] = true,
	["npc_fastzombie_torso"] = true,
	["npc_headcrab"] = true,
	["npc_headcrab_black"] = true,
	["npc_headcrab_fast"] = true,
	["npc_zombie_torso"] = true,
	["npc_cscanner"] = true,
	["npc_clawscanner"] = true,
	["npc_combinegunship"] = true,
	["npc_combine_camera"] = true,
	["npc_manhack"] = true,
	["npc_hunter"] = true,
	["npc_helicopter"] = true,
	["npc_combinedropship"] = true,
	["npc_rollermine"] = true,
	["npc_strider"] = true,
	["npc_turret_floor"] = true,
	["npc_crow"] = true,
	["npc_pigeon"] = true,
	["npc_seagull"] = true}
	
local Mins, Maxs = Vector(-4, -4, -4), Vector(4, 4, 4)

local isply, isnpc, ang

function SWEP:CanBackstab()
	return false
end

--[[
blood_impact_antlion_01
blood_impact_antlion_worker
blood_impact_green_01
blood_impact_red_01
blood_impact_synth_01
blood_impact_yellow_01
blood_impact_zombie_01
]]--

local ClassToParticle = {
	["npc_antlionguard"] = "blood_impact_antlion_01",
	["npc_antlionguardian"] = "blood_impact_green_01",
	["npc_antlion"] = "blood_impact_antlion_01",
	["npc_antlion_worker"] = "blood_impact_antlion_worker",
	["npc_zombie"] = "blood_impact_zombie_01",
	["npc_zombine"] = "blood_impact_zombie_01",
	["npc_poisonzombie"] = "blood_impact_zombie_01",
	["npc_fastzombie_torso"] = "blood_impact_zombie_01",
	["npc_zombie_torso"] = "blood_impact_zombie_01",
	["npc_fastzombie"] = "blood_impact_zombie_01",
	["npc_headcrab"] = "blood_impact_green_01",
	["npc_headcrab_black"] = "blood_impact_green_01",
	["npc_headcrab_fast"] = "blood_impact_green_01",
	["npc_vortigaunt"] = "blood_impact_zombie_01"
}

for k, v in pairs(ClassToParticle) do
	PrecacheParticleSystem(v)
end

local cl, hit, ef

function SWEP:Think()
	CT = CurTime()

	if self.CurSoundTable then
		t = self.CurSoundTable[self.CurSoundEntry]
		
		if CT >= self.SoundTime + t.time / self.SoundSpeed then
			self:EmitSound(t.sound, 70, 100)
			
			if self.CurSoundTable[self.CurSoundEntry + 1] then
				self.CurSoundEntry = self.CurSoundEntry + 1
			else
				self.CurSoundTable = nil
				self.CurSoundEntry = nil
				self.SoundTime = nil
			end
		end
	end
	
	if self.DrawTime and CT > self.DrawTime then
		FAS2_PlayAnim(self, self.Anims.Draw)
		self.DrawTime = nil
	end
	
	if CT > self.DamageWait and self.Attacking then
		self.Attacking = false

		force = self.Owner:EyeAngles():Forward()
		
		td.start = self.Owner:GetShootPos()
		td.endpos = td.start + force * 80
		td.filter = self.Owner
		td.mins = Mins
		td.maxs = Maxs
		
		tr = util.TraceHull(td)

		if tr.Hit then
			hit = false
			ent = tr.Entity
			
			if IsValid(ent) then
				if (ent:IsNextBot() or ent:IsNPC() or ent:IsPlayer()) and ent:Health() > 0 then
					if SERVER then
						dmg = DamageInfo()
						dmg:SetDamageType(DMG_SLASH)
						dmg:SetDamage(self.DamageAmount)
						
						dmg:SetAttacker(self.Owner)
						dmg:SetInflictor(self)
						dmg:SetDamageForce(force * 500)
						ent:TakeDamageInfo(dmg)
						self:GetOwner():EmitSound("physics/body/body_medium_impact_hard" .. math.random( 1, 6 ) .. ".wav", 70, 100)
					end
					hit = true
					if tr.MatType == MAT_FLESH or tr.MatType == MAT_ANTLION or tr.MatType == MAT_ALIENFLESH or tr.MatType == MAT_BLOODYFLESH then
						cl = ClassToParticle[ent:GetClass()]
						ParticleEffect((cl and cl or "blood_impact_red_01"), tr.HitPos, tr.HitNormal:Angle(), ent)
					end
					self:GetOwner():IncreaseSkillExperience( "strength", SKL.Strength.incamt )
				else
					hit = true
					tr2 = self.Owner:GetEyeTrace() -- separate trace for the decal, because decals don't like util.TraceHull :(

					if SERVER then
						dmg = DamageInfo()
						dmg:SetDamageType(DMG_SLASH)
						dmg:SetDamage(self.DamageAmount)
							
						dmg:SetAttacker(self.Owner)
						dmg:SetInflictor(self)
						dmg:SetDamageForce(force * 500)
						ent:TakeDamageInfo(dmg)
						self:GetOwner():EmitSound("physics/body/body_medium_impact_hard" .. math.random( 1, 6 ) .. ".wav", 70, 100)
					end
					
				end
			end
			if tr.HitWorld then
				if SERVER then
					self:GetOwner():EmitSound("physics/body/body_medium_impact_hard" .. math.random( 1, 6 ) .. ".wav", 70, 100)
				end
			end
		end
	end
end

function SWEP:PrimaryAttack()	
	if not IsFirstTimePredicted() then return end
	CT = CurTime()

	FAS2_PlayAnim(self, self.Anims.Slash, 1)
	self:SetNextPrimaryFire(CT + 0.9)
	self.DamageWait = CT + 0.17
	self.Attacking = true

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.AttackType = "slash"

	self.DamageAmount = 11 * (1 + (self:GetOwner():GetSkillLevel("strength") * SKL.Strength.dmgmultinc))
	self:EmitSound("weapons/slam/throw.wav")
end

function SWEP:SecondaryAttack()	
	return
end

if CLIENT then
	function SWEP:DrawHUD() return end
end
