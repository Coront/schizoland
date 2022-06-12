AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "ent_breach"
ENT.Category = "Aftershock"
ENT.Spawnable = false

if ( SERVER ) then
    function ENT:Initialize()
        self:SetModel( "models/weapons/w_slam.mdl" )
        self:SetSolid( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetUseType( SIMPLE_USE )
        self:SetCollisionGroup( COLLISION_GROUP_WEAPON )

        local phys = self:GetPhysicsObject()
        phys:EnableMotion( false )
    end

    function ENT:Think()
        self.Beeps = self.Beeps or 0
        self.MaxBeeps = 15

        if CurTime() > (self.NextBeep or 0) then
            self:EmitSound( "weapons/c4/c4_beep1.wav", 70, 90 )
            self.Beeps = self.Beeps + 1

            self.NextBeep = CurTime() + ((1 - (self.Beeps / self.MaxBeeps)) * 0.5)
        end

        if self.Beeps > self.MaxBeeps then
            self:RemoveDoor()
            self:Explode()
        end

        self:NextThink( CurTime() + 0.01 )
        return true
    end

    function ENT:Explode()
        local explosion = EffectData()
        explosion:SetOrigin( self:GetPos() )
        util.Effect( "Explosion", explosion )
        util.BlastDamage( self, self.Deployer, self:GetPos(), 200, 100 )

        self:Remove()
    end

    function ENT:RemoveDoor()
        local door = self:GetDoor()

        local newdoor = ents.Create("prop_physics")
        newdoor:SetModel( door:GetModel() )
        newdoor:Spawn()
        newdoor:SetPos( door:GetPos() )
        newdoor:SetAngles( door:GetAngles() )
        newdoor:SetModelScale( 0.95, 0 )
        newdoor:Activate()
        newdoor:SetCollisionGroup( COLLISION_GROUP_WEAPON )

        door:SetMaterial("Models/effects/splodearc_sheet")
        door:SetCollisionGroup( COLLISION_GROUP_WEAPON )
        door:SetColor( Color( 0, 0, 0, 0 ) )
        door:SetPos( door:GetPos() + Vector( 0, 0, -200 ) )
        door:Fire( "unlock", "", 0)
        door.Breached = true

        timer.Simple( 300, function()
            if IsValid(door) and door.Breached then
                door:SetMaterial("")
                door:SetCollisionGroup( 0 )
                door:SetColor( Color( 255, 255, 255, 255 ) )
                door:SetPos( door:GetPos() + Vector( 0, 0, 200 ) )
                door.Breached = false
            end

            if IsValid(newdoor) then
                newdoor:Remove()
            end
        end)


    end
end

function ENT:SetDoor( ent )
    self.Door = ent
end

function ENT:GetDoor()
    return self.Door
end