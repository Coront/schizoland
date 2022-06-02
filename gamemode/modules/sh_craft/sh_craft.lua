function PlayerMeta:CanCraftItem( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to give a non-existant item - " .. item) return end
    if not AS.Items[item].craft then AS.LuaError("Attempt to check 'CanCraftItem' with no crafting table - " .. item) return end
    amt = amt and amt > 0 and math.Round(amt) or 1

    if AS.Items[item].class and self:GetASClass() != AS.Items[item].class then return false end
    for k, v in pairs( AS.Items[item].craft ) do
        if SET.RawResources[k] and v == 0 then continue end
        if not self:HasInInventory( k, v * amt ) then return false end
    end

    return true
end

function PlayerMeta:CanCraftAmount( item ) --This function just returns the amount of an item the player can craft with their current materials.
    if not AS.Items[item] then AS.LuaError("Attempt to give a non-existant item - " .. item) return end
    if not AS.Items[item].craft then AS.LuaError("Attempt to check 'CanCraftAmount' with no crafting table - " .. item) return end

    local amts = {}
    local inv = self:GetInventory()
    for k, v in pairs( AS.Items[item].craft ) do
        if v == 0 then continue end
        if not inv[k] then return 0 end
        local canmakeamount = math.floor(inv[k] / v)
        amts[k] = canmakeamount
    end

    local maxamount = 0
    for k, v in SortedPairsByValue( amts ) do --We're literally just getting the first key, aka the lowest key and returning it.
        maxamount = v
        break
    end

    return maxamount
end

function PlayerMeta:CraftItem( item, amt )
    for k, v in pairs( AS.Items[item].craft ) do
        if v != 0 then --This stops items than aren't supposed to be taken from a recipe.
            self:TakeItemFromInventory( k, v * amt )
        end
    end

    if SERVER then
        local time = SET.CraftTime * amt
        local itemname = AS.Items[item].name
        self:ChatPrint("Crafting " .. itemname .. " (" .. amt .. ")")
        self:StartTimedEvent( time, true, function()
            local ent
            if AS.Items[item].category == "tool" then
                local class = AS.Items[item].ent or "prop_physics"
                ent = ents.Create(class)
                if ent:GetClass() == "prop_physics" then
                    ent:SetModel( AS.Items[item].model )
                end
                ent:SetSkin( AS.Items[item].skin or 0 )
                ent:SetObjectOwner( self )
                self:AddToolToCache( item )
            else
                ent = ents.Create("as_baseitem")
                ent:SetItem( item )
                ent:SetAmount( amt )
                ent:SetSkin( AS.Items[item].skin or 0 )
            end
            ent:SetPos( self:TracePosFromEyes(200) + Vector( 0, 0, 20 ) )
            ent:Spawn()
            ent:PhysWake()
            ent:EmitSound(ITEMCUE.DROP)
        end)

        self:AddToStatistic( "item_craft", amt )
    end
end