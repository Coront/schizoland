if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.ExtraMags = 3
end

if CLIENT then
    SWEP.PrintName = "MINIMI"
    SWEP.Slot = 3
    SWEP.SlotPos = 0
	
	SWEP.AimPos = Vector(-3.516, -3.5, 2.02)
	SWEP.AimAng = Vector(0.45, 0.025, 0)

	SWEP.CustomizePos = Vector(6, -1.92, -3.396)
	SWEP.CustomizeAng = Vector(16.431, 22.895, 9.747)
	
	SWEP.SprintPos = Vector(1.5, -7, -1.59)
	SWEP.SprintAng = Vector(4.033, 34, 0)
	
	SWEP.AimPos_Bipod = Vector(-2.591, -2.874, 1.215)
	SWEP.AimAng_Bipod = Vector(0.5, 0, 0)
		
	SWEP.CompM4Pos = Vector(-2.665, -6, 0.97)
	SWEP.CompM4Ang = Vector(0, 0, 0)

	SWEP.CompM4Pos_Bipod = Vector(-1.75, -4.5, 0.18)
	SWEP.CompM4Ang_Bipod = Vector(-0.084, 0, 0)

	SWEP.ELCANPos = Vector(-2.665, -4.5, 0.5)
	SWEP.ELCANAng = Vector(-0.595, 0, 0)
	
	SWEP.ELCANPos_Bipod = Vector(-1.74, -3.5, -0.29)
	SWEP.ELCANAng_Bipod = Vector(-0.575, 0, 0)

	SWEP.EoTechPos_Bipod = Vector(-1.74, -6.75, -0.375)
	SWEP.EoTechAng_Bipod = Vector(1.17, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.665, -7.5, 0.5)
	SWEP.EoTechAng = Vector(0.5, 0, 0)


	SWEP.MuzzleEffect = "muzzleflash_ak47"
	SWEP.Shell = "5.56x45"
	SWEP.YawMod = 0.1
	SWEP.AttachmentBGs = {["suppressor"] = {bg = 3, sbg = 1},
		["compm4"] = {bg = 2, sbg = 1},
		["eotech"] = {bg = 2, sbg = 2},
		["c79"] = {bg = 2, sbg = 3},	
		["lmgx200mag"] = {bg = 4, sbg = 1}}
	
	SWEP.WMAng = Vector(-19, 180, 180)
	SWEP.WMPos = Vector(1, -3, -1.35)
end

SWEP.Attachments = {
	[2] = {header = "Barrel", y = -100, atts = {"suppressor"}},
	[1] = {header = "Sight", sight = true, x = 800, y = -200, atts = {"c79", "compm4", "eotech"}},
	[3] = {header = "Magazine", x = 300, y = 50, atts = {"lmgx200mag"}}}

SWEP.BulletLength = 5.56
SWEP.CaseLength = 45
SWEP.EmptySound = Sound("weapons/empty_assaultrifles.wav")

SWEP.Anims = {}
SWEP.Anims.Draw_First = "deploy_first02"
SWEP.Anims.Draw = "deploy"
SWEP.Anims.Draw_Empty = "deploy_empty"
SWEP.Anims.Holster_Empty = "holster_empty"
SWEP.Anims.Holster = "holster"
SWEP.Anims.Fire = {"fire1", "fire2", "fire3"}
SWEP.Anims.Fire_Last = "Fire_empty"
SWEP.Anims.Fire_Bipod_Last = "bipod_fire_empty"
SWEP.Anims.Fire_Bipod = "bipod_Fire1"
SWEP.Anims.Fire_Aiming = {"fire1_scoped", "fire2_scoped"}
SWEP.Anims.Fire_Bipod_Aiming = "bipod_fire1_scoped"
SWEP.Anims.Idle = "idle"
SWEP.Anims.Idle_Aim = "idle_scoped"
SWEP.Anims.Fire_Aiming_Last = "fire_empty_scoped"
SWEP.Anims.Reload = "reload"
SWEP.Anims.Reload_Bipod = "bipod_Reload"
SWEP.Anims.Reload_Nomen = "reload_nomen"
SWEP.Anims.Reload_Bipod_Nomen = "bipod_reload_nomen"
SWEP.Anims.Reload_Empty = "reload_empty"
SWEP.Anims.Reload_Bipod_Empty = "bipod_reload_empty"
SWEP.Anims.Reload_Empty_Nomen = "reload_empty_nomen"
SWEP.Anims.Reload_Bipod_Empty_Nomen = "bipod_reload_empty_nomen"
SWEP.Anims.Bipod_Deploy = "bipod_down"
SWEP.Anims.Bipod_UnDeploy = "bipod_up"
SWEP.Anims.Bipod_Deploy_Empty = "bipod_down_empty"
SWEP.Anims.Bipod_UnDeploy_Empty = "bipod_up_empty"

