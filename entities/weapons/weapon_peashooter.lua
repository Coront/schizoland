SWEP.PrintName = "Peashooter"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 2

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 60
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

SWEP.ASID = "wep_peashooter" --Aftershock item ID

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "idle01"
Anim.Deploy = "draw"
Anim.Holster = "holster"
Anim.Attack = {"fire", "fire1", "fire2", "fire3"}
Anim.Reload = "reload"

Stat = SWEP.Primary
Stat.Damage = 19 --Damage
Stat.Bullets = 1 --Bullets to fire
Stat.Automatic = false
Stat.Ammo = "pistol" --Ammo Type
Stat.ClipSize = 18 --Mag size
Stat.Firerate = 60/420 --Attack Rate
Stat.Spread = 0.02 --Spread Cone
Stat.SpreadC = 0.01 --Spread Cone while crouching
Stat.RecoilVertical = 0.2 --vertical recoil
Stat.RecoilHorizontal = 0.02 --Horizontal recoil
Stat.Sound = "weapons/pistol/pistol_fire2.wav"
Stat.Reload = "weapons/pistol/pistol_reload1.wav"
Stat.ReloadTime = 0.8

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0