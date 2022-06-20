AddCSLuaFile()

SWEP.PrintName = "Stunstick"
SWEP.Base = "fas2_base_melee"
SWEP.Spawnable = true 
SWEP.Slot = 1
SWEP.Category = "FA:S 2 Weapons - Melee"
SWEP.ASID = "wep_stun"

SWEP.VM = "models/weapons/v_stunstick.mdl"
SWEP.WM = "models/weapons/w_stunbaton.mdl"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.ViewModelFOV = 50

SWEP.WMAng = Vector( 90, 0, 0 )
SWEP.WMPos = Vector( 1, -6, -4 )

SWEP.HoldType = "melee"

SWEP.Anims = {}
SWEP.Anims.Draw = "draw"
SWEP.Anims.Idle = "idle01"
SWEP.Anims.Holster = "holster"
SWEP.Anims.SlashMiss = {
	"misscenter1",
	"misscenter2"
}
SWEP.Anims.Slash = {
	"hitcenter1",
	"hitcenter2",
	"hitcenter3",
}

SWEP.Sounds = {}
SWEP.Sounds.Swing = "weapons/stunstick/stunstick_swing1.wav"
SWEP.Sounds.Hit = {}
SWEP.Sounds.Hit["Default"] = {
	"weapons/stunstick/stunstick_fleshhit1.wav",
	"weapons/stunstick/stunstick_fleshhit2.wav",
}

SWEP.Damage = 20
SWEP.HitRange = 75
SWEP.NextSwing = 1
SWEP.ImpactDelay = 0.1
SWEP.StatusEffects = {
	["stunned"] = 1.5,
}