function PlayerMeta:ValidateInventory() --This function will cycle through a player's inventory and automatically validate all items.
    local inv = self:GetInventory()
    local invaliditems = {}

    for k, v in pairs(inv) do --We'll check every item they have.
        if not AS.Items[k] then --If the item is not found on the Items table, it's invalid, and will have to be cleared to prevent issues.
            invaliditems[k] = v
            inv[k] = nil
        end
    end
    self:SetInventory( inv )

    if #invaliditems > 0 then
        self:ChatPrint("Invalid items have been detected in your inventory, and have been cleared:")
        for k, v in pairs(invaliditems) do
            self:ChatPrint(k .. "(" .. v .. ")")
        end
    end
end

function PlayerMeta:UseItem( item )
    if not self:CanUseItem( item ) then return end

    self:TakeItemFromInventory( item )
    local use = AS.Items[item].use

    if use.ammotype then
        local amt = use.ammoamt
        self:GiveAmmo( amt, use.ammotype, false )
    end
    if use.items then
        for k, v in pairs( use.items ) do
            self:ChatPrint( AS.Items[k].name .. " (" .. v .. ") added to inventory.")
            self:AddItemToInventory( k, v )
        end
        self:ResyncInventory()
    end
    if use.health then
        self:SetHealth( math.Clamp( self:Health() + use.health, 1, self:GetMaxHealth() ) )
    end
    if use.hunger then
        if use.hunger > 0 then
            self:AddHunger( use.hunger )
        else
            self:TakeHunger( use.hunger )
        end
    end
    if use.thirst then
        if use.thirst > 0 then
            self:AddThirst( use.thirst )
        else
            self:TakeThirst( use.thirst )
        end
    end
    if use.hunger or use.thirst then self:ResyncSatiation() end
    if use.stat then
        --self:GiveStatus( use.stat )
    end
    if use.sound then
        self:EmitSound( use.sound, 40 )
    end
    if use.soundcs then
        self:SendLua( "LocalPlayer():EmitSound('" .. use.soundcs .. "', 40)" )
    end
    if use.func then
        use.func()
    end
end

function PlayerMeta:EquipItem( item )
    if not self:CanEquipItem( item ) then return end

    self:TakeItemFromInventory( item )
    self:Give( AS.Items[item].wep )
    self:ChatPrint("Equipped " .. AS.Items[item].name .. ".")
end

function PlayerMeta:UnequipItem( item )
    if not self:CanUnequipItem( item ) then return end

    self:AddItemToInventory( item )
    local wep = self:GetWeapon(AS.Items[item].wep)
    local ammoinclip = wep:Clip1()
    self:StripWeapon( AS.Items[item].wep )
    self:GiveAmmo( ammoinclip, wep:GetPrimaryAmmoType() ) --Returns any extra ammo we have loaded, so it's not deleted.
    self:ChatPrint("Holstered " .. AS.Items[item].name .. ".")
end

function PlayerMeta:UnequipAmmo( item, amt )
    self:AddItemToInventory( item, amt )
    self:RemoveAmmo( (AS.Items[item].use.ammoamt) * amt, translateAmmoNameID( item ) )
    self:ChatPrint("Unequipped " .. AS.Items[item].name .. " (" .. amt .. ").")
end

function PlayerMeta:DropItem( item, amt )
    local itemname = AS.Items[item].name
    self:TakeItemFromInventory( item, amt )
    local ent = ents.Create("as_baseitem")
    ent:SetItem( item )
    ent:SetAmount( amt )
    ent:SetSkin( AS.Items[item].skin or 0 )
    ent:SetPos( self:TracePosFromEyes(200) + Vector( 0, 0, 20 ) )
    ent:Spawn()
    ent:PhysWake()
    self:ChatPrint("Dropped " .. itemname .. " (" .. amt .. ")")
    ent:EmitSound(ITEMCUE.DROP)
end

function PlayerMeta:DestroyItem( item, amt )
    local itemname = AS.Items[item].name
    self:TakeItemFromInventory( item, amt )
    self:ChatPrint("Salvaged " .. itemname .. " (" .. amt .. ") for:")
    if AS.Items[item].salvage then
        for k, v in pairs( AS.Items[item].salvage ) do
            self:AddItemToInventory( k, v * amt )
            self:ChatPrint(AS.Items[k].name .. " (" .. v * amt .. ")")
        end
    end
    self:EmitSound(ITEMCUE.DESTROY)
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝
-- To quickly explain, I run net messages through 2 functions. The receiver function is used to verify information, and then the actual function is to do the things I want it to do.

util.AddNetworkString("as_inventory_useitem")
util.AddNetworkString("as_inventory_equipitem")
util.AddNetworkString("as_inventory_unequipitem")
util.AddNetworkString("as_inventory_unequipammo")
util.AddNetworkString("as_inventory_dropitem")
util.AddNetworkString("as_inventory_destroyitem")

