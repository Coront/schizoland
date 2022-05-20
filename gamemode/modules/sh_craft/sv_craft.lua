-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString( "as_crafting_craftitem" )

net.Receive( "as_crafting_craftitem", function( _, ply )
    local item = net.ReadString()
    local amt = net.ReadUInt( NWSetting.ItemCraftBits )

    --We are crafting an item, so first we must validate that the item they are trying to craft exists, can be crafted
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() return end --item doesnt exist
    if not AS.Items[item].craft then ply:ChatPrint("This item cannot be crafted.") ply:ResyncInventory() return end --item exists but not listed as craftable
    if AS.Items[item].hidden then ply:ChatPrint("This item cannot be crafted.") ply:ResyncInventory() return end --same as above but listed as hidden
    if amt < 1 then amt = 1 end --Person might try negative numbers
    amt = math.Round( amt ) --Person might try decimals
    if AS.Items[item].category == "tool" then amt = 1 end
    if not ply:CanCraftItem( item, amt ) then ply:ChatPrint("You lack the sufficient materials to craft this item.") ply:ResyncInventory() return end --no materials????

    --Everything ran is valid, now we run the main function.
    ply:CraftItem( item, amt )

    plogs.PlayerLog(ply, "Craft", ply:NameID() .. " crafted " .. AS.Items[item].name .. " (" .. amt .. ").", {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
        ["Item"]	= AS.Items[item].name .. " (" .. amt .. ")",
    })
end)