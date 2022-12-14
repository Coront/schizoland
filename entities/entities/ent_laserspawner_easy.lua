AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Laser Generator (1.5s)"
ENT.Category = "Aftershock - Fun"
ENT.Spawnable = true

if ( SERVER ) then
    
    function ENT:Initialize()
        self:SetModel("models/hunter/plates/plate075x8.mdl")
        self:PhysicsInit( SOLID_NONE )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
        self:SetAngles( Angle( 0, 0, 0 ) )

        self.LaserDelay = 1.5

        self.NextLaser = CurTime() + 3
    end

    function ENT:CreateLaser()
        local ent = ents.Create("ent_laser")
        ent:SetPos( self:GetPos() )
        ent.Speed = 15
        ent:Spawn()
    end

    function ENT:Think()
        if CurTime() > self.NextLaser then
            self:CreateLaser()
            self.NextLaser = CurTime() + self.LaserDelay
        end

        self:NextThink( CurTime() + 0.05 )
        return true
    end

end