AS.ChatCommands = {}

function AS.AddChatCommand( str, callback )
    AS.ChatCommands = AS.ChatCommands or {}
    if not str then return end
    if not callback then AS.LuaError("Chat Command does not have a function callback - " .. str) return end

    AS.ChatCommands[str] = callback
end

--  ██████╗██╗  ██╗ █████╗ ████████╗     ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
-- ██╔════╝██║  ██║██╔══██╗╚══██╔══╝    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
-- ██║     ███████║███████║   ██║       ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
-- ██║     ██╔══██║██╔══██║   ██║       ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
-- ╚██████╗██║  ██║██║  ██║   ██║       ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
--  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝        ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝

AS.AddChatCommand("devmode", function( ply, args ) --callback will always return the player who ran it. (Run it by typing /devmode)
    if not ply:IsAdmin() then ply:ChatPrint("You are not an admin.") return end
    ply:ToggleDevmode()
end)

AS.AddChatCommand("forcenamechange", function( ply, args )
    if not ply:IsAdmin() then ply:ChatPrint("You are not an admin.") return end
    local otherPly, multiple = FindPlayerByName( args[2] )
    if not otherPly then ply:ChatPrint("Cannot find a player by the name of '" .. args[2] .. "'.") return end
    if multiple then
        local plys = otherPly[1]:Nickname()
        for k, v in pairs( otherPly ) do
            if k == 1 then continue end
            plys = plys .. ", " .. v:Nickname()
        end
        ply:ChatPrint("Multiple people found by name of '" .. args[2] .. "';")
    end
    local newName = args[3]
    for k, v in pairs( args ) do
        if k < 4 then continue end
        newName = newName .. " " .. v
    end
    if not newName then ply:ChatPrint("Please supply a second argument (Player's New Name).") return end

    ply:ChatPrint("Changed " .. otherPly:Nickname() .. "'s name to " .. newName .. ".")
    otherPly:ChatPrint("An admin has forcefully changed your name to " .. newName .. ".")

    otherPly:SetNWString( "as_name", newName )
    sql.Query("UPDATE as_characters SET name = " .. SQLStr( newName ) .. " WHERE pid = " .. otherPly:GetPID() )
end)

AS.AddChatCommand("roll", function( ply, args )
    local max = tonumber(args[2]) or 6
    local dice = math.random( 1, max )

    for k, v in pairs( player.GetAll() ) do
        if v:GetPos():Distance( ply:GetPos() ) > PERM.ChatDistance then continue end
        v:ChatPrint( "** " .. ply:Nickname() .. " rolled " .. dice .. " out of " .. max)
    end
end)

AS.AddChatCommand("yell", function( ply, args )
    for k, v in pairs( player.GetAll() ) do
        if v:GetPos():Distance( ply:GetPos() ) > PERM.YellDistance then continue end
        local tab = {}
        table.insert( tab, color_blue )
        table.insert( tab, "(Yell) " )
        table.insert( tab, AS.Classes[ply:GetASClass()].color )
        table.insert( tab, ply:Nickname() )
        table.insert( tab, color_white )
        local str = ""
        for k, v in pairs(args) do
            str = str .. v .. " "
        end
        table.insert( tab, ": " .. str )

        net.Start("as_chatmessage")
            net.WriteTable( tab )
        net.Send( v )
    end
end)

AS.AddChatCommand("y", function( ply, args )
    for k, v in pairs( player.GetAll() ) do
        if v:GetPos():Distance( ply:GetPos() ) > PERM.YellDistance then continue end
        local tab = {}
        table.insert( tab, color_blue )
        table.insert( tab, "(Yell) " )
        table.insert( tab, AS.Classes[ply:GetASClass()].color )
        table.insert( tab, ply:Nickname() )
        table.insert( tab, color_white )
        local str = ""
        for k, v in pairs(args) do
            str = str .. v .. " "
        end
        table.insert( tab, ": " .. str )

        net.Start("as_chatmessage")
            net.WriteTable( tab )
        net.Send( v )
    end
end)

AS.AddChatCommand("rules", function( ply, args )
    ply:SendLua("gui.OpenURL('" .. GAMEMODE.Rules .. "')")
end)

AS.AddChatCommand("rename", function( ply, args )
    if CurTime() < (ply.NextNameChange or 0) then ply:ChatPrint("You must wait " .. math.Round(ply.NextNameChange - CurTime()) .. " seconds before changing your name!") return end
    if not args[2] then ply:ChatPrint("Please supply an argument (New Name).") return end
    local newName = args[2]

    if string.len(newName:lower()) < SET.MinNameLength then ply:ChatPrint("Your name must be longer (" .. SET.MinNameLength .. " Characters).") return end
    if string.len(newName:lower()) > SET.MaxNameLength then ply:ChatPrint("Your name must be shorter (" .. SET.MaxNameLength .. " Characters).") return end
    if string.find(newName:lower(), "[%/%\\%!%@%#%$%%%^%&%*%(%)%+%=%.]") then ply:ChatPrint("Your character's name cannot have special characters in it") return end
    for k, v in pairs(SET.BannedWords) do
        if string.find(newName:lower(), v) then ply:Kick("Inappropriate name usage") return end
    end

    ply.NextNameChange = CurTime() + 3600
    ply:ChatPrint("You have changed your name to " .. newName .. ".")
    ply:SetNWString( "as_name", newName )
    sql.Query("UPDATE as_characters SET name = " .. SQLStr( newName ) .. " WHERE pid = " .. ply:GetPID() )
end)

AS.AddChatCommand("discord", function( ply, args )
    ply:SendLua("gui.OpenURL('" .. GAMEMODE.Discord .. "')")
end)

-- ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝

hook.Add( "PlayerSay", "AS_ChatCommands", function( ply, txt, team )
    if not ply:Alive() then return end
    local args = string.Explode(" ", txt)
    args[1] = string.lower( args[1] )

    if string.find(args[1], "/") and  AS.ChatCommands[string.Replace(args[1], "/", "")] then
        local newtxt = string.Replace(args[1], "/", "")
        args[1] = nil
        AS.ChatCommands[newtxt]( ply, args )
        return ""
    end
end)

--  ██████╗ ████████╗██╗  ██╗███████╗██████╗
-- ██╔═══██╗╚══██╔══╝██║  ██║██╔════╝██╔══██╗
-- ██║   ██║   ██║   ███████║█████╗  ██████╔╝
-- ██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗
-- ╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║
--  ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝

concommand.Add( "as_chatcommands", function( ply, cmd, args )
    print( "----[[ Existing Chat Commands ]]----" )

    for k, v in pairs( AS.ChatCommands ) do
        print( "/" .. k )
    end
end)