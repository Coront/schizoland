CreateClientConVar( "as_container_sounds", "1", true, false )

function ContainerMenu( ent )
    if IsValid(frame_container) then frame_container:Close() end
    if tobool(GetConVar("as_container_sounds"):GetInt()) then
        ent:EmitSound(AS.Loot[ent:GetContainer()].opensound)
    end

    frame_container = vgui.Create("DFrame")
    frame_container:SetPos( ScrW() * 0.51, ScrH() * 0.515 )
    frame_container:SetSize(300, 200)
    frame_container:SetDraggable( false )
    frame_container:SetTitle( "" )
    frame_container:ShowCloseButton( false )
    frame_container.ent = ent
    frame_container.Paint = function( _, w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end
    function frame_container:OnClose()
        if tobool(GetConVar("as_container_sounds"):GetInt()) then
            ent:EmitSound(AS.Loot[ent:GetContainer()].closesound)
        end
    end
    function frame_container:OnKeyCodePressed( key ) 
        LocalPlayer():ChatPrint( key )
    end

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
    buttonshelp:SetText( "[" .. string.upper(KEYBIND_USE) .. "] Take Item" )
    buttonshelp:SetContentAlignment( 3 )
    buttonshelp:SizeToContents()
    buttonshelp:SetPos( frame_container:GetWide() / 2 - (buttonshelp:GetWide() / 2), frame_container:GetTall() - buttonshelp:GetTall() )

    for k, v in SortedPairs( ent:GetInventory() ) do
        local info = AS.Items[k]

        local panel = itemlist:Add("DPanel")
        panel:SetSize( itemlist:GetWide(), 50 )
        panel.Paint = function(self,w,h)
            if info.color then
                surface.SetDrawColor( info.color )
            else
                surface.SetDrawColor( COLHUD_PRIMARY )
            end
            surface.DrawRect( 0, 0, w, h )
        end

        local icon = vgui.Create("SpawnIcon", panel)
        icon:SetSize( panel:GetTall(), panel:GetTall() )

        local name = vgui.Create("DLabel", panel)
        name:SetFont("TargetID")
        name:SetText( info.name .. " (" .. v .. "x)" )
        name:SetContentAlignment( 3 )
        name:SizeToContents()
        name:SetPos( icon:GetWide() + 5, 0 )

        icon:SetModel( AS.Items[k].model )
    end
end