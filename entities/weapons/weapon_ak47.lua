AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "AK-47"
    SWEP.Slot = 3
    SWEP.SlotPos = 0
	
	SWEP.AimPos = Vector(-2.201, -4.646, 0.675)
	SWEP.AimAng = Vector(0.264, 0, 0)
	
	SWEP.CompM4Pos = Vector(-2.181, -2.5, -0.203)
	SWEP.CompM4Ang = Vector(0, 0, 0)
	
	SWEP.MuzzleEffect = "muzzleflash_ak47"
	SWEP.Shell = "7.62x39"
	SWEP.AttachmentBGs = {
		["compm4"] = {bg = 3, sbg = 1},
		["suppressor"] = {bg = 2, sbg = 1}
	}

	SWEP.WMAng = Vector(0, 90, 180)
	SWEP.WMPos = Vector(-10.3, 0.6, 2.9)
end

SWEP.ASID = "wep_ak47"

SWEP.Attachments = {
	[1] = {header = "Sight", sight = true, x = 800, y = -50, atts = {"compm4"}},
	[2] = {header = "Barrel", y = -200, atts = {"suppressor"}}}

SWEP.BulletLength = 7.62
SWEP.CaseLength = 39
SWEP.EmptySound = Sound("weapons/empty_assaultrifles.wav")

SWEP.Anims = {}
SWEP.Anims.Draw_First = "deploy"
SWEP.Anims.Draw = "deploy"
SWEP.Anims.Holster = "holster"
SWEP.Anims.Fire = "fire"
SWEP.Anims.Fire_Aiming = "fire_scoped"
SWEP.Anims.Idle = "idle"
SWEP.Anims.Idle_Aim = "idle_scoped"
SWEP.Anims.Reload = "reload"
SWEP.Anims.Reload_Nomen = "reload_nomen"
SWEP.Anims.Reload_Empty = "reload_empty"
SWEP.Anims.Reload_Empty_Nomen = "reload_empty_nomen"

SWEP.Sounds = {}
SWEP.Sounds["reload"] = {
	[1] = {time = 0.9, sound = Sound("Weapon_AK47.MagOut")},
	[2] = {time = 1.4, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.9, sound = Sound("Weapon_AK47.MagIn")}
}

SWEP.Sounds["reload_nomen"] = {
	[1] = {time = 0.6, sound = Sound("Weapon_AK47.MagOut")},
	[2] = {time = 1.2, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.8, sound = Sound("Weapon_AK47.MagIn")}
}

SWEP.Sounds["reload_empty"] = {
	[1] = {time = 0.6, sound = Sound("Weapon_AK47.MagOutEmpty")},
	[2] = {time = 1.15, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.7, sound = Sound("Weapon_AK47.MagIn")},
	[4] = {time = 2.8, sound = Sound("Weapon_AK47.BoltPull")}
}

SWEP.Sounds["reload_empty_nomen"] = {
	[1] = {time = 0.8, sound = Sound("MagPouch_AR")},
	[2] = {time = 1.5, sound = Sound("Weapon_AK47.MagOutEmptyNomen")},
	[3] = {time = 1.8, sound = Sound("Weapon_AK47.MagIn")},
	[4] = {time = 2.5, sound = Sound("Weapon_AK47.BoltPull")}
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

SWEP.VM = "models/weapons/view/rifles/ak47.mdl"
SWEP.WM = "models/items/weapons/ak47.mdl"
SWEP.WorldModel   = "models/items/weapons/ak47.mdl"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 30
SWEP.Primary.DefaultClip    = 0
SWEP.Primary.Automatic       = true 
SWEP.Primary.Ammo             = "smg1"

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
SWEP.FireDelay = 60/600
SWEP.Damage = 27
SWEP.FireSound = Sound("FAS2_AK47")
SWEP.FireSound_Suppressed = Sound("FAS2_AK47_S")

-- Accuracy related
SWEP.HipCone = 0.084
SWEP.AimCone = 0.004
SWEP.SpreadPerShot = 0.014
SWEP.MaxSpreadInc = 0.08
SWEP.SpreadCooldown = 0.18
SWEP.AimFOV = 0

-- Recoil related
SWEP.Recoil = 1.8
SWEP.RecoilHorizontal = 0.95

-- Reload related
SWEP.ReloadTime = 2.6
SWEP.ReloadTime_Nomen = 2.2
SWEP.ReloadTime_Empty = 3.3
SWEP.ReloadTime_Empty_Nomen = 3