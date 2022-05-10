AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Grub Nugget"
ENT.Category		= "Aftershock"
ENT.Spawnable		= false

function ENT:Initialize()
    if ( SERVER ) then
        self:SetModel( "models/grub_nugget_medium.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetUseType( SIMPLE_USE )
        self:SetSolid( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
    end
end

function ENT:SetAmount( int )
    self.Amount = int
end

function ENT:GetAmount()
    return self.Amount or 0
end

function ENT:Use( ply )
    self:Remove()
    ply:AddItemToInventory( "misc_chemical", self:GetAmount() )
    ply:ChatPrint("Picked up " .. self:GetAmount() .. " chemicals.")
end

function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) < GetConVar("as_entity_renderdist"):GetInt() then
        self:DrawModel()
        self:DrawShadow(true)
    else
        self:DrawShadow(false)
    end
end