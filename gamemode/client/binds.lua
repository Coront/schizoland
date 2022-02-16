CreateClientConVar( "as_bind_inventory", "TAB", true, false )
CreateClientConVar( "as_bind_skills", "b", true, false )
CreateClientConVar( "as_bind_missions", "m", true, false )
CreateClientConVar( "as_bind_stats", "t", true, false )

function GetConVarString( convar )
    return GetConVar(convar):GetString()
end

function GetKeyName( button )
    return input.GetKeyName( button )
end

hook.Add( "PlayerBindPress", "AS_SprayBlock", function( ply, bind )
    if string.find( bind, "impulse 201" ) then
        return true
    end
end )

hook.Add( "PlayerButtonDown", "AS_Binds", function( ply, button )
    if IsFirstTimePredicted() then
        local button = GetKeyName( button )

        if button == GetConVarString("as_bind_inventory") then
            AS.Inventory.Open()
        elseif button == GetConVarString("as_bind_skills") then
            AS.Inventory.Open( 2 )
        elseif button == GetConVarString("as_bind_missions") then
            AS.Inventory.Open( 3 )
        elseif button == GetConVarString("as_bind_stats") then
            AS.Inventory.Open( 4 )
        end
    end
end )