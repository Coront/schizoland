AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( AS.Items[self:GetItem()].model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )

	self:SetDespawnTime( 300 ) --Sets a timer for an item to be deleted.
end

function ENT:SetDespawnTime( time )
	self.DespawnTime = CurTime() + time
end

function ENT:GetDespawnTime()
	return self.DespawnTime or CurTime() + 60
end

function ENT:Use( ply )
	if not ply:CanCarryItem( self:GetItem(), self:GetAmount() ) then return end

	self:Remove()
	self:EmitSound("physics/body/body_medium_impact_soft1.wav")
	ply:AddItemToInventory( self:GetItem(), self:GetAmount() )

	net.Start("as_item_pickup")
		net.WriteString( self:GetItem() )
		net.WriteInt( self:GetAmount(), 32 )
	net.Send(ply)
end

function ENT:Think()
	--Despawning
	if IsValid(self) and self:GetDespawnTime() < CurTime() then
		self:Remove()
	end

	--Water
	if IsValid(self) and self:GetItem() == "misc_emptybottle" and self:WaterLevel() == 1 then
		self:SetItem("food_dirty_water")
		self:EmitSound("ambient/water/water_spray" .. math.random( 1, 3 ) .. ".wav")
	end
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_item_pickup")
util.AddNetworkString("as_item_syncinfo")