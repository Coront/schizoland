SWEP.PrintName = "MP7"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 4

SWEP.HoldType = "smg"
SWEP.ViewModelFOV = 55
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"

SWEP.ASID = "wep_mp7" --Aftershock item ID

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "idle01"
Anim.Deploy = "draw"
Anim.Holster = "idletolow"
Anim.Attack = {"fire01", "fire02", "fire03", "fire04"}
Anim.Reload = "reload"

Stat = SWEP.Primary
Stat.Damage = 21 --Damage
Stat.Bullets = 1 --Bullets to fire
Stat.Automatic = true
Stat.Ammo = "smg1" --Ammo Type
Stat.ClipSize = 30 --Mag size
Stat.Firerate = 60/900 --Attack Rate
Stat.Spread = 0.03 --Spread Cone
Stat.SpreadC = 0.025 --Spread Cone while crouching
Stat.RecoilVertical = 0.2 --vertical recoil
Stat.RecoilHorizontal = 1 --Horizontal recoil
Stat.Sound = "weapons/smg1/smg1_fire1.wav"
Stat.ReloadTime = 1.4
Stat.Reload = "weapons/smg1/smg1_reload.wav"

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0