if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.ExtraMags = 4
end

if CLIENT then
    SWEP.PrintName = "M16A2"
    SWEP.Slot = 3
    SWEP.SlotPos = 0
	SWEP.YawMod = 0.1

	SWEP.AimPos = Vector(-2.2745, -2.5, 0.363)
	SWEP.AimAng = Vector(-0.1, 0, 1.75)
	
	SWEP.CompM4Pos = Vector(-2.28, -1.2, -0.6)
	SWEP.CompM4Ang = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.28, -2.2, -0.8)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(-0.15, -2.55, -0.3)
	SWEP.SprintAng = Vector(-12, 10, -10)
		
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.Shell = "5.56x45"
	SWEP.HideWorldModel = true
	SWEP.AttachmentBGs = {["compm4"] = {bg = 3, sbg = 1},
		["eotech"] = {bg = 3, sbg = 2},
		["suppressor"] = {bg = 2, sbg = 1}}
		
	SWEP.WMAng = Vector(-13, 90, 180)
	SWEP.WMPos = Vector(-8.8, 0, 2.8)
	SWEP.TargetViewModelFOV = 40
end

SWEP.Attachments = {[1] = {header = "Sight", sight = true, x = 800, y = 100, atts = {"compm4", "eotech"}},
	[2] = {header = "Barrel", x = 50, y = -200, atts = {"suppressor"}}}

SWEP.BulletLength = 5.56
SWEP.CaseLength = 45
SWEP.EmptySound = Sound("weapons/empty_battlerifles.wav")

SWEP.Anims = {}
SWEP.Anims.Draw_First = "deploy_first"
SWEP.Anims.Draw = "deploy"
SWEP.Anims.Draw_Empty = "deploy_empty"
SWEP.Anims.Holster = "holster"
SWEP.Anims.Holster_Empty = "holster_empty"
SWEP.Anims.Fire = {"fire", "fire2", "fire3"}
SWEP.Anims.Fire_Last = "idle_scoped"
SWEP.Anims.Fire_Aiming = "shoot_scoped"
SWEP.Anims.Fire_Aiming_Last = "idle_scoped_empty"
SWEP.Anims.Idle = "idle"
SWEP.Anims.Idle_Aim = "idle_Scoped"
SWEP.Anims.Reload = "reload"
SWEP.Anims.Reload_Nomen = "reload_nomen"
SWEP.Anims.Reload_Empty = "reload_empty"
SWEP.Anims.Reload_Empty_Nomen = "reload_empty_nomen"

SWEP.Sounds = {}

SWEP.Sounds["deploy_first"] = {[1] = {time = 0.91, sound = Sound("FAS2_M16.MagHousing")},
	[2] = {time = 1.93, sound = Sound("FAS2_M16.ChargeBack")},
	[3] = {time = 2.05, sound = Sound("FAS2_M16.ReleaseHandle")}}
	
SWEP.Sounds["reload"] = {[1] = {time = 0.42, sound = Sound("FAS2_M16.Magout")},
	[2] = {time = 0.69, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.21, sound = Sound("FAS2_M16.Magin")}}
	
SWEP.Sounds["reload_nomen"] = {[1] = {time = 0.34, sound = Sound("FAS2_M16.Magout")},
	[2] = {time = 0.5, sound = Sound("MagPouch_AR")},
	[3] = {time = 0.98, sound = Sound("FAS2_M16.Magin")}}
	
SWEP.Sounds["reload_empty"] = {[1] = {time = 0.35, sound = Sound("FAS2_M16.MagoutEmpty")},
	[2] = {time = 0.6, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.215, sound = Sound("FAS2_M16.Magin")},
	[4] = {time = 2.13, sound = Sound("FAS2_M16.BoltCatch")}}
	
SWEP.Sounds["reload_empty_nomen"] = {[1] = {time = 0.4, sound = Sound("FAS2_M16.MagoutEmpty")},
	[2] = {time = 0.6, sound = Sound("MagPouch_AR")},
	[3] = {time = 0.99, sound = Sound("FAS2_M16.Magin")},
	[4] = {time = 1.59, sound = Sound("FAS2_M16.BoltCatch")}}
	
SWEP.FireModes = {"3burst", "semi"}

SWEP.Category = "FA:S 2 Weapons"
SWEP.Base = "fas2_base"
SWEP.Author            = "Spy"
SWEP.Instructions    = ""
SWEP.Contact        = ""
SWEP.Purpose        = ""

SWEP.ViewModelFOV    = 59
SWEP.ViewModelFlip    = false

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true

SWEP.VM = "models/weapons/view/rifles/m16a2.mdl"
SWEP.WM = "models/weapons/b_m16a2.mdl"
SWEP.WorldModel   = "models/weapons/b_m16a2.mdl"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 30
SWEP.Primary.DefaultClip    = 60
SWEP.Primary.Automatic       = true    
SWEP.Primary.Ammo             = "5.56x45MM"
 
-- Secondary Fire Attributes --
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic       = false
SWEP.Secondary.Ammo         = "none"

-- Deploy related
SWEP.FirstDeployTime = 3.2
SWEP.DeployTime = 0.41

-- Firing related
SWEP.Shots = 1
SWEP.FireDelay = 0.081
SWEP.Damage = 32
SWEP.FireSound = Sound("FAS2_M16")
SWEP.FireSound_Suppressed = Sound("FAS2_M16_S")

-- Accuracy related
SWEP.HipCone = 0.045
SWEP.AimCone = 0.00805
SWEP.SpreadPerShot = 0.014
SWEP.MaxSpreadInc = 0.035
SWEP.SpreadCooldown = 0.25
SWEP.VelocitySensitivity = 1.4
SWEP.AimFOV = 5

-- Recoil related
SWEP.ViewKick = 0.853
SWEP.Recoil = 0.511

-- Reload related
SWEP.ReloadTime = 1.76
SWEP.ReloadTime_Nomen = 1.4
SWEP.ReloadTime_Empty = 2.65
SWEP.ReloadTime_Empty_Nomen = 1.8

if CLIENT then
	local old, x, y, ang
	local sight = surface.GetTextureID("sprites/scope_leo")
	local lens = surface.GetTextureID("VGUI/fas2/lense")
	local lensring = surface.GetTextureID("VGUI/fas2/lensring")
	local cd, alpha = {}, 0.5
	local Ini = true
	
	function SWEP:DrawRenderTarget()
		if self.AimPos == self.LeupoldPos then
			if self.dt.Status == FAS_STAT_ADS then
				alpha = math.Approach(alpha, 0, FrameTime() * 5)
			else
				alpha = math.Approach(alpha, 1, FrameTime() * 5)
			end
			
			x, y = ScrW(), ScrH()
			old = render.GetRenderTarget()
		
			ang = self.Wep:GetAttachment(self.Wep:LookupAttachment("muzzle")).Ang
			ang:RotateAroundAxis(ang:Forward(), -90)
			
			cd.angles = ang
			cd.origin = self.Owner:GetShootPos()
			cd.x = 0
			cd.y = 0
			cd.w = 512
			cd.h = 512
			cd.fov = 2.5
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
end