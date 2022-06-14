AS.Storage = {}

local ent

function AS.Storage.Menu( ent )
    if not IsValid(ent) then return end

    if IsValid(frame_storage) then frame_storage:Close() end

    frame_storage = vgui.Create("DFrame")
    frame_storage:SetSize(960, 700)
    frame_storage:Center()
    frame_storage:MakePopup()
    frame_storage:SetDraggable( false )
    frame_storage:SetTitle( "" )
    frame_storage:ShowCloseButton( false )
    function frame_storage:Paint( w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetMaterial( Material("gui/aftershock/default.png") )
        surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
        surface.DrawTexturedRect( 0, 0, w, h )
    end
    function frame_storage:Think()
        if not IsValid(ent) then frame_storage:Close() end
    end

    local cbuttonsize = 24
    local closebutton = CreateCloseButton( frame_storage, cbuttonsize, frame_storage:GetWide() - cbuttonsize - 6, 3 )

    local pickup = vgui.Create("DButton", frame_storage)
    pickup:SetSize( 80, 20 )
    pickup:SetPos( frame_storage:GetWide() - (cbuttonsize + 10) - pickup:GetWide(), 4 )
    pickup:SetText("Pick Up")
    pickup:SetEnabled( false )
    pickup:SetTooltip("You are not the owner of this object.")
    if ent:PlayerCanPickUp( LocalPlayer() ) then
        pickup:SetEnabled( true )
        pickup:SetTooltip("Pickup the entity and place it in your inventory.")
    end
    function pickup:DoClick()
        net.Start("as_storage_pickup")
            net.WriteEntity( ent )
        net.SendToServer()
        frame_storage:Close()
    end
    function pickup:Paint( w, h )
        if self:IsHovered() then
            surface.SetDrawColor( COLHUD_DEFAULT )
            self:SetColor( COLHUD_SECONDARY )
        else
            surface.SetDrawColor( COLHUD_SECONDARY )
            self:SetColor( COLHUD_DEFAULT )
        end
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    local invbutton = DefaultButton( "Inventory", pickup:GetX() - 80, 4, 80, 20, frame_storage, function()
        frame_storage:Close()
        AS.Inventory.Open( 1, true )
    end)

    local inventory = vgui.Create("DLabel", frame_storage)
    inventory:SetFont("TargetID")
    inventory:SetText( "Inventory" )
    inventory:SetContentAlignment( 3 )
    inventory:SizeToContents()
    inventory:SetPos( 55, 32 )

    inventorypanel = vgui.Create("DPanel", frame_storage)
    local x, y, space = 50, 50, 60
    inventorypanel:SetPos( x, y )
    inventorypanel:SetSize( (frame_storage:GetWide() / 2) - space, (frame_storage:GetTall() - 45) - y )
    function inventorypanel:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    inventorysearchbar = vgui.Create( "DTextEntry", inventorypanel )
    inventorysearchbar:Dock( TOP )
    inventorysearchbar:DockMargin( 1, 1, 1, 0 )
    inventorysearchbar:SetSize( 0, 25 )
    inventorysearchbar:SetPlaceholderText( "Search an item here. Hit enter to submit." )
    inventorysearchbar.OnEnter = function( self )
        inventoryitemlist:Clear()
        AS.Storage.BuildInventory( ent )
    end

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

    AS.Storage.BuildInventory( ent )

    local storage = vgui.Create("DLabel", frame_storage)
    storage:SetFont("TargetID")
    storage:SetText( "Storage" )
    storage:SetContentAlignment( 3 )
    storage:SizeToContents()
    storage:SetPos( frame_storage:GetWide() / 2 + 5, 32 )

    storagepanel = vgui.Create("DPanel", frame_storage)
    local x, y, space = 60, 50, 60
    storagepanel:SetPos( inventorypanel:GetWide() + x, y )
    storagepanel:SetSize( (frame_storage:GetWide() / 2) - space, (frame_storage:GetTall() - 45) - y )
    function storagepanel:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    banksearchbar = vgui.Create( "DTextEntry", storagepanel )
    banksearchbar:Dock( TOP )
    banksearchbar:DockMargin( 0, 0, 0, 0 )
    banksearchbar:SetSize( 0, 25 )
    banksearchbar:SetPlaceholderText( "Search an item here. Hit enter to submit." )
    banksearchbar.OnEnter = function( self )
        storageitemlist:Clear()
        AS.Storage.BuildStorage( ent )
    end

    local bankweight = vgui.Create("DPanel", storagepanel)
    bankweight:SetPos( 5, storagepanel:GetTall() - 25 )
    bankweight:SetSize( storagepanel:GetWide() - 10, 20 )
    function bankweight:Paint( w, h )
        local col = COLHUD_DEFAULT:ToTable()
        surface.SetDrawColor( col[1], col[2], col[3], 150 )
        surface.DrawRect( 0, 0, (LocalPlayer():GetBankWeight() / LocalPlayer():MaxBankWeight( ent:GetNWString("ASID") )) * w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    bankweightlbl = vgui.Create("DLabel", bankweight)
    bankweightlbl:SetFont("TargetID")
    bankweightlbl:SetText( "Weight: " .. LocalPlayer():GetBankWeight() .. " / " .. LocalPlayer():MaxBankWeight( ent:GetNWString("ASID") ) )
    bankweightlbl:SetContentAlignment( 3 )
    bankweightlbl:SizeToContents()
    bankweightlbl:SetPos( weight:GetWide() / 2 - bankweightlbl:GetWide() / 2, 1 )
    function bankweightlbl:Think()
        if ent:GetNWString("ASID", "") == "" then return end
        if LocalPlayer():GetBankWeight() <= LocalPlayer():MaxBankWeight( ent:GetNWString("ASID") ) then
            bankweightlbl:SetColor( Color( 255, 255, 255 ) )
        else
            bankweightlbl:SetColor( COLHUD_BAD )
        end
    end

    AS.Storage.BuildStorage( ent )
end
net.Receive( "as_storage_open", AS.Storage.Menu )

function AS.Storage.BuildInventory( ent )
    local itemscrollpanel = vgui.Create("DScrollPanel", inventorypanel)
    itemscrollpanel:SetPos( 5, inventorysearchbar:GetTall() + 5 )
    itemscrollpanel:SetSize( inventorypanel:GetWide() - 10, inventorypanel:GetTall() - (inventorysearchbar:GetTall() + 5) - 30 )

    inventoryitemlist = vgui.Create( "DIconLayout", itemscrollpanel )
    inventoryitemlist:SetSize( itemscrollpanel:GetWide(), itemscrollpanel:GetTall() )
    inventoryitemlist:SetSpaceY( 5 )
    inventoryitemlist:SetSpaceX( 5 )

    for k, v in SortedPairs( LocalPlayer():GetInventory() ) do
        if (AS.Items[k].nostore or false) then continue end
        if not string.find( string.lower(AS.Items[k].name), inventorysearchbar:GetValue() ) and not string.find( string.lower(k), inventorysearchbar:GetValue() ) then continue end

        local info = AS.Items[k]
        local name = info.name or "name?" .. k
        local desc = info.desc or "desc?" .. k
        local weight = info.weight or "weight?" .. k

        local panel = inventoryitemlist:Add("SpawnIcon")
        local size = GetConVar("as_menu_inventory_itemiconsize"):GetInt()
        panel:SetSize( size, size )
        panel:SetModel( info.model, info.skin or 0 )
        local TTtext = v > 1 and name .. "\n" .. desc .. "\nWeight: " .. weight .. " [" .. (isnumber(weight) and weight * v or "w?") .. "]" or name .. "\n" .. desc .. "\nWeight: " .. weight
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
            if LocalPlayer():GetInventory()[k] then
                itemamt:SetText( LocalPlayer():GetInventory()[k] )
                itemamt:SizeToContents()
                itemamt:SetPos( (panel:GetWide() - itemamt:GetWide()) - 2, panel:GetTall() - itemamt:GetTall() )
                weightlbl:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
                weightlbl:SizeToContents()
                bankweightlbl:SetText( "Weight: " .. LocalPlayer():GetBankWeight() .. " / " .. LocalPlayer():MaxBankWeight( ent:GetNWString("ASID") ) )
                bankweightlbl:SizeToContents()
            else
                panel:Remove()
                weightlbl:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
                weightlbl:SizeToContents()
                bankweightlbl:SetText( "Weight: " .. LocalPlayer():GetBankWeight() .. " / " .. LocalPlayer():MaxBankWeight( ent:GetNWString("ASID") ) )
                bankweightlbl:SizeToContents()
            end
        end

        local function depositItem( item, amt )
            if not LocalPlayer():CanStoreItem( ent, k, amt ) then surface.PlaySound( UICUE.DECLINE ) return end
            LocalPlayer():DepositItem( item, amt )
            itemamtUpdate()
            surface.PlaySound(STORAGECUE.TRANSFER)

            storageitemlist:Clear()
            AS.Storage.BuildStorage( ent )

            net.Start("as_storage_tostore")
                net.WriteString( item )
                net.WriteUInt( amt, NWSetting.ItemAmtBits )
                net.WriteEntity( ent )
            net.SendToServer()
        end

        panel.DoClick = function( self )
            depositItem( k, 1 )
        end
        panel.DoRightClick = function( self )
            local options = vgui.Create("DMenu")
            if v > 1 then
                options:AddOption("Deposit 1", function()
                    depositItem( k, 1 )
                end)
                options:AddOption("Deposit X", function()
                    VerifySlider( LocalPlayer():GetInventory()[k], function( amt )
                        depositItem( k, amt )
                    end )
                end)
            end
            options:AddOption("Deposit All", function()
                depositItem( k, LocalPlayer():GetInventory()[k] )
            end)
            options:Open()
        end
    end
end

function AS.Storage.BuildStorage( ent )
    local itemscrollpanel = vgui.Create("DScrollPanel", storagepanel)
    itemscrollpanel:SetPos( 5, inventorysearchbar:GetTall() + 5 )
    itemscrollpanel:SetSize( inventorypanel:GetWide() - 10, inventorypanel:GetTall() - (inventorysearchbar:GetTall() + 5) - 30 )

    storageitemlist = vgui.Create( "DIconLayout", itemscrollpanel )
    storageitemlist:SetSize( itemscrollpanel:GetWide(), itemscrollpanel:GetTall() )
    storageitemlist:SetSpaceY( 5 )
    storageitemlist:SetSpaceX( 5 )

    for k, v in SortedPairs( LocalPlayer():GetBank() ) do
        if not string.find( string.lower(AS.Items[k].name), banksearchbar:GetValue() ) and not string.find( string.lower(k), banksearchbar:GetValue() ) then continue end

        local info = AS.Items[k]
        local name = info.name or "name?" .. k
        local desc = info.desc or "desc?" .. k
        local weight = info.weight or "weight?" .. k

        local panel = storageitemlist:Add("SpawnIcon")
        local size = GetConVar("as_menu_inventory_itemiconsize"):GetInt()
        panel:SetSize( size, size )
        panel:SetModel( info.model, info.skin or 0 )
        local TTtext = v > 1 and name .. "\n" .. desc .. "\nWeight: " .. weight .. " [" .. (isnumber(weight) and weight * v or "w?") .. "]" or name .. "\n" .. desc .. "\nWeight: " .. weight
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
            else
                panel:Remove()
                weightlbl:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
                weightlbl:SizeToContents()
                bankweightlbl:SetText( "Weight: " .. LocalPlayer():GetBankWeight() .. " / " .. LocalPlayer():MaxBankWeight( ent:GetNWString("ASID") ) )
                bankweightlbl:SizeToContents()
            end
        end

        local function withdrawItem( item, amt )
            if not LocalPlayer():CanWithdrawItem( ent, k, amt ) then surface.PlaySound( UICUE.DECLINE ) return end
            LocalPlayer():WithdrawItem( item, amt )
            itemamtUpdate()
            surface.PlaySound(STORAGECUE.TRANSFER)

            inventoryitemlist:Clear()
            AS.Storage.BuildInventory( ent )

            net.Start("as_storage_toinventory")
                net.WriteString( item )
                net.WriteUInt( amt, NWSetting.ItemAmtBits )
                net.WriteEntity( ent )
            net.SendToServer()
        end

        panel.DoClick = function( self )
            withdrawItem( k, 1 )
        end
        panel.DoRightClick = function( self )
            local options = vgui.Create("DMenu")
            if v > 1 then
                options:AddOption("Withdraw 1", function()
                    withdrawItem( k, 1 )
                end)
                options:AddOption("Withdraw X", function()
                    VerifySlider( LocalPlayer():GetBank()[k], function( amt )
                        withdrawItem( k, amt )
                    end )
                end)
            end
            options:AddOption("Withdraw All", function()
                withdrawItem( k, LocalPlayer():GetBank()[k] )
            end)
            options:Open()
        end
    end
end