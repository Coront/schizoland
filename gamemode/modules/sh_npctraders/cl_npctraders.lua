// Initialize NW vars for clientside NPC Shop menu
local traderEntity = nil
local traderName = ""
local stockItems = ""
local restockTime = 10
local currencyItem = ""
local currencySymbol = ""
local currencyLocation = ""
local defaultCurrencyAmount = -1

local function setNPCTraderVars(npctrader_entityObj)
    traderEntity = npctrader_entityObj
    traderName = npctrader_entityObj:GetNWString("traderName", "")
    stockItems = npctrader_entityObj:GetNWString("stockItems", "")
    restockTime = npctrader_entityObj:GetNWInt("restockTime", 10)
    currencyItem = npctrader_entityObj:GetNWString("currencyItem", "")
    currencySymbol = npctrader_entityObj:GetNWString("currencySymbol", "")
    currencyLocation = npctrader_entityObj:GetNWString("currencyLocation", "")
    defaultCurrencyAmount = npctrader_entityObj:GetNWString("defaultCurrencyAmount", 0)
end

// Set NW vars for clientside NPC Shop menu
net.Receive( "npctradermenu", function()
    local npctraderEntity = net.ReadEntity()
    local npctraderData = net.ReadTable()
    setNPCTraderVars(npctraderEntity)
    NPCTraderMenu(npctraderEntity)
end )

// Play a noise when the transaction is complete
net.Receive("as_NPCTraderTransactionComplete", function(len, ply)
    surface.PlaySound(STORAGECUE.TRANSFER)
end)


