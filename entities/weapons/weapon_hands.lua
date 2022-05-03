AddCSLuaFile()

SWEP.PrintName = "Hands"
SWEP.Base = "fas2_base_melee"
SWEP.Spawnable = false
SWEP.Slot = 1
SWEP.Category = "FA:S 2 Weapons - Melee"

SWEP.VM = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_grenade.mdl"

SWEP.HoldType = "fist"

SWEP.Anims = {}
SWEP.Anims.Draw_First = "fists_draw"
SWEP.Anims.Draw = "fists_draw"
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