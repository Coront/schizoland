SWEP.PrintName = "Crowbar"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 1

SWEP.Melee = true
SWEP.HoldType = "melee"
SWEP.ViewModelFOV = 50
SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.DefaultCrosshair = true
SWEP.NoAmmo = true

SWEP.ASID = "wep_crowbar" --Aftershock item ID

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = {"fists_idle_01", "fists_idle_02"}
Anim.Deploy = "draw"
Anim.Holster = "holster"
Anim.HolsterIdle = "holster"
Anim.Attack = {"misscenter1", "misscenter2"}

Stat = SWEP.Primary
Stat.Damage = 24 --Damage
Stat.Firerate = 60/65 --Attack Rate
Stat.Distance = 90 --Attack Distance
Stat.ImpactDelay = 0.2 --Delay before impacting
Stat.Automatic = true
Stat.Sound = {"weapons/knife/knife_slash1.wav", "weapons/knife/knife_slash2.wav"}
Stat.Impact = {"weapons/crowbar/crowbar_impact1.wav", "weapons/crowbar/crowbar_impact2.wav"}
Stat.ImpactFlesh = {"physics/flesh/flesh_impact_bullet1.wav", "physics/flesh/flesh_impact_bullet2.wav", "physics/flesh/flesh_impact_bullet3.wav", "physics/flesh/flesh_impact_bullet4.wav"}

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0