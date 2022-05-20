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
            self:ChatPrint(k .. "(" .. v .. ")")
        end
    end
end

function PlayerMeta:PickUpStorage( ent )
	local item = ent:GetNWString("ASID")
	ent:Remove()

	if not item then AS.LuaError("Attempt to pick up an object with no entity tied, cannot find itemid - " .. ent.ASID) return end

	self:ChatPrint("Picked up " .. AS.Items[item].name .. ".")
	self:AddItemToInventory( item, 1 )
	self:RemoveToolFromCache( item )
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_storage_tostore")
util.AddNetworkString("as_storage_toinventory")
util.AddNetworkString("as_storage_pickup")

net.Receive( "as_storage_tostore", function( _, ply )
    local item = net.ReadString()
    local amt = net.ReadUInt( NWSetting.ItemAmtBits )
    local ent = net.ReadEntity()
    if not IsValid( ent ) then return end

    --We are going to store an item into our stash. We need to make sure the player actually has the item on them, and the right amount of it.
    if ent:GetClass() != "prop_vehicle_jeep" then ply:ChatPrint("Not a valid entity.") ply:ResyncInventory() ply:ResyncBank() return end
    if ply:GetPos():Distance(ent:GetPos()) > 300 then ply:ChatPrint("You're too far to store items.") ply:ResyncInventory() ply:ResyncBank() return end
    if ent:GetObjectOwner() != ply then ply:ChatPrint("Not an owned object.") ply:ResyncInventory() ply:ResyncBank() return end
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() ply:ResyncBank() return end --Person might try an invalid item
    if not ply:HasInInventory( item, amt ) then ply:ChatPrint("You don't have this item.") ply:ResyncInventory() ply:ResyncBank() return end --Person might try running without actually having item
    if not ply:CanStoreItem( ent, item, amt ) then return end --This is just some default checks, like do they have enough room in their storage.
    if amt < 1 then amt = 1 end --Person might try negative numbers
    local inv = ply:GetInventory()
    if amt > inv[item] then amt = inv[item] end --Person might try higher numbers than what they actually have
    amt = math.Round(amt) --Person might try decimals

    --Everything is verified, we'll run the function.
    ply:DepositItem( item, amt )

    plogs.PlayerLog(ply, "Storage", ply:NameID() .. " stored " .. AS.Items[item].name .. " (" .. amt .. ") in vehicle inventory.", {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
        ["Item"]	= AS.Items[item].name .. " (" .. amt .. ")",
    })
end )

net.Receive( "as_storage_toinventory", function( _, ply )
    local item = net.ReadString()
    local amt = net.ReadUInt( NWSetting.ItemAmtBits )
    local ent = net.ReadEntity()
    if not IsValid( ent ) then return end

    --We are going to withdraw an item from our stash. We need to make sure the stash actually has the item, and the right amount.
    if ent:GetClass() != "prop_vehicle_jeep" then ply:ChatPrint("Not a valid entity.") ply:ResyncInventory() ply:ResyncBank() return end
    if ply:GetPos():Distance(ent:GetPos()) > 300 then ply:ChatPrint("You're too far to withdraw items.") ply:ResyncInventory() ply:ResyncBank() return end
    if ent:GetObjectOwner() != ply then ply:ChatPrint("Not an owned object.") ply:ResyncInventory() ply:ResyncBank() return end
    if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() ply:ResyncBank() return end --Person might try an invalid item
    if not ply:HasInBank( item, amt ) then ply:ChatPrint("You don't have this item.") ply:ResyncInventory() ply:ResyncBank() return end --Person might try running without actually having item
    if not ply:CanWithdrawItem( ent, item, amt ) then return end
    if amt < 1 then amt = 1 end --Person might try negative numbers
    local bank = ply:GetBank()
    if amt > bank[item] then amt = bank[item] end --Person might try higher numbers than what they actually have
    amt = math.Round(amt) --Person might try decimals

    --It's all verified.
    ply:WithdrawItem( item, amt )

    plogs.PlayerLog(ply, "Storage", ply:NameID() .. " withdrew " .. AS.Items[item].name .. " (" .. amt .. ") from vehicle inventory.", {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
        ["Item"]	= AS.Items[item].name .. " (" .. amt .. ")",
    })
end )

net.Receive("as_storage_pickup", function( _, ply )
	local ent = net.ReadEntity()

	if not ent:PlayerCanPickUp( ply ) then return end

	ply:PickUpStorage( ent )
end)