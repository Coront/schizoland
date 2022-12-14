AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "M4A1"
    SWEP.Slot = 3
    SWEP.SlotPos = 0
	
	SWEP.AimPos = Vector(-2.044, -4.2, 0.446)
	SWEP.AimAng = Vector(0, 0, 0)
	
	SWEP.CompM4Pos = Vector(-2.04, -2, 0.6)
	SWEP.CompM4Ang = Vector(-0.631, 0, 0)
	
	SWEP.ELCANPos = Vector(-2.04, -2, 0.43)
	SWEP.ELCANAng = Vector(-0.631, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.04, -4.848, 0.537)
	SWEP.EoTechAng = Vector(-0.631, 0, 0)
	
	SWEP.YawMod = 0.1
	SWEP.SuppressorBodygroup = 3
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.Shell = "5.56x45"
	SWEP.AttachmentBGs = {["compm4"] = {bg = 2, sbg = 1},
		["eotech"] = {bg = 2, sbg = 2},
		["c79"] = {bg = 2, sbg = 3},
		["suppressor"] = {bg = 3, sbg = 1}}
		
	SWEP.WMAng = Vector(180, -180, 0)
	SWEP.WMPos = Vector(-0.8, 11.4, 3.5)
	
	SWEP.HideWorldModel = true
end

SWEP.ASID = "wep_m4a1"

SWEP.Attachments = {
	[1] = {header = "Sight", sight = true, x = 600, y = -50, atts = {"c79", "compm4", "eotech"}},
	[2] = {header = "Barrel", x = 50, y = -200, atts = {"suppressor"}}}

SWEP.BulletLength = 5.56
SWEP.CaseLength = 45
SWEP.EmptySound = Sound("weapons/empty_assaultrifles.wav")

SWEP.Anims = {}
SWEP.Anims.Draw_First = "deploy"
SWEP.Anims.Draw = "deploy"
SWEP.Anims.Draw_Empty = "deploy_empty"
SWEP.Anims.Holster = "holster"
SWEP.Anims.Holster_Empty = "holster_empty"
SWEP.Anims.Fire = {"shoot", "shoot2", "shoot3"}
SWEP.Anims.Fire_Last = "shoot_last"
SWEP.Anims.Fire_Aiming = {"shoot1_scoped", "shoot2_scoped", "shoot3_scoped"}
SWEP.Anims.Fire_Aiming_Last = "shoot_last_scoped"
SWEP.Anims.Idle = "idle"
SWEP.Anims.Idle_Aim = "idle_scoped"
SWEP.Anims.Reload = "reload"
SWEP.Anims.Reload_Nomen = "reload_nomen"
SWEP.Anims.Reload_Empty = "reload_empty"
SWEP.Anims.Reload_Empty_Nomen = "reload_empty_nomen"

SWEP.Sounds = {}

SWEP.Sounds["deploy_first"] = {[1] = {time = 0.9, sound = Sound("Weapon_M4A1.StockPull")},
	[2] = {time = 1.5, sound = Sound("Weapon_M4A1.ChargeBack")},
	[3] = {time = 1.65, sound = Sound("Weapon_M4A1.ReleaseHandle")},
	[4] = {time = 2.2, sound = Sound("Weapon_M4A1.Check")},
	[5] = {time = 3.6, sound = Sound("Weapon_M4A1.Forwardassist")},
	[6] = {time = 4.05, sound = Sound("Weapon_M4A1.DustCover")},
	[7] = {time = 4.8, sound = Sound("Weapon_M4A1.Switch")}}
	
SWEP.Sounds["reload"] = {[1] = {time = 0.7, sound = Sound("Weapon_M4A1.Magout")},
	[2] = {time = 1.5, sound = Sound("MagPouch_AR")},
	[3] = {time = 2.05, sound = Sound("Weapon_M4A1.Magin")}}
	
SWEP.Sounds["reload_nomen"] = {[1] = {time = 0.3, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.8, sound = Sound("Weapon_M4A1.Magout")},
	[3] = {time = 1.1, sound = Sound("Weapon_M4A1.Magin")}}
	
SWEP.Sounds["reload_empty"] = {[1] = {time = 0.7, sound = Sound("Weapon_M4A1.MagoutEmpty")},
	[2] = {time = 1.15, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.7, sound = Sound("Weapon_M4A1.Magin")},
	[4] = {time = 2.3, sound = Sound("Weapon_M4A1.Boltcatch")}}
	
SWEP.Sounds["reload_empty_nomen"] = {[1] = {time = 0.4, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.7, sound = Sound("Weapon_M4A1.MagoutEmpty")},
	[3] = {time = 1.1, sound = Sound("Weapon_M4A1.Magin")},
	[4] = {time = 1.6, sound = Sound("Weapon_M4A1.Boltcatch")}}
	
SWEP.FireModes = {"auto", "3burst", "semi"}

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

SWEP.VM = "models/weapons/view/rifles/m4a1.mdl"
SWEP.WM = "models/items/weapons/m4a1.mdl"
SWEP.WorldModel   = "models/weapons/w_rif_m4a1.mdl"
SWEP.HoldType = "smg"

-- Primary Fire Attributes --
SWEP.Primary.ClipSize        = 30
SWEP.Primary.DefaultClip    = 0
SWEP.Primary.Automatic       = true    
SWEP.Primary.Ammo             = "ar2"
 
-- Secondary Fire Attributes --
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic       = false
SWEP.Secondary.Ammo         = "none"

-- Deploy related
SWEP.FirstDeployTime = 0.6
SWEP.DeployTime = 0.6
SWEP.DeployAnimSpeed = 0.7
SWEP.HolsterTime = 0.3

-- Firing related
SWEP.Shots = 1
SWEP.FireDelay = 60/700
SWEP.Damage = 26
SWEP.FireSound = Sound("FAS2_M4A1")
SWEP.FireSound_Suppressed = Sound("FAS2_M4A1_S")

-- Accuracy related
SWEP.HipCone = 0.082
SWEP.AimCone = 0.004
SWEP.SpreadPerShot = 0.009
SWEP.MaxSpreadInc = 0.065
SWEP.SpreadCooldown = 0.15
SWEP.AimFOV = 0

-- Recoil related
SWEP.Recoil = 1.5
SWEP.RecoilHorizontal = 0.8

-- Reload related
SWEP.ReloadTime = 2.6
SWEP.ReloadTime_Nomen = 1.9
SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadTime_Empty_Nomen = 1.9

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
		cd.fov = 5
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