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

    if table.Count(invaliditems) > 0 then
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
        self:GiveAmmo( amt, use.ammotype, true )
        self:ChatPrint("Equipped " .. amt .. "x " .. AS.Items[item].name .. ".")
        self:EmitSound(ITEMCUE.DROP)
    end
    if use.items then
        for k, v in pairs( use.items ) do
            self:ChatPrint( AS.Items[k].name .. " (" .. v .. ") added to inventory.")
            self:AddItemToInventory( k, v )
        end
    end
    if use.health then
        self:SetHealth( math.Clamp( self:Health() + use.health, 1, self:GetMaxHealth() ) )
    end
    if use.hunger then
        if use.hunger > 0 then
            self:AddHunger( use.hunger )
        else
            self:TakeHunger( -use.hunger )
        end
    end
    if use.thirst then
        if use.thirst > 0 then
            self:AddThirst( use.thirst )
        else
            self:TakeThirst( -use.thirst )
        end
    end
    if use.hunger or use.thirst then self:ResyncSatiation() end
    if use.stat then
        for k, v in pairs( use.stat ) do
            local length = v.length
            if (v.stack or false) then
                length = self.Status and self.Status[v.effect] and (self.Status[v.effect].time - CurTime()) + v.length or v.length
            end
            self:AddStatus( v.effect, length )
            self:ResyncStatuses()
        end
    end
    if use.toxic then
        if use.toxic > 0 then
            self:AddToxic( use.toxic )
        else
            self:RemoveToxic( -use.toxic )
        end
    end
    if use.sound then
        self:EmitSound( use.sound, 40 )
    end
    if use.soundcs then
        self:SendLua( "LocalPlayer():EmitSound('" .. use.soundcs .. "', 40)" )
    end
    if use.func then
        use.func( self )
    end

    if not use.ammotype then --no ammo because ammo can be unequipped.
        self:AddToStatistic( "item_uses", 1 )
    end
end

function PlayerMeta:EquipItem( item )
    if not self:CanEquipItem( item ) then return end

    self:TakeItemFromInventory( item )
    self:Give( AS.Items[item].wep, true )
    self:ChatPrint("Equipped " .. AS.Items[item].name .. ".")
end

function PlayerMeta:UnequipItem( item )
    if not self:CanUnequipItem( item ) then return end

    self:AddItemToInventory( item )
    local wep = self:GetWeapon(AS.Items[item].wep)
    local ammoinclip = wep:Clip1()
    self:StripWeapon( AS.Items[item].wep )
    self:GiveAmmo( ammoinclip, wep:GetPrimaryAmmoType(), true ) --Returns any extra ammo we have loaded, so it's not deleted.
    self:ChatPrint("Holstered " .. AS.Items[item].name .. ".")
end

function PlayerMeta:UnequipAmmo( item, amt )
    if not self:CanUnequipAmmo( item, amt ) then return end

    self:AddItemToInventory( item, amt )
    self:RemoveAmmo( (AS.Items[item].use.ammoamt) * amt, translateAmmoNameID( item ) )
    self:ChatPrint("Unequipped " .. AS.Items[item].name .. " (" .. amt .. ").")
end

function PlayerMeta:DeployVehicle( item )
    local ent = ents.Create("prop_vehicle_jeep")
    ent:SetAngles(Angle(0,180,0))
    ent:SetModel( AS.Items[item].model )
    ent:SetNWBool("AS_OwnableObject", true)

    local name = AS.Items[item].ent
    local vlist = list.Get( "Vehicles" ) --Will return all of the vehicles.
    local vehicle = vlist[ name ] --A table of the vehicle information.

    for k, v in pairs( vehicle.KeyValues ) do
        ent:SetKeyValue( k, v ) --We'll apply all of the key values from the vehicle table
    end

    ent.VehicleName = vname
    ent.VehicleTable = vehicle
    ent:SetNWString("ASID", item)

    ent:SetObjectOwner( self )
    self:AddToolToCache( item )

    return ent
end

function PlayerMeta:DeployTool( item )
    local class = AS.Items[item].ent or "prop_physics"
    ent = ents.Create(class)
    if ent:GetClass() == "prop_physics" then
        ent:SetModel( AS.Items[item].model )
    end
    ent:SetObjectOwner( self )
    self:AddToolToCache( item )

    return ent
