AddCSLuaFile()

SWEP.Base = "fas2_base"
SWEP.Slot = 1

if CLIENT then
    SWEP.PrintName = "fas2_base_melee"
    SWEP.Slot = 0
    SWEP.SlotPos = 0

	SWEP.WMAng = Vector( 0, 0, 0 )
	SWEP.WMPos = Vector( 0, 0, 0 )

	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(0, 0, 0)
	SWEP.MoveType = 3
	SWEP.MuzzleName = "2"
	SWEP.NoNearWall = true
end

SWEP.HoldType = "fist"
SWEP.RunHoldType = "fist"
SWEP.NoProficiency = true
SWEP.NoAttachmentMenu = true

SWEP.Sounds = {}
SWEP.FireModes = {"semi"}

SWEP.Spawnable            = false
SWEP.AdminSpawnable        = true

SWEP.Author            = ""

SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions    = ""
SWEP.DrawWeaponInfoBox = false

SWEP.ViewModelFOV    = 50
SWEP.ViewModelFlip    = false

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
SWEP.FirstDeployTime = 0
SWEP.DeployTime = 0
SWEP.HolsterTime = 0
SWEP.DeployAnimSpeed = 1

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

        if not self.W_Wep and self.WM then
			self.W_Wep = self:createManagedCModel(self.WM, RENDERGROUP_BOTH)
			self.W_Wep:SetNoDraw(true)
		end

	end
end

function SWEP:Reload()
	return
end

local Mins, Maxs = Vector(0, -15, -1), Vector(0, 15, 1)

local isply, isnpc, ang

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

SWEP.DrawTime = 1
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
		td.endpos = td.start + force * self.HitRange
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
                        local snd = self.Sounds.Hit and self.Sounds.Hit[tr.MatType] and table.Random(self.Sounds.Hit[tr.MatType]) or table.Random(self.Sounds.Hit["Default"])
						snd = Sound( snd )
						sound.Play( snd, tr.HitPos, 75, 100, 1 )
					end
					hit = true
					if tr.MatType == MAT_FLESH or tr.MatType == MAT_ANTLION or tr.MatType == MAT_ALIENFLESH or tr.MatType == MAT_BLOODYFLESH then
						cl = ClassToParticle[ent:GetClass()]
						ParticleEffect((cl and cl or "blood_impact_red_01"), tr.HitPos, tr.HitNormal:Angle(), ent)
					end
					self:GetOwner():IncreaseSkillExperience( "strength", SKL.Strength.incamt )
					if ent:IsPlayer() and self.StatusEffects and SERVER then
						for k, v in pairs( self.StatusEffects ) do
							ent:AddStatus( k, v )
						end
						ent:ResyncStatuses()
					end
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
                        local snd = self.Sounds.Hit and self.Sounds.Hit[tr.MatType] and table.Random(self.Sounds.Hit[tr.MatType]) or table.Random(self.Sounds.Hit["Default"])
						snd = Sound( snd )
						if self.Sounds.HitLocal then
							self.Owner:EmitSound( snd, 100, 100, 1, CHAN_WEAPON)
						else
							sound.Play( snd, tr.HitPos, 75, 100, 1 )
						end
					end
				end
			end
			if tr.HitWorld then
				if SERVER then
					local snd = self.Sounds.Hit and self.Sounds.Hit[tr.MatType] and table.Random(self.Sounds.Hit[tr.MatType]) or table.Random(self.Sounds.Hit["Default"])
					snd = Sound( snd )
					if self.Sounds.HitLocal then
						self.Owner:EmitSound( snd, 100, 100, 1, CHAN_WEAPON)
					else
						sound.Play( snd, tr.HitPos, 75, 100, 1 )
					end
				end
			end
		end
	end

	if CT > (self.NextIdle or 0) and self.Wep and not self.NoIdleRefresh then
		self.Wep:SetCycle(0)
		self.Wep:SetSequence(self.Anims.Idle)
		self.Wep:SetPlaybackRate(1)
	end
end

function SWEP:PrimaryAttack()
	CT = CurTime()
	if CT < self:GetNextPrimaryFire() then return end
	
	local trace = util.TraceHull({
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:EyeAngles():Forward() * self.HitRange,
		filter = self.Owner,
		mins = Mins,
		maxs = Maxs,
	})

	local anim
	if trace.Hit then
		anim = istable(self.Anims.Slash) and table.Random(self.Anims.Slash) or self.Anims.Slash
	else
		anim = istable(self.Anims.SlashMiss) and table.Random(self.Anims.SlashMiss) or self.Anims.SlashMiss
	end

	if IsFirstTimePredicted() then
		self.DamageWait = CT + self.ImpactDelay
		self.Attacking = true

		self.Owner:SetAnimation(PLAYER_ATTACK1)
		self.AttackType = "slash"

		self.NextIdle = CT + (self.ImpactDelay + 0.4)

		if (SERVER) then
			self.Owner:EmitSound(self.Sounds.Swing)
		elseif (CLIENT) and self.Wep then
			self.Wep:SetCycle(0)
			self.Wep:SetSequence(anim)
			self.Wep:SetPlaybackRate(1)
		end

		self.DamageAmount = self.Damage * (1 + (self:GetOwner():GetSkillLevel("strength") * SKL.Strength.dmgmultinc))
	end
	self:SetNextPrimaryFire(CT + self.NextSwing)
end

function SWEP:SecondaryAttack()	
	return
end

if CLIENT then
	function SWEP:DrawHUD() return end
end
