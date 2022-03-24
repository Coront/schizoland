SWEP.PrintName = "P228"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 2

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 60
SWEP.ViewModel = "models/weapons/cstrike/c_pist_p228.mdl"
SWEP.WorldModel = "models/weapons/w_pist_p228.mdl"

SWEP.ASID = "wep_p228" --Aftershock item ID

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "idle"
Anim.Deploy = "draw"
Anim.Holster = "idle"
Anim.Attack = {"shoot1", "shoot2", "shoot3"}
Anim.Reload = "reload"

Stat = SWEP.Primary
Stat.Damage = 21 --Damage
Stat.Bullets = 1 --Bullets to fire
Stat.Automatic = false
Stat.Ammo = "pistol" --Ammo Type
Stat.ClipSize = 13 --Mag size
Stat.Firerate = 60/380 --Attack Rate
Stat.Spread = 0.02 --Spread Cone
Stat.SpreadC = 0.01 --Spread Cone while crouching
Stat.RecoilVertical = 0.22 --vertical recoil
Stat.RecoilHorizontal = 0.03 --Horizontal recoil
Stat.Sound = "weapons/p228/p228-1.wav"
Stat.ReloadTime = 2.5

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0