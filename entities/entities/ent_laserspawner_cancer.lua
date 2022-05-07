AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Laser Generator (0.45s)"
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

        self.LaserDelay = 0.45

        self.NextLaser = CurTime() + 3
    end

    function ENT:CreateLaser( vert )
        local ent = ents.Create("ent_laser")
        ent:SetPos( self:GetPos() )
        if vert then
            ent.Vertical = true
        end
        ent:Spawn()
    end

    function ENT:Think()
        if CurTime() > self.NextLaser then
            self:CreateLaser()
            self:CreateLaser( true )
            self.NextLaser = CurTime() + self.LaserDelay
        end

        self:NextThink( CurTime() + 0.05 )
        return true
    end

end