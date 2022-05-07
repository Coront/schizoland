AddCSLuaFile()

SWEP.PrintName = "Hands"
SWEP.Base = "fas2_base_melee"
SWEP.Spawnable = false
SWEP.Slot = 1
SWEP.Category = "FA:S 2 Weapons - Melee"

SWEP.VM = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_grenade.mdl"

SWEP.Drawn = false
SWEP.HoldType = "normal"

SWEP.Anims = {}
SWEP.Anims.Draw_First = "idle"
SWEP.Anims.Draw = "idle"
SWEP.Anims.Holster = "fists_holster"
SWEP.Anims.Slash = {"fists_left", "fists_right"}
SWEP.Anims.Idle = "fists_idle_01"

SWEP.Sounds = {}
SWEP.Sounds.Swing = "weapons/slam/throw.wav"
SWEP.Sounds.HitWall = {
	"physics/body/body_medium_impact_hard1.wav",
	"physics/body/body_medium_impact_hard2.wav",
	"physics/body/body_medium_impact_hard3.wav",
	"physics/body/body_medium_impact_hard4.wav",
	"physics/body/body_medium_impact_hard5.wav",
	"physics/body/body_medium_impact_hard6.wav",
}
SWEP.Sounds.Hit = {
	"physics/body/body_medium_impact_hard1.wav",
	"physics/body/body_medium_impact_hard2.wav",
	"physics/body/body_medium_impact_hard3.wav",
	"physics/body/body_medium_impact_hard4.wav",
	"physics/body/body_medium_impact_hard5.wav",
	"physics/body/body_medium_impact_hard6.wav",
}

SWEP.Damage = 11
SWEP.HitRange = 70
SWEP.NextSwing = 0.75
SWEP.ImpactDelay = 0.1

function SWEP:Deploy()
	if self.Drawn then
		FAS2_PlayAnim( self, "fists_draw" )
	end

	return true
end

function SWEP:PrimaryAttack()	
	if not IsFirstTimePredicted() then return end

	if self.Drawn then

		CT = CurTime()

		local anim = istable(self.Anims.Slash) and table.Random(self.Anims.Slash) or self.Anims.Slash

		if CLIENT and self.Wep then
			self.Wep:SetCycle(0)
			self.Wep:SetSequence(anim)
			self.Wep:SetPlaybackRate(1)
		end

		self:SetNextPrimaryFire(CT + self.NextSwing)
		self.DamageWait = CT + self.ImpactDelay
		self.Attacking = true

		self.Owner:SetAnimation(PLAYER_ATTACK1)
		self.AttackType = "slash"

		self.DamageAmount = self.Damage * (1 + (self:GetOwner():GetSkillLevel("strength") * SKL.Strength.dmgmultinc))
		if SERVER then
			self.Owner:EmitSound(self.Sounds.Swing)
		end

	else

		local trace = util.TraceLine({
            start = self.Owner:EyePos(),
            endpos = self.Owner:EyePos() + self.Owner:EyeAngles():Forward() * 150,
            filter = self.Owner,
        })
        local ent = trace.Entity
		
		if ent:GetObjectOwner() == self.Owner then
			local ply = self.Owner
			self:SetNextPrimaryFire( CurTime() + 1 )
			if SERVER then
				if ent:GetClass() != "prop_vehicle_jeep" and ent:GetClass() != "prop_door_rotating" and ent:GetClass() != "func_door_rotating" and ent:GetClass() != "func_door" then return end
				ent:EmitSound("doors/door_locked2.wav")
				ent:Fire( "lock", "", 0 )
				if ent.VC_SeatTable and ent:IsVehicle() then
					for _, seat in pairs( ent.VC_SeatTable ) do
						seat.Locked = true
					end
				end
				ply:ChatPrint("Locked.")
			end

			if CLIENT then
				local seq = ply:LookupSequence("gesture_item_place")
				ply:AddVCDSequenceToGestureSlot( 0, seq, 0, true )
			end
		end

	end
end

function SWEP:SecondaryAttack()
	if self.Drawn then return end

	local trace = util.TraceLine({
		start = self.Owner:EyePos(),
		endpos = self.Owner:EyePos() + self.Owner:EyeAngles():Forward() * 150,
		filter = self.Owner,
	})
	local ent = trace.Entity
	
	if ent:GetObjectOwner() == self.Owner then
		local ply = self.Owner
		self:SetNextSecondaryFire( CurTime() + 1 )
		if SERVER then
			if ent:GetClass() != "prop_vehicle_jeep" and ent:GetClass() != "prop_door_rotating" and ent:GetClass() != "func_door_rotating" and ent:GetClass() != "func_door" then return end
			ent:EmitSound("doors/door_latch3.wav")
			ent:Fire( "unlock", "", 0 )
			if ent.VC_SeatTable and ent:IsVehicle() then
				for _, seat in pairs( ent.VC_SeatTable ) do
					seat.Locked = false
				end
			end
			ply:ChatPrint("Unlocked.")
		end

		if CLIENT then
			local seq = ply:LookupSequence("gesture_item_place")
			ply:AddVCDSequenceToGestureSlot( 0, seq, 0, true )
		end
	end
end

function SWEP:Reload()
	if not IsFirstTimePredicted() then return end
	if CurTime() < (self.NextToggle or 0) then return end
	self.NextToggle = CurTime() + 1

	self:ToggleDrawn()
end

function SWEP:ToggleDrawn()
	if self.Drawn then
		self.Drawn = false
		self.HoldType = "normal"
		FAS2_PlayAnim( self, "fists_holster" )
	else
		self.Drawn = true
		self.HoldType = "fist"
		FAS2_PlayAnim( self, "fists_draw" )
	end
end