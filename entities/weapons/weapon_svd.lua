AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Dragunov SVD"
    SWEP.Slot = 3
    SWEP.SlotPos = 0
	SWEP.YawMod = 0.1
	
	SWEP.AimPos = Vector(-2.286, -4.191, 0.825)
	SWEP.AimAng = Vector(-0.045, -0.05, 0)

	--SWEP.SprintPos = Vector(0.75, -4.55, -0.45)
	--SWEP.SprintAng = Vector(-11, 25, -15)

	SWEP.AimSens = 0.15

	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.Shell = "7.62x51"
	SWEP.AttachmentBGs = {["suppressor"] = {bg = 2, sbg = 1}}
	
	SWEP.WMAng = Vector(-15, 180, 180)
	SWEP.WMPos = Vector(1, -3, -1.25)
	SWEP.TargetViewModelFOV = 50
	SWEP.CanPeek = true
	SWEP.BlurOnAim = true
end

SWEP.Attachments = {[1] = {header = "Barrel", x = 50, atts = {"suppressor"}}}

SWEP.BulletLength = 7.62
SWEP.CaseLength = 51
SWEP.EmptySound = Sound("weapons/empty_sniperrifles.wav")

SWEP.Anims = {}
SWEP.Anims.Draw_First = "deploy"
SWEP.Anims.Draw = "deploy"
SWEP.Anims.Draw_Empty = "deploy"
SWEP.Anims.Holster = "holster"
SWEP.Anims.Holster_Empty = "holster"
SWEP.Anims.Fire = {"fire", "fire2", "fire3"}
SWEP.Anims.Fire_Last = "fire"
SWEP.Anims.Idle = "idle"
SWEP.Anims.Idle_Aim = "idle_scoped"
SWEP.Anims.Reload = "reload"
SWEP.Anims.Reload_Nomen = "reload_nomen"
SWEP.Anims.Reload_Empty = "reload_empty"
SWEP.Anims.Reload_Empty_Nomen = "reload_empty_nomen"
SWEP.Anims.Fire_Aiming = "idle"

SWEP.Sounds = {}
SWEP.Sounds = {}
SWEP.Sounds["deploy_first2"] = {[1] = {time = 1.05, sound = Sound("FAS2_M14.BoltRelease")}}

SWEP.Sounds["reload"] = {[1] = {time = 0.5, sound = Sound("FAS2_SVD.MagOut")},
	[2] = {time = 1, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.8, sound = Sound("FAS2_SVD.MagIn")}}
	
SWEP.Sounds["reload_nomen"] = {[1] = {time = 0.5, sound = Sound("FAS2_SVD.MagOut")},
	[2] = {time = 1.0, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.5, sound = Sound("FAS2_SVD.MagIn")}}
	
SWEP.Sounds["reload_empty"] = {[1] = {time = 0.45, sound = Sound("FAS2_SVD.MagOutEmpty")},
	[2] = {time = 1, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.96, sound = Sound("FAS2_SVD.MagIn")},
	[4] = {time = 3.81, sound = Sound("FAS2_SVD.BoltBack")},
	[5] = {time = 3.99, sound = Sound("FAS2_SVD.BoltForward")}}
	
SWEP.Sounds["reload_empty_nomen"] = {[1] = {time = 0.35, sound = Sound("FAS2_SVD.MagOutEmpty")},
	[2] = {time = 1, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.82, sound = Sound("FAS2_SVD.MagIn")},
	[4] = {time = 3, sound = Sound("FAS2_SVD.BoltBack")},
	[5] = {time = 3.28, sound = Sound("FAS2_SVD.BoltForward")}}

SWEP.FireModes = {"semi"}

SWEP.Category = "FA:S 2 Weapons"
SWEP.Base = "fas2_base"
SWEP.Author            = "Spy"
SWEP.Instructions    = ""
SWEP.Contact        = ""
SWEP.Purpose        = ""

SWEP.ViewModelFOV    = 52
SWEP.ViewModelFlip    = false

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true

SWEP.VM = "models/weapons/view/support/svd_update.mdl"
SWEP.WM = "models/weapons/w_sr25.mdl"
SWEP.WorldModel   = "models/weapons/w_snip_sg550.mdl"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 10
SWEP.Primary.DefaultClip    = 0
SWEP.Primary.Automatic       = false   
SWEP.Primary.Ammo             = "sniperround"
 
-- Secondary Fire Attributes --
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic       = false
SWEP.Secondary.Ammo         = "none"

-- Deploy related
SWEP.FirstDeployTime = 0.45
SWEP.DeployTime = 0.7
SWEP.DeployAnimSpeed = 0.75

-- Firing related
SWEP.Shots = 1
SWEP.FireDelay = 60/200
SWEP.Damage = 42
SWEP.FireSound = Sound("FAS2_SVD")
SWEP.FireSound_Suppressed = Sound("FAS2_SVD_S")

-- Accuracy related
SWEP.HipCone = 0.09
SWEP.AimCone = 0.0006
SWEP.SpreadPerShot = 0.02
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadCooldown = 0.4
SWEP.VelocitySensitivity = 2.2
SWEP.AimFOV = 0

-- Recoil related
SWEP.Recoil = 1.9
SWEP.RecoilHorizontal = 2.0

-- Reload related
SWEP.ReloadTime = 2.6
SWEP.ReloadTime_Nomen = 1.9
SWEP.ReloadTime_Empty = 4.5
SWEP.ReloadTime_Empty_Nomen = 3.2

if CLIENT then
	local old, x, y, ang
	local sight = surface.GetTextureID("sprites/scope_pso_illum")
	local sight2 = surface.GetTextureID("sprites/scope_pso")
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