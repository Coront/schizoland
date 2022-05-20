net.Receive("as_ammobox_open", function()
    local ent = net.ReadEntity()

    if IsValid(frame_ammobox) then frame_ammobox:Close() end

    frame_ammobox = vgui.Create("DFrame")
    frame_ammobox:SetSize(550, 500)
    frame_ammobox:Center()
    frame_ammobox:MakePopup()
    frame_ammobox:SetDraggable( false )
    frame_ammobox:SetTitle( "" )
    frame_ammobox:ShowCloseButton( false )
    function frame_ammobox:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetMaterial( Material("gui/aftershock/default.png") )
        surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
        surface.DrawTexturedRect( 0, 0, w, h )
    end

    local cbuttonsize = 15
    local closebutton = CreateCloseButton( frame_ammobox, cbuttonsize, frame_ammobox:GetWide() - cbuttonsize - 5, 3 )

    local panel = vgui.Create("DPanel", frame_ammobox)
    local x, y, space = 30, 20, 64
    panel:SetPos( x, y )
    panel:SetSize( frame_ammobox:GetWide() - space, (frame_ammobox:GetTall() - x) - y )
    function panel:Paint( w, h ) end

    local scroll = vgui.Create("DScrollPanel", panel)
    scroll:SetSize( panel:GetWide(), panel:GetTall() )

    itemlist = vgui.Create( "DIconLayout", scroll )
    itemlist:SetSize( scroll:GetWide(), scroll:GetTall() )
    itemlist:SetSpaceY( 2 )
    itemlist:SetSpaceX( 0 )

    for k, v in SortedPairsByValue( ent.Items ) do
        if not AS.Items[k] then continue end --Item doesnt exist
        local id = AS.Items[k]

        local item = itemlist:Add("DPanel")
        item:SetSize(itemlist:GetWide() - 15, 90)
        function item:Paint(w, h)
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        local itemname = id.name or k .. "?name"
        local itemdesc = id.desc or k .. "?desc"

        local icon = vgui.Create( "SpawnIcon", item )
        icon:SetSize( 75, 75 )
        local ypos = item:GetTall() / 2 - icon:GetTall() / 2
        icon:SetPos( 5, ypos )
        icon:SetModel( id.model, id.skin or 0 )
        icon:SetTooltip( itemname .. "\n\nClick to take." )
        function icon:DoClick()
            frame_ammobox:Close()
            net.Start("as_ammobox_take")
                net.WriteEntity( ent )
                net.WriteString( k )
            net.SendToServer()
        end

        local name = vgui.Create("DLabel", item)
        name:SetFont("TargetIDSmall")
        name:SetText( itemname )
        name:SetContentAlignment(4)
        name:SizeToContents()
        name:SetPos( 85, 10 )

        local scroll_desc = vgui.Create("DScrollPanel", item)
        scroll_desc:SetSize( 320, 60 )
        scroll_desc:SetPos( 100, 25 )

        local desc = vgui.Create("DLabel", scroll_desc)
        desc:SetText( itemdesc )
        desc:SetSize( scroll_desc:GetWide() - 15, scroll_desc:GetTall() )
        desc:SetWrap( true )
        desc:SetAutoStretchVertical( true )
    end
end)