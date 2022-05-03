AddCSLuaFile()

SWEP.PrintName = "Crowbar"
SWEP.Base = "fas2_base_melee"
SWEP.Spawnable = true 
SWEP.Slot = 1
SWEP.Category = "FA:S 2 Weapons - Melee"
SWEP.ASID = "wep_crowbar"

SWEP.VM = "models/weapons/v_crowbar.mdl"
SWEP.WM = "models/weapons/w_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.ViewModelFOV = 50

SWEP.WMAng = Vector( 90, 0, 150 )
SWEP.WMPos = Vector( 1, -4, 3.5 )

SWEP.HoldType = "melee"

SWEP.Anims = {}
SWEP.Anims.Draw_First = "draw"
SWEP.Anims.Draw = "draw"
SWEP.Anims.Holster = "idle01"
SWEP.Anims.Slash = {
	"misscenter1",
	"misscenter2",
}
SWEP.Anims.Idle = "idle01"

SWEP.Sounds = {}
SWEP.Sounds.Swing = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.Sounds.HitWall = "weapons/crowbar/crowbar_impact1.wav"
SWEP.Sounds.Hit = {
	"physics/flesh/flesh_impact_bullet1.wav",
	"physics/flesh/flesh_impact_bullet2.wav",
	"physics/flesh/flesh_impact_bullet3.wav",
	"physics/flesh/flesh_impact_bullet4.wav",
	"physics/flesh/flesh_impact_bullet5.wav",
}

SWEP.Damage = 24
SWEP.HitRange = 80
SWEP.NextSwing = 0.9
SWEP.ImpactDelay = 0.15