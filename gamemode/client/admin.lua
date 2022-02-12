function ItemMenu()
    if not LocalPlayer():IsAdmin() then LocalPlayer():ChatPrint("You are not an admin!") return end
    if IsValid(frame_itemmenu) then frame_itemmenu:Close() end

    frame_itemmenu = vgui.Create("DFrame")
    frame_itemmenu:SetSize(800, 600)
    frame_itemmenu:Center()
    frame_itemmenu:MakePopup()
    frame_itemmenu:SetDraggable( false )
    frame_itemmenu:SetTitle( "Left Click an item to give a single to yourself. Right Click an item to give yourself a bulk. Middle Click to fetch item's ID." )
    frame_itemmenu:ShowCloseButton( true )

    local itemscrollpanel = vgui.Create("DScrollPanel", frame_itemmenu)
    itemscrollpanel:SetSize( frame_itemmenu:GetWide(), 0 )
    itemscrollpanel:Dock( FILL )
    itemscrollpanel:DockMargin( 0, 5, 0, 0 )
    itemscrollpanel.Paint = function(self,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local searchbar = vgui.Create( "DTextEntry", frame_itemmenu )
    searchbar:Dock( TOP )
    searchbar:DockMargin( 0, 0, 0, 0 )
    searchbar:SetSize( 0, 25 )
    searchbar:SetPlaceholderText( "Search an item here. Hit enter to submit." )
    searchbar.OnEnter = function( self )
        itemscrollpanel:Clear()
        refreshList()
    end

    function refreshList()
        local itemlist = vgui.Create("DIconLayout", itemscrollpanel)
        itemlist:SetPos( 0, 0 )
        itemlist:SetSize( itemscrollpanel:GetWide(), itemscrollpanel:GetTall() )
        itemlist:SetSpaceY( 5 )
        itemlist:SetSpaceX( 5 )

        for k, v in SortedPairs( AS.Items ) do
            if not string.find( string.lower(v.name), searchbar:GetValue() ) and not string.find( string.lower(k), searchbar:GetValue() ) then continue end

            local panel = itemlist:Add("SpawnIcon")
            panel:SetSize( 60, 60 )
            panel:SetModel( v.model )
            local name = v.name or "name?" .. k
            local desc = v.desc or "desc?" .. k
            local value = v.value or "value?" .. k
            local weight = v.weight or "weight?" .. k
            panel:SetTooltip(name .. "\n" .. desc .. "\nValue: " .. value .. "\nWeight: " .. weight)
            local function giveItem( item, amt )
                LocalPlayer():AddItemToInventory( item, amt )
                net.Start("as_admin_spawnitem")
                    net.WriteString(item)
                    net.WriteInt( amt, 32 )
                net.SendToServer()
            end
            panel.DoClick = function()
                giveItem( k, 1 )
            end
            panel.DoMiddleClick = function()
                SetClipboardText( k )
                LocalPlayer():ChatPrint( k )
            end
            panel.DoRightClick = function()
                VerifySlider( 1000, function( amt ) 
                    giveItem( k, amt )
                end )
            end
            panel.Paint = function(self,w,h)
                if v.color then
                    surface.SetDrawColor( v.color )
                else
                    surface.SetDrawColor( COLHUD_PRIMARY )
                end
                surface.DrawRect( 0, 0, w, h )
            end

            local itemname = vgui.Create("DLabel", panel)
            itemname:SetSize( panel:GetWide(), 14)
            itemname:SetPos( 1, panel:GetTall() - itemname:GetTall())
            itemname:SetText(name)
        end
    end
    refreshList()
end
concommand.Add("as_itemmenu", ItemMenu)