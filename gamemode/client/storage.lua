AS.Storage = {}

local ent

function AS.Storage.Menu()
    ent = net.ReadEntity()

    if IsValid(frame_storage) then frame_storage:Close() end
    ent:EmitSound(STORAGECUE.OPEN)

    frame_storage = vgui.Create("DFrame")
    frame_storage:SetSize(800, 600)
    frame_storage:Center()
    frame_storage:MakePopup()
    frame_storage:SetDraggable( false )
    frame_storage:SetTitle( "" )
    frame_storage:ShowCloseButton( false )
    frame_storage.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local closebutton = vgui.Create("DButton", frame_storage)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_storage:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_storage) then
            frame_storage:Close()
            ent:EmitSound(STORAGECUE.CLOSE)
        end
    end

    local inventory = vgui.Create("DLabel", frame_storage)
    inventory:SetFont("TargetID")
    inventory:SetText( "Inventory" )
    inventory:SetContentAlignment( 3 )
    inventory:SizeToContents()
    inventory:SetPos( 8, 3 )

    inventorypanel = vgui.Create("DPanel", frame_storage)
    local x, y, space = 5, 25, 10
    inventorypanel:SetPos( x, y )
    inventorypanel:SetSize( (frame_storage:GetWide() / 2) - space, (frame_storage:GetTall() - x) - y )
    inventorypanel.Paint = function( self, w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    inventorysearchbar = vgui.Create( "DTextEntry", inventorypanel )
    inventorysearchbar:Dock( TOP )
    inventorysearchbar:DockMargin( 0, 0, 0, 0 )
    inventorysearchbar:SetSize( 0, 25 )
    inventorysearchbar:SetPlaceholderText( "Search an item here. Hit enter to submit." )
    inventorysearchbar.OnEnter = function( self )
        inventoryitemlist:Clear()
        AS.Storage.BuildInventory()
    end

    weightlbl = vgui.Create("DLabel", inventorypanel)
    weightlbl:SetFont("TargetID")
    weightlbl:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
    weightlbl:SetContentAlignment( 3 )
    weightlbl:SizeToContents()
    weightlbl:SetPos( 5, 27 )

    AS.Storage.BuildInventory()

    local storage = vgui.Create("DLabel", frame_storage)
    storage:SetFont("TargetID")
    storage:SetText( "Storage" )
    storage:SetContentAlignment( 3 )
    storage:SizeToContents()
    storage:SetPos( frame_storage:GetWide() / 2 + 5, 3 )

    storagepanel = vgui.Create("DPanel", frame_storage)
    local x, y, space = 5, 25, 10
    storagepanel:SetPos( inventorypanel:GetWide() + space, y )
    storagepanel:SetSize( (frame_storage:GetWide() / 2) - (space / 2), (frame_storage:GetTall() - x) - y )
    storagepanel.Paint = function( self, w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    banksearchbar = vgui.Create( "DTextEntry", storagepanel )
    banksearchbar:Dock( TOP )
    banksearchbar:DockMargin( 0, 0, 0, 0 )
    banksearchbar:SetSize( 0, 25 )
    banksearchbar:SetPlaceholderText( "Search an item here. Hit enter to submit." )
    banksearchbar.OnEnter = function( self )
        storageitemlist:Clear()
        AS.Storage.BuildStorage()
    end

    bankweightlbl = vgui.Create("DLabel", storagepanel)
    bankweightlbl:SetFont("TargetID")
    bankweightlbl:SetText( "Weight: " .. LocalPlayer():GetBankWeight() .. " / " .. LocalPlayer():MaxBankWeight() )
    bankweightlbl:SetContentAlignment( 3 )
    bankweightlbl:SizeToContents()
    bankweightlbl:SetPos( 5, 27 )

    AS.Storage.BuildStorage()
end
net.Receive( "as_storage_open", AS.Storage.Menu )

function AS.Storage.BuildInventory()
    local itemscrollpanel = vgui.Create("DScrollPanel", inventorypanel)
    itemscrollpanel:SetSize( inventorypanel:GetWide(), 0 )
    itemscrollpanel:Dock( FILL )
    itemscrollpanel:DockMargin( 0, 25, 0, 0 )

    inventoryitemlist = vgui.Create( "DIconLayout", itemscrollpanel )
    inventoryitemlist:SetSize( itemscrollpanel:GetWide(), itemscrollpanel:GetTall() )
    inventoryitemlist:SetSpaceY( 5 )
    inventoryitemlist:SetSpaceX( 5 )

    for k, v in SortedPairs( LocalPlayer():GetInventory() ) do
        if not string.find( string.lower(AS.Items[k].name), inventorysearchbar:GetValue() ) and not string.find( string.lower(k), inventorysearchbar:GetValue() ) then continue end

        local info = AS.Items[k]
        local name = info.name or "name?" .. k
        local desc = info.desc or "desc?" .. k
        local weight = info.weight or "weight?" .. k

        local panel = inventoryitemlist:Add("DButton")
        panel:SetSize( 58, 58 )
        panel:SetText("")
        local TTtext = v > 1 and name .. "\n" .. desc .. "\nWeight: " .. weight .. " [" .. (isnumber(weight) and weight * v or "w?") .. "]" or name .. "\n" .. desc .. "\nWeight: " .. weight
        tooltipadd = tooltipadd or ""
        panel:SetTooltip(TTtext .. tooltipadd)
        panel.Paint = function(self,w,h)
            if AS.Items[k].color then
                surface.SetDrawColor( AS.Items[k].color )
            else
                surface.SetDrawColor( COLHUD_PRIMARY )
            end
            surface.DrawRect( 0, 0, w, h )
        end

        local image = vgui.Create("DImage", panel)
        image:SetSize(panel:GetWide(), panel:GetTall())
        local model = v and "spawnicons/" .. string.Replace( AS.Items[k].model, ".mdl", ".png" ) or ""
        image:SetImage( model )

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
                weightlbl:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
                weightlbl:SizeToContents()
                bankweightlbl:SetText( "Weight: " .. LocalPlayer():GetBankWeight() .. " / " .. LocalPlayer():MaxBankWeight() )
                bankweightlbl:SizeToContents()
            else
                panel:Remove()
                weightlbl:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
                weightlbl:SizeToContents()
                bankweightlbl:SetText( "Weight: " .. LocalPlayer():GetBankWeight() .. " / " .. LocalPlayer():MaxBankWeight() )
                bankweightlbl:SizeToContents()
            end
        end

        local function depositItem( item, amt )
            LocalPlayer():DepositItem( item, amt )
            itemamtUpdate()
            surface.PlaySound(STORAGECUE.TRANSFER)

            storageitemlist:Clear()
            AS.Storage.BuildStorage()

            net.Start("as_storage_tostore")
                net.WriteString( item )
                net.WriteInt( amt, 32 )
                net.WriteEntity( ent )
            net.SendToServer()
        end

        panel.DoClick = function( self )
            if not LocalPlayer():CanStoreItem( k, v ) then surface.PlaySound( UICUE.DECLINE ) return end
            depositItem( k, v )
        end
        panel.DoRightClick = function( self )
            local options = vgui.Create("DMenu")
            if v > 1 then
                options:AddOption("Deposit 1", function()
                    depositItem( k, 1 )
                end)
                options:AddOption("Deposit X", function()
                    VerifySlider( v, function( amt )
                        if not LocalPlayer():CanStoreItem( k, amt ) then surface.PlaySound( UICUE.DECLINE ) return end
                        depositItem( k, amt )
                    end )
                end)
            end
            options:AddOption("Deposit All", function()
                depositItem( k, v )
            end)
            options:Open()
        end
    end
end

function AS.Storage.BuildStorage()
    local itemscrollpanel = vgui.Create("DScrollPanel", storagepanel)
    itemscrollpanel:SetSize( storagepanel:GetWide(), 0 )
    itemscrollpanel:Dock( FILL )
    itemscrollpanel:DockMargin( 0, 25, 0, 0 )

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

        local panel = storageitemlist:Add("DButton")
        panel:SetSize( 58, 58 )
        panel:SetText("")
        local TTtext = v > 1 and name .. "\n" .. desc .. "\nWeight: " .. weight .. " [" .. (isnumber(weight) and weight * v or "w?") .. "]" or name .. "\n" .. desc .. "\nWeight: " .. weight
        tooltipadd = tooltipadd or ""
        panel:SetTooltip(TTtext .. tooltipadd)
        panel.Paint = function(self,w,h)
            if AS.Items[k].color then
                surface.SetDrawColor( AS.Items[k].color )
            else
                surface.SetDrawColor( COLHUD_PRIMARY )
            end
            surface.DrawRect( 0, 0, w, h )
        end

        local image = vgui.Create("DImage", panel)
        image:SetSize(panel:GetWide(), panel:GetTall())
        local model = v and "spawnicons/" .. string.Replace( AS.Items[k].model, ".mdl", ".png" ) or ""
        image:SetImage( model )

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
                weightlbl:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
                weightlbl:SizeToContents()
                bankweightlbl:SetText( "Weight: " .. LocalPlayer():GetBankWeight() .. " / " .. LocalPlayer():MaxBankWeight() )
                bankweightlbl:SizeToContents()
            else
                panel:Remove()
                weightlbl:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
                weightlbl:SizeToContents()
                bankweightlbl:SetText( "Weight: " .. LocalPlayer():GetBankWeight() .. " / " .. LocalPlayer():MaxBankWeight() )
                bankweightlbl:SizeToContents()
            end
        end

        local function withdrawItem( item, amt )
            LocalPlayer():WithdrawItem( item, amt )
            itemamtUpdate()
            surface.PlaySound(STORAGECUE.TRANSFER)

            inventoryitemlist:Clear()
            AS.Storage.BuildInventory()

            net.Start("as_storage_toinventory")
                net.WriteString( item )
                net.WriteInt( amt, 32 )
                net.WriteEntity( ent )
            net.SendToServer()
        end

        panel.DoClick = function( self )
            if not LocalPlayer():CanWithdrawItem( k, v ) then surface.PlaySound( UICUE.DECLINE ) return end
            withdrawItem( k, v )
        end
        panel.DoRightClick = function( self )
            local options = vgui.Create("DMenu")
            if v > 1 then
                options:AddOption("Withdraw 1", function()
                    withdrawItem( k, 1 )
                end)
                options:AddOption("Withdraw X", function()
                    VerifySlider( v, function( amt )
                        if not LocalPlayer():CanWithdrawItem( k, amt ) then surface.PlaySound( UICUE.DECLINE ) return end
                        withdrawItem( k, amt )
                    end )
                end)
            end
            options:AddOption("Withdraw All", function()
                withdrawItem( k, v )
            end)
            options:Open()
        end
    end
end