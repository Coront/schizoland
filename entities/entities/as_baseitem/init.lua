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

	self:SetDespawnTime( 43200 ) --Sets a timer for an item to be deleted.
end

function ENT:SetDespawnTime( time )
	self.DespawnTime = CurTime() + time
end

function ENT:GetDespawnTime()
	return self.DespawnTime or 0
end

function ENT:Use( ply )
	if ply:CanCarryItem( self:GetItem(), self:GetAmount(), true ) then
		self:Remove()
		self:EmitSound("physics/body/body_medium_impact_soft1.wav")
		ply:AddItemToInventory( self:GetItem(), self:GetAmount() )
		plogs.PlayerLog(ply, "Items", ply:NameID() .. " picked up " .. AS.Items[self:GetItem()].name .. " (" .. self:GetAmount() .. ")", {
			["Name"] 	= ply:Name(),
			["SteamID"]	= ply:SteamID(),
			["Item"]	= AS.Items[self:GetItem()].name .. " (" .. self:GetAmount() .. ")",
		})
	else
		local amt = self:CalcCanCarry( ply )
		if amt > 0 then
			self:SetAmount( self:GetAmount() - amt)
			self:EmitSound("physics/body/body_medium_impact_soft1.wav")
			ply:AddItemToInventory( self:GetItem(), amt )
			ply:ChatPrint("You managed to take " .. amt .. ", you are too overweight to take the rest.")
		else
			ply:ChatPrint("You are too overweight to carry this.")
			return
		end
		plogs.PlayerLog(ply, "Items", ply:NameID() .. " picked up " .. AS.Items[self:GetItem()].name .. " (" .. amt .. ")", {
			["Name"] 	= ply:Name(),
			["SteamID"]	= ply:SteamID(),
			["Item"]	= AS.Items[self:GetItem()].name .. " (" .. amt .. ")",
		})
	end
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

	--Toxic Fruit
	if IsValid(self) and self:GetItem() == "food_orange" and self:ToxicPresent() then
		self:SetItem("food_toxicfruit")
		self:EmitSound("physics/flesh/flesh_squishy_impact_hard" .. math.random( 1, 4 ) .. ".wav")
		self:SetModel( AS.Items["food_toxicfruit"].model )
	end
end

function ENT:ToxicPresent()
	for k, v in pairs( ents.FindByClass("as_toxicrock") ) do
		if self:GetPos():Distance(v:GetPos()) <= v:GetToxicDistance() then
			return true
		end
	end
	return false
end

function ENT:Touch( otherEnt )
	if IsValid(self) and self:GetItem() == "misc_emptybottle" and otherEnt:GetClass() == "as_watersource" then
		self:SetItem("food_dirty_water")
		self:EmitSound("ambient/water/water_spray" .. math.random( 1, 3 ) .. ".wav")
	end
end

function ENT:OnDuplicated( tbl )
	self:Remove()
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_item_syncinfo")