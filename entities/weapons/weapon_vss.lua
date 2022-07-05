AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "VSS Vintorez"
    SWEP.Slot = 3
    SWEP.SlotPos = 0

	SWEP.AimPos = Vector(-2.189, -4.449, 0.928)
	SWEP.AimAng = Vector(0.74, 0, 0)

	SWEP.PSO1Pos = Vector(-2.028, -4.259, 0.398)
	SWEP.PSO1Ang = Vector(0, 0, 0)

	SWEP.YawMod = 0.1
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.Shell = "9x19"
	SWEP.AttachmentBGs = {
		["pso1"] = {bg = 2, sbg = 1}
	}

	SWEP.VMOffset = Vector( 0, 0, 0.7 )
	
	SWEP.WMAng = Vector(0, 0, 180)
	SWEP.WMPos = Vector(-0.5, 13.5, -4)
end

SWEP.ASID = "wep_vss"

SWEP.Attachments = {[1] = {header = "Sight", sight = true, x = 400, y = -50, atts = {"pso1"}},
}

SWEP.BulletLength = 9
SWEP.CaseLength = 19

SWEP.Anims = {}
SWEP.Anims.Draw_First = "deploy"
SWEP.Anims.Draw = "deploy"
SWEP.Anims.Draw_Empty = "deploy"
SWEP.Anims.Holster = "holster"
SWEP.Anims.Holster_Empty = "holster"
SWEP.Anims.Fire = "fire"
SWEP.Anims.Fire_Last = "fire"
SWEP.Anims.Fire_Aiming = "fire_ironsight"
SWEP.Anims.Fire_Aiming_Last = "fire_ironsight"
SWEP.Anims.Idle = "idle"
SWEP.Anims.Idle_Aim = "idle"
SWEP.Anims.Reload = "reload"
SWEP.Anims.Reload_Nomen = "reload"
SWEP.Anims.Reload_Empty = "reload_empty"
SWEP.Anims.Reload_Empty_Nomen = "reload_empty"

SWEP.Sounds = {}

SWEP.Sounds["deploy_first"] = {[1] = {time = 0.85, sound = Sound("FAS2_MP5A5.SelectorSwitch")}}
	
SWEP.Sounds["reload"] = {[1] = {time = 0.3, sound = Sound("Weapon_G3.MagOut")},
	[2] = {time = 1.2, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.6, sound = Sound("Weapon_G3.MagIn")}}

SWEP.Sounds["reload_empty"] = {[1] = {time = 0.3, sound = Sound("Weapon_G3.MagOut")},
[2] = {time = 1.2, sound = Sound("MagPouch_AR")},
[3] = {time = 1.6, sound = Sound("Weapon_G3.MagIn")},
[4] = {time = 3, sound = Sound("Weapon_ak74.BoltPull")},

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

SWEP.VM = "models/weapons/vss.mdl"
SWEP.WM = "models/items/weapons/vss.mdl"
SWEP.WorldModel   = "models/items/weapons/vss.mdl"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 20
SWEP.Primary.DefaultClip    = 0
SWEP.Primary.Automatic       = true    
SWEP.Primary.Ammo             = "gravity"

-- Secondary Fire Attributes --
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic = true --       = false
SWEP.Secondary.Ammo         = "none"

-- Deploy related
SWEP.FirstDeployTime = 1.75
SWEP.DeployTime = 0.5
SWEP.HolsterTime = 0.35
SWEP.DeployAnimSpeed = 0.75

-- Firing related
SWEP.Shots = 1
SWEP.FireDelay = 60/1300
SWEP.Damage = 22
SWEP.FireSound = Sound("weapon/vss_fire.wav")
SWEP.FireSound_Suppressed = Sound("weapon/vss_fire.wav")

-- Accuracy related
SWEP.HipCone = 0.09
SWEP.AimCone = 0.005
SWEP.SpreadPerShot = 0.006
SWEP.MaxSpreadInc = 0.032
SWEP.SpreadCooldown = 0.16
SWEP.AimFOV = 0

-- Recoil related
SWEP.Recoil = 1.1
SWEP.RecoilHorizontal = 0.3

-- Reload related
SWEP.ReloadTime = 2.2
SWEP.ReloadTime_Nomen = 2.2
SWEP.ReloadTime_Empty = 3.4
SWEP.ReloadTime_Empty_Nomen = 3.4

if CLIENT then

	local x, y, old, ang
	local sight = surface.GetTextureID("sprites/scope_pso_illum")
	local sight2 = surface.GetTextureID("sprites/scope_pso")
	local lens = surface.GetTextureID("VGUI/fas2/lense")
	local lensring = surface.GetTextureID("VGUI/fas2/lensring")
	local cd, alpha = {}, 0.5
	local Ini = true

	SWEP.PSO1Glass = Material("models/items/weapons/lens_envsolid")

	function SWEP:DrawRenderTarget()
		if self.AimPos != self.PSO1Pos then
			return
		end
		
		if self.dt.Status == FAS_STAT_ADS and not self.Peeking then
			alpha = math.Approach(alpha, 0, FrameTime() * 5)
		else
			alpha = math.Approach(alpha, 1, FrameTime() * 5)
		end
			
		x, y = ScrW(), ScrH()
		old = render.GetRenderTarget()
		
		ang = self.Wep:GetAttachment(self.Wep:LookupAttachment("muzzle")).Ang
		ang:RotateAroundAxis(ang:Forward(), -0)
		
		cd.angles = ang
		cd.origin = self.Owner:GetShootPos()
		cd.x = 0
		cd.y = 0
		cd.w = 512 
		cd.h = 512
		cd.fov = 4
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
				surface.SetTexture(sight2)
				surface.DrawTexturedRect(1, 1, 512, 512)
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