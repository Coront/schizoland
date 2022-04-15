AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/hunter/plates/plate1x2.mdl" )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
    self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

function ENT:CanWarp( ply )
    if (ply.NextWarp or 0) > CurTime() then return false end
    return true
end

function ENT:LocateOtherTeleport()
    for k, v in pairs( ents.FindByClass("as_teleporter") ) do
        if v == self then continue end
        if v:GetIdentifier() == self:GetIdentifier() then
            return v
        end
    end
    return false
end

function ENT:Use( ply )
    local tele = self:LocateOtherTeleport()

    if self:GetIdentifier() == "" then return end
    if not tele then AS.LuaError("Cannot locate other teleport - " .. self:GetIdentifier() ) return end
    if not self:CanWarp( ply ) then return end

    ply.NextWarp = CurTime() + 0.5
    ply:SetPos( tele:GetSpawnPos() )
    ply:SendLua("surface.PlaySound('" .. self:GetWarpSound() .. "')")
end