AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "proj_grenade"

ENT.Spawnable = false

if (SERVER) then

    function ENT:Initialize()
        self:SetModel( "models/items/grenadeammo.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
        self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		self:PhysWake()
		self:SetUseType(SIMPLE_USE)
        self.NextTick = CurTime() + 0.5
        self.TickRate = 1
        self.SpawnTime = CurTime()
    end

    function ENT:Explode()
        local pos = self:GetPos() + self:OBBCenter()
        local dmg = DamageInfo()
        dmg:SetDamage( self:GetDamage() )
        dmg:SetDamageType( DMG_BLAST )
        dmg:SetAttacker( self:GetAttacker() )
        dmg:SetInflictor( self )
        util.BlastDamageInfo( dmg, pos, self:GetRadius() )
        util.ScreenShake( pos, 2500, 2500, 0.75, self:GetRadius() * 2 )

        self:EmitSound("weapons/explode" .. math.random( 3, 5 ) .. ".wav", 90, 100, 1, CHAN_WEAPON)
        self:Remove()
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
        self.TickRate = (self:GetExplosion() - CurTime()) / (self:GetExplosion() - self.SpawnTime)

        if CurTime() > self.NextTick then
            self:EmitSound("weapons/grenade/tick1.wav", 80, 100, 1, CHAN_WEAPON)
            self.NextTick = CurTime() + ( 0.5 * self.TickRate )
        end

        if CurTime() > self:GetExplosion() then
            self:Explode()
        end
    end

elseif (CLIENT) then



end