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

function PlayerMeta:GetItemCount( item )
    if not AS.Items[item] then AS.LuaError("Attempt to request a non-existant item - " .. item) return end
    local inv = self:GetInventory()
    if inv and inv[item] then
        return inv[item]
    else
        return 0
    end
end

function PlayerMeta:GetCarryWeight()
    local weight = 0
    for k, v in pairs(self:GetInventory()) do
        weight = weight + ((AS.Items[k].weight or 0) * v)
    end
    return weight
end

function PlayerMeta:MaxCarryWeight()
    local scavbonus = self:GetASClass() == "scavenger" and CLS.Scavenger.carryweightinc or 0
    return SKL.DefaultCarryWeight + (SKL.Strength.carryweight * self:GetSkillLevel("strength")) + scavbonus
end

function PlayerMeta:CanCarryItem( item, amt )
    amt = amt and amt > 0 and math.Round(amt) or 1
    if self:GetCarryWeight() + (AS.Items[item].weight * amt) > self:MaxCarryWeight() then self:ChatPrint("You are too overweight to carry this.") return false end
    return true
end

function PlayerMeta:CanUseItem( item )
    return true
end

function PlayerMeta:CanEquipItem( item )
    if self:HasWeapon( AS.Items[item].wep ) then self:ChatPrint("You already have this weapon equipped.") return false end
    return true
end

function PlayerMeta:CanUnequipItem( item )
    if not self:CanCarryItem( item ) then return false end --Player needs room in their inventory to unequip.
    return true
end

function translateAmmoNameID( ammo ) --This function translates an itemid/ammoid to its opposite. I know it kinda sucks but whatever.
    if AS.Items[ammo] then --we were given a AS.itemid.
        return AS.Items[ammo].use.ammotype --we will convert the itemid to the ammoid and send it back.
    else --We were not given an AS.itemid. (assuming we were fed an ammoid and not an itemid.)
        ammo = string.lower(ammo)
        for k, v in pairs(AS.Items) do
            if not string.find( k, "ammo_" ) then continue end --Ignore everything thats not an ammo.
            if AS.Items[k].use.ammotype == ammo then
                return k --We'll feed back the itemid
            end
        end
    end
    return nil
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