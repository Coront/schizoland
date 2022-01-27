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

    if #invaliditems > 1 then
        self:ChatPrint("Invalid items have been detected in your inventory, and have been cleared:")
        for k, v in pairs(invaliditems) do
            self:ChatPrint(k .. "(x" .. v .. ")")
        end
    end
end

function PlayerMeta:UseItem( item )
    self:TakeItemFromInventory( item )
    local use = AS.Items[item].use

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

function PlayerMeta:DropItem( item, amt )
    local itemname = AS.Items[item].name
    self:TakeItemFromInventory( item, amt )
    ent = ents.Create("as_baseitem")
    ent:SetItem( item )
    ent:SetAmount( amt )
    ent:SetPos( self:TracePosFromEyes(200) + Vector( 0, 0, 20 ) )
    ent:Spawn()
    ent:PhysWake()
    self:ChatPrint("Dropped " .. itemname .. " (x" .. amt .. ")")
    ent:EmitSound("items/ammo_pickup.wav")
end

function PlayerMeta:DestroyItem( item, amt )
    local itemname = AS.Items[item].name
    self:TakeItemFromInventory( item, amt )
    self:ChatPrint("Destroyed " .. itemname .. " (x" .. amt .. ")")
    self:EmitSound("physics/cardboard/cardboard_box_break1.wav")
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝
-- To quickly explain, I run net messages through 2 functions. The receiver function is used to verify information, and then the actual function is to do the things I want it to do.

util.AddNetworkString("as_inventory_validate")
util.AddNetworkString("as_inventory_useitem")
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

    --Contents are verified. Running the actual function.
    ply:DestroyItem( item, amt )
end)