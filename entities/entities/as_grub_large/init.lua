AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:SelectSchedule()
	self:SetSchedule(SCHED_IDLE_STAND)
end

function ENT:Use( ply )
    net.Start( "as_grub_open" )
        net.WriteEntity( self )
    net.Send( ply )
end

function ENT:Die()
    if (self.Dead or false) then return end
    self.Dead = true

    local owner = self:GetObjectOwner()
    owner:RemoveToolFromCache( "tool_grub_large" ) --Remove this object from the player's cache, so it's gone forever.
    self:EmitSound( "npc/antlion_grub/squashed.wav" )

    local deathdoll = ents.Create("prop_ragdoll")
    deathdoll:SetModel( "models/antlion_grub_squashed.mdl" )
    deathdoll:SetPos( self:GetPos() )
    deathdoll:SetAngles( self:GetAngles() )
    deathdoll:Spawn()
    deathdoll:SetCollisionGroup( COLLISION_GROUP_DEBRIS )

    timer.Simple( 15, function()
        if IsValid( deathdoll ) then
            deathdoll:Remove()
        end
    end)

    local ent = ents.Create("as_grub_nugget")
    ent:SetPos( self:GetPos() + Vector( 0, 0, 20 ) )
    ent:Spawn()
    local amt = ((AS.Items["tool_grub"].craft["misc_chemical"] * 10) * 0.6) + (self:GetInventory()["misc_chemical"] or 0)
    ent:SetAmount( amt )
    ent:SetModelScale( 2 + (amt * 0.002) )
    ent:Activate()

    self:Remove()
end

function ENT:OnTakeDamage( dmginfo )
    self:SetHealth( math.Clamp(self:Health() - dmginfo:GetDamage(), 0, self.MaxHealth) )

    if self:Health() <= 0 then
        self:Die()
    end
end