SWEP.PrintName = "Hands"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"

SWEP.Melee = true
SWEP.HoldType = "fist"
SWEP.ViewModelFOV = 50
SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = ""
SWEP.DefaultCrosshair = true
SWEP.NoAmmo = true

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = {"fists_idle_01", "fists_idle_02"}
Anim.Deploy = "fists_draw"
Anim.Holster = "fists_holster"
Anim.HolsterIdle = "reference"
Anim.Attack = {"fists_left", "fists_right"}

Stat = SWEP.Primary
Stat.Damage = 12 --Damage
Stat.Firerate = 60/65 --Attack Rate
Stat.Distance = 65 --Attack Distance
Stat.ImpactDelay = 0.25 --Delay before impacting
Stat.Automatic = true
Stat.Sound = "WeaponFrag.Throw"
Stat.Impact = "Flesh.ImpactHard"
Stat.ImpactFlesh = "Flesh.ImpactHard"

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0