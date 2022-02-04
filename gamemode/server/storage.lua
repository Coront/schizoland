function PlayerMeta:ValidateStorage() --This function will cycle through a player's storage and validate items.
    local storage = self:GetBank()
    local invaliditems = {}

    for k, v in pairs(storage) do
        if not AS.Items[k] then
            invaliditems[k] = v
            storage[k] = nil
        end
    end
    self:SetBank( storage )

    if #invaliditems > 0 then
        self:ChatPrint("Invalid items have been detected in your stash, and have been cleared:")
        for k, v in pairs(invaliditems) do
            self:ChatPrint(k .. "(x" .. v .. ")")
        end
    end
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_storage_tostore")
util.AddNetworkString("as_storage_toinventory")

net.Receive( "as_storage_tostore", function( _, ply )
    local item = net.ReadString()
    local amt = net.ReadInt( 32 )

    --We are going to store an item into our stash. We need to make sure the player actually has the item on them, and the right amount of it.
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() ply:ResyncBank() return end --Person might try an invalid item
    if not ply:HasInInventory( item ) then ply:ChatPrint("You don't have this item.") ply:ResyncInventory() ply:ResyncBank() return end --Person might try running without actually having item
    if amt < 1 then amt = 1 end --Person might try negative numbers
    local inv = ply:GetInventory()
    if amt > inv[item] then amt = inv[item] end --Person might try higher numbers than what they actually have
    amt = math.Round(amt) --Person might try decimals

    --Everything is verified, we'll run the function.
    ply:DepositItem( item, amt )
end )

net.Receive( "as_storage_toinventory", function( _, ply )
    local item = net.ReadString()
    local amt = net.ReadInt( 32 )

    --We are going to withdraw an item from our stash. We need to make sure the stash actually has the item, and the right amount.
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() ply:ResyncBank() return end --Person might try an invalid item
    if not ply:HasInBank( item ) then ply:ChatPrint("You don't have this item.") ply:ResyncInventory() ply:ResyncBank() return end --Person might try running without actually having item
    if amt < 1 then amt = 1 end --Person might try negative numbers
    local bank = ply:GetBank()
    if amt > bank[item] then amt = bank[item] end --Person might try higher numbers than what they actually have
    amt = math.Round(amt) --Person might try decimals

    --It's all verified.
    ply:WithdrawItem( item, amt )
end )