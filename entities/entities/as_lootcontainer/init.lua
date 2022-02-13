AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Think()
	if CurTime() > self:GetNextGeneration() then
		self:GenerateLoot()
		self:SetNextGeneration( CurTime() + AS.Loot[self:GetContainer()].generation.time )
	end
end

function ENT:GenerateLoot()
	--To explain how this generation works, we will take all of the items that were put into the item's table for the storageid and put them on a number line.
	local newinv = {} --This will be our new inventory.
	local gentbl = AS.Loot[self:GetContainer()].generation
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