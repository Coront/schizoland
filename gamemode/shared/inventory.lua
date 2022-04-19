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
        if AS.Items[k].category == "vehicle" then continue end --Vehicles will weigh nothing.
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
    local toweight = AS.Items[item].category == "vehicle" and 0 or AS.Items[item].weight * amt
    if self:GetCarryWeight() + toweight > self:MaxCarryWeight() and not SET.RawResources[item] then self:ChatPrint("You are too overweight to carry this.") return false end
    return true
end

function PlayerMeta:CanUseItem( item )
    if not self:Alive() then self:ChatPrint("You are dead, you cannot use this.") return false end
    if AS.Items[item].use and AS.Items[item].use.health and self:Health() >= self:GetMaxHealth() then self:ChatPrint("You don't need this right now.") return false end
    if AS.Items[item].use and AS.Items[item].use.health and self:HasStatus( "healingsickness" ) then self:ChatPrint("You cannot use this with " .. AS.Effects["healingsickness"].name .. " active.") return false end
    return true
end

function PlayerMeta:CanEquipItem( item )
    if not self:Alive() then self:ChatPrint("You are dead, you cannot equip this.") return false end
    if AS.Items[item].category == "armor" and self:HasArmor() then self:ChatPrint("You already have an armor equipped.") return false end
    if self:HasWeapon( AS.Items[item].wep ) then self:ChatPrint("You already have this equipped.") return false end
    return true
end

function PlayerMeta:CanUnequipItem( item )
    if not self:Alive() then self:ChatPrint("You are dead, you cannot unequip this.") return false end
    if self:InCombat() then self:ChatPrint("You cannot unequip this while in combat.") return false end
    if not self:CanCarryItem( item ) then return false end --Player needs room in their inventory to unequip.
    return true
end

function PlayerMeta:CanUnequipAmmo( item, amt )
    if not self:Alive() then self:ChatPrint("You are dead, you cannot unequip this.") return false end
    if self:InCombat() then self:ChatPrint("You cannot unequip this while in combat.") return false end
    if not self:CanCarryItem( item, amt ) then return false end
    return true
end

function translateAmmoNameID( ammo ) --This function translates an itemid/ammoid to its opposite. I know it kinda sucks but whatever.
    if AS.Items[ammo] then --we were given a AS.itemid.
        return AS.Items[ammo].use.ammotype --we will convert the itemid to the ammoid and send it back.
    else --We were not given an AS.itemid. (assuming we were fed an ammoid and not an itemid.)
        ammo = string.lower(ammo)
        for k, v in pairs(AS.Items) do
            if not string.find( k, "ammo_" ) then continue end --Ignore everything thats not an ammo.
            if string.lower(AS.Items[k].use.ammotype) == ammo then
                return k --We'll feed back the itemid
            end
        end
    end
    return nil
end

function FetchToolIDByClass( class )
    local item
    for k, v in pairs( AS.Items ) do
        if v.category != "tool" then continue end --Skip everything not a tool
        if v.ent != class then continue end --Skip everything that doesn't have the entity tied
        item = k
        break
    end

    return item
end

function PlayerMeta:GetAllTools() --Will return a table of a player's deployed tools
    local tbl = {}
    for k, v in pairs( ents.GetAll() ) do
        if not v.AS_OwnableObject then continue end --Ignore everything that's not an ownable object
        if not IsValid(v:GetObjectOwner()) then continue end
        if v:GetObjectOwner() != self then continue end
        tbl[k] = v
    end
    return tbl
end

function PlayerMeta:GetArmor()
    for k, v in pairs( self:GetWeapons() ) do
        if not v.ASArmor then continue end --Skip everything not an armor.
        if v.ASID then --Item has an ASID.
            return v.ASID --We'll return the active armor ID.
        end
    end
    return false --If we've reached this point, they don't have armor.
end

function PlayerMeta:GetArmorWep() --Same thing as the function above, but will return the weapon instead of the ASID.
    for k, v in pairs( self:GetWeapons() ) do
        if not v.ASArmor then continue end
        if v.ASID then
            return v
        end
    end
    return false
end

function PlayerMeta:HasArmor()
    local armor = self:GetArmor()
    if armor then return true end
    return false
end

function CalculateItemSalvage( itemid, amt ) --This will calculate the amount of resources to recieve from salvaging an item.
    local tbl = {}

    for k, v in pairs( AS.Items[itemid].craft ) do
        if not SET.RawResources[k] then continue end --Ignore everything not a raw resource
        local toAmt = math.floor(v * SET.DestroyPerc) * amt
        tbl[k] = toAmt
    end

    return tbl
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

    net.Receive("as_syncinventory", function()
        local inv = net.ReadTable()
        LocalPlayer():SetInventory( inv )
    end)

end