if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.ExtraMags = 4
end

if CLIENT then
    SWEP.PrintName = "Sterling MK7A4"
    SWEP.Slot = 2
    SWEP.SlotPos = 0
	
	SWEP.AimPos = Vector(-2.86155, -4, 1.4525)
	SWEP.AimAng = Vector(-0.05, 0.015, 0)
	
	SWEP.SprintPos = Vector(2, -7, -4.69)
	SWEP.SprintAng = Vector(30.433, 15, 5)
	
	SWEP.MoveType = 2
	SWEP.YawMod = 0.1
	
	SWEP.MuzzleEffect = "muzzleflash_OTS"
	SWEP.Shell = "9x19"
	SWEP.AttachmentBGs = {["suppressor"] = {bg = 2, sbg = 1}}
	
	SWEP.WMAng = Vector(-15, 90, 180)
	SWEP.WMPos = Vector(-11, 0, 2)
	SWEP.Text3DForward = -2
	SWEP.Text3DRight = -1
	SWEP.Text3DSize = 0.007
	SWEP.SafePosType = "pistol"
	SWEP.SwayInterpolation = "linear"
end

SWEP.Attachments = {[1] = {header = "Barrel", x = 50, y = -100, atts = {"suppressor"}}}

SWEP.BulletLength = 9
SWEP.CaseLength = 18

SWEP.Anims = {}
SWEP.Anims.Draw_First = "deploy"
SWEP.Anims.Draw = "Deploy"
SWEP.Anims.Draw_Empty = "deploy_Empty"
SWEP.Anims.Holster = "Holster"
SWEP.Anims.Holster_Empty = "Holster_Empty"
SWEP.Anims.Fire = {"fire", "fire2", "fire3"}
SWEP.Anims.Fire_Last = "fire_Last"
SWEP.Anims.Fire_Aiming = "shoot_scoped"
SWEP.Anims.Fire_Aiming_Last = "fire_last_scoped"
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
	[3] = {time = 1.08, sound = Sound("FAS2_Sterling.MagPart")},
	[4] = {time = 1.13, sound = Sound("FAS2_SterlingM.MagIn")}}
	
SWEP.Sounds["Reload_empty"] = {[1] = {time = 0.4, sound = Sound("FAS2_SterlingM.MagOutEmpty")},
	[2] = {time = 0.65, sound = Sound("MagPouch_Pistol")},
	[3] = {time = 1.38, sound = Sound("FAS2_Sterling.MagPart")},
	[4] = {time = 1.96, sound = Sound("FAS2_SterlingM.Magslap")},
	[5] = {time = 2.6, sound = Sound("FAS2_Sterling.BoltBack")}}
	
SWEP.Sounds["reload_empty_nomen"] = {[1] = {time = 0.4, sound = Sound("FAS2_Sterling.MagOutEmpty")},
	[2] = {time = 0.75, sound = Sound("MagPouch_Pistol")},
	[3] = {time = 1.1, sound = Sound("FAS2_Sterling.MagPart")},
	[4] = {time = 1.2, sound = Sound("FAS2_SterlingM.MagIn")},
	[5] = {time = 1.75, sound = Sound("FAS2_Sterling.BoltBack")}}
	
SWEP.FireModes = {"auto", "semi"}

SWEP.Category = "FA:S 2 Weapons"
SWEP.Base = "fas2_base"
SWEP.Author            = "Spy"
SWEP.Instructions    = ""
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.HoldType = "smg"
SWEP.RunHoldType = "normal"

SWEP.ViewModelFOV    = 49
SWEP.ViewModelFlip    = false

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true

SWEP.VM = "models/weapons/view/smgs/mk7a4_update.mdl"
SWEP.WM = "models/weapons/b_sterling.mdl"
SWEP.WorldModel   = "models/weapons/b_sterling.mdl"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 17
SWEP.Primary.DefaultClip    = 17
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
SWEP.FireDelay = 0.0688
SWEP.Damage = 18
SWEP.FireSound = Sound("FAS2_SterlingM")
SWEP.FireSound_Suppressed = Sound("FAS2_SterlingM_S")


-- Accuracy related
SWEP.HipCone = 0.045
SWEP.AimCone = 0.0035
SWEP.SpreadPerShot = 0.015
SWEP.MaxSpreadInc = 0.03
SWEP.SpreadCooldown = 0.2
SWEP.VelocitySensitivity = 1.4
SWEP.SpreadToRecoil = 24 -- 25x additional recoil from continuous fire
SWEP.AimFOV = 5

-- Recoil related
SWEP.ViewKick = 0.51
SWEP.Recoil = 0.49

-- Reload related
SWEP.ReloadTime = 2.05
SWEP.ReloadTime_Nomen = 1.45
SWEP.ReloadTime_Empty = 3.2
SWEP.ReloadTime_Empty_Nomen = 2