end

function PlayerMeta:DropItem( item, amt )
    if not self:CanDropItem( item ) then return end
    local itemname = AS.Items[item].name

    local ent
    if AS.Items[item].category == "tool" then
        self:TakeItemFromInventory( item, 1 )
        ent = self:DeployTool( item )
    elseif AS.Items[item].category == "vehicle" then
        self:TakeItemFromInventory( item, 1 )
        ent = self:DeployVehicle( item )
    else
        self:TakeItemFromInventory( item, amt )
        ent = ents.Create("as_baseitem")
        ent:SetItem( item )
        ent:SetAmount( amt )
    end
    ent:SetSkin( AS.Items[item].skin or 0 )
    ent:SetPos( self:TracePosFromEyes(200) + Vector( 0, 0, 20 ) )
    ent:Spawn()
    ent:PhysWake()
    ent:EmitSound(ITEMCUE.DROP)

    self:ChatPrint("Dropped " .. itemname .. " (" .. amt .. ").")
end

function PlayerMeta:DestroyItem( item, amt )
    local itemname = AS.Items[item].name
    self:TakeItemFromInventory( item, amt )
    self:ChatPrint("Salvaged " .. itemname .. " (" .. amt .. ").")
    for k, v in pairs( CalculateItemSalvage(item, amt) ) do
        if v < 1 then continue end
        self:AddItemToInventory( k, v )
        self:ChatPrint(AS.Items[k].name .. " (" .. v .. ") added to inventory.")
    end
    self:EmitSound(ITEMCUE.DESTROY)

    self:AddToStatistic( "item_salvage", amt )
end

-- ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗
-- ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝
-- ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗
-- ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝
-- ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗
-- ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝

function PlayerMeta:SaveInventory()
    sql.Query("UPDATE as_characters_inventory SET inv = " .. SQLStr( util.TableToJSON( self:GetInventory(), true ) ) .. " WHERE pid = " .. self:GetPID() )
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
util.AddNetworkString("as_inventory_unequipatch")
util.AddNetworkString("as_inventory_dropitem")
util.AddNetworkString("as_inventory_dropammo")
util.AddNetworkString("as_inventory_droprespack")
util.AddNetworkString("as_inventory_destroyitem")

net.Receive("as_inventory_useitem", function( _, ply ) 
    local item = net.ReadString()

    --We are using an item, and players will only be using an item once, so we need to verify that its a valid item and that the player has it.
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() return end --Invalid item
    if not AS.Items[item].use then ply:ChatPrint("This item doesn't have any use functionality.") ply:ResyncInventory() return end --Person tried to use item but item doesnt have any uses.
    if not ply:HasInInventory( item ) then ply:ChatPrint("You don't have this item.") ply:ResyncInventory() return end --Person doesnt have item

    --We're verified, so run the actual function.
    ply:UseItem( item )

    plogs.PlayerLog(ply, "Items", ply:NameID() .. " used " .. AS.Items[item].name, {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
        ["Item"]	= AS.Items[item].name,
    })
end)

net.Receive("as_inventory_equipitem", function( _, ply ) 
    local item = net.ReadString()

    --We are equipping a item, and players will only be equipping a item once, so we need to verify that its a valid item and that the player has it.
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() return end --Invalid item
    if not AS.Items[item].wep then ply:ChatPrint("This item doesn't have any linked weapons.") ply:ResyncInventory() return end --Person tried to equip an item but the item isnt linked to a weapon.
    if not ply:HasInInventory( item ) then ply:ChatPrint("You don't have this item.") ply:ResyncInventory() return end --Person doesnt have item

    --We're verified, so run the actual function.
    ply:EquipItem( item )

    plogs.PlayerLog(ply, "Items", ply:NameID() .. " equipped " .. AS.Items[item].name, {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
        ["Item"]	= AS.Items[item].name,
    })
end)

