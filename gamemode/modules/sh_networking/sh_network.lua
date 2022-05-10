--[[
Quick Warning, DO NOT modify this file unless you are ABSOLUTELY SURE you know what you're doing. The networking data needs to be handled very
carefully or it can cause issues with the server entirely. 

Net messages should never be sent extremely quickly, and should never be unneccessarily large.
]]

AS.Networking = {}

AS.Networking.Settings = {}
NWSetting = AS.Networking.Settings

--Bit Counts (Reference net.WriteInt)
NWSetting.MaxDifferentItems = 10
NWSetting.ItemNameBits = 8
NWSetting.ItemAmtBits = 20

-- ██╗    ██╗██████╗ ██╗████████╗██╗███╗   ██╗ ██████╗
-- ██║    ██║██╔══██╗██║╚══██╔══╝██║████╗  ██║██╔════╝
-- ██║ █╗ ██║██████╔╝██║   ██║   ██║██╔██╗ ██║██║  ███╗
-- ██║███╗██║██╔══██╗██║   ██║   ██║██║╚██╗██║██║   ██║
-- ╚███╔███╔╝██║  ██║██║   ██║   ██║██║ ╚████║╚██████╔╝
--  ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝

--[[
    net.WriteInventory()
    Desc: Will compress item keys into data to be sent. Use this rather than net.WriteTable for player inventories.
]]
function net.WriteInventory( inventory )
    local reps = table.Count( inventory )
    net.WriteUInt( reps, NWSetting.MaxDifferentItems )

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