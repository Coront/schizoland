CreateClientConVar( "as_container_sounds", "1", true, false )

function ContainerMenu( ent )
    if IsValid(frame_container) then frame_container:Close() end
    if tobool(GetConVar("as_container_sounds"):GetInt()) and AS.Loot[ent:GetContainer()] and AS.Loot[ent:GetContainer()].opensound then
        ent:EmitSound(AS.Loot[ent:GetContainer()].opensound)
    end

    frame_container = vgui.Create("DFrame")
    frame_container:SetPos( ScrW() * 0.51, ScrH() * 0.515 )
    frame_container:SetSize(300, 200)
    frame_container:SetDraggable( false )
    frame_container:SetTitle( "" )
    frame_container:ShowCloseButton( false )
    frame_container.ent = ent
    function frame_container:Paint( w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end
    function frame_container:OnClose()
        if tobool(GetConVar("as_container_sounds"):GetInt()) and IsValid( frame_container.ent ) and AS.Loot[ent:GetContainer()] and AS.Loot[ent:GetContainer()].closesound then
            ent:EmitSound(AS.Loot[ent:GetContainer()].closesound)
        end
    end
    frame_container.selectedItem = nil

    local scroll_items = vgui.Create("DScrollPanel", frame_container)
    scroll_items:SetPos( 5, 5 )
    scroll_items:SetSize( frame_container:GetWide() - (scroll_items:GetX() * 2), frame_container:GetTall() - (scroll_items:GetY() * 4.5) )
    scroll_items.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)
    end

    local itemlist = vgui.Create("DIconLayout", scroll_items)
    itemlist:SetPos( 0, 0 )
    itemlist:SetSize( scroll_items:GetWide(), scroll_items:GetTall())
    itemlist:SetSpaceY( 2 )
    itemlist:SetSpaceX( 5 )

    local buttonshelp = vgui.Create("DLabel", frame_container)
    buttonshelp:SetFont("TargetID")
    buttonshelp:SetText( "[" .. string.upper(KEYBIND_USE) .. "] Quick Take Item    [" .. string.upper( input.LookupBinding( "+reload" ) ) .. "] Mouse" )
    buttonshelp:SetContentAlignment( 3 )
    buttonshelp:SizeToContents()
    buttonshelp:SetPos( frame_container:GetWide() / 2 - (buttonshelp:GetWide() / 2), frame_container:GetTall() - buttonshelp:GetTall() - 1 )

    panel = {}
    for k, v in SortedPairs( ent:GetInventory() ) do
        local info = AS.Items[k]
        if not frame_container.selectedItem then frame_container.selectedItem = {ID = k, amt = v} end

        panel[k] = itemlist:Add("DPanel")
        panel[k]:SetSize( itemlist:GetWide(), 50 )
        panel[k].Paint = function(self,w,h)
            if frame_container.selectedItem.ID == k then
                surface.SetDrawColor( COLHUD_GOOD )
            else
                surface.SetDrawColor( COLHUD_PRIMARY )
            end
            surface.DrawRect( 0, 0, w, h )
        end

        local icon = vgui.Create("SpawnIcon", panel[k])
        icon:SetSize( panel[k]:GetTall(), panel[k]:GetTall() )

        local name = vgui.Create("DLabel", panel[k])
        name:SetFont("TargetID")
        name:SetText( info.name .. " (" .. v .. "x)" )
        name:SetContentAlignment( 3 )
        name:SizeToContents()
        name:SetPos( icon:GetWide() + 5, 0 )
        function frame_container.containeritemamtUpdate( key )
            if frame_container.ent:GetInventory()[key] then
                if IsValid( name ) then
                    name:SetText( info.name .. " (" .. frame_container.ent:GetInventory()[k] .. "x)" )
                    name:SizeToContents()
                end
            else
                if IsValid( panel[key] ) then
                    panel[key]:Remove()
                    noitem = true
                    for k, v in SortedPairs( frame_container.ent:GetInventory() ) do
                        frame_container.selectedItem = {ID = k, amt = v}
                        noitem = false
                        break
                    end
                    if noitem then
                        frame_container.selectedItem = nil
                    end
                end
            end
        end

        icon:SetModel( AS.Items[k].model )
        icon:SetTooltip( "Left Click to take all.\nRight Click to take amount." )
        icon.DoClick = function( self )
            if frame_container.ent:PlayerCanTakeItem( LocalPlayer(), k, frame_container.ent:GetInventory()[k] ) then
                local amt = frame_container.ent:GetInventory()[k]
                frame_container.ent:PlayerTakeItem( LocalPlayer(), k, frame_container.ent:GetInventory()[k] )
                surface.PlaySound( ITEMCUE.TAKE )
                frame_container.containeritemamtUpdate( k )

                net.Start("as_container_takeitem")
                    net.WriteEntity( frame_container.ent )
                    net.WriteString( k )
                    net.WriteInt( amt, 32 )
                net.SendToServer()
            end
        end
        icon.DoRightClick = function( self )
            VerifySlider( 1000, function( amt ) 
                giveItem( k, amt )
            end )
        end

    end
end