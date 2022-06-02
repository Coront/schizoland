function PlayerMeta:AdminSpawnItem( item, amt )
    self:AddItemToInventory( item, amt )
    self:ChatPrint("You have received " .. AS.Items[item].name .. " (" .. amt .. ").")
end

-- ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝

hook.Add( "EntityTakeDamage", "AS_DevMode", function( target, dmginfo )
    if not target:IsPlayer() then return end
    if not target:InDevmode() then return end
    local attacker = dmginfo:GetAttacker()

    dmginfo:SetDamage( 0 )

    if attacker:IsPlayer() then
        target:ChatPrint("You were attacked by " .. attacker:Nickname() .. " while in devmode.")
        attacker:ChatPrint("You attacked " .. target:Nickname() .. ", who is in devmode.")
    end
end)

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_admin_modifyconvar")
util.AddNetworkString("as_admin_spawnitem")
util.AddNetworkString("as_admin_changeskillxp")
util.AddNetworkString("as_admin_inventory_request")
util.AddNetworkString("as_admin_inventory_send")
util.AddNetworkString("as_admin_inventory_deleteitem")

net.Receive("as_admin_modifyconvar", function( _, ply )
    local convar = net.ReadString()
    local value = net.ReadString()

    if not ply:IsAdmin() then ply:ChatPrint("You are not an admin.") return end

    convar = GetConVar(convar)
    convar:SetString( value )

    plogs.PlayerLog(ply, "Admin", ply:NameID() .. " set server convar " .. convar:GetName() .. " to " .. value, {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
    })
end)

net.Receive("as_admin_spawnitem", function( _, ply )
    local item = net.ReadString()
    local amt = net.ReadUInt( NWSetting.ItemAmtBits )

    if not ply:IsAdmin() then ply:ChatPrint("You are not an admin.") return end

    ply:AdminSpawnItem( item, amt )

    plogs.PlayerLog(ply, "Admin", ply:NameID() .. " spawned item " .. AS.Items[item].name .. " (" .. amt .. ")", {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
    })
end)

net.Receive("as_admin_changeskillxp", function( _, ply )
    local skill = net.ReadString()
    local amt = net.ReadInt( 32 )

    if not ply:IsAdmin() then ply:ChatPrint("You are not an admin.") return end

    if amt > 0 then
        ply:ChatPrint("Added " .. amt .. " experience to " .. skill .. ".")
        ply:IncreaseSkillExperience( skill, amt )
        plogs.PlayerLog(ply, "Admin", ply:NameID() .. " added " .. amt ..  " " .. skill .. " experience", {
            ["Name"] 	= ply:Name(),
            ["SteamID"]	= ply:SteamID(),
        })
    else
        amt = -amt
        ply:ChatPrint("Removed " .. amt .. " experience from " .. skill .. ".")
        ply:DecreaseSkillExperience( skill, amt )
        plogs.PlayerLog(ply, "Admin", ply:NameID() .. " removed " .. amt ..  " " .. skill .. " experience", {
            ["Name"] 	= ply:Name(),
            ["SteamID"]	= ply:SteamID(),
        })
    end
    ply:ResyncSkills()
end)

net.Receive( "as_admin_inventory_request", function( _, ply ) 
    if not ply:IsAdmin() then ply:ChatPrint("RIP BOZO") return end

    local ent = net.ReadEntity()
    if not IsValid(ent) then ply:ChatPrint("Player not found.") return end
    if not ent:IsPlayer() then ply:ChatPrint("Not a player.") return end

    net.Start("as_admin_inventory_send")
        net.WriteEntity( ent )
        net.WriteInventory( ent:GetInventory() )
    net.Send(ply)
    plogs.PlayerLog(ply, "Admin", ply:NameID() .. " requested to view " .. ent:Nickname() .. "'s inventory.", {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
    })
end)

net.Receive( "as_admin_inventory_deleteitem", function( _, ply )
    if not ply:IsAdmin() then ply:ChatPrint("Cope Harder") return end

    local ent = net.ReadEntity()
    if not IsValid(ent) then ply:ChatPrint("Player not found.") return end
    if not ent:IsPlayer() then ply:ChatPrint("Not a player.") return end

    local item = net.ReadString()
    if not ent:HasInInventory( item ) then ply:ChatPrint("Player does not have this item.") return end

    local amt = net.ReadUInt( NWSetting.ItemAmtBits )
    if amt > ent:GetItemCount( item ) then amt = ent:GetItemCount( item ) end
    if amt < 0 then amt = 1 end

    ent:TakeItemFromInventory( item, amt )
    ent:ChatPrint("An admin has deleted " .. item .. " (" .. amt .. ") from your inventory.")
    ply:ChatPrint("You have deleted " .. item .. " (" .. amt .. ") from " .. ent:Nickname() .. "'s inventory.")
    plogs.PlayerLog(ply, "Admin", ply:NameID() .. " deleted " .. item .. " (" .. amt .. ") in " .. ent:Nickname() .. "'s inventory", {
        ["Name"] 	= ply:Name(),
        ["SteamID"]	= ply:SteamID(),
        ["Item"] = item .. " (" .. amt .. ")"
    })
end)