net.Receive("as_inventory_unequipitem", function( _, ply ) 
    local item = net.ReadString()

    --We are unequipping a item (usually will be weapon), so we have to verify that the player has the weapon before we return it to their inventory.
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() return end --The weapon the player tried to unequip isnt an item? plus there is nothing to resync.
    if not AS.Items[item].wep then ply:ChatPrint("This weapon doesn't have any linked items.") ply:ResyncInventory() return end --The weapon isn't linked to any items, so this would be impossible but just incase.
    if not ply:HasWeapon( AS.Items[item].wep ) then ply:ChatPrint("You don't have this item equipped.") ply:ResyncInventory() return end --Player doesn't actually have this equipped.

    --We're verified, so run the actual function.
    ply:UnequipItem( item )

    plogs.PlayerLog(ply, "Items", ply:NameID() .. " unequipped " .. AS.Items[item].name, {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
        ["Item"]	= AS.Items[item].name,
    })
end)

net.Receive("as_inventory_unequipammo", function( _, ply ) 
    local item = net.ReadString()
    local amt = net.ReadUInt( NWSetting.ItemAmtBits )

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

    plogs.PlayerLog(ply, "Items", ply:NameID() .. " unequipped ammo " .. AS.Items[item].name .. " (" .. amt .. ")", {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
        ["Item"]	= AS.Items[item].name,
    })
end)

net.Receive("as_inventory_unequipatch", function( _, ply )
    local item = net.ReadString()

    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() return end
    if not ply:HasAttachment( item ) then ply:ChatPrint("You don't have this attachment.") ply:ResyncInventory() return end

    ply:RemoveAttachment( item )
    ply:AddItemToInventory( item, 1, true )

    plogs.PlayerLog(ply, "Items", ply:NameID() .. " equipped attachment " .. AS.Items[item].name, {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
        ["Item"]	= AS.Items[item].name,
    })
end)

net.Receive("as_inventory_dropitem", function( _, ply )
    local item = net.ReadString()
    local amt = net.ReadUInt( NWSetting.ItemAmtBits )

    --Since we are dropping an item, we need to verify that the item exists, that the player has it, and that they are dropping a valid amount of it.
    if CurTime() < (ply.NextItemDrop or 0) then ply:ChatPrint("Please wait " .. math.Round(ply.NextItemDrop - CurTime(), 2) .. " seconds before dropping another item." ) return end
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() return end --Person might try an invalid item
    if not ply:HasInInventory( item ) then ply:ChatPrint("You don't have this item.") ply:ResyncInventory() return end --Person might try running without actually having item
    if not ply:Alive() then ply:ChatPrint("You cannot drop items while being dead.") ply:ResyncInventory() return end
    if amt < 1 then amt = 1 end --Person might try negative numbers
    local inv = ply:GetInventory()
    if amt > inv[item] then amt = inv[item] end --Person might try higher numbers than what they actually have
    amt = math.Round(amt) --Person might try decimals
    if AS.Items[item].nodrop then ply:ChatPrint("This item cannot be dropped.") ply:ResyncInventory() return end

    --We're verified, so we'll run the actual function.
    ply.NextItemDrop = CurTime() + 0.1
    ply:DropItem( item, amt )

    plogs.PlayerLog(ply, "Items", ply:NameID() .. " dropped " .. AS.Items[item].name .. " (" .. amt .. ")", {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
        ["Item"]	= AS.Items[item].name,
    })
end)

net.Receive("as_inventory_dropammo", function( _, ply )
    local item = net.ReadString()
    local amt = net.ReadUInt( NWSetting.ItemAmtBits )

    --Since we are dropping ammo, we need to make sure that they have that ammo and that they are dropping a valid amount of it.
    if not ply:Alive() then ply:ChatPrint("You cannot drop ammo while being dead.") return end
    if amt < 1 then amt = 1 end
    if amt > ply:GetAmmoCount( AS.Items[item].use.ammotype ) then amt = ply:GetAmmoCount( item ) end
    amt = math.Round( amt )
    if amt == 0 then ply:ChatPrint("You do not have this ammo.") return end

    local newamt = ply:GetAmmoCount(AS.Items[item].use.ammotype) - amt
    ply:SetAmmo( newamt, AS.Items[item].use.ammotype )

    local ent = ents.Create("as_spareammo")
    ent:SetPos( ply:TracePosFromEyes(200) + Vector( 0, 0, 20 ) )
    ent:SetModel( AS.Items[item].model )
    ent:Spawn()
    ent:SetAmmoType( AS.Items[item].use.ammotype )
    ent:SetAmmoAmount( amt )

    plogs.PlayerLog(ply, "Items", ply:NameID() .. " dropped unpacked ammo " .. AS.Items[item].name .. " (" .. amt .. ")", {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
        ["Item"]	= AS.Items[item].name,
    })
end)

