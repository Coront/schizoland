AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetContainer( "drawer" )
	self:SetModel( AS.Loot[self:GetContainer()].model )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
end

function ENT:OnLootTableChanged( name, old, new )
	if old == "" then return end
	self:SetInventory( {} )
	self:SetNextGeneration( CurTime() + AS.Loot[new].generation.time )
	self:SetModel( AS.Loot[new].model )
	self:SetSolid( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
end

function ENT:ShouldStopTimer()
	for k, v in pairs( player.GetAll() ) do
		if not v:IsLoaded() then continue end
		if not v:Alive() then continue end
		if v:IsDeveloping() then continue end
		if v:GetPos():Distance(self:GetPos()) < 1500 then --A player is too close, we should stop the timer.
			return true
		end
	end
	for k, v in pairs( ents.FindByClass("prop_physics") ) do
		if not v.Owner then continue end
		if v:GetPos():Distance(self:GetPos()) < 1500 then --A player's prop is too close, assuming they're building in the area.
			return true 
		end
	end

	return false
end

function ENT:Think()
	if self:GetContainer() != "" and self:ShouldStopTimer() then
		self:SetNextGeneration( CurTime() + (self:GetNextGeneration() - CurTime()) ) --based programming skills
	end

	if self:GetContainer() != "" and CurTime() > self:GetNextGeneration() then
		self:GenerateLoot()
		self:SetNextGeneration( CurTime() + AS.Loot[self:GetContainer()].generation.time )
	end
end

function ENT:GenerateLoot()
	--To explain how this generation works, we will take all of the items that were put into the item's table for the storageid and put them on a number line.
	local newinv = {} --This will be our new inventory.
	local gentbl = AS.Loot[self:GetContainer()] and AS.Loot[self:GetContainer()].generation
	if not gentbl then AS.LuaError("Container doesn't have a valid generation table - " .. self:GetContainer()) return end
	local generate = math.random(0, 100)
	local generatechance = gentbl.chance
	if generate > generatechance then return end --We failed to generate, so we won't do anything.

	--We have to create a new table that contains the drawing chances of items, and add a current number to know how large the overall draw chance is.
	local itemtable = {}
	local current = 0
	for k, v in pairs( gentbl.items ) do
		itemtable[k] = {min = current, max = current + gentbl.items[k].tickets}
		current = current + v.tickets
	end

	--Now, for the generation, we will pick a minimal and maximum item regen amount, and we'll cycle the spawn table to see what item's ticket gets drawn.
	local totalitems = math.random(gentbl.minitem, gentbl.maxitem)
	for i = 1, totalitems do
		local randomitem = math.random( 0, current )
		for k, v in pairs(itemtable) do
			if randomitem > v.min and randomitem <= v.max then
				newinv[k] = math.random( gentbl.items[k].min, gentbl.items[k].max )
				break
			end
		end
	end

	self:SetInventory( newinv ) --We'll then take the new table and set it as our new inventory!
	self:ResyncInventory() --We also need to sync this information, so we'll take care of that too.
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString( "as_container_takeitem" )

net.Receive( "as_container_takeitem", function(_, ply) 
	local ent = net.ReadEntity()
	local item = net.ReadString()
	local amt = net.ReadInt( 32 )

	--We are going to take an item from a container. We need to make sure that the container actually CONTAINS the item, and the right amount.
	if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() ent:ResyncInventory() return end --Person might try an invalid item
    if not ent:HasInInventory( item, amt ) then ply:ChatPrint("This item isn't in the container.") ply:ResyncInventory() ent:ResyncInventory() return end --Person might try running without the container actually having the item
    if not ent:PlayerCanTakeItem( ply, item, amt ) then return end
    if amt < 1 then amt = 1 end --Person might try negative numbers
    local inv = ent:GetInventory()
    if amt > inv[item] then amt = inv[item] end --Person might try higher numbers than what they actually have
    amt = math.Round(amt) --Person might try decimals

    --It's all verified.
    ent:PlayerTakeItem( ply, item, amt )
	ply:ChatPrint( AS.Items[item].name .. " (" .. amt .. ") added to inventory." )

	ent:ResyncInventory() --We need to resync the inventory to all clients.
end)