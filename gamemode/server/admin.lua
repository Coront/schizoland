function PlayerMeta:AdminSpawnItem( item, amt )
    self:AddItemToInventory( item, amt )
    self:ChatPrint("You have received " .. AS.Items[item].name .. " (" .. amt .. ").")
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_admin_modifyconvar")
util.AddNetworkString("as_admin_spawnitem")

net.Receive("as_admin_modifyconvar", function( _, ply )
    local convar = net.ReadString()
    local value = net.ReadString()

    if not ply:IsAdmin() then ply:ChatPrint("You are not an admin.") return end

    convar = GetConVar(convar)
    convar:SetString( value )
end)

net.Receive("as_admin_spawnitem", function( _, ply )
    local item = net.ReadString()
    local amt = net.ReadInt( 32 )

    if not ply:IsAdmin() then ply:ChatPrint("You are not an admin.") ply:ResyncInventory() return end

    ply:AdminSpawnItem( item, amt )
end)