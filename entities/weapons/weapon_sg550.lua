AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "SG 550"
    SWEP.Slot = 3
    SWEP.SlotPos = 0
	
	SWEP.AimPos = Vector(-1.649, -2.757, 0.463)
	SWEP.AimAng = Vector(0.282, 0, 0)
	
	SWEP.EoTechPos = Vector(-1.65, -2.727, -0.134)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-1.647, -3.79, -0.073)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.YawMod = 0.1
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.Shell = "5.56x45"
	SWEP.AttachmentBGs = {["eotech"] = {bg = 3, sbg = 1},
		["suppressor"] = {bg = 2, sbg = 1}}
		
	SWEP.WMAng = Vector(0, 180, 180)
	SWEP.WMPos = Vector(1, -3, 0.25)

	SWEP.BodyGroups = {
		["Magazine"] = 1,
	}
end

SWEP.ASID = "wep_sg550"

SWEP.Attachments = {[1] = {header = "Sight", sight = true, x = 700, y = 20, atts = {"eotech"}},
	[2] = {header = "Barrel", x = 50, y = -200, atts = {"suppressor"}}}

SWEP.BulletLength = 5.56
SWEP.CaseLength = 45
SWEP.EmptySound = Sound("weapons/empty_assaultrifles.wav")

SWEP.Anims = {}
SWEP.Anims.Draw_First = "draw_first"
SWEP.Anims.Draw = "deploy"
SWEP.Anims.Holster = "holster"
SWEP.Anims.Holster_Empty = "holster_empty"
SWEP.Anims.Draw_Empty = "deploy_empty"
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

SWEP.Sounds["draw_first"] = {[1] = {time = 0.5, sound = Sound("MagPouch_AR")},
	[2] = {time = 1.5, sound = Sound("Weapon_SG550.MagIn")},
	[3] = {time = 2.45, sound = Sound("Weapon_SG550.BoltBack")},
	[4] = {time = 2.8, sound = Sound("Weapon_SG550.BoltForward")}}
	
SWEP.Sounds["reload"] = {[1] = {time = 0.65, sound = Sound("Weapon_SG550.MagOut")},
	[2] = {time = 1.3, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.8, sound = Sound("Weapon_SG550.Magin")}}
	
SWEP.Sounds["reload_nomen"] = {[1] = {time = 0.3, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.6, sound = Sound("Grip_Heavy")},
	[3] = {time = 0.8, sound = Sound("Weapon_SG550.MagOut")},
	[4] = {time = 1.25, sound = Sound("Weapon_SG550.Magin")}}
	
SWEP.Sounds["reload_empty"] = {[1] = {time = 0.65, sound = Sound("Weapon_SG550.MagOutEmpty")},
	[2] = {time = 1.3, sound = Sound("MagPouch_AR")},
	[3] = {time = 2.1, sound = Sound("Weapon_SG550.Magin")},
	[4] = {time = 2.8, sound = Sound("Weapon_M4A1.Boltcatch")}}
	
SWEP.Sounds["reload_empty_nomen"] = {[1] = {time = 0.3, sound = Sound("MagPouch_AR")},
	[2] = {time = 0.6, sound = Sound("Grip_Heavy")},
	[3] = {time = 0.8, sound = Sound("Weapon_SG550.MagOutEmpty")},
	[4] = {time = 1.25, sound = Sound("Weapon_SG550.Magin")},
	[5] = {time = 1.8, sound = Sound("Weapon_M4A1.Boltcatch")}}
	
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

SWEP.VM = "models/weapons/view/rifles/sg550.mdl"
SWEP.WM = "models/weapons/w_sg550.mdl"
SWEP.WorldModel   = "models/props_junk/PopCan01a.mdl"

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
SWEP.FirstDeployTime = 4
SWEP.DeployTime = 0.7
SWEP.DeployAnimTime = 0.75

-- Firing related
SWEP.Shots = 1
SWEP.FireDelay = 60/850
SWEP.Damage = 20
SWEP.FireSound = Sound("FAS2_SG550")
SWEP.FireSound_Suppressed = Sound("FAS2_SG550_S")

-- Accuracy related
SWEP.HipCone = 0.08
SWEP.AimCone = 0.005
SWEP.SpreadPerShot = 0.008
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadCooldown = 0.15
SWEP.VelocitySensitivity = 1.6
SWEP.AimFOV = 0

-- Recoil related
SWEP.Recoil = 1.7
SWEP.RecoilHorizontal = 0.6

-- Reload related
SWEP.ReloadTime = 2.6
SWEP.ReloadTime_Nomen = 1.9
SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadTime_Empty_Nomen = 1.9

if CLIENT then
	local x, y, old, t
	local sight = surface.GetTextureID("models/weapons/view/accessories/Acog/reticle_chevron")
	local lens = surface.GetTextureID("VGUI/fas2/lense")
	local cd, alpha = {}, 0.5
	
	function SWEP:DrawRenderTarget()
		if self.AimPos == self.ACOGPos then
			if self.dt.Status == FAS_STAT_ADS then
				alpha = math.Approach(alpha, 0, FrameTime() * 5)
			else
				alpha = math.Approach(alpha, 1, FrameTime() * 5)
			end
			
			x, y = ScrW(), ScrH()
			old = render.GetRenderTarget()
		
			//t = self.Wep:GetAttachment(self.Wep:LookupAttachment("muzzle"))
			//t = t.Ang
			//t:RotateAroundAxis(t:Forward(), -90)
			//t.r = 0
			
			cd.angles = EyeAngles()
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
			
				render.RenderView(cd)
				
				cam.Start2D()
					surface.SetDrawColor(255, 255, 255, 255)
					surface.SetTexture(sight)
					surface.DrawTexturedRect(0, 0, 512, 512)
					surface.SetDrawColor(150, 150, 150, 245 * alpha)
					surface.SetTexture(lens)
					surface.DrawTexturedRect(0, 0, 512, 512)
				cam.End2D()
			
			render.SetViewPort(0, 0, x, y)
			render.SetRenderTarget(old)
			
			if self.PSO1Glass then
				self.PSO1Glass:SetTexture("$basetexture", self.ScopeRT)
				//self.PSO1Glass:SetInt("$phong", "0")
			end
		end
	end
end