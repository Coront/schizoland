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
	--self:MergeCheck() --Will run a function to see if an item can merge with any similar items in the area.
end

function ENT:SetDespawnTime( time )
	self.DespawnTime = CurTime() + time
end

function ENT:GetDespawnTime()
	return self.DespawnTime or CurTime() + 60
end

--[[
function ENT:MergeCheck() --This function will search for the same entities with similar ids to merge itself to in the area.
	for k, v in pairs(ents.FindByClass("as_baseitem")) do
		if self == v then continue end --Don't merge to ourself!!!
		if self:GetPos():Distance(v:GetPos()) > 50 then continue end --The entities are too far
		if self:GetItem() != v:GetItem() then continue end --The entities are not the same item
		self:Remove()
		v:Remove()

		local newent = ents.Create("as_baseitem")
		newent:SetPos(v:GetPos())
		newent:SetAngles(v:GetAngles())
		newent:SetItem(v:GetItem())
		newent:SetAmount(v:GetAmount() + self:GetAmount())
		newent:Spawn()
	end
end
]]

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