SWEP.Sounds = {}

SWEP.Sounds["deploy_first02"] = {[1] = {time = 0.35, sound = Sound("FAS2_M249.LidOpen")},
	[2] = {time = 1.25, sound = Sound("FAS2_M249.BeltLoad")},
	[3] = {time = 2.25, sound = Sound("FAS2_MC51.Beltload")},
	[4] = {time = 2.7, sound = Sound("FAS2_M249.BeltLoad")},
	[5] = {time = 2.9, sound = Sound("MagPouch_AR")},
	[6] = {time = 3.535, sound = Sound("FAS2_M249.LidClose")}}

SWEP.Sounds["bipod_down"] = {[1] = {time = 0, sound = Sound("Generic_Cloth")},
	[2] = {time = 0.09, sound = Sound("FAS2_M249.Bipod")}}
	
SWEP.Sounds["bipod_up"] = {[1] = {time = 0, sound = Sound("Generic_Cloth")},
	[2] = {time = 0.45, sound = Sound("Grip_Medium")}}

SWEP.Sounds["bipod_down_empty"] = {[1] = {time = 0, sound = Sound("Generic_Cloth")},
	[2] = {time = 0.09, sound = Sound("FAS2_M249.Bipod")}}
	
SWEP.Sounds["bipod_up_empty"] = {[1] = {time = 0, sound = Sound("Generic_Cloth")},
	[2] = {time = 0.45, sound = Sound("Grip_Medium")}}
	
SWEP.Sounds["reload"] = {[1] = {time = 0.07, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.4, sound = Sound("FAS2_M249.LidOpen")},
	[3] = {time = 0.8, sound = Sound("MagPouch_AR")},
	[4] = {time = 1, sound = Sound("FAS2_M249.BeltRemove")},
	[5] = {time = 1.52, sound = Sound("MagPouch_AR")},
	[6] = {time = 2.2, sound = Sound("FAS2_M249.BoxRemove")},
	[7] = {time = 3, sound = Sound("Magpouch_AR")},
	[8] = {time = 3.65, sound = Sound("FAS2_M249.BoxInsert")},
	[9] = {time = 4.15, sound = Sound("FAS2_M249.BeltPull")},
	[10] = {time = 4.4, sound = Sound("FAS2_M249.BeltLoad")},
	[11] = {time = 5.6, sound = Sound("FAS2_M249.LidClose")}}

SWEP.Sounds["reload_empty"] = {[1] = {time = 0.07, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.35, sound = Sound("FAS2_M60.Charge")},
	[3] = {time = 1.1, sound = Sound("FAS2_M249.LidOpen")},
	[4] = {time = 1.45, sound = Sound("Generic_Cloth")},
	[5] = {time = 2.85, sound = Sound("MagPouch_AR")},
	[6] = {time = 3, sound = Sound("FAS2_M249.BoxRemove")},
	[7] = {time = 3.55, sound = Sound("MagPouch_AR")},
	[8] = {time = 4.42, sound = Sound("FAS2_M249.BoxInsert")},
	[9] = {time = 4.9, sound = Sound("FAS2_M249.BeltPull")},
	[10] = {time = 5.1, sound = Sound("FAS2_M249.BeltLoad")},
	[11] = {time = 6.25, sound = Sound("FAS2_M249.LidClose")}}

SWEP.Sounds["bipod_Reload"] = {[1] = {time = 0.07, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.25, sound = Sound("FAS2_M249.LidOpen")},
	[3] = {time = 0.55, sound = Sound("MagPouch_AR")},
	[4] = {time = 0.65, sound = Sound("FAS2_M249.BeltRemove")},
	[5] = {time = 0.92, sound = Sound("MagPouch_AR")},
	[6] = {time = 1.25, sound = Sound("FAS2_M249.BoxRemove")},
	[7] = {time = 1.9, sound = Sound("Magpouch_AR")},
	[8] = {time = 2.35, sound = Sound("FAS2_M249.BoxInsert")},
	[9] = {time = 2.95, sound = Sound("FAS2_M249.BeltPull")},
	[10] = {time = 3.2, sound = Sound("FAS2_M249.BeltLoad")},
	[11] = {time = 4, sound = Sound("FAS2_M249.LidClose")}}