net.Receive("as_inventory_useitem", function( _, ply ) 
    local item = net.ReadString()

    --We are using an item, and players will only be using an item once, so we need to verify that its a valid item and that the player has it.
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() return end --Invalid item
    if not AS.Items[item].use then ply:ChatPrint("This item doesn't have any use functionality.") ply:ResyncInventory() return end --Person tried to use item but item doesnt have any uses.
    if not ply:HasInInventory( item ) then ply:ChatPrint("You don't have this item.") ply:ResyncInventory() return end --Person doesnt have item

    --We're verified, so run the actual function.
    ply:UseItem( item )
end)

net.Receive("as_inventory_equipitem", function( _, ply ) 
    local item = net.ReadString()

    --We are equipping a item, and players will only be equipping a item once, so we need to verify that its a valid item and that the player has it.
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() return end --Invalid item
    if not AS.Items[item].wep then ply:ChatPrint("This item doesn't have any linked weapons.") ply:ResyncInventory() return end --Person tried to equip an item but the item isnt linked to a weapon.
    if not ply:HasInInventory( item ) then ply:ChatPrint("You don't have this item.") ply:ResyncInventory() return end --Person doesnt have item

    --We're verified, so run the actual function.
    ply:EquipItem( item )
end)

net.Receive("as_inventory_unequipitem", function( _, ply ) 
    local item = net.ReadString()

    --We are unequipping a item (usually will be weapon), so we have to verify that the player has the weapon before we return it to their inventory.
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") return end --The weapon the player tried to unequip isnt an item? plus there is nothing to resync.
    if not AS.Items[item].wep then ply:ChatPrint("This weapon doesn't have any linked items.") return end --The weapon isn't linked to any items, so this would be impossible but just incase.
    if not ply:HasWeapon( AS.Items[item].wep ) then ply:ChatPrint("You don't have this item equipped.") return end --Player doesn't actually have this equipped.

    --We're verified, so run the actual function.
    ply:UnequipItem( item )
end)

net.Receive("as_inventory_unequipammo", function( _, ply ) 
    local item = net.ReadString()
    local amt = net.ReadInt( 32 )

    --We will be unequipping ammunition, so we will have to validate that the ammo they want to unequip that they actually have and they have the corrent amount as well.
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() return end --The weapon the player tried to unequip ammo that isnt an item?
    local ammo = ply:GetAmmoCount( translateAmmoNameID( item ) )
    local maxCanStore = math.floor( ammo / AS.Items[item].use.ammoamt )
    if amt < 1 then amt = 1 end --Person might try negative numbers
    if amt > maxCanStore then amt = maxCanStore end --Person might try higher numbers than what they have
    amt = math.Round(amt) --fuck off floats
    if amt == 0 then ply:ChatPrint("trollface") ply:ResyncInventory() return end --caught a sussy thick amogus boy

    --We're verified, so run the actual function.
    ply:UnequipAmmo( item, amt )
end)

net.Receive("as_inventory_dropitem", function( _, ply )
    local item = net.ReadString()
    local amt = net.ReadInt( 32 )

    --Since we are dropping an item, we need to verify that the item exists, that the player has it, and that they are dropping a valid amount of it.
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() return end --Person might try an invalid item
    if not ply:HasInInventory( item ) then ply:ChatPrint("You don't have this item.") ply:ResyncInventory() return end --Person might try running without actually having item
    if amt < 1 then amt = 1 end --Person might try negative numbers
    local inv = ply:GetInventory()
    if amt > inv[item] then amt = inv[item] end --Person might try higher numbers than what they actually have
    amt = math.Round(amt) --Person might try decimals

    --We're verified, so we'll run the actual function.
    ply:DropItem( item, amt )
end)

net.Receive("as_inventory_destroyitem", function( _, ply )
    local item = net.ReadString()
    local amt = net.ReadInt( 32 )

    --We will be destroying an item, so we just need to verify that the item exists, the player has it, and they have the amount they specified to destroy.
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() return end --Person might try an invalid item
    if not ply:HasInInventory( item ) then ply:ChatPrint("You don't have this item.") ply:ResyncInventory() return end --Person might try running without actually having item
    if amt < 1 then amt = 1 end --Person might try negative numbers
    local inv = ply:GetInventory()
    if amt > inv[item] then amt = inv[item] end --Person might try higher numbers than what they actually have
    amt = math.Round(amt) --Person might try decimals
    if not AS.Items[item].salvage then ply:ChatPrint("This item cannot be salvaged.") ply:ResyncInventory() return end --Needs to be an item that can be destroyed.

    --Contents are verified. Running the actual function.
    ply:DestroyItem( item, amt )
end)