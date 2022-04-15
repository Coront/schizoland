AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/Combine_Helicopter/helicopter_bomb01.mdl" )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
    self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

function ENT:Think()
    self.DisableSpawners = false

    for k, v in pairs( player.GetAll() ) do
        if not v:IsLoaded() then continue end
        if not v:Alive() then continue end
        if v:IsDeveloping() then continue end

        if v:GetPos():Distance(self:GetPos()) <= self:GetZoneDistance() then
            self.DisableSpawners = true
            break
        end
    end

    for k, v in pairs( ents.FindByClass("as_staticspawn") ) do
        if self.DisableSpawners then
            v.Disabled = true
        else
            v.Disabled = false
        end
    end
end