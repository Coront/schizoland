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
SWEP.Sounds.Swing = "weapons/iceaxe/iceaxe_swing1.wav"
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

SWEP.Damage = 24
SWEP.HitRange = 80
SWEP.NextSwing = 0.9
SWEP.ImpactDelay = 0.05