function NPCTraderMenu(npctrader_entity)
    if IsValid(frameNPCTraderShop) then frameNPCTraderShop:Close() end

    timer.Create("AutoRefreshNPCTraderGUI", tonumber(restockTime), 0, function()
        if IsValid(LocalPlayer()) and IsValid(frameNPCTraderShop) and LocalPlayer():GetPos():Distance(npctrader_entity:GetPos()) < 100 then
            frameNPCTraderShop:Clear()
            NPCTraderMenu(npctrader_entity)
        else
            timer.Destroy("AutoRefreshNPCTraderGUI")
        end
    end)

    -- General frame of NPC Trader Shop menu
    frameNPCTraderShop = vgui.Create("DFrame")
    frameNPCTraderShop:SetSize(960, 700)
    frameNPCTraderShop:Center()
    frameNPCTraderShop:MakePopup()
    frameNPCTraderShop:SetDraggable( false )
    frameNPCTraderShop:SetTitle( "" )
    frameNPCTraderShop:ShowCloseButton( false )
    function frameNPCTraderShop:Paint( w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetMaterial( Material("gui/aftershock/default.png") )
        surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
        surface.DrawTexturedRect( 0, 0, w, h )
    end
    local cbuttonsize = 24
    local closebutton = CreateCloseButton( frameNPCTraderShop, cbuttonsize, frameNPCTraderShop:GetWide() - cbuttonsize - 6, 3 )


    -- Player inventory
    inventorypanel = vgui.Create("DPanel", frameNPCTraderShop)
    local x, y, space = 50, 50, 60
    inventorypanel:SetPos( x, y )
    inventorypanel:SetSize( (frameNPCTraderShop:GetWide() / 2) - space, (frameNPCTraderShop:GetTall() - 45) - y )
    function inventorypanel:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end
    getPlayerInventory(npctrader_entity)

    local weight = vgui.Create("DPanel", inventorypanel)
    weight:SetPos( 5, inventorypanel:GetTall() - 25 )
    weight:SetSize( inventorypanel:GetWide() - 10, 20 )
    function weight:Paint( w, h )
        local col = COLHUD_DEFAULT:ToTable()
        surface.SetDrawColor( col[1], col[2], col[3], 150 )
        surface.DrawRect( 0, 0, (LocalPlayer():GetCarryWeight() / LocalPlayer():MaxCarryWeight()) * w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    weightlbl = vgui.Create("DLabel", weight)
    weightlbl:SetFont("TargetID")
    weightlbl:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
    weightlbl:SetContentAlignment( 3 )
    weightlbl:SizeToContents()
    weightlbl:SetPos( weight:GetWide() / 2 - weightlbl:GetWide() / 2, 1 )
    function weightlbl:Think()
        if LocalPlayer():GetCarryWeight() <= LocalPlayer():MaxCarryWeight() then
            weightlbl:SetColor( Color( 255, 255, 255 ) )
        else
            weightlbl:SetColor( COLHUD_BAD )
        end
    end

    local playerInventoryFrame = vgui.Create("DLabel", frameNPCTraderShop)
    playerInventoryFrame:SetFont("TargetID")
    if ( currencyLocation == "left" ) then
        playerInventoryFrame:SetText( "Your Currency: " .. currencySymbol .. LocalPlayer():GetNWInt("NPCTraderCurrency_AMT", 0) )
    else
        playerInventoryFrame:SetText( "Your Currency: " .. LocalPlayer():GetNWInt("NPCTraderCurrency_AMT", 0)  .. currencySymbol)
    end
    playerInventoryFrame:SetContentAlignment( 3 )
    playerInventoryFrame:SizeToContents()
    playerInventoryFrame:SetPos( frameNPCTraderShop:GetWide() / 18, 32 )

    overallInventoryPanel = vgui.Create("DPanel", frameNPCTraderShop)
    local x, y, space = 60, 50, 60
    overallInventoryPanel:SetPos( inventorypanel:GetWide() + x, y )
    overallInventoryPanel:SetSize( (frameNPCTraderShop:GetWide() / 2) - space, (frameNPCTraderShop:GetTall() - 45) - y )
    function overallInventoryPanel:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    -- Generate NPC Trader Shop inventory
    -- Note: Timer is there to prevent race conditions
    timer.Simple(0.05, function()
        getNPCTraderInventory( npctrader_entity )
    end)


end
concommand.Add( "npctradermenu", NPCTraderMenu )

function getNPCTraderInventory(npctrader_entity)

    -- Get stock data from server
    local stockTable = {}
    net.Start("as_requestNPCTraderStock")
    net.WriteEntity(npctrader_entity)
    net.SendToServer()

    -- Stock derma for client
    local itemscrollpanel = vgui.Create("DScrollPanel", overallInventoryPanel)
    itemscrollpanel:SetPos( 5, 5 )
    itemscrollpanel:SetSize( inventorypanel:GetWide() - 10, inventorypanel:GetTall() - 30 )

    npcStockList = vgui.Create( "DIconLayout", itemscrollpanel )
    npcStockList:SetSize( itemscrollpanel:GetWide(), itemscrollpanel:GetTall() )
    npcStockList:SetSpaceY( 5 )
    npcStockList:SetSpaceX( 5 )
 
    net.Receive("as_receiveNPCTraderStock", function(len, ply)
        stockTable = net.ReadTable()

        // Get currency from NPC Trader
        local function setNWCurrencyAmountNPCTrader()
            for i=1, #stockTable do
                local k = stockTable[i]["item"]
                local v = stockTable[i]["amountInStock"]
                if k == currencyItem then 
                    npctrader_entity:SetNWInt("NPCTraderCurrency_AMT", v)
                    return
                end
            end
            npctrader_entity:SetNWInt("NPCTraderCurrency_AMT", 0)
        end

        local npcInventoryFrame = vgui.Create("DLabel", frameNPCTraderShop)
        npcInventoryFrame:SetFont("TargetID")
        npcInventoryFrame:SetContentAlignment( 3 )
        npcInventoryFrame:SetPos( frameNPCTraderShop:GetWide() / 2 + 5, 32 )
        if ( currencyLocation == "left" ) then
            npcInventoryFrame:SetText( "Trader's Currency: " .. currencySymbol .. npctrader_entity:GetNWInt("NPCTraderCurrency_AMT", 0) )
            npcInventoryFrame:SizeToContents()
        else
            npcInventoryFrame:SetText( "Trader's Currency: " .. npctrader_entity:GetNWInt("NPCTraderCurrency_AMT", 0)  .. currencySymbol)
            npcInventoryFrame:SizeToContents()
        end

        setNWCurrencyAmountNPCTrader()

        for i=1, #stockTable do
            local k = stockTable[i]["item"]
            local v = stockTable[i]["amountInStock"]
            local npcTraderHasCurrency = false
            local info = AS.Items[k]
            local name = info.name or "name?" .. k
            local desc = info.desc or "desc?" .. k
            local weight = info.weight or "weight?" .. k
        
            local price = ""
            if ( currencyLocation == "left" ) then
                price = currencySymbol .. info.value or "price?" .. k
                npcInventoryFrame:SetText( "Trader's Currency: " .. currencySymbol .. npctrader_entity:GetNWInt("NPCTraderCurrency_AMT", 0) )
                npcInventoryFrame:SizeToContents()
            else
                price = info.value or "price?" .. k .. currencySymbol
                npcInventoryFrame:SetText( "Trader's Currency: " .. npctrader_entity:GetNWInt("NPCTraderCurrency_AMT", 0)  .. currencySymbol)
                npcInventoryFrame:SizeToContents()
            end


            local panel = npcStockList:Add("SpawnIcon")
            local size = GetConVar("as_menu_inventory_itemiconsize"):GetInt()
            panel:SetSize( size, size )
            panel:SetModel( info.model, info.skin or 0 )
            
            local TTtext = v > 1 and name .. "\n" .. desc .. "\nWeight: " .. weight .. " [" .. (isnumber(weight) and weight * v or "w?") .. "]"  .. "\n Price: " .. price or name .. "\n" .. desc .. "\nWeight: " .. weight
            tooltipadd = tooltipadd or ""
            panel:SetTooltip(TTtext .. tooltipadd)
            function panel:Paint( w, h )
                local col = info.color and info.color:ToTable() or COLHUD_PRIMARY:ToTable()
                surface.SetDrawColor( col[1], col[2], col[3], 50 )
                surface.DrawRect( 0, 0, w, h )

                if info.color then
                    surface.SetDrawColor( info.color )
                else
                    surface.SetDrawColor( COLHUD_PRIMARY )
                end
                surface.DrawOutlinedRect( 0, 0, w, h, 1 )
            end

            local itemamt = vgui.Create("DLabel", panel)
            itemamt:SetFont("TargetID")
            itemamt:SetText( v )
            itemamt:SetContentAlignment( 3 )
            itemamt:SizeToContents()
            itemamt:SetPos( (panel:GetWide() - itemamt:GetWide()) - 2, panel:GetTall() - itemamt:GetTall() )

            local function itemamtUpdate()
                if LocalPlayer():GetBank()[k] then
                    itemamt:SetText( LocalPlayer():GetBank()[k] )
                    itemamt:SizeToContents()
                    itemamt:SetPos( (panel:GetWide() - itemamt:GetWide()) - 2, panel:GetTall() - itemamt:GetTall() )
                    weightlbl:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
                    weightlbl:SizeToContents()
                    bankweightlbl:SetText( "Weight: " .. LocalPlayer():GetBankWeight() .. " / " .. LocalPlayer():MaxBankWeight( ent:GetNWString("ASID") ) )
                    bankweightlbl:SizeToContents()
                end
            end

            local function buyItem(item, amt)
                itemamtUpdate()
                net.Start("as_buyItemFromNPC")
                net.WriteEntity( npctrader_entity )
                net.WriteString( item )
                net.WriteUInt( amt, NWSetting.ItemAmtBits )
                net.SendToServer()

                frameNPCTraderShop:Clear()
                NPCTraderMenu(npctrader_entity)
                end

                panel.DoClick = function( self )
                    buyItem(k, 1 )
                end
                panel.DoRightClick = function( self )
                    local options = vgui.Create("DMenu")
                    if v > 1 then
                        options:AddOption("Buy 1", function()
                            buyItem(k, 1 )
                        end)
                        options:AddOption("Buy X", function()
                            VerifySlider( LocalPlayer():GetInventory()[k], function( amt )
                                buyItem(k, amt )
                            end )
                        end)
                    end
                    options:AddOption("Buy All", function()
                        buyItem(k, v)
                    end)
                options:Open()
            end
        end
    end)
end


function getPlayerInventory(npctrader_entity)

    local itemscrollpanel = vgui.Create("DScrollPanel", inventorypanel)
    itemscrollpanel:SetPos( 5, 10 )
    itemscrollpanel:SetSize( inventorypanel:GetWide() - 10, inventorypanel:GetTall() - (10) - 30 )

    inventoryitemlist = vgui.Create( "DIconLayout", itemscrollpanel )
    inventoryitemlist:SetSize( itemscrollpanel:GetWide(), itemscrollpanel:GetTall() )
    inventoryitemlist:SetSpaceY( 5 )
    inventoryitemlist:SetSpaceX( 5 )

    for k, v in SortedPairs( LocalPlayer():GetInventory() ) do
        if (AS.Items[k].nostore or false) then continue end
        
        local npcTraderCurrencyItem = currencyItem
        if k == npcTraderCurrencyItem then LocalPlayer():SetNWInt("NPCTraderCurrency_AMT", v) end

        local info = AS.Items[k]
        local name = info.name or "name?" .. k
        local desc = info.desc or "desc?" .. k
        local weight = info.weight or "weight?" .. k

        local price = ""
        if ( currencyLocation == "left" ) then
            price = currencySymbol .. info.value or "price?" .. k
        else
            price = info.value or "price?" .. k .. currencySymbol
        end

        local panel = inventoryitemlist:Add("SpawnIcon")
        local size = GetConVar("as_menu_inventory_itemiconsize"):GetInt()
        panel:SetSize( size, size )
        panel:SetModel( info.model, info.skin or 0 )
        local TTtext = v > 1 and name .. "\n" .. desc .. "\nWeight: " .. weight .. " [" .. (isnumber(weight) and weight * v or "w?") .. "]"  .. "\n Price: " .. price or name .. "\n" .. desc .. "\nWeight: " .. weight
        tooltipadd = tooltipadd or ""
        panel:SetTooltip(TTtext .. tooltipadd)
        function panel:Paint( w, h )
            local col = info.color and info.color:ToTable() or COLHUD_PRIMARY:ToTable()
            surface.SetDrawColor( col[1], col[2], col[3], 50 )
            surface.DrawRect( 0, 0, w, h )

            if info.color then
                surface.SetDrawColor( info.color )
            else
                surface.SetDrawColor( COLHUD_PRIMARY )
            end
            surface.DrawOutlinedRect( 0, 0, w, h, 1 )
        end

        local itemamt = vgui.Create("DLabel", panel)
        itemamt:SetFont("TargetID")
        itemamt:SetText( v )
        LocalPlayer():SetNWInt("TraderNPC_CurrencyAmt", v)
        itemamt:SetContentAlignment( 3 )
        itemamt:SizeToContents()
        itemamt:SetPos( (panel:GetWide() - itemamt:GetWide()) - 2, panel:GetTall() - itemamt:GetTall() )

        local function itemamtUpdate()
            if LocalPlayer():GetInventory()[k] then
                itemamt:SetText( LocalPlayer():GetInventory()[k] )
                itemamt:SizeToContents()
                itemamt:SetPos( (panel:GetWide() - itemamt:GetWide()) - 2, panel:GetTall() - itemamt:GetTall() )
                weightlbl:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
                weightlbl:SizeToContents()
            else
                panel:Remove()
                weightlbl:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
                weightlbl:SizeToContents()
            end
        end

        local function sellItem(item, amt)
            itemamtUpdate()

            net.Start("as_sellItemToNPC")
            net.WriteEntity( npctrader_entity )
            net.WriteString( item )
            net.WriteUInt( amt, NWSetting.ItemAmtBits )
            net.SendToServer()

            timer.Simple(0.1, function ()
                frameNPCTraderShop:Clear()
                NPCTraderMenu(npctrader_entity) 
            end)
        end

        panel.DoClick = function( self )
            sellItem(k, 1 )
        end
        panel.DoRightClick = function( self )
            local options = vgui.Create("DMenu")
            if v > 1 then
                options:AddOption("Sell 1", function()
                    sellItem(k, 1 )
                end)
                options:AddOption("Sell X", function()
                    VerifySlider( LocalPlayer():GetInventory()[k], function( amt )
                        sellItem(k, amt )
                    end )
                end)
            end
            options:AddOption("Sell All", function()
                sellItem(k, LocalPlayer():GetInventory()[k] )
            end)
            options:Open()
        end
    end
end