SWEP.Sounds["bipod_reload_empty"] = {[1] = {time = 0.07, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.15, sound = Sound("FAS2_M60.Charge")},
	[3] = {time = 1.15, sound = Sound("FAS2_M249.LidOpen")},
	[4] = {time = 1.4, sound = Sound("Generic_Cloth")},
	[5] = {time = 2, sound = Sound("MagPouch_AR")},
	[6] = {time = 2.4, sound = Sound("FAS2_M249.BoxRemove")},
	[7] = {time = 3.35, sound = Sound("MagPouch_AR")},
	[8] = {time = 3.72, sound = Sound("FAS2_M249.BoxInsert")},
	[9] = {time = 4.25, sound = Sound("FAS2_M249.BeltPull")},
	[10] = {time = 4.5, sound = Sound("FAS2_M249.BeltLoad")},
	[11] = {time = 5.2, sound = Sound("FAS2_M249.LidClose")}}
	
SWEP.Sounds["reload_nomen"] = {[1] = {time = 0.07, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.4, sound = Sound("FAS2_M249.LidOpen")},
	[3] = {time = 0.8, sound = Sound("MagPouch_AR")},
	[4] = {time = 1, sound = Sound("FAS2_M249.BeltRemove")},
	[5] = {time = 1.35, sound = Sound("MagPouch_AR")},
	[6] = {time = 1.6, sound = Sound("FAS2_M249.BoxRemove")},
	[7] = {time = 2, sound = Sound("Magpouch_AR")},
	[8] = {time = 2.65, sound = Sound("FAS2_M249.BoxInsert")},
	[9] = {time = 3.1, sound = Sound("FAS2_M249.BeltPull")},
	[10] = {time = 3.2, sound = Sound("FAS2_M249.BeltLoad")},
	[11] = {time = 4.2, sound = Sound("FAS2_M249.LidClose")}}
	
SWEP.Sounds["bipod_reload_nomen"] = {[1] = {time = 0.07, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.25, sound = Sound("FAS2_M249.LidOpen")},
	[3] = {time = 0.4, sound = Sound("MagPouch_AR")},
	[4] = {time = 0.55, sound = Sound("FAS2_M249.BeltRemove")},
	[5] = {time = 0.72, sound = Sound("MagPouch_AR")},
	[6] = {time = 1, sound = Sound("FAS2_M249.BoxRemove")},
	[7] = {time = 1.3, sound = Sound("Magpouch_AR")},
	[8] = {time = 1.84, sound = Sound("FAS2_M249.BoxInsert")},
	[9] = {time = 2.3, sound = Sound("FAS2_M249.BeltPull")},
	[10] = {time = 2.6, sound = Sound("FAS2_M249.BeltLoad")},
	[11] = {time = 3, sound = Sound("FAS2_M249.LidClose")}}
	
SWEP.Sounds["bipod_reload_empty_nomen"] = {[1] = {time = 0.07, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.15, sound = Sound("FAS2_M60.Charge")},
	[3] = {time = 1, sound = Sound("FAS2_M249.LidOpen")},
	[4] = {time = 1.3, sound = Sound("Generic_Cloth")},
	[5] = {time = 1.6, sound = Sound("MagPouch_AR")},
	[6] = {time = 1.9, sound = Sound("FAS2_M249.BoxRemove")},
	[7] = {time = 2.35, sound = Sound("MagPouch_AR")},
	[8] = {time = 2.72, sound = Sound("FAS2_M249.BoxInsert")},
	[9] = {time = 3.15, sound = Sound("FAS2_M249.BeltPull")},
	[10] = {time = 3.3, sound = Sound("FAS2_M249.BeltLoad")},
	[11] = {time = 4, sound = Sound("FAS2_M249.LidClose")}}
	
SWEP.Sounds["reload_empty_nomen"] = {[1] = {time = 0.07, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.35, sound = Sound("FAS2_M249.LidOpen")},
	[3] = {time = 1.1, sound = Sound("FAS2_M60.Charge")},
	[4] = {time = 1.35, sound = Sound("Generic_Cloth")},
	[5] = {time = 1.55, sound = Sound("MagPouch_AR")},
	[6] = {time = 2.2, sound = Sound("FAS2_M249.BoxRemove")},
	[7] = {time = 2.55, sound = Sound("MagPouch_AR")},
	[8] = {time = 3.22, sound = Sound("FAS2_M249.BoxInsert")},
	[9] = {time = 3.7, sound = Sound("FAS2_M249.BeltPull")},
	[10] = {time = 4, sound = Sound("FAS2_M249.BeltLoad")},
	[11] = {time = 4.8, sound = Sound("FAS2_M249.LidClose")}}
	
SWEP.FireModes = {"auto", "semi"}

SWEP.Category = "FA:S 2 Weapons"
SWEP.Base = "fas2_base"
SWEP.Author            = "Spy"
SWEP.Contact        = ""
SWEP.Purpose        = ""

SWEP.ViewModelFOV    = 52
SWEP.ViewModelFlip    = false

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true

