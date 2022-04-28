AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Model CMG"
    SWEP.Slot = 3
    SWEP.SlotPos = 0
	
	SWEP.AimPos = Vector(-4.71, 1, 0.4)
	SWEP.AimAng = Vector(0, 0, 0)

	SWEP.Shell = "7.62x39"

	SWEP.WMAng = Vector(0, 180, 180)
	SWEP.WMPos = Vector(0.1, -9.3, 3.3)
end

SWEP.ASID = "wep_csmg"

SWEP.BulletLength = 7.62
SWEP.CaseLength = 39
SWEP.EmptySound = Sound("weapons/empty_assaultrifles.wav")

SWEP.Anims = {}
SWEP.Anims.Draw_First = "draw"
SWEP.Anims.Draw = "draw"
SWEP.Anims.Holster = "idle"
SWEP.Anims.Fire = {"shoot1", "shoot2", "shoot3"}
SWEP.Anims.Fire_Aiming = "idle"
SWEP.Anims.Idle = "idle"
SWEP.Anims.Idle_Aim = "idle"
SWEP.Anims.Reload = "reload"
SWEP.Anims.Reload_Nomen = "reload"
SWEP.Anims.Reload_Empty = "reload"
SWEP.Anims.Reload_Empty_Nomen = "reload"

SWEP.Sounds = {}
SWEP.Sounds["reload"] = {
	[1] = {time = 0.6, sound = "weapons/mp5/mp5_magout_empty.wav"},
	[2] = {time = 1.8, sound = "weapons/mp5/mp5_magin.wav"},
	[3] = {time = 2.5, sound = "weapons/mp5/mp5_boltforward.wav"}
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

SWEP.VM = "models/weapons/v_csmg.mdl"
SWEP.WM = "models/items/weapons/csmg.mdl"
SWEP.WorldModel   = "models/items/weapons/csmg.mdl"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 25
SWEP.Primary.DefaultClip    = 0
SWEP.Primary.Automatic       = true 
SWEP.Primary.Ammo             = "AlyxGun"

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
SWEP.FireDelay = 60/800
SWEP.Damage = 26
SWEP.FireSound = "weapons/mp5/mp5k_suppressed_fire1.wav"

-- Accuracy related
SWEP.HipCone = 0.084
SWEP.AimCone = 0.004
SWEP.SpreadPerShot = 0.014
SWEP.MaxSpreadInc = 0.08
SWEP.SpreadCooldown = 0.18
SWEP.AimFOV = 0

-- Recoil related
SWEP.Recoil = 1.1
SWEP.RecoilHorizontal = 1.3

-- Reload related
SWEP.ReloadTime = 2.9
SWEP.ReloadTime_Nomen = 2.2
SWEP.ReloadTime_Empty = 3.3
SWEP.ReloadTime_Empty_Nomen = 3