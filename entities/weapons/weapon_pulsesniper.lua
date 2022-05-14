AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Pulse Sniper"
    SWEP.Slot = 3
    SWEP.SlotPos = 0

	SWEP.AimPos = Vector(-6.3,-10,-6)
	SWEP.AimAng = Vector(0, 0, 0)

	SWEP.Shell = "7.62x39"

	SWEP.WMAng = Vector(0, 180, 180)
	SWEP.WMPos = Vector(0.2, -16.9, 1.1)

	SWEP.ScopeMat = "ph_scope/ph_scope_lens4"
end

SWEP.ASID = "wep_pulsesniper"

SWEP.Tracer = "AR2Tracer"

SWEP.BulletLength = 7.62
SWEP.CaseLength = 39
SWEP.EmptySound = Sound("weapons/empty_assaultrifles.wav")

SWEP.Anims = {}
SWEP.Anims.Draw_First = "idle"
SWEP.Anims.Draw = "idle"
SWEP.Anims.Draw_Empty = "idle"
SWEP.Anims.Holster = "idle"
SWEP.Anims.Fire = "fire"
SWEP.Anims.Fire_Aiming = "fire"
SWEP.Anims.Idle = "idle"
SWEP.Anims.Idle_Aim = "idle"
SWEP.Anims.Reload = "reload"
SWEP.Anims.Reload_Nomen = "reload"
SWEP.Anims.Reload_Empty = "reload"
SWEP.Anims.Reload_Empty_Nomen = "reload"

SWEP.Sounds = {}
SWEP.Sounds["reload"] = {
	[1] = {time = 0.5, sound = Sound("weapons/ar2/ar2_reload_rotate.wav")},
	[2] = {time = 1.2, sound = Sound("weapons/ar2/ar2_reload_push.wav")},
}

SWEP.FireModes = {"semi"}

SWEP.Category = "FA:S 2 Weapons"
SWEP.Base = "fas2_base"
SWEP.Author            = "Spy"

SWEP.Contact        = ""
SWEP.Purpose        = ""

SWEP.ViewModelFOV    = 60
SWEP.ViewModelFlip    = false

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true

SWEP.VM = "models/weapons/v_pulsesniper.mdl"
SWEP.WM = "models/items/weapons/pulsesniper.mdl"
SWEP.WorldModel   = "models/items/weapons/pulsesniper.mdl"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 10
SWEP.Primary.DefaultClip    = 0
SWEP.Primary.Automatic       = false 
SWEP.Primary.Ammo             = "striderminigun"

-- Secondary Fire Attributes --
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo         = "none"

-- Deploy related
SWEP.FirstDeployTime = 0.45
SWEP.DeployTime = 0.8
SWEP.DeployAnimSpeed = 0.5

-- Firing related
SWEP.Shots = 1
SWEP.ConsumePerShot = 2
SWEP.FireDelay = 60/60
SWEP.Damage = 55
SWEP.DamageType = DMG_ENERGYBEAM
SWEP.FireSound = "npc/sniper/echo1.wav"
SWEP.FireSound_Suppressed = Sound("FAS2_AK47_S")

-- Accuracy related
SWEP.HipCone = 0.081
SWEP.AimCone = 0.003
SWEP.SpreadPerShot = 0.025
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadCooldown = 0.18
SWEP.AimFOV = 80

-- Recoil related
SWEP.Recoil = 1.8
SWEP.RecoilHorizontal = 1.5

-- Reload related
SWEP.ReloadTime = 2.4
SWEP.ReloadTime_Nomen = 2.2
SWEP.ReloadTime_Empty = 3.3
SWEP.ReloadTime_Empty_Nomen = 3
SWEP.CantChamber = true