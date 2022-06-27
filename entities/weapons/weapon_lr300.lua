AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "LR-300"
    SWEP.Slot = 3
    SWEP.SlotPos = 0
	
	SWEP.AimPos = Vector(-2.304, -4, 0.08)
	SWEP.AimAng = Vector(-0.02, -0.12, 0)

	SWEP.YawMod = 0.1
	SWEP.SuppressorBodygroup = 3
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.Shell = "5.56x45"
	SWEP.AttachmentBGs = {
		["suppressor"] = {bg = 2, sbg = 1}
	}

	SWEP.WMAng = Vector(180, -180, 0)
	SWEP.WMPos = Vector(-0.6, 12.4, -4)
	
	SWEP.HideWorldModel = true
end

SWEP.ASID = "wep_lr300"

SWEP.Attachments = {
	[1] = {
		header = "Barrel",
		x = 100,
		y = 0,
		atts = {"suppressor"}
	}
}

SWEP.BulletLength = 5.56
SWEP.CaseLength = 45
SWEP.EmptySound = Sound("weapons/empty_assaultrifles.wav")

SWEP.Anims = {}
SWEP.Anims.Draw_First = "deploy"
SWEP.Anims.Draw = "deploy"
SWEP.Anims.Draw_Empty = "deploy_empty"
SWEP.Anims.Holster = "holster"
SWEP.Anims.Holster_Empty = "holster_empty"
SWEP.Anims.Fire = {"fire", "fire_2", "fire_3"}
SWEP.Anims.Fire_Last = "fire"
SWEP.Anims.Fire_Aiming = "fire_ironsight"
SWEP.Anims.Fire_Aiming_Last = "fire_ironsight"
SWEP.Anims.Idle = "idle"
SWEP.Anims.Idle_Aim = "idle_ironsight"
SWEP.Anims.Reload = "reload"
SWEP.Anims.Reload_Nomen = "reload_empty"
SWEP.Anims.Reload_Empty = "reload_empty"
SWEP.Anims.Reload_Empty_Nomen = "reload_empty"

SWEP.Sounds = {}

SWEP.Sounds["reload"] = {[1] = {time = 0.4, sound = Sound("weapon/ash12_magout.wav")},
	[2] = {time = 1.2, sound = Sound("weapon/lr300_magin.wav")}}

SWEP.Sounds["reload_empty"] = {[1] = {time = 0.4, sound = Sound("weapon/ash12_magout.wav")},
	[2] = {time = 1.2, sound = Sound("weapon/lr300_magin.wav")},
	[3] = {time = 1.9, sound = Sound("Weapon_M4A1.Boltcatch")}}

SWEP.FireModes = {"auto", "semi"}

SWEP.Category = "FA:S 2 Weapons"
SWEP.Base = "fas2_base"
SWEP.Author            = "Spy"
SWEP.Instructions    = ""
SWEP.Contact        = ""
SWEP.Purpose        = ""

SWEP.ViewModelFOV    = 60
SWEP.ViewModelFlip    = false

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true

SWEP.VM = "models/weapons/lr300.mdl"
SWEP.WM = "models/items/weapons/lr300.mdl"
SWEP.WorldModel   = "models/items/weapons/lr300.mdl"
SWEP.HoldType = "ar2"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 30
SWEP.Primary.DefaultClip    = 0
SWEP.Primary.Automatic       = true    
SWEP.Primary.Ammo             = "ar2"
 
-- Secondary Fire Attributes --
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic       = false
SWEP.Secondary.Ammo         = "none"

-- Deploy related
SWEP.FirstDeployTime = 0.6
SWEP.DeployTime = 0.6
SWEP.DeployAnimSpeed = 0.7
SWEP.HolsterTime = 0.3

-- Firing related
SWEP.Shots = 1
SWEP.FireDelay = 60/600
SWEP.Damage = 27
SWEP.FireSound = Sound("weapon/lr300_fire.wav")
SWEP.FireSound_Suppressed = Sound("weapon/lr300_fire_silencer.wav")

-- Accuracy related
SWEP.HipCone = 0.08
SWEP.AimCone = 0.0035
SWEP.SpreadPerShot = 0.008
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadCooldown = 0.14
SWEP.AimFOV = 0

-- Recoil related
SWEP.Recoil = 1.4
SWEP.RecoilHorizontal = 0.75

-- Reload related
SWEP.ReloadTime = 2
SWEP.ReloadTime_Nomen = 2
SWEP.ReloadTime_Empty = 2.6
SWEP.ReloadTime_Empty_Nomen = 2.6