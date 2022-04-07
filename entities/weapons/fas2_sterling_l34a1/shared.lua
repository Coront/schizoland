if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.ExtraMags = 4
end

if CLIENT then
    SWEP.PrintName = "Sterling L34A1"
    SWEP.Slot = 2
    SWEP.SlotPos = 0
	
	SWEP.AimPos = Vector(-2.2675, -3, 1.42)
	SWEP.AimAng = Vector(-0.05, 0.185, 0)
	
	SWEP.SprintPos = Vector(2, -4, -2.69)
	SWEP.SprintAng = Vector(15.433, 5, 5)
	
	SWEP.MoveType = 2
	SWEP.YawMod = 0.1
	
	SWEP.MuzzleEffect = "muzzleflash_suppressed"
	SWEP.Shell = "9x19"
	
	SWEP.WMAng = Vector(-15, 90, 180)
	SWEP.WMPos = Vector(-11, 0, 2)
	SWEP.Text3DForward = -2
	SWEP.Text3DRight = -1
	SWEP.Text3DSize = 0.007
	SWEP.SafePosType = "pistol"
	SWEP.SwayInterpolation = "linear"
end

SWEP.BulletLength = 9
SWEP.CaseLength = 18

SWEP.Anims = {}
SWEP.Anims.Draw_First = "deploy_first"
SWEP.Anims.Draw = "Draw"
SWEP.Anims.Draw_Empty = "Draw_Empty"
SWEP.Anims.Holster = "Holster"
SWEP.Anims.Holster_Empty = "Holster_Empty"
SWEP.Anims.Fire = {"shoot1", "shoot2", "shoot3"}
SWEP.Anims.Fire_Last = "shoot_Last"
SWEP.Anims.Fire_Aiming = "Fire_scoped"
SWEP.Anims.Fire_Aiming_Last = "shoot_last_scoped"
SWEP.Anims.Idle = "idle"
SWEP.Anims.Idle_Aim = "idle_scoped"
SWEP.Anims.Reload = "Reload" 
SWEP.Anims.Reload_Nomen = "reload_nomen"
SWEP.Anims.Reload_Empty = "Reload_empty"
SWEP.Anims.Reload_Empty_Nomen = "reload_empty_nomen"

SWEP.Sounds = {}
SWEP.Sounds["Reload"] = {[1] = {time = 0.4, sound = Sound("FAS2_SterlingM.MagOut")},
	[2] = {time = 0.7, sound = Sound("MagPouch_Pistol")},
	[3] = {time = 1.38, sound = Sound("FAS2_Sterling.MagPart")},
	[4] = {time = 1.43, sound = Sound("FAS2_SterlingM.MagIn")}}
	
SWEP.Sounds["reload_nomen"] = {[1] = {time = 0.4, sound = Sound("FAS2_SterlingM.MagOut")},
	[2] = {time = 0.85, sound = Sound("MagPouch_Pistol")},
	[3] = {time = 1.38, sound = Sound("FAS2_Sterling.MagPart")},
	[4] = {time = 1.43, sound = Sound("FAS2_SterlingM.MagIn")}}
	
SWEP.Sounds["Reload_empty"] = {[1] = {time = 0.4, sound = Sound("FAS2_SterlingM.MagOutEmpty")},
	[2] = {time = 0.65, sound = Sound("MagPouch_Pistol")},
	[3] = {time = 1.38, sound = Sound("FAS2_Sterling.MagPart")},
	[4] = {time = 1.46, sound = Sound("FAS2_SterlingM.MagIn")},
	[5] = {time = 2.2, sound = Sound("FAS2_Sterling.BoltBack")}}
	
SWEP.Sounds["reload_empty_nomen"] = {[1] = {time = 0.4, sound = Sound("FAS2_Sterling.MagOutEmpty")},
	[2] = {time = 0.75, sound = Sound("MagPouch_Pistol")},
	[3] = {time = 1.35, sound = Sound("FAS2_Sterling.MagPart")},
	[4] = {time = 1.4, sound = Sound("FAS2_SterlingM.MagIn")},
	[5] = {time = 2, sound = Sound("FAS2_Sterling.BoltBack")}}
	
SWEP.FireModes = {"auto", "semi"}

SWEP.Category = "FA:S 2 Weapons"
SWEP.Base = "fas2_base"
SWEP.Author            = "Spy"
SWEP.Instructions    = ""
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.RunHoldType = "normal"

SWEP.ViewModelFOV    = 47
SWEP.ViewModelFlip    = false

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true

SWEP.VM = "models/weapons/view/smgs/sterling_sil_update.mdl"
SWEP.WM = "models/weapons/b_sterling_sil.mdl"
SWEP.WorldModel   = "models/weapons/b_sterling_sil.mdl"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 34
SWEP.Primary.DefaultClip    = 34
SWEP.Primary.Automatic       = true    
SWEP.Primary.Ammo             = "9x19MM"
 
-- Secondary Fire Attributes --
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic       = false
SWEP.Secondary.Ammo         = "none"

-- Deploy related
SWEP.FirstDeployTime = 0.45
SWEP.DeployTime = 0.45
SWEP.DeployAnimSpeed = 0.5

-- Firing related
SWEP.Shots = 1
SWEP.FireDelay = 0.0866
SWEP.Damage = 21
SWEP.FireSound = Sound("FAS2_Sterling_s")

-- Accuracy related
SWEP.HipCone = 0.041
SWEP.AimCone = 0.0025
SWEP.SpreadPerShot = 0.0045
SWEP.MaxSpreadInc = 0.025
SWEP.SpreadCooldown = 0.2
SWEP.VelocitySensitivity = 1.3
SWEP.SpreadToRecoil = 23 -- 25x additional recoil from continuous fire
SWEP.AimFOV = 5

-- Recoil related
SWEP.ViewKick = 0.51427
SWEP.Recoil = 0.50224

-- Reload related
SWEP.ReloadTime = 2.15
SWEP.ReloadTime_Nomen = 1.95
SWEP.ReloadTime_Empty = 2.8
SWEP.ReloadTime_Empty_Nomen = 2.2