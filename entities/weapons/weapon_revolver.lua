SWEP.PrintName = "Magnum"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 2

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 60
SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"

SWEP.ASID = "wep_magnum" --Aftershock item ID

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "idle1"
Anim.Deploy = "draw"
Anim.Holster = "idle1"
Anim.Attack = "fire"
Anim.Reload = "reload"

Stat = SWEP.Primary
Stat.Damage = 49 --Damage
Stat.Bullets = 1 --Bullets to fire
Stat.Automatic = false
Stat.Ammo = "pistol" --Ammo Type
Stat.ClipSize = 6 --Mag size
Stat.Firerate = 60/100 --Attack Rate
Stat.Spread = 0.015 --Spread Cone
Stat.SpreadC = 0.008 --Spread Cone while crouching
Stat.RecoilVertical = 1.5 --vertical recoil
Stat.RecoilHorizontal = 2 --Horizontal recoil
Stat.Sound = "weapons/357/357_fire3.wav"
Stat.ReloadTime = 2.1

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0