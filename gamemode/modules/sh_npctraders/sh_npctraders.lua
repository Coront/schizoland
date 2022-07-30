concommand.Add( "as_setnpctrader", function( ply, cmd, args)
    local traderTable = AS.NPCTraders[args[1]]
    if !ply:IsAdmin() then return end

    if SERVER then
        -- Spawn a NPC Trader where the player is looking
        local tr = ply:GetEyeTrace()
        local ent = ents.Create("as_npctrader")
        ent:SetModel(traderTable["model"])
        ent:SetPos(tr.HitPos)
        ent:SetAngles(Angle(0, 90, 0))
        ent:Spawn()

        -- Set serversided variables
        ent.traderID = traderTable["id"]
        ent.traderName = traderTable["name"]
        ent.stockItems = traderTable["stock"]
        ent.alwaysCarryItems = traderTable["alwaysCarryItems"]
        ent.restockTime = traderTable["restockTime"]
        ent.currencyItem = traderTable["currencyItem"]
        ent.currencySymbol = traderTable["currencySymbol"]
        ent.currencyLocation = traderTable["currencySymbolLocation"]

        -- Set shared variables for client
        ent:SetNWString("traderID", ent.traderID) -- Not really used for anything at the moment
        ent:SetNWString("traderName", ent.traderName)
        ent:SetNWString("stockItems", ent.stockItems)
        ent:SetNWString("alwaysCarryItems", ent.alwaysCarryItems)
        ent:SetNWInt("restockTime", ent.restockTime)
        ent:SetNWString("currencyItem", ent.currencyItem)
        ent:SetNWString("currencySymbol", ent.currencySymbol)
        ent:SetNWString("currencyLocation", ent.currencyLocation)
    end   
end)