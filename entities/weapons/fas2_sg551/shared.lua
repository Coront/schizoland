if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.ExtraMags = 5
end

if CLIENT then
    SWEP.PrintName = "SG 551"
    SWEP.Slot = 3
    SWEP.SlotPos = 0
	
	SWEP.AimPos = Vector(-1.649, -3, 0)
	SWEP.AimAng = Vector(0, 0, 0)
	SWEP.YawMod = 0.1
	
	SWEP.SprintPos = Vector(0.35, -2.25, -1.15)
	SWEP.SprintAng = Vector(-15, 29, -15)
	SWEP.AimSens = 0.2
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.Shell = "5.56x45"
	SWEP.AttachmentBGs = {["suppressor"] = {bg = 2, sbg = 1},
		["sg55x30mag"] = {bg = 3, sbg = 1}}
	SWEP.CanPeek = true
	SWEP.BlurOnAim = true		
		
	SWEP.CustomizePos = Vector(3, -1.92, -1)
	SWEP.CustomizeAng = Vector(19.231, 15.895, 17.747)
	
	SWEP.WMAng = Vector(-10, -0.5, 180)
	SWEP.WMPos = Vector(-0.5, 12.5, -3.75)
end

SWEP.Attachments = {
	[1] = {header = "Barrel", x = 150, y = 200, atts = {"suppressor"}},
	[2] = {header = "Magazine", y = 500, x = 500, atts = {"sg55x30mag"}}}

SWEP.BulletLength = 5.56
SWEP.CaseLength = 45
SWEP.EmptySound = Sound("weapons/empty_assaultrifles.wav")

SWEP.Anims = {}
SWEP.Anims.Draw_First = "draw_first"
SWEP.Anims.Draw = "deploy"
SWEP.Anims.Draw_Empty = "deploy_empty"
SWEP.Anims.Holster = "holster"
SWEP.Anims.Holster_Empty = "holster_empty"
SWEP.Anims.Fire = {"fire", "fire2", "fire3"}
SWEP.Anims.Fire_Last = "fire_last"
SWEP.Anims.Fire_Aiming = {"fire_scoped", "fire_scoped2", "fire_scoped3"}
SWEP.Anims.Fire_Aiming_Last = "fire_scoped_last"
SWEP.Anims.Idle = "idle"
SWEP.Anims.Idle_Aim = "idle_scoped"
SWEP.Anims.Reload = "reload"
SWEP.Anims.Reload_Nomen = "reload_nomen"
SWEP.Anims.Reload_Empty = "reload_empty"
SWEP.Anims.Reload_Empty_Nomen = "reload_empty_nomen"

SWEP.Sounds = {}

SWEP.Sounds["draw_first"] = {[1] = {time = 0.6, sound = Sound("MagPouch_AR")},
	[2] = {time = 1.05, sound = Sound("Weapon_SG550.MagIn")},
	[3] = {time = 2.31, sound = Sound("Weapon_SG550.BoltBack")},
	[4] = {time = 2.71, sound = Sound("Weapon_SG550.BoltForward")},
	[5] = {time = 3.2, sound = Sound("MagPouch_AR")}}
	
SWEP.Sounds["reload"] = {[1] = {time = 0.45, sound = Sound("Weapon_M4A1.Switch")},
	[2] = {time = 0.65, sound = Sound("Weapon_SG550.MagOut")},
	[3] = {time = 1.3, sound = Sound("MagPouch_AR")},
	[4] = {time = 1.8, sound = Sound("Weapon_SG550.Magin")}}
	
SWEP.Sounds["reload_nomen"] = {[1] = {time = 0.3, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.6, sound = Sound("Grip_Heavy")},
	[3] = {time = 0.8, sound = Sound("Weapon_SG550.MagOut")},
	[4] = {time = 1.25, sound = Sound("Weapon_SG550.Magin")}}
	
SWEP.Sounds["reload_empty"] = {[1] = {time = 0.45, sound = Sound("Weapon_M4A1.Switch")},
	[2] = {time = 0.65, sound = Sound("Weapon_SG550.MagOutEmpty")},
	[3] = {time = 1.3, sound = Sound("MagPouch_AR")},
	[4] = {time = 2.1, sound = Sound("Weapon_SG550.Magin")},
	[5] = {time = 2.8, sound = Sound("Weapon_M4A1.Boltcatch")}}
	
SWEP.Sounds["reload_empty_nomen"] = {[1] = {time = 0.3, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.6, sound = Sound("Grip_Heavy")},
	[3] = {time = 0.8, sound = Sound("Weapon_SG550.MagOutEmpty")},
	[4] = {time = 1.25, sound = Sound("Weapon_SG550.Magin")},
	[5] = {time = 1.8, sound = Sound("Weapon_M4A1.Boltcatch")}}
	
SWEP.FireModes = {"auto", "3burst", "semi"}

SWEP.Category = "FA:S 2 Weapons"
SWEP.Base = "fas2_base"
SWEP.Author            = "Spy"
SWEP.Contact        = ""
SWEP.Purpose        = ""

SWEP.ViewModelFOV    = 62
SWEP.ViewModelFlip    = false

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true

SWEP.VM = "models/weapons/view/support/sg551_s.mdl"
SWEP.WM = "models/weapons/w_snip_sg550.mdl"
SWEP.WorldModel   = "models/weapons/w_snip_sg550.mdl"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 20
SWEP.Primary.DefaultClip    = 100
SWEP.Primary.Automatic       = true    
SWEP.Primary.Ammo             = "5.56x45MM"
 
-- Secondary Fire Attributes --
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic       = false
SWEP.Secondary.Ammo         = "none"

-- Deploy related
SWEP.FirstDeployTime = 4
SWEP.DeployTime = 0.7

-- Firing related
SWEP.Shots = 1
SWEP.FireDelay = 0.125865
SWEP.Damage = 33
SWEP.FireSound = Sound("FAS2_SG550")
SWEP.FireSound_Suppressed = Sound("FAS2_SG550_S")

-- Accuracy related
SWEP.HipCone = 0.06
SWEP.AimCone = 0.002
SWEP.SpreadPerShot = 0.25
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadCooldown = 0.02
SWEP.VelocitySensitivity = 1.4
SWEP.AimFOV = 10

-- Recoil related
SWEP.ViewKick = 0.521
SWEP.Recoil = 1.055

-- Reload related
SWEP.ReloadTime = 2.55
SWEP.ReloadTime_Nomen = 2.02
SWEP.ReloadTime_Empty = 3.3
SWEP.ReloadTime_Empty_Nomen = 2.3

if CLIENT then
	local old, x, y, ang
	local sight = surface.GetTextureID("sprites/scope_leo")
	local lens = surface.GetTextureID("VGUI/fas2/lense")
	local lensring = surface.GetTextureID("VGUI/fas2/lensring")
	local cd, alpha = {}, 0.5
	local Ini = true
	
	function SWEP:DrawRenderTarget()
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
		cd.fov = 4.5
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