net.Receive("as_inventory_droprespack", function( _, ply )
    local scrap = net.ReadUInt( NWSetting.ItemAmtBits )
    local sp = net.ReadUInt( NWSetting.ItemAmtBits )
    local chem = net.ReadUInt( NWSetting.ItemAmtBits )

    --Since we are dropping an item, we need to verify that the item exists, that the player has it, and that they are dropping a valid amount of it.
    if CurTime() < (ply.NextItemDrop or 0) then ply:ChatPrint("Please wait " .. math.Round(ply.NextItemDrop - CurTime(), 2) .. " seconds before dropping another item." ) return end
    if not ply:Alive() then ply:ChatPrint("You cannot drop items while being dead.") ply:ResyncInventory() return end
    if scrap < 0 then scrap = 0 end
    if scrap > ply:GetItemCount("misc_scrap") then scrap = ply:GetItemCount("misc_scrap") end
    if sp < 0 then sp = 0 end
    if sp > ply:GetItemCount("misc_smallparts") then sp = ply:GetItemCount("misc_smallparts") end
    if chem < 0 then chem = 0 end
    if chem > ply:GetItemCount("misc_chemical") then chem = ply:GetItemCount("misc_chemical") end
    if scrap == 0 and sp == 0 and chem == 0 then return end

    --We're verified, so we'll run the actual function.
    ply.NextItemDrop = CurTime() + 0.1

    if scrap >= 1 then
        ply:TakeItemFromInventory("misc_scrap", scrap)
    end
    if sp >= 1 then
        ply:TakeItemFromInventory("misc_smallparts", sp)
    end
    if chem >= 1 then
        ply:TakeItemFromInventory("misc_chemical", chem)
    end

    local ent = ents.Create("as_resourcepack")
    ent:SetPos( ply:TracePosFromEyes(200) + Vector( 0, 0, 20 ) )
    ent:Spawn()
    ent:SetScrap( scrap )
    ent:SetSmallParts( sp )
    ent:SetChemicals( chem )
    ent:EmitSound(ITEMCUE.DROP)
    timer.Simple( 0.1, function()
        if IsValid( ent ) then
            ent:ResyncResources()
        end
    end)

    plogs.PlayerLog(ply, "Items", ply:NameID() .. " dropped resource pack ( " .. scrap .. " Scrap, " .. sp .. " Small Parts, " .. chem .. " Chemicals )", {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
        ["Amt"]	= scrap .. " | " .. sp .. " | " .. chem,
    })
end)

net.Receive("as_inventory_destroyitem", function( _, ply )
    local item = net.ReadString()
    local amt = net.ReadUInt( NWSetting.ItemAmtBits )

    --We will be destroying an item, so we just need to verify that the item exists, the player has it, and they have the amount they specified to destroy.
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() return end --Person might try an invalid item
    if not ply:HasInInventory( item ) then ply:ChatPrint("You don't have this item.") ply:ResyncInventory() return end --Person might try running without actually having item
    if not ply:Alive() then ply:ChatPrint("You cannot salvage items while being dead.") ply:ResyncInventory() return end
    if amt < 1 then amt = 1 end --Person might try negative numbers
    local inv = ply:GetInventory()
    if amt > inv[item] then amt = inv[item] end --Person might try higher numbers than what they actually have
    amt = math.Round(amt) --Person might try decimals
    if not AS.Items[item].craft then ply:ChatPrint("This item cannot be salvaged.") ply:ResyncInventory() return end --Needs to be an item that can be destroyed.

    --Contents are verified. Running the actual function.
    ply:DestroyItem( item, amt )

    plogs.PlayerLog(ply, "Items", ply:NameID() .. " salvaged " .. AS.Items[item].name .. " (" .. amt .. ")", {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
        ["Item"]	= AS.Items[item].name,
    })
end)