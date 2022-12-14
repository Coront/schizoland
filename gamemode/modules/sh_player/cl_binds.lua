AS_ClientConVar( "as_bind_inventory", "TAB", true, false )
AS_ClientConVar( "as_bind_skills", "b", true, false )
AS_ClientConVar( "as_bind_missions", "m", true, false )
AS_ClientConVar( "as_bind_stats", "t", true, false )
AS_ClientConVar( "as_bind_players", "p", true, false )
AS_ClientConVar( "as_bind_class", "F3", true, false )
AS_ClientConVar( "as_bind_craft", "F4", true, false )
AS_ClientConVar( "as_bind_ownership", "F11", true, false )
AS_ClientConVar( "as_bind_thirdperson", "g", true, false )

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
        local tr = ply:TraceFromEyes( 150 )

        if button == GetConVarString("as_bind_inventory") then
            if IsValid(tr.Entity) and tr.Entity:GetClass() == "prop_vehicle_jeep" and tr.Entity:GetObjectOwner() == ply and not LocalPlayer():InVehicle() then
                tr.Entity:EmitSound(STORAGECUE.OPEN)
                AS.Storage.Menu( tr.Entity )
            else
                AS.Inventory.Open()
            end
        elseif button == GetConVarString("as_bind_skills") then
            AS.Inventory.Open( 2 )
        elseif button == GetConVarString("as_bind_missions") then
            AS.Inventory.Open( 4 )
        elseif button == GetConVarString("as_bind_stats") then
            AS.Inventory.Open( 5 )
        elseif button == GetConVarString("as_bind_class") then
            AS.Class.Open()
        elseif button == GetConVarString("as_bind_craft") then
            AS.Craft.Open()
        elseif button == GetConVarString("as_bind_players") then
            AS.Inventory.Open( 6 )
        elseif button == GetConVarString("as_bind_ownership") then
            local tr = ply:TraceFromEyes( 150 )
            if tr.Entity and IsValid(tr.Entity) and tr.Entity:IsObjectOwnable() then
                ply:BecomeObjectOwner( tr.Entity )
            end
        elseif button == GetConVarString("as_bind_thirdperson") then
            RunConsoleCommand("as_thirdperson")
        end
    end
end )