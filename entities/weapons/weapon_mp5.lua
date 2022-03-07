SWEP.PrintName = "MP5"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 2

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 55
SWEP.ViewModel = "models/weapons/cstrike/c_smg_mp5.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mp5.mdl"

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "idle"
Anim.Deploy = "draw"
Anim.Holster = "idle"
Anim.Attack = {"shoot1", "shoot2", "shoot3"}
Anim.Reload = "reload1"

Stat = SWEP.Primary
Stat.Damage = 20 --Damage
Stat.Bullets = 1 --Bullets to fire
Stat.Automatic = true
Stat.Ammo = "smg1" --Ammo Type
Stat.ClipSize = 30 --Mag size
Stat.Firerate = 60/780 --Attack Rate
Stat.Spread = 0.02 --Spread Cone
Stat.SpreadC = 0.017 --Spread Cone while crouching
Stat.RecoilVertical = 0.03 --Veritcal recoil
Stat.RecoilHorizontal = 0.06 --Horizontal recoil
Stat.Sound = "weapons/mp5navy/mp5-1.wav"
Stat.ReloadTime = 2.6

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0