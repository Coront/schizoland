function PlayerMeta:SetInventory( tbl )
    tbl = tbl or {}
    self.Inventory = tbl
end

function PlayerMeta:GetInventory()
    return self.Inventory
end

function PlayerMeta:AddItemToInventory( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to give a non-existant item - " .. item) return end
    amt = amt and amt > 0 and math.Round(amt) or 1
    local inv = self:GetInventory()
    inv[item] = (inv[item] or 0) + amt
    self:SetInventory( inv )
end

function PlayerMeta:TakeItemFromInventory( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to take a non-existant item - " .. item) return end
    amt = amt and amt > 0 and math.Round(amt) or 1
    local inv = self:GetInventory()
    inv[item] = (inv[item] or 0) - amt
    if inv[item] <= 0 then inv[item] = nil end --They don't have the item anymore, so just remove it from the table.
    self:SetInventory( inv )
end

function PlayerMeta:HasInInventory( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to request a non-existant item - " .. item) return end
    amt = amt and amt > 0 and math.Round(amt) or 1
    local inv = self:GetInventory()
    if (inv[item] or 0) >= amt then return true end
    return false
end

function PlayerMeta:GetCarryWeight()
    local weight = 0
    for k, v in pairs(self:GetInventory()) do
        weight = weight + ((AS.Items[k].weight or 0) * v)
    end
    return weight
end

function PlayerMeta:MaxCarryWeight()
    return SKL.DefaultCarryWeight
end

function PlayerMeta:CanCarryItem( item, amt )
    if self:GetCarryWeight() + (AS.Items[item].weight * amt) > self:MaxCarryWeight() then self:ChatPrint("You are too overweight to carry this.") return false end
    return true
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if SERVER then

    util.AddNetworkString("as_syncinventory")

    --This function will resync a player's inventory if an error with information that was sent from the client was caught.
    function PlayerMeta:ResyncInventory()
        net.Start("as_syncinventory")
            net.WriteTable(self:GetInventory())
        net.Send(self)
    end
    concommand.Add("as_resyncinventory", function(ply) ply:ResyncInventory() end)

elseif CLIENT then

    function InventorySync()
        local inv = net.ReadTable()

        LocalPlayer():SetInventory( inv )
    end
    net.Receive("as_syncinventory", InventorySync)

end