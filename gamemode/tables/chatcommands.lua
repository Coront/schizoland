AS.AddChatCommand("devmode", function( ply, args ) --callback will always return the player who ran it. (Run it by typing /devmode)
    if not ply:IsAdmin() then ply:ChatPrint("You are not an admin.") return end
    ply:ToggleDevmode()
end)

AS.AddChatCommand("roll", function( ply, args )
    for k, v in pairs( player.GetAll() ) do
        if v:GetPos():Distance( ply:GetPos() ) > PERM.ChatDistance then continue end
        local max = tonumber(args[2]) or 6
        local dice = math.random( 1, max )
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