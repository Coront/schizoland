
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "" )
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal()
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid( SOLID_BBOX )
	self:CapabilitiesAdd( bit.bor( CAP_ANIMATEDFACE, CAP_TURN_HEAD ) )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
	self:SetMaxYawSpeed( 90 )


	-- Setting NPC Trader variables
	-- NOTE: Timer is used so server has time to initialize data server sided with perma propper.
	-- 		 Prevents race conditions.
	timer.Simple(1, function()
		self:SetNWString("traderID", self.traderID) -- Not really used for anything at the moment
		self:SetNWString("traderName", self.traderName)
		self:SetNWString("stockItems", self.stockItems)
		self:SetNWString("alwaysCarryItems", self.alwaysCarryItems)
		self:SetNWInt("restockTime", self.restockTime)
		self:SetNWString("currencyItem", self.currencyItem)
		self:SetNWString("currencySymbol", self.currencySymbol)
		self:SetNWString("currencyLocation", self.currencyLocation)
	end)

	local npcTraderRestockTimerIdentifier =  "(" .. self:EntIndex().. ")" .. "_restock"
	timer.Create(npcTraderRestockTimerIdentifier, 3, 0, function()
		if !IsValid(self) then timer.Destroy(npcTraderRestockTimerIdentifier) return end

		for i=1, #self.alwaysCarryItems do
			local alwaysCarryItem = self.alwaysCarryItems[i]["item"]
			local alwaysCarryMaxAmount = self.alwaysCarryItems[i]["maxStock"]

			local currentItemStock = self:GetItemStockAmount( alwaysCarryItem )
			if self:HasItemInStock( alwaysCarryItem, 1 ) and (currentItemStock < alwaysCarryMaxAmount) then
				local itemInfo = AS.Items[alwaysCarryItem]
				self:AddItemtoStock( alwaysCarryItem, itemInfo.value, 1 )
			end
		end
	end)
end

function ENT:GetItemStockAmount(requestedItem)
    for i=1, #self.stockItems do
        local item = self.stockItems[i]["item"]
        local amountinStock = self.stockItems[i]["amountInStock"]

		if item == requestedItem then
			return amountinStock
		end
	end

	return -1
end

function ENT:HasItemInStock(requestedItem, amt)
    for i=1, #self.stockItems do
        local item = self.stockItems[i]["item"]
        local amountinStock = self.stockItems[i]["amountInStock"]
		
		if (item == requestedItem) and (amountinStock >= amt) then return true end
	end
	return false
end

function ENT:getNPCStockTable()
	return self.stockItems
end

function ENT:FindItemInStockIndex(requestedItem)
	for i=1, #self.stockItems do
        local item = self.stockItems[i]["item"]
		if item == requestedItem then return i end
	end

	return -1
end

function ENT:AddItemtoStock(itemid, pricetoStock, amttoStock)
	if self:HasItemInStock(itemid, 1) then 
		local itemIndex = self:FindItemInStockIndex(itemid)
		self.stockItems[itemIndex]["amountInStock"] = self.stockItems[itemIndex]["amountInStock"] + amttoStock
		return
	end
	local itemTable = {}
	itemTable["item"] = itemid
	itemTable["price"] = pricetoStock
	itemTable["amountInStock"] = amttoStock
	table.insert(self.stockItems, itemTable)
end

function ENT:RemoveItemFromStock(itemid, amt)
	if !self:HasItemInStock(itemid, 1) then return end

	for i=1, #self.stockItems do
        local item = self.stockItems[i]["item"]
		local amountinStock = self.stockItems[i]["amountInStock"]
		if (item == itemid) and ((self.stockItems[i]["amountInStock"] - amt) > 0) then
			self.stockItems[i]["amountInStock"] = self.stockItems[i]["amountInStock"] - amt			
			return
		elseif (item == itemid) and ((self.stockItems[i]["amountInStock"] - amt) <= 0) then
			table.remove(self.stockItems, i)
			return
		end
	end
end


function ENT:AcceptInput( name, ply, caller, data )
	if name == "Use" then
		net.Start( "npctradermenu" )
		net.WriteEntity(self)
		net.Send(ply)
	end
end

function ENT:OnTakeDamage()
	return false
end