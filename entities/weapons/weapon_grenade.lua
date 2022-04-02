SWEP.PrintName = "HE Grenade"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 5

SWEP.HoldType = "grenade"
SWEP.ViewModelFOV = 60
SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/weapons/w_grenade.mdl"

SWEP.ASID = "wep_grenade" --Aftershock item ID

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "idle01"
Anim.Deploy = "draw"
Anim.Holster = "idle"
Anim.Charge = "drawbackhigh"
Anim.Attack = "throw"

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0

SWEP.DefaultCrosshair = true
SWEP.NoAmmo = true

SWEP.Charging = false
SWEP.Throwing = 0

function SWEP:PrimaryAttack()
    if not self.Charging then
        self:PlaySequence( self.Anim.Charge )
        self.Charging = true
        self.Throwing = CurTime() + 0.3
    end
end

function SWEP:SecondaryAttack()
    if self.Charging then
        self.Charging = false
        self:Deploy()
    end
end

function SWEP:Think()
    if self.Charging and CurTime() > self.Throwing and not self:GetOwner():KeyDown( IN_ATTACK ) then
        if SERVER then
            self:GetOwner():EmitSound( "weapons/slam/throw.wav" )
            local ply = self:GetOwner()
            ply:StripWeapon( self:GetClass() )
            ply:SelectWeapon( "weapon_hands" )
            local grenade = ents.Create("as_proj_grenade")
            grenade:Spawn()
            grenade:SetPos( ply:EyePos() )
            grenade:SetAngles( ply:EyeAngles() + Angle( 0, 0, -80 ) )
            grenade:SetAttacker( ply )
            grenade:SetDamage( 200 )
            local phys = grenade:GetPhysicsObject()
            phys:SetVelocity( ply:GetVelocity() + ply:EyeAngles():Forward() * 1250 )
        end
    end
end

function SWEP:Holster()
    if self.Charging then
        self.Charging = false
    end

    return true
end

--Overrides
function SWEP:Reload() end