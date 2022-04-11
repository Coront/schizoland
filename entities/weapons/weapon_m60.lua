AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "M60"
    SWEP.Slot = 3
    SWEP.SlotPos = 0
	
	SWEP.AimPos = Vector(-2.835, -5.474, 1.8)
	SWEP.AimAng = Vector(0.018, 0, 0)

	SWEP.CustomizePos = Vector(6, -2.92, -1.296)
	SWEP.CustomizeAng = Vector(14.231, 30, 12.747)

	--SWEP.SprintPos = Vector(2.5, -5, -1.69)
	--SWEP.SprintAng = Vector(3.033, 34, 0)
		
	SWEP.CompM4Pos = Vector(-2.845, -3.25, 1.355)
	SWEP.CompM4Ang = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.845, -5.56, 0.95)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.Shell = "7.62x51"
	SWEP.YawMod = 0.1
	SWEP.AttachmentBGs = {["suppressor"] = {bg = 4, sbg = 1},
		["compm4"] = {bg = 3, sbg = 1},
		["eotech"] = {bg = 3, sbg = 2}}	
		
	SWEP.WMAng = Vector(-14, 180, 180)
	SWEP.WMPos = Vector(1, -3, -1.5)
end

SWEP.ASID = "wep_m60"

SWEP.Attachments = {
	[1] = {header = "Sight", sight = true, x = 800, y = 100, atts = {"compm4", "eotech"}},
	[2] = {header = "Barrel", y = -200, atts = {"suppressor"}}}

SWEP.BulletLength = 7.62
SWEP.CaseLength = 51
SWEP.EmptySound = Sound("weapons/empty_assaultrifles.wav")

SWEP.Anims = {}
SWEP.Anims.Draw_First = "deploy"
SWEP.Anims.Draw = "deploy"
SWEP.Anims.Draw_Empty = "Deploy00"
SWEP.Anims.Holster = "holster"
SWEP.Anims.Holster_Empty = "Holster00"
SWEP.Anims.Fire = {"fire1", "fire2", "fire3"}
SWEP.Anims.Fire_Last = "Fire_Last00"
SWEP.Anims.Fire_Aiming = "fire_first"
SWEP.Anims.Idle = "idle_unfired"
SWEP.Anims.Idle_Aim = "idle_scoped"
SWEP.Anims.Fire_Aiming_Last = "idle00"
SWEP.Anims.Reload = "reload"
SWEP.Anims.Reload_Nomen = "reload_nomen"
SWEP.Anims.Reload_Empty = "reload_fired00"
SWEP.Anims.Reload_Empty_Nomen = "reload_fired00_nomen"

SWEP.Sounds = {}
	
SWEP.Sounds["reload"] = {[1] = {time = 0.14, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.32, sound = Sound("FAS2_M60.Open")},
	[3] = {time = 0.7, sound = Sound("FAS2_M60.BeltRemove")},
	[4] = {time = 1.4, sound = Sound("MagPouch_AR")},
	[5] = {time = 2.1, sound = Sound("FAS2_M60.VelcroRip")},
	[6] = {time = 2.6, sound = Sound("FAS2_M60.CardboardRemove")},
	[7] = {time = 4.1, sound = Sound("FAS2_M60.CardboardInsert")},
	[8] = {time = 4.65, sound = Sound("FAS2_M60.CardboardRip")},
	[9] = {time = 5.35, sound = Sound("FAS2_M60.BeltInsert")},
	[10] = {time = 6.58, sound = Sound("FAS2_M60.VelcroClose")},
	[11] = {time = 7.29, sound = Sound("FAS2_M60.Close")}}
	
	
SWEP.Sounds["reload_nomen"] = {[1] = {time = 0.14, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.32, sound = Sound("FAS2_M60.Open")},
	[3] = {time = 0.6, sound = Sound("FAS2_M60.BeltRemove")},
	[4] = {time = 1.4, sound = Sound("MagPouch_AR")},
	[5] = {time = 1.8, sound = Sound("FAS2_M60.VelcroRip")},
	[6] = {time = 2.2, sound = Sound("FAS2_M60.CardboardRemove")},
	[7] = {time = 3.3, sound = Sound("FAS2_M60.CardboardInsert")},
	[8] = {time = 3.75, sound = Sound("FAS2_M60.CardboardRip")},
	[9] = {time = 4.35, sound = Sound("FAS2_M60.BeltInsert")},
	[10] = {time = 5, sound = Sound("FAS2_M60.VelcroClose")},
	[11] = {time = 5.8, sound = Sound("FAS2_M60.Close")}}
	
