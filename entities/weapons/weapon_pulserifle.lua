SWEP.PrintName = "Pulse Rifle"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 3

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 55
SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/w_irifle.mdl"

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "ir_idle"
Anim.Deploy = "ir_draw"
Anim.Holster = "lowidle"
Anim.Attack = {"fire2", "fire3", "fire4"}
Anim.Reload = "ir_reload"

Stat = SWEP.Primary
Stat.Damage = 29 --Damage
Stat.Bullets = 1 --Bullets to fire
Stat.Automatic = true
Stat.Ammo = "ar2" --Ammo Type
Stat.ClipSize = 30 --Mag size
Stat.Firerate = 60/600 --Attack Rate
Stat.Spread = 0.03 --Spread Cone
Stat.SpreadC = 0.009 --Spread Cone while crouching
Stat.RecoilVertical = 0.2 --Veritcal recoil
Stat.RecoilHorizontal = 0.02 --Horizontal recoil
Stat.Sound = "weapons/ar2/fire1.wav"
Stat.ReloadTime = 1.1

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0