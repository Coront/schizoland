AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "ent_laser"
ENT.Category = "Aftershock - Fun"
ENT.Spawnable = false

if ( SERVER ) then
    
    function ENT:Initialize()
        self:EmitSound("beams/beamstart5.wav", 150, 130, 1)
        self:SetModel("models/hunter/plates/plate075x8.mdl")
        self:SetMaterial("models/props_combine/portalball001_sheet")
        self:PhysicsInit( SOLID_NONE )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
        self:SetAngles( Angle( 0, 0, 0 ) )

        self.Lifetime = CurTime() + 3
    end

    function ENT:PerformTrace()
        local pos = self:GetPos() + self:OBBCenter()
        local bboxmax = self:OBBMaxs() + Vector( 1, 0, 1)
        local bboxmin = self:OBBMins() + Vector( -1, -1, -1 )

        local tr = util.TraceHull({
            start = pos,
            endpos = pos + self:GetAngles():Forward(),
            maxs = bboxmax,
            mins = bboxmin,
            ignoreworld = true,
            filter = self,
        })

        if IsValid(tr.Entity) and tr.Entity:IsPlayer() then
            self:KillPlayer( tr.Entity )
        end
    end

    function ENT:KillPlayer( ent )
        local dmg = DamageInfo()
        dmg:SetAttacker( self )
        dmg:SetInflictor( self )
        dmg:SetDamage( 99999999999 )
        dmg:SetDamageForce( Vector( 2000, 2000, 2000 ) )

        local snds = {
            "vo/npc/male01/no01.wav",
            "vo/npc/male01/no02.wav",
            "vo/npc/male01/ohno.wav",
            "vo/npc/male01/help01.wav",
            "vo/npc/male01/pain07.wav",
            "vo/npc/male01/pain08.wav",
            "vo/npc/male01/pain09.wav",
        }
        local sndsfemale = {
            "vo/npc/female01/help01.wav",
            "vo/npc/female01/uhoh.wav",
            "vo/npc/female01/no01.wav",
            "vo/npc/female01/no02.wav",
            "vo/npc/female01/ow01.wav",
            "vo/npc/female01/ow02.wav",
            "vo/npc/female01/pain06.wav",
            "vo/npc/female01/pain07.wav",
            "vo/npc/female01/pain08.wav",
            "vo/npc/female01/pain09.wav",
        }
        local randomsnd = ent:IsFemale() and table.Random( sndsfemale ) or table.Random( snds )
        ent:EmitSound( randomsnd )
        ent:TakeDamageInfo( dmg )
    end 

    function ENT:Think()
        if not (self.AdjustPosition or false) then
            local roll = math.random( 1, 2 )
            local duck = roll == 1 and Vector( 0, 0, 50 ) or Vector( 0, 0, 10 )
            self:SetPos(self:GetPos() + duck)
            self.AdjustPosition = true
        end
        if CurTime() > self.Lifetime then self:Remove() end
        self:SetPos( self:GetPos() + self:GetAngles():Forward() * -20 )
        self:PerformTrace()

        self:NextThink( CurTime() + 0.01 )
        return true
    end

end