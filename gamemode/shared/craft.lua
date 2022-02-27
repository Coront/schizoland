function PlayerMeta:CanCraftItem( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to give a non-existant item - " .. item) return end
    if not AS.Items[item].craft then AS.LuaError("Attempt to check 'CanCraftItem' with no crafting table - " .. item) return end
    amt = amt and amt > 0 and math.Round(amt) or 1

    for k, v in pairs( AS.Items[item].craft ) do
        if not self:HasInInventory( k, v ) then return false end
    end

    return true
end