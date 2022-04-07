if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.ExtraMags = 4
end

if CLIENT then
    SWEP.PrintName = "M14"
    SWEP.Slot = 3
    SWEP.SlotPos = 0
	SWEP.YawMod = 0.1

	SWEP.AimPos = Vector(-2.56, -5.354, 1.363)
	SWEP.AimAng = Vector(0, 0, 0)
	
	SWEP.CompM4Pos = Vector(-2.56, -2, 0.54)
	SWEP.CompM4Ang = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.56, -5.354, 0.15)
	SWEP.EoTechAng = Vector(0, 0, 0)
		
	SWEP.LeupoldPos = Vector(-2.56, -4.8, 0.71)
	SWEP.LeupoldAng = Vector(0, 0, 0)
		
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.Shell = "7.62x51"
	SWEP.HideWorldModel = true
	SWEP.AttachmentBGs = {["compm4"] = {bg = 2, sbg = 1},
		["eotech"] = {bg = 2, sbg = 2},
		["leupold"] = {bg = 2, sbg = 3},
		["suppressor"] = {bg = 3, sbg = 1}}
		
	SWEP.WMAng = Vector(0, 180, 180)
	SWEP.WMPos = Vector(1, -3, 0.25)
	SWEP.TargetViewModelFOV = 40
end

SWEP.Attachments = {[1] = {header = "Sight", sight = true, x = 800, y = 100, atts = {"leupold", "compm4", "eotech"}},
	[2] = {header = "Barrel", x = 50, y = -200, atts = {"suppressor"}}}

SWEP.BulletLength = 7.62
SWEP.CaseLength = 51
SWEP.EmptySound = Sound("weapons/empty_battlerifles.wav")

SWEP.Anims = {}
SWEP.Anims.Draw_First = "deploy_first2"
SWEP.Anims.Draw = "deploy"
SWEP.Anims.Draw_Empty = "deploy_empty"
SWEP.Anims.Holster = "holster"
SWEP.Anims.Holster_Empty = "holster_empty"
SWEP.Anims.Fire = {"shoot", "shoot2", "shoot3"}
SWEP.Anims.Fire_Last = "shoot_last"
SWEP.Anims.Fire_Aiming = "shoot_scoped"
SWEP.Anims.Fire_Aiming_Last = "shoot_last_scoped"
SWEP.Anims.Idle = "idle"
SWEP.Anims.Idle_Aim = "idle_scoped"
SWEP.Anims.Reload = "reload"
SWEP.Anims.Reload_Nomen = "reload_nomen"
SWEP.Anims.Reload_Empty = "reload_empty"
SWEP.Anims.Reload_Empty_Nomen = "reload_empty_nomen"

SWEP.Sounds = {}

SWEP.Sounds["deploy_first2"] = {[1] = {time = 1.25, sound = Sound("FAS2_M14.BoltRelease")}}
	
SWEP.Sounds["reload"] = {[1] = {time = 0.6, sound = Sound("FAS2_M14.MagOut")},
	[2] = {time = 1.3, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.9, sound = Sound("FAS2_M14.MagIn")}}
	
SWEP.Sounds["reload_nomen"] = {[1] = {time = 0.7, sound = Sound("FAS2_M14.MagOut")},
	[2] = {time = 1.2, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.65, sound = Sound("FAS2_M14.MagIn")}}
	
SWEP.Sounds["reload_empty"] = {[1] = {time = 0.6, sound = Sound("FAS2_M14.MagOutEmpty")},
	[2] = {time = 1.95, sound = Sound("FAS2_M14.MagIn")},
	[3] = {time = 2.6, sound = Sound("MagPouch_AR")},
	[4] = {time = 3.15, sound = Sound("FAS2_M14.BoltRelease")}}
	
SWEP.Sounds["reload_empty_nomen"] = {[1] = {time = 0.6, sound = Sound("FAS2_M14.MagOutEmpty")},
	[2] = {time = 1.5, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.9, sound = Sound("FAS2_M14.MagIn")},
	[4] = {time = 2.35, sound = Sound("FAS2_M14.BoltRelease")}}
	
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

SWEP.VM = "models/weapons/view/rifles/m14.mdl"
SWEP.WM = "models/weapons/w_m14.mdl"
SWEP.WorldModel   = "models/weapons/w_snip_awp.mdl"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 20
SWEP.Primary.DefaultClip    = 40
SWEP.Primary.Automatic       = true    
SWEP.Primary.Ammo             = "7.62x51MM"
 
-- Secondary Fire Attributes --
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic       = false
SWEP.Secondary.Ammo         = "none"

-- Deploy related
SWEP.FirstDeployTime = 2.5
SWEP.DeployTime = 0.45

-- Firing related
SWEP.Shots = 1
SWEP.FireDelay = 0.08
SWEP.Damage = 55
SWEP.FireSound = Sound("FAS2_M14")
SWEP.FireSound_Suppressed = Sound("FAS2_M14_S")

-- Accuracy related
SWEP.HipCone = 0.05
SWEP.AimCone = 0.001
SWEP.SpreadPerShot = 0.015
SWEP.MaxSpreadInc = 0.045
SWEP.SpreadCooldown = 0.2
SWEP.VelocitySensitivity = 2
SWEP.AimFOV = 5

-- Recoil related
SWEP.ViewKick = 1.5
SWEP.Recoil = 1.1

-- Reload related
SWEP.ReloadTime = 2.3
SWEP.ReloadTime_Nomen = 1.9
SWEP.ReloadTime_Empty = 3.7
SWEP.ReloadTime_Empty_Nomen = 2.65

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