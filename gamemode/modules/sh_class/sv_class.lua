function PlayerChangeClass( ply, cmd, args )
    local class = args[1]
    if not AS.Classes[class] then return end
    if not ply:CanChangeClass( class ) then return end
    if tobool(GetConVar("as_classchangecost"):GetInt()) then
        for k, v in pairs( SET.ClassChangeCostTbl ) do
            ply:TakeItemFromInventory( k, v )
            ply:ResyncInventory()
        end
    end

    ply:SetASClass( class )
    ply:Spawn()
    ply:ChatPrint("You are now a " .. AS.Classes[class].name .. "." )

end
concommand.Add( "as_changeclass", PlayerChangeClass )