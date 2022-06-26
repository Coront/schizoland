AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "ASH-12"
    SWEP.Slot = 3
    SWEP.SlotPos = 0
	SWEP.YawMod = 0.1

	SWEP.AimPos = Vector(-1.64, -0.5, -0.01)
	SWEP.AimAng = Vector(0.95, 0.02, 0)

	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.Shell = "7.62x51"
	SWEP.HideWorldModel = true

	SWEP.WMAng = Vector(0, 0, 180)
	SWEP.WMPos = Vector(-0.4, 13, -4)
	SWEP.TargetViewModelFOV = 40
end

SWEP.ASID = "wep_ash12"

SWEP.BulletLength = 7.62
SWEP.CaseLength = 51
SWEP.EmptySound = Sound("weapons/empty_battlerifles.wav")

SWEP.Anims = {}
SWEP.Anims.Draw_First = "deploy"
SWEP.Anims.Draw = "deploy"
SWEP.Anims.Draw_Empty = "deploy"
SWEP.Anims.Holster = "holster"
SWEP.Anims.Holster_Empty = "holster"
SWEP.Anims.Fire = {"fire"}
SWEP.Anims.Fire_Last = "fire"
SWEP.Anims.Fire_Aiming = "fire_iron"
SWEP.Anims.Fire_Aiming_Last = "fire_iron"
SWEP.Anims.Idle = "idle"
SWEP.Anims.Idle_Aim = "idle"
SWEP.Anims.Reload = "reload"
SWEP.Anims.Reload_Nomen = "reload"
SWEP.Anims.Reload_Empty = "reload_empty"
SWEP.Anims.Reload_Empty_Nomen = "reload_empty"

SWEP.Sounds = {}

SWEP.Sounds["deploy"] = {
	[1] = {time = 0, sound = Sound("weapon/ash12_cloth.wav")}
}
SWEP.Sounds["reload"] = {
	[1] = {time = 0.4, sound = Sound("weapon/ash12_magout.wav")},
	[2] = {time = 1.3, sound = Sound("weapon/ash12_magin.wav")},
}
SWEP.Sounds["reload_empty"] = {
	[1] = {time = 0.4, sound = Sound("weapon/ash12_magout.wav")},
	[2] = {time = 1.3, sound = Sound("weapon/ash12_magin.wav")},
	[3] = {time = 3, sound = Sound("weapon/ash12_boltback.wav")},
	[4] = {time = 3.2, sound = Sound("weapon/ash12_boltforward.wav")}
	--[[
	]]
}

SWEP.FireModes = {"auto", "semi"}

SWEP.Category = "FA:S 2 Weapons"
SWEP.Base = "fas2_base"
SWEP.Author            = "Spy"
SWEP.Instructions    = ""
SWEP.Contact        = ""
SWEP.Purpose        = ""

SWEP.ViewModelFOV    = 65
SWEP.ViewModelFlip    = false

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true

SWEP.VM = "models/weapons/ash12.mdl"
SWEP.WM = "models/items/weapons/ash12.mdl"
SWEP.WorldModel   = "models/items/weapons/ash12.mdl"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 20
SWEP.Primary.DefaultClip    = 0
SWEP.Primary.Automatic       = true
SWEP.Primary.Ammo             = "sniperround"
 
-- Secondary Fire Attributes --
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic       = false
SWEP.Secondary.Ammo         = "none"

-- Deploy related
SWEP.FirstDeployTime = 0.45
SWEP.DeployTime = 0.45

-- Firing related
SWEP.Shots = 1
SWEP.FireDelay = 60/350
SWEP.Damage = 51
SWEP.FireSound = Sound("weapon/ash12_fire1.wav")

-- Accuracy related
SWEP.HipCone = 0.12
SWEP.AimCone = 0.01
SWEP.SpreadPerShot = 0.03
SWEP.MaxSpreadInc = 0.08
SWEP.SpreadCooldown = 0.3
SWEP.AimFOV = 0

-- Recoil related
SWEP.Recoil = 1
SWEP.RecoilHorizontal = 2.5

-- Reload related
SWEP.ReloadTime = 2.3
SWEP.ReloadTime_Nomen = 2.3
SWEP.ReloadTime_Empty = 3.7
SWEP.ReloadTime_Empty_Nomen = 2.3