AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "ent_laser"
ENT.Category = "Aftershock - Fun"
ENT.Spawnable = true

if ( SERVER ) then
    
    function ENT:Initialize()
        self:EmitSound("beams/beamstart5.wav", 150, 130, 1)
        self:SetModel("models/hunter/plates/plate075x8.mdl")
        self:SetMaterial("models/props_combine/portalball001_sheet")
        self:PhysicsInit( SOLID_NONE )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
        if not self.Vertical then
            local vert = math.random( 0, 1 )
            if vert == 1 then self.Vertical = true end
        end
        ang = 0
        if self.Vertical then ang = 90 end
        self:SetAngles( Angle( 0, 0, ang ) )

        self.Lifetime = CurTime() + 3
    end

    function ENT:PerformTrace()
        local pos = self:GetPos() + self:OBBCenter()
        local bboxmax = self.Vertical and Vector( 12, 2, 190 ) or self:OBBMaxs() + Vector( 1, 1, 1 )
        local bboxmin = self.Vertical and Vector( -24, -2, -190 ) or self:OBBMins() + Vector( -1, -1, -1 )

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
        ent:TakeDamageInfo( dmg )
    end 

    function ENT:Think()
        if not (self.AdjustPosition or false) then
            if not self.Vertical then
                local roll = math.random( 1, 2 )
                local duck = roll == 1 and Vector( 0, 0, 50 ) or Vector( 0, 0, 10 )
                self:SetPos(self:GetPos() + duck)
                self.AdjustPosition = true
            else
                local strafe = Vector( 0, math.random( -80, 80 ), 0 )
                self:SetPos(self:GetPos() + strafe)
                self.AdjustPosition = true
            end
        end
        if CurTime() > self.Lifetime then self:Remove() end
        self:SetPos( self:GetPos() + self:GetAngles():Forward() * -20 )
        self:PerformTrace()

        self:NextThink( CurTime() + 0.01 )
        return true
    end

end

function ENT:Draw()
    self:DrawModel()

    --render.DrawWireframeBox( self:GetPos(), Angle( 0, 0, 0 ), Vector( -24, -2, -190 ), Vector( 12, 2, 190 ), COLHUD_DEFAULT  )
end