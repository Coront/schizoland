AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/hunter/plates/plate1x1.mdl" )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
    self:SetCollisionGroup( COLLISION_GROUP_WEAPON )

    self.SpawnTime = 900
    self.PlyDisableDist = 5000

    self:SetNPC( "npc_as_raider" )
    self:SetNextSpawn( CurTime() + 10 )
end

function ENT:CanSpawnNPC() --Can we spawn an NPC?
    if self:NPCActive() then return false end
    return true
end

function ENT:NPCActive() --Will report whether this spawner's NPC is alive or not.
    if IsValid( self.CurrentNPC ) then return true end
    return false
end

function ENT:SetNextSpawn( time )
    self.NextSpawn = time
end

function ENT:GetNextSpawn()
    return self.NextSpawn or 0
end

function ENT:CreateNPC()
    local ent = ents.Create( self:GetNPC() )
    ent:SetPos( self:GetSpawnPos() )
    ent:SetAngles( self:GetSpawnAng() )
    ent:Spawn()
    ent.Guarding = true

    self.CurrentNPC = ent
end

function ENT:Think()
    if CurTime() > self:GetNextSpawn() then
        for k, v in pairs( player.GetAll() ) do
            if not v:IsLoaded() then continue end
            if not v:Alive() then continue end
            if v:IsDeveloping() then continue end
            if v:GetPos():Distance(self:GetPos()) <= self.PlyDisableDist then --Disable if one player is nearby.
                self.Disabled = true
                break
            end
        end

        if self.Disabled then --Intentionally pushing the time to stop rapid thinking of this function.
            self:SetNextSpawn( CurTime() + 10 )
            return 
        end

        if not self:CanSpawnNPC() then return end
        self:SetNextSpawn( CurTime() + self.SpawnTime )
        self:CreateNPC()
    end
end

function ENT:OnRemove()
    if self.CurrentNPC and IsValid(self.CurrentNPC) then
        self.CurrentNPC:Remove()
    end
end