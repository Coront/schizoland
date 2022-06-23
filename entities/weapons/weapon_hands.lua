AddCSLuaFile()

SWEP.PrintName = "Hands"
SWEP.Base = "fas2_base_melee"
SWEP.Spawnable = false
SWEP.Slot = 1
SWEP.Category = "FA:S 2 Weapons - Melee"

SWEP.VM = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_grenade.mdl"

SWEP.HoldType = "normal"

SWEP.Anims = {}
SWEP.Anims.Draw = "idle"
SWEP.Anims.Holster = "fists_holster"
SWEP.Anims.Slash = {"fists_left", "fists_right"}
SWEP.Anims.Idle = "fists_idle_01"

SWEP.Sounds = {}
SWEP.Sounds.Swing = "weapons/slam/throw.wav"
SWEP.Sounds.Hit = {}
SWEP.Sounds.Hit["Default"] = {
	"physics/body/body_medium_impact_hard1.wav",
	"physics/body/body_medium_impact_hard2.wav",
	"physics/body/body_medium_impact_hard3.wav",
	"physics/body/body_medium_impact_hard4.wav",
	"physics/body/body_medium_impact_hard5.wav",
	"physics/body/body_medium_impact_hard6.wav",
}
SWEP.Sounds.HitLocal = true

SWEP.Damage = 11
SWEP.HitRange = 70
SWEP.NextSwing = 0.75
SWEP.ImpactDelay = 0.1

SWEP.NoIdleRefresh = true

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

	self.Drawn = false
end

function SWEP:Deploy()
	if self.Drawn then
		FAS2_PlayAnim( self, "fists_draw" )
	end

	return true
end

function SWEP:PrimaryAttack()	
	CT = CurTime()
	if CT < self:GetNextPrimaryFire() then return end

	if self.Drawn then

		local anim = istable(self.Anims.Slash) and table.Random(self.Anims.Slash) or self.Anims.Slash

		if IsFirstTimePredicted() then
			self.DamageWait = CT + self.ImpactDelay
			self.Attacking = true

			self.Owner:SetAnimation(PLAYER_ATTACK1)
			self.AttackType = "slash"

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

	else

		local trace = util.TraceLine({
            start = self.Owner:EyePos(),
            endpos = self.Owner:EyePos() + self.Owner:EyeAngles():Forward() * 150,
            filter = self.Owner,
        })
        local ent = trace.Entity
		
		if ent:GetObjectOwner() == self:GetOwner() or ent.CoOwners and ent.CoOwners[self:GetOwner()] then
			local ply = self.Owner
			self:SetNextPrimaryFire( CurTime() + 1 )
			if IsFirstTimePredicted() then
				if ent:GetClass() != "prop_vehicle_jeep" and ent:GetClass() != "prop_door_rotating" and ent:GetClass() != "func_door_rotating" and ent:GetClass() != "func_door" then return end
				if SERVER then
					ent:EmitSound("doors/door_locked2.wav")
					ent:Fire( "lock", "", 0 )
					if ent.VC_SeatTable and ent:IsVehicle() then
						for _, seat in pairs( ent.VC_SeatTable ) do
							seat.Locked = true
						end
					end
					ply:ChatPrint("Locked.")
				elseif CLIENT then
					local seq = ply:LookupSequence("gesture_item_place")
					ply:AddVCDSequenceToGestureSlot( 0, seq, 0, true )
				end
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

	if ent:GetObjectOwner() == self:GetOwner() or ent.CoOwners and ent.CoOwners[self:GetOwner()] then
		local ply = self.Owner
		self:SetNextSecondaryFire( CurTime() + 1 )
		if ent:GetClass() != "prop_vehicle_jeep" and ent:GetClass() != "prop_door_rotating" and ent:GetClass() != "func_door_rotating" and ent:GetClass() != "func_door" then return end
		if SERVER then
			ent:EmitSound("doors/door_latch3.wav")
			ent:Fire( "unlock", "", 0 )
			if ent.VC_SeatTable and ent:IsVehicle() then
				for _, seat in pairs( ent.VC_SeatTable ) do
					seat.Locked = false
				end
			end
			ply:ChatPrint("Unlocked.")
		elseif CLIENT then
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
		self:SetDrawn( false )
	else
		self:SetDrawn( true )
	end

	if ( SERVER ) then
		self:UpdateState()
	end
end

function SWEP:SetDrawn( bool )
	if not bool then
		self.Drawn = false
		self.HoldType = "normal"
		FAS2_PlayAnim( self, "fists_holster" )
	else
		self.Drawn = true
		self.HoldType = "fist"
		FAS2_PlayAnim( self, "fists_draw" )
	end

	if ( SERVER ) then
		self:UpdateState()
	end
end

-- Networking

if ( SERVER ) then

	util.AddNetworkString("aswep_hands_updatestate")

	function SWEP:UpdateState()
		net.Start("aswep_hands_updatestate")
			net.WriteEntity( self )
			net.WriteBit( self.Drawn )
		net.Broadcast()
	end

elseif ( CLIENT ) then

	net.Receive("aswep_hands_updatestate", function()
		local ent = net.ReadEntity()
		local state = tobool(net.ReadBit())
		if not IsValid(ent) then return end

		ent:SetDrawn( state )
	end)

end