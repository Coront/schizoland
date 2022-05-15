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
SWEP.ViewModelFOV = 50

SWEP.WMAng = Vector(90, 0, 120)
SWEP.WMPos = Vector(2, -6, 2.5)

SWEP.HoldType = "melee2"

SWEP.Anims = {}
SWEP.Anims.Draw = "draw"
SWEP.Anims.Idle = "idle01"
SWEP.Anims.Holster = "holster"
SWEP.Anims.SlashMiss = {
	"misscenter1",
	"misscenter2",
}
SWEP.Anims.Slash = {
	"hitcenter1",
	"hitcenter2",
	"hitcenter3",
}

SWEP.Sounds = {}
SWEP.Sounds.Swing = "weapons/knife/knife_slash1.wav"
SWEP.Sounds.Hit = {}
SWEP.Sounds.Hit[MAT_FLESH] = {
	"physics/flesh/flesh_impact_bullet1.wav",
	"physics/flesh/flesh_impact_bullet2.wav",
	"physics/flesh/flesh_impact_bullet3.wav",
	"physics/flesh/flesh_impact_bullet4.wav",
	"physics/flesh/flesh_impact_bullet5.wav",
}
SWEP.Sounds.Hit[MAT_CONCRETE] = {
	"physics/concrete/concrete_impact_bullet1.wav",
	"physics/concrete/concrete_impact_bullet2.wav",
	"physics/concrete/concrete_impact_bullet3.wav",
	"physics/concrete/concrete_impact_bullet4.wav",
}
SWEP.Sounds.Hit[MAT_SAND] = {
	"physics/surfaces/sand_impact_bullet1.wav",
	"physics/surfaces/sand_impact_bullet2.wav",
	"physics/surfaces/sand_impact_bullet3.wav",
	"physics/surfaces/sand_impact_bullet4.wav",
}
SWEP.Sounds.Hit[MAT_DIRT] = SWEP.Sounds.Hit[MAT_SAND]
SWEP.Sounds.Hit[MAT_GRASS] = SWEP.Sounds.Hit[MAT_SAND]
SWEP.Sounds.Hit[MAT_GLASS] = {
	"physics/glass/glass_impact_bullet1.wav",
	"physics/glass/glass_impact_bullet2.wav",
	"physics/glass/glass_impact_bullet3.wav",
	"physics/glass/glass_impact_bullet4.wav",
}
SWEP.Sounds.Hit[MAT_TILE] = {
	"physics/surfaces/tile_impact_bullet1.wav",
	"physics/surfaces/tile_impact_bullet2.wav",
	"physics/surfaces/tile_impact_bullet3.wav",
	"physics/surfaces/tile_impact_bullet4.wav",
}
SWEP.Sounds.Hit[MAT_METAL] = {
	"physics/metal/metal_solid_impact_bullet1.wav",
	"physics/metal/metal_solid_impact_bullet2.wav",
	"physics/metal/metal_solid_impact_bullet3.wav",
	"physics/metal/metal_solid_impact_bullet4.wav",
}
SWEP.Sounds.Hit[MAT_WOOD] = {
	"physics/wood/wood_solid_impact_bullet1.wav",
	"physics/wood/wood_solid_impact_bullet2.wav",
	"physics/wood/wood_solid_impact_bullet3.wav",
	"physics/wood/wood_solid_impact_bullet4.wav",
	"physics/wood/wood_solid_impact_bullet5.wav",
}
SWEP.Sounds.Hit[MAT_GRATE] = {
	"physics/metal/metal_chainlink_impact_hard1.wav",
	"physics/metal/metal_chainlink_impact_hard2.wav",
	"physics/metal/metal_chainlink_impact_hard3.wav",
}
SWEP.Sounds.Hit["Default"] = SWEP.Sounds.Hit[MAT_FLESH]

SWEP.Damage = 27
SWEP.HitRange = 90
SWEP.NextSwing = 1.2
SWEP.ImpactDelay = 0.1