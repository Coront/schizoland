util.AddNetworkString( "npctradermenu" )
util.AddNetworkString( "as_sellItemToNPC" )
util.AddNetworkString( "as_requestNPCTraderStock" )
util.AddNetworkString( "as_receiveNPCTraderStock" )
util.AddNetworkString( "as_buyItemFromNPC" )
util.AddNetworkString( "as_NPCTraderTransactionComplete" )

// Called to get current stock of an NPC from the server
net.Receive("as_requestNPCTraderStock", function(len, ply)
    local npctraderEntity = net.ReadEntity()
    local stockTable = npctraderEntity:getNPCStockTable()
    net.Start("as_receiveNPCTraderStock")
    net.WriteTable(stockTable)
    net.Send(ply)
end )

// Called when a player is selling an item to a NPC shop.
net.Receive("as_buyItemFromNPC", function(len, ply)
    local npctraderEntity = net.ReadEntity()
    local item = net.ReadString()
    local amt = net.ReadUInt(NWSetting.ItemAmtBits)

    -- Check to see if player is valid and is near requested entity
    if !IsValid(ply) or !IsValid(npctraderEntity) or (ply:GetPos():Distance(npctraderEntity:GetPos()) > 250) then return end
    -- Check to make sure player is not trying to buy currency with currency
    if item == npctraderEntity.currencyItem then ply:ChatPrint("No point in trying to buy this...") return end
    -- Check if the npc has the item
    if !npctraderEntity:HasItemInStock( item, amt ) then return end
    -- Check to see if player can carry item
    if !ply:CanCarryItem( item, amt, false ) then return end
    -- Check if player has enough money to buy item off of npc
    local itemInfo = AS.Items[item]
    local totalItemValue = itemInfo.value * amt
    if !ply:HasInInventory( npctraderEntity.currencyItem, totalItemValue ) then ply:ChatPrint("You cannot afford to buy this item!") return end
    -- Remove item from npc inventory
    npctraderEntity:RemoveItemFromStock( item, amt )
    -- Rremove currency from player
    ply:TakeItemFromInventory( npctraderEntity.currencyItem, totalItemValue, false )
    -- Add currency item to npc inventory
    npctraderEntity:AddItemtoStock(npctraderEntity.currencyItem, itemInfo.value, totalItemValue)
    -- Add item to player inventory
    ply:AddItemToInventory( item, amt, false )
    -- Let the player know transaction is complete
    net.Start("as_NPCTraderTransactionComplete")
    net.Send(ply)
end )

// Called when a player is buying an item from a NPC shop.
net.Receive("as_sellItemToNPC", function(len, ply)
    local npctraderEntity = net.ReadEntity()
    local item = net.ReadString()
    local amt = net.ReadUInt(NWSetting.ItemAmtBits)

    -- Check to see if player is valid and is near requested entity
    if !IsValid(ply) or !IsValid(npctraderEntity) or (ply:GetPos():Distance(npctraderEntity:GetPos()) > 250) then return end
    -- Check if the player has the item
    if !ply:HasInInventory( item, amt ) then return end
    -- Check to see if player is trying to sell currency for currency
    if item == npctraderEntity.currencyItem then ply:ChatPrint("No point in trying to sell this...") return end
    -- Check if npc has enough money to buy item off of player
    local itemInfo = AS.Items[item]
    local totalItemValue = itemInfo.value * amt
    if !npctraderEntity:HasItemInStock( npctraderEntity.currencyItem, totalItemValue ) then ply:ChatPrint("NPC Trader doesn't have enough to purchase that off of you.") return end
    -- Remove item from player inventory
    ply:TakeItemFromInventory( item, amt, false )
    -- Remove currency from npc
    npctraderEntity:RemoveItemFromStock( npctraderEntity.currencyItem, totalItemValue )
    -- Add currency item to player inventory
    ply:AddItemToInventory( npctraderEntity.currencyItem, totalItemValue, false )
    -- Add item to npc inventory
    npctraderEntity:AddItemtoStock(item, itemInfo.value, amt)
    -- Let the player know transaction is complete
    net.Start("as_NPCTraderTransactionComplete")
    net.Send(ply)
end )
