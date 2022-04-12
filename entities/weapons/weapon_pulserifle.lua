AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Pulse Rifle"
    SWEP.Slot = 3
    SWEP.SlotPos = 0

	SWEP.AimPos = Vector(-2.201, -4.646, 0.675)
	SWEP.AimAng = Vector(0.264, 0, 0)

	SWEP.Shell = "7.62x39"

	SWEP.WMAng = Vector(180, 0, 0)
	SWEP.WMPos = Vector(0, -16.3, 0.1)
	SWEP.CrosshairShow = true
end

SWEP.ASID = "wep_pulserifle"

SWEP.Tracer = "AR2Tracer"

SWEP.BulletLength = 7.62
SWEP.CaseLength = 39
SWEP.EmptySound = Sound("weapons/empty_assaultrifles.wav")

SWEP.Anims = {}
SWEP.Anims.Draw_First = "ir_draw"
SWEP.Anims.Draw = "ir_draw"
SWEP.Anims.Holster = "ir_holster"
SWEP.Anims.Fire = {"fire2", "fire3", "fire4"}
SWEP.Anims.Fire_Aiming = {"fire2", "fire3", "fire4"}
SWEP.Anims.Idle = "ir_idle"
SWEP.Anims.Idle_Aim = "ir_idle"
SWEP.Anims.Reload = "ir_reload"
SWEP.Anims.Reload_Nomen = "ir_reload"
SWEP.Anims.Reload_Empty = "ir_reload"
SWEP.Anims.Reload_Empty_Nomen = "ir_reload"

SWEP.Sounds = {}
SWEP.Sounds["ir_reload"] = {
	[1] = {time = 0.1, sound = Sound("weapons/ar2/ar2_reload_rotate.wav")},
	[2] = {time = 0.6, sound = Sound("weapons/ar2/ar2_reload_push.wav")},
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

SWEP.VM = "models/weapons/v_irifle.mdl"
SWEP.WM = "models/weapons/w_irifle.mdl"
SWEP.WorldModel   = "models/weapons/w_irifle.mdl"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 30
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
SWEP.FireDelay = 60/450
SWEP.Damage = 28
SWEP.FireSound = "weapons/ar2/fire1.wav"
SWEP.FireSound_Suppressed = Sound("FAS2_AK47_S")

-- Accuracy related
SWEP.HipCone = 0.086
SWEP.AimCone = 0.007
SWEP.SpreadPerShot = 0.009
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadCooldown = 0.13
SWEP.AimFOV = 0

-- Recoil related
SWEP.Recoil = 1.5
SWEP.RecoilHorizontal = 1.6

-- Reload related
SWEP.ReloadTime = 1.2
SWEP.ReloadTime_Nomen = 1.2
SWEP.ReloadTime_Empty = 1.2
SWEP.ReloadTime_Empty_Nomen = 1.2