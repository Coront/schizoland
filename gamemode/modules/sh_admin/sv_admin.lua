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