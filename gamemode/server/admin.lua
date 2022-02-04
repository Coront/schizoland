util.AddNetworkString("as_admin_spawnitem")

function AdminSpawnItem( _, ply )
    local item = net.ReadString()
    local amt = net.ReadInt( 32 )

    if not ply:IsAdmin() then 
        ply:ChatPrint("You are not an admin.") 
        ply:ResyncInventory()
        return 
    end

    ply:AddItemToInventory( item, amt )
    ply:ChatPrint("You have received " .. AS.Items[item].name .. " (x" .. amt .. ").")
end
net.Receive("as_admin_spawnitem", AdminSpawnItem)