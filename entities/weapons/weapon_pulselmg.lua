AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Pulse LMG"
    SWEP.Slot = 3
    SWEP.SlotPos = 0

	SWEP.AimPos = Vector(-2.201, -4.646, 0.675)
	SWEP.AimAng = Vector(0.264, 0, 0)

	SWEP.Shell = "7.62x39"

	SWEP.WMAng = Vector(180, -90, 0)
	SWEP.WMPos = Vector(16.5, 0.5, 1)
	SWEP.CrosshairShow = true
end

SWEP.ASID = "wep_pulselmg"

SWEP.Tracer = "AR2Tracer"

SWEP.BulletLength = 7.62
SWEP.CaseLength = 39
SWEP.EmptySound = Sound("weapons/empty_assaultrifles.wav")

SWEP.Anims = {}
SWEP.Anims.Draw_First = "draw"
SWEP.Anims.Draw = "draw"
SWEP.Anims.Holster = "holster"
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
	[1] = {time = 0.8, sound = Sound("weapons/m21/m21_magout.wav")},
	[2] = {time = 0.9, sound = Sound("weapons/ar2/ar2_reload_rotate.wav")},
	[3] = {time = 1.8, sound = Sound("MagPouch_AR")},
	[4] = {time = 2.1, sound = Sound("weapons/m21/m21_magin.wav")},
	[5] = {time = 2.2, sound = Sound("weapons/ar2/ar2_reload_push.wav")},
}

SWEP.FireModes = {"auto", "semi"}

SWEP.Category = "FA:S 2 Weapons"
SWEP.Base = "fas2_base"
SWEP.Author            = "Spy"

SWEP.Contact        = ""
SWEP.Purpose        = ""

SWEP.ViewModelFOV    = 60
SWEP.ViewModelFlip    = false

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true

SWEP.VM = "models/weapons/v_pulselmg.mdl"
SWEP.WM = "models/items/weapons/pulselmg.mdl"
SWEP.WorldModel   = "models/items/weapons/pulselmg.mdl"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 75
SWEP.Primary.DefaultClip    = 0
SWEP.Primary.Automatic       = true 
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
SWEP.FireDelay = 60/750
SWEP.Damage = 21
SWEP.DamageType = DMG_ENERGYBEAM
SWEP.FireSound = "weapons/ar1/ar1_dist1.wav"
SWEP.FireSound_Suppressed = Sound("FAS2_AK47_S")

-- Accuracy related
SWEP.HipCone = 0.086
SWEP.AimCone = 0.006
SWEP.SpreadPerShot = 0.009
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadCooldown = 0.18
SWEP.AimFOV = 0

-- Recoil related
SWEP.Recoil = 1.2
SWEP.RecoilHorizontal = 0.9

-- Reload related
SWEP.ReloadTime = 3.1
SWEP.ReloadTime_Nomen = 2.2
SWEP.ReloadTime_Empty = 3.3
SWEP.ReloadTime_Empty_Nomen = 3
SWEP.CantChamber = true