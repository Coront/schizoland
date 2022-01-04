function PlayerMeta:UseItem( item )

end

function PlayerMeta:DropItem( item, amt )
    local itemname = AS.Items[item].name
    self:ChatPrint("Dropped " .. itemname .. " (x" .. amt .. ")")
    self:TakeItemFromInventory( item, amt )
end

function PlayerMeta:DestroyItem( item, amt )
    local itemname = AS.Items[item].name
    self:ChatPrint("Destroyed " .. itemname .. " (x" .. amt .. ")")
    self:TakeItemFromInventory( item, amt )
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝
-- To quickly explain, I run net messages through 2 functions. The receiver function is used to verify information, and then the actual function is to do the things I want it to do.

util.AddNetworkString("as_inventory_useitem")
util.AddNetworkString("as_inventory_dropitem")
util.AddNetworkString("as_inventory_destroyitem")

net.Receive("as_inventory_useitem", function( _, ply ) 
    local item = net.ReadString()

    --We are using an item, and players will only be using an item once, so we need to verify that its a valid item and that the player has it.
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") return end --Invalid item
    if not ply:HasInInventory( item ) then ply:ChatPrint("You don't have this item.") return end --Person doesnt have item

    --We're verified, so run the actual function.
    ply:UseItem( item )
end)

net.Receive("as_inventory_dropitem", function( _, ply )
    local item = net.ReadString()
    local amt = net.ReadInt( 32 )

    --Since we are dropping an item, we need to verify that the item exists, that the player has it, and that they are dropping a valid amount of it.
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") return end --Person might try an invalid item
    if not ply:HasInInventory( item ) then ply:ChatPrint("You don't have this item.") return end --Person might try running without actually having item
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
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") return end --Person might try an invalid item
    if not ply:HasInInventory( item ) then ply:ChatPrint("You don't have this item.") return end --Person might try running without actually having item
    if amt < 1 then amt = 1 end --Person might try negative numbers
    local inv = ply:GetInventory()
    if amt > inv[item] then amt = inv[item] end --Person might try higher numbers than what they actually have
    amt = math.Round(amt) --Person might try decimals

    --Contents are verified. Running the actual function.
    ply:DestroyItem( item, amt )
end)