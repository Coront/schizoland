AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "proj_grenade"
ENT.Spawnable = false

function ENT:Initialize()
    if ( SERVER ) then
        self:SetModel( "models/items/grenadeammo.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
        self:PhysWake()
        self:SetUseType(SIMPLE_USE)
    end
    self:SetExplosion( CurTime() + 3 )
    self:SetRadius( 500 )

    self.NextTick = CurTime() + 0.5
    self.TickRate = 1
    self.SpawnTime = CurTime()
end

function ENT:SetAttacker( ent )
    self.Attacker = ent
end

function ENT:GetAttacker()
    return self.Attacker
end

function ENT:SetExplosion( time )
    self.ExplodeIn = time
end

function ENT:GetExplosion()
    return self.ExplodeIn
end

function ENT:SetDamage( int )
    self.Damage = int
end

function ENT:GetDamage()
    return self.Damage
end

function ENT:SetRadius( int )
    self.Radius = int
end

function ENT:GetRadius()
    return self.Radius
end

function ENT:Think()
    if ( CLIENT ) then

        self.TickRate = math.Clamp((self:GetExplosion() - CurTime()) / (self:GetExplosion() - self.SpawnTime), 0.25, 1)
        if CurTime() > self.NextTick then
            self:EmitSound("weapons/grenade/tick1.wav", 80, 100, 1, CHAN_STATIC)
            self.NextTick = CurTime() + ( 0.5 * self.TickRate )
        end

    end

    if CurTime() > self:GetExplosion() and not self.Exploded then
        self:Explode()
    end
end

function ENT:Explode()
    local pos = self:GetPos() + self:OBBCenter()
    self.Exploded = true

    if ( SERVER ) then

        local dmg = DamageInfo()
        dmg:SetDamage( self:GetDamage() )
        dmg:SetDamageType( DMG_BLAST )
        dmg:SetAttacker( self:GetAttacker() )
        dmg:SetInflictor( self )
        util.BlastDamageInfo( dmg, pos, self:GetRadius() )
        util.ScreenShake( pos, 20, 20, 0.75, self:GetRadius() * 2 )
        self:Remove()

    elseif ( CLIENT ) then

        local effect = EffectData()
        effect:SetOrigin( pos )
        util.Effect( "Explosion", effect )

    end

end