AddCSLuaFile()

SWEP.PrintName = "Knife"
SWEP.Base = "fas2_base_melee"
SWEP.Spawnable = true 
SWEP.Slot = 1
SWEP.Category = "FA:S 2 Weapons - Melee"
SWEP.ASID = "wep_knife"

SWEP.VM = "models/weapons/v_knife_t.mdl"
SWEP.WM = "models/weapons/w_knife_ct.mdl"
SWEP.WorldModel = "models/weapons/w_knife_ct.mdl"
SWEP.ViewModelFOV = 70

SWEP.WMAng = Vector( 0, 0, 180 )
SWEP.WMPos = Vector( -1, -0.4, 1.5 )

SWEP.HoldType = "knife"

SWEP.Anims = {}
SWEP.Anims.Draw_First = "draw"
SWEP.Anims.Draw = "draw"
SWEP.Anims.Holster = "idle"
SWEP.Anims.Slash = "midslash1"
SWEP.Anims.Idle = "idle_cycle"

SWEP.Sounds = {}
SWEP.Sounds.Swing = "weapons/knife/knife_slash1.wav"
SWEP.Sounds.HitWall = "weapons/knife/knife_hitwall1.wav"
SWEP.Sounds.Hit = {
	"weapons/knife/knife_hit1.wav",
	"weapons/knife/knife_hit2.wav",
	"weapons/knife/knife_hit3.wav",
	"weapons/knife/knife_hit4.wav",
}

SWEP.Damage = 18
SWEP.HitRange = 75
SWEP.NextSwing = 0.75
SWEP.ImpactDelay = 0.1