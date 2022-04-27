AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Initialize()
    self:SetModel( "models/props_c17/substation_transformer01d.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
end

function ENT:Use( ply )
    if not self:PlayerCanPickUp( ply ) then return end
    local item = FetchToolIDByClass( self:GetClass() )
	if not item then AS.LuaError("Attempt to pick up an object with no entity tied, cannot find itemid - " .. self:GetClass()) return end
	if ply:GetCarryWeight() + AS.Items[item].weight > ply:MaxCarryWeight() then ply:ChatPrint("You are too overweight to carry this.") return end

	self:PickedUp( ply, item )
end