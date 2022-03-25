SWEP.PrintName = "SG-552"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 4

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 55
SWEP.ViewModel = "models/weapons/cstrike/c_rif_sg552.mdl"
SWEP.WorldModel = "models/weapons/w_rif_sg552.mdl"

SWEP.ASID = "wep_sg552" --Aftershock item ID

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "idle"
Anim.Deploy = "draw"
Anim.Holster = "adjustment"
Anim.Attack = {"shoot1", "shoot2", "shoot3"}
Anim.Reload = "reload"

Stat = SWEP.Primary
Stat.Damage = 23 --Damage
Stat.Bullets = 1 --Bullets to fire
Stat.Automatic = true
Stat.Ammo = "ar2" --Ammo Type
Stat.ClipSize = 30 --Mag size
Stat.Firerate = 60/650 --Attack Rate
Stat.Spread = 0.025 --Spread Cone
Stat.SpreadC = 0.022 --Spread Cone while crouching
Stat.RecoilVertical = 0.7 --vertical recoil
Stat.RecoilHorizontal = 0.2 --Horizontal recoil
Stat.Sound = "weapons/sg552/sg552-1.wav"
Stat.ReloadTime = 2.7

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0

SWEP.Zoomed = SWEP.Zoomed or false
SWEP.ZoomedFOV = 80

function SWEP:ToggleZoom()
    if not self.Zoomed then
        self.Zoomed = true
        self.Owner:SetFOV( self.ZoomedFOV, 0.1, self )
    else
        self.Zoomed = false
        self.Owner:SetFOV( 0, 0.1, self )
    end
    self:EmitSound( "weapons/zoom.wav" )
end

function SWEP:SecondaryAttack()
    if IsFirstTimePredicted() then
        self:ToggleZoom()
    end
    self:SetNextSecondaryFire( CurTime() + 0.5 )
end

function SWEP:Holster()
    if self.Zoomed then
        self:ToggleZoom()
    end

    return true
end

function SWEP:AdjustMouseSensitivity()
    if self.Zoomed then
        return GetConVar("aswep_scope_sensitivity"):GetInt() * 0.01
    else
        return 1
    end
end