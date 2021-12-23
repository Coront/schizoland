local PlayerMeta = FindMetaTable("Player")

function PlayerMeta:SetInventory( tbl )
    tbl = tbl or {}
    self.Inventory = tbl
end

function PlayerMeta:GetInventory()
    return self.Inventory
end

function PlayerMeta:AddItemToInventory( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to give a non-existant item - " .. item) return end
    amt = amt > 0 and math.Round(amt) or 1
    local inv = self:GetInventory()
    inv[item] = (inv[item] or 0) + amt
    self:SetInventory( inv )
end

function PlayerMeta:TakeItemFromInventory( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to take a non-existant item - " .. item) return end
    amt = amt > 0 and math.Round(amt) or 1
    local inv = self:GetInventory()
    inv[item] = (inv[item] or 0) - amt
    if inv[item] <= 0 then inv[item] = nil end --They don't have the item anymore, so just remove it from the table.
    self:SetInventory( inv )
end

function PlayerMeta:HasInInventory( item, amt )
    local inv = self:GetInventory()
    if inv[item] >= amt then return true end
    return false
end

function PlayerMeta:GetCarryWeight()
    local weight = 0
    for k, v in pairs(self:GetInventory()) do
        weight = weight + (AS.Items[k].weight or 1)
    end
    return weight
end

function PlayerMeta:MaxCarryWeight()
    return SKL.DefaultCarryWeight
end