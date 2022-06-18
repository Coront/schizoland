--[[
Quick Warning, DO NOT modify this file unless you are ABSOLUTELY SURE you know what you're doing. The networking data needs to be handled very
carefully or it can cause issues with the server entirely. 

General rule is net messages should never be sent extremely quickly, and should never be unneccessarily large.
]]

Networking = {}

Networking.Settings = {}
NWSetting = Networking.Settings

--Bit Counts (Reference net.WriteInt)
NWSetting.MaxDifferentItems = 10
NWSetting.ItemNameBits = 8
NWSetting.ItemAmtBits = 20
NWSetting.ItemCraftBits = 11
NWSetting.ToxicBits = 11
NWSetting.VendorPriceBits = 13
NWSetting.CommunityAmtBits = 16 --How many communities you think there would be max
NWSetting.UIDAmtBits = 16 --How many profiles you think there would be max (I KNOW IT SAYS LOCKER JUST ASSUME ITS FOR ALL ENTITIES WITH PROFILES)

-- ██╗    ██╗██████╗ ██╗████████╗██╗███╗   ██╗ ██████╗
-- ██║    ██║██╔══██╗██║╚══██╔══╝██║████╗  ██║██╔════╝
-- ██║ █╗ ██║██████╔╝██║   ██║   ██║██╔██╗ ██║██║  ███╗
-- ██║███╗██║██╔══██╗██║   ██║   ██║██║╚██╗██║██║   ██║
-- ╚███╔███╔╝██║  ██║██║   ██║   ██║██║ ╚████║╚██████╔╝
--  ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝

--[[
    net.WriteInventory()
    Desc: Will write individual keys as a string and the item amount. Use this rather than net.WriteTable for player inventories.
]]
function net.WriteInventory( inventory )
    local reps = table.Count( inventory )
    net.WriteUInt( reps, NWSetting.MaxDifferentItems ) --The read function needs to know how many times it should repeat reading the information.

    for k, v in pairs( inventory ) do
        local id = k
        local amt = v

        net.WriteString( id )
        net.WriteUInt( amt, NWSetting.ItemAmtBits )
    end
end

-- ██████╗ ███████╗ █████╗ ██████╗ ██╗███╗   ██╗ ██████╗
-- ██╔══██╗██╔════╝██╔══██╗██╔══██╗██║████╗  ██║██╔════╝
-- ██████╔╝█████╗  ███████║██║  ██║██║██╔██╗ ██║██║  ███╗
-- ██╔══██╗██╔══╝  ██╔══██║██║  ██║██║██║╚██╗██║██║   ██║
-- ██║  ██║███████╗██║  ██║██████╔╝██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝

function net.ReadInventory()
    local inventory = {}
    local reps = net.ReadUInt( NWSetting.MaxDifferentItems )

    for i = 1, reps do
        local id = net.ReadString()
        local amt = net.ReadUInt( NWSetting.ItemAmtBits )

        inventory[id] = amt
    end

    return inventory
end