SWEP.Sounds["reload_fired00"] = {[1] = {time = 0.13, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.32, sound = Sound("FAS2_M60.Open")},
	[3] = {time = 0.9, sound = Sound("FAS2_M60.Charge")},
	[4] = {time = 1.2, sound = Sound("MagPouch_AR")},
	[5] = {time = 2.3, sound = Sound("FAS2_M60.VelcroRip")},
	[6] = {time = 2.9, sound = Sound("FAS2_M60.CardboardRemove")},
	[7] = {time = 4.35, sound = Sound("FAS2_M60.CardboardInsert")},
	[8] = {time = 4.8, sound = Sound("FAS2_M60.CardboardRip")},
	[9] = {time = 5.35, sound = Sound("FAS2_M60.BeltInsert")},
	[10] = {time = 6.28, sound = Sound("FAS2_M60.VelcroClose")},
	[11] = {time = 7.2, sound = Sound("FAS2_M60.Close")}}
	
SWEP.Sounds["reload_fired00_nomen"] = {[1] = {time = 0.13, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.32, sound = Sound("FAS2_M60.Open")},
	[3] = {time = 0.5, sound = Sound("MagPouch_AR")},
	[3] = {time = 0.75, sound = Sound("FAS2_M60.Charge")},
	[4] = {time = 1.6, sound = Sound("FAS2_M60.VelcroRip")},
	[5] = {time = 2.1, sound = Sound("FAS2_M60.CardboardRemove")},
	[6] = {time = 3.25, sound = Sound("FAS2_M60.CardboardInsert")},
	[7] = {time = 3.75, sound = Sound("FAS2_M60.CardboardRip")},
	[8] = {time = 4.25, sound = Sound("FAS2_M60.BeltInsert")},
	[9] = {time = 4.65, sound = Sound("FAS2_M60.VelcroClose")},
	[10] = {time = 5.7, sound = Sound("FAS2_M60.Close")}}
	
SWEP.FireModes = {"auto", "semi"}

SWEP.Category = "FA:S 2 Weapons"
SWEP.Base = "fas2_base"
SWEP.Author            = "Go nuts with it"
SWEP.Contact        = ""
SWEP.Purpose        = ""

SWEP.ViewModelFOV    = 58
SWEP.ViewModelFlip    = true

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true

SWEP.VM = "models/weapons/view/support/m60e3.mdl"
SWEP.WM = "models/weapons/w_m60e3.mdl"
SWEP.WorldModel   = "models/weapons/w_mach_m249para.mdl"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 100
SWEP.Primary.DefaultClip    = 0
SWEP.Primary.Automatic       = true    
SWEP.Primary.Ammo             = "sniperround"
 
-- Secondary Fire Attributes --
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic       = false
SWEP.Secondary.Ammo         = "none"

-- Deploy related
SWEP.FirstDeployTime = 0.65
SWEP.DeployTime = 0.65
SWEP.DeployAnimSpeed = 0.8
SWEP.HolsterTime = 0.45

-- Firing related
SWEP.Shots = 1
SWEP.FireDelay = 60/400
SWEP.Damage = 39
SWEP.FireSound = Sound("FAS2_M60")
SWEP.FireSound_Suppressed = Sound("FAS2_M60_S")

-- Accuracy related
SWEP.HipCone = 0.09
SWEP.AimCone = 0.01
SWEP.SpreadPerShot = 0.023
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadCooldown = 0.4
SWEP.AimFOV = 0

-- Recoil related
SWEP.Recoil = 2.1
SWEP.RecoilHorizontal = 1.8

-- Reload related
SWEP.ReloadTime = 7.65
SWEP.ReloadTime_Nomen = 6.1
SWEP.ReloadTime_Empty = 7.65
SWEP.ReloadTime_Empty_Nomen = 6.1
SWEP.CantChamber = true