SWEP.VM = "models/weapons/view/support/minimi.mdl"
SWEP.WM = "models/weapons/w_m249.mdl"
SWEP.WorldModel   = "models/weapons/w_mach_m249para.mdl"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 100
SWEP.Primary.DefaultClip    = 100
SWEP.Primary.Automatic       = true    
SWEP.Primary.Ammo             = "5.56x45MM"
 
-- Secondary Fire Attributes --
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic       = false
SWEP.Secondary.Ammo         = "none"

-- Deploy related
SWEP.FirstDeployTime = 4.35
SWEP.DeployTime = 0.65
SWEP.DeployAnimSpeed = 0.8
SWEP.HolsterTime = 0.5

-- Firing related
SWEP.Shots = 1
SWEP.FireDelay = 0.0825
SWEP.Damage = 45
SWEP.FireSound = Sound("FAS2_M249")
SWEP.FireSound_Suppressed = Sound("FAS2_M249_S")

-- Accuracy related
SWEP.HipCone = 0.0577
SWEP.AimCone = 0.0039
SWEP.SpreadPerShot = 0.025
SWEP.MaxSpreadInc = 0.0351
SWEP.SpreadCooldown = 0.05
SWEP.VelocitySensitivity = 1.4
SWEP.AimFOV = 7

-- Recoil related
SWEP.ViewKick = 0.92
SWEP.Recoil = 1.11

-- Reload related
SWEP.ReloadTime = 6.4
SWEP.ReloadTime_Nomen = 4.8
SWEP.ReloadTime_Empty = 7.2
SWEP.ReloadTime_Empty_Nomen = 5.25
SWEP.CantChamber = true
SWEP.ReloadTime_Bipod = 4.5
SWEP.ReloadTime_Bipod_Nomen = 3.35
SWEP.ReloadTime_Bipod_Empty = 5.7
SWEP.ReloadTime_Bipod_Empty_Nomen = 4.25

-- Misc
SWEP.InstalledBipod = true
SWEP.BipodAngleLimitYaw = 30
SWEP.BipodAngleLimitPitch = 10
SWEP.BipodDeployTime = 0.93
SWEP.BipodUndeployTime = 0.93

if CLIENT then
	local x, y, old, ang
	local sight = surface.GetTextureID("models/weapons/view/accessories/elcan_reticle")
	local lens = surface.GetTextureID("VGUI/fas2/lense")
	local lensring = surface.GetTextureID("VGUI/fas2/lensring")
	local cd, alpha = {}, 0.5
	local Ini = true
	
	function SWEP:DrawRenderTarget()
		if self.AimPos != self.ELCANPos then
			return
		end
		
		if self.dt.Status == FAS_STAT_ADS then
			alpha = math.Approach(alpha, 0, FrameTime() * 5)
		else
			alpha = math.Approach(alpha, 1, FrameTime() * 5)
		end
			
		x, y = ScrW(), ScrH()
		old = render.GetRenderTarget()
		
		ang = self.Wep:GetAttachment(self.Wep:LookupAttachment("muzzle")).Ang
		ang:RotateAroundAxis(ang:Forward(), -90)
		ang:RotateAroundAxis(ang:Right(), 0.55)
		
		cd.angles = ang
		cd.origin = self.Owner:GetShootPos()
		cd.x = 0
		cd.y = 0
		cd.w = 512 
		cd.h = 512
		cd.fov = 5.6
		cd.drawviewmodel = false
		cd.drawhud = false
		render.SetRenderTarget(self.ScopeRT)
		render.SetViewPort(0, 0, 512, 512)
			
			if alpha < 1 or Ini then
				render.RenderView(cd)
				Ini = false
			end
			
			ang = self.Owner:EyeAngles()
			ang.p = ang.p + self.BlendAng.x
			ang.y = ang.y + self.BlendAng.y
			ang.r = ang.r + self.BlendAng.z
			ang = -ang:Forward()
			local light = render.ComputeLighting(self.Owner:GetShootPos(), ang)
			
			cam.Start2D()
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(lensring)
				surface.DrawTexturedRect(0, 0, 512, 512)
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(sight)
				surface.DrawTexturedRect(0, 0, 512, 512)
				surface.SetDrawColor(150 * light[1], 150 * light[2], 150 * light[3], 255 * alpha)
				surface.SetTexture(lens)
				surface.DrawTexturedRect(0, 0, 512, 512)
			cam.End2D()
			
		render.SetViewPort(0, 0, x, y)
		render.SetRenderTarget(old)
			
		if self.PSO1Glass then
			self.PSO1Glass:SetTexture("$basetexture", self.ScopeRT)
		end
	end
end