SWEP.PrintName = "Desert Eagle"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 2

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 60
SWEP.ViewModel = "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"

SWEP.ASID = "wep_deagle" --Aftershock item ID

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "idle1"
Anim.Deploy = "draw"
Anim.Holster = "idle1"
Anim.Attack = {"shoot1", "shoot2"}
Anim.Reload = "reload"

Stat = SWEP.Primary
Stat.Damage = 43 --Damage
Stat.Bullets = 1 --Bullets to fire
Stat.Automatic = false
Stat.Ammo = "pistol" --Ammo Type
Stat.ClipSize = 7 --Mag size
Stat.Firerate = 60/240 --Attack Rate
Stat.Spread = 0.015 --Spread Cone
Stat.SpreadC = 0.008 --Spread Cone while crouching
Stat.RecoilVertical = 2 --vertical recoil
Stat.RecoilHorizontal = 1.5 --Horizontal recoil
Stat.Sound = "weapons/deagle/deagle-1.wav"
Stat.ReloadTime = 2.1

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0