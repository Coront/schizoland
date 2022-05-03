AddCSLuaFile()

SWEP.PrintName = "Katana"
SWEP.Base = "fas2_base_melee"
SWEP.Spawnable = true 
SWEP.Slot = 1
SWEP.Category = "FA:S 2 Weapons - Melee"
SWEP.ASID = "wep_katana"

SWEP.VM = "models/weapons/v_katana.mdl"
SWEP.WM = "models/items/weapons/katana.mdl"
SWEP.WorldModel = "models/items/weapons/katana.mdl"
SWEP.ViewModelFOV = 55

SWEP.WMAng = Vector(90, 0, 120)
SWEP.WMPos = Vector(2, -6, 2.5)

SWEP.HoldType = "melee2"

SWEP.Anims = {}
SWEP.Anims.Draw_First = "draw"
SWEP.Anims.Draw = "draw"
SWEP.Anims.Holster = "holster"
SWEP.Anims.Slash = "hitkill1"
SWEP.Anims.Idle = "idle_01"

SWEP.Sounds = {}
SWEP.Sounds.Swing = "weapons/knife/knife_slash1.wav"
SWEP.Sounds.HitWall = "weapons/knife/knife_hitwall1.wav"
SWEP.Sounds.Hit = {
	"physics/flesh/flesh_impact_bullet1.wav",
	"physics/flesh/flesh_impact_bullet2.wav",
	"physics/flesh/flesh_impact_bullet3.wav",
	"physics/flesh/flesh_impact_bullet4.wav",
	"physics/flesh/flesh_impact_bullet5.wav",
}

SWEP.Damage = 27
SWEP.HitRange = 90
SWEP.NextSwing = 1.2
SWEP.ImpactDelay = 0.15