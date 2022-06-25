local function ReadPaper( ent)
    if IsValid(frame_paper) then frame_paper:Close() end

    frame_paper = vgui.Create("DFrame")
    frame_paper:SetSize(500, 550)
    frame_paper:Center()
    frame_paper:MakePopup()
    frame_paper:SetDraggable( false )
    frame_paper:SetTitle( "" )
    frame_paper:ShowCloseButton( false )
    function frame_paper:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetMaterial( Material("gui/aftershock/default.png") )
        surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
        surface.DrawTexturedRect( 0, 0, w, h )
    end

    local cbuttonsize = 16
    local closebutton = CreateCloseButton( frame_paper, cbuttonsize, frame_paper:GetWide() - cbuttonsize - 3, 4 )

    local panel = vgui.Create("DPanel", frame_paper)
    local x, y, space = 26, 23, 56
    panel:SetPos( x, y )
    panel:SetSize( frame_paper:GetWide() - space, (frame_paper:GetTall() - x) - y - 6 )
    function panel:Paint( w, h ) end

    local title = vgui.Create("DLabel", panel)
    title:SetText( ent:GetTitle() )
    title:SetPos( 5, 5 )
    title:SetFont( "DermaDefaultBold" )
    title:SizeToContents()

    local scroll = vgui.Create("DScrollPanel", panel)
    scroll:SetPos( 5, 25 )
    scroll:SetSize( panel:GetWide() - 10, panel:GetTall() - 30 )

    local desc = vgui.Create("DLabel", scroll)
    desc:SetText( ent:GetParagraph() )
    desc:SetSize( scroll:GetWide() - 15, scroll:GetTall() )
    desc:SetWrap( true )
    desc:SetAutoStretchVertical( true )
end

net.Receive( "as_paper_open", function()
    local ent = net.ReadEntity()
    if not IsValid(ent) then return end

    if IsValid(frame_paper) then frame_paper:Close() end

    frame_paper = vgui.Create("DFrame")
    frame_paper:SetSize(500, 550)
    frame_paper:Center()
    frame_paper:MakePopup()
    frame_paper:SetDraggable( false )
    frame_paper:SetTitle( "" )
    frame_paper:ShowCloseButton( false )
    function frame_paper:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetMaterial( Material("gui/aftershock/default.png") )
        surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
        surface.DrawTexturedRect( 0, 0, w, h )
    end

    local cbuttonsize = 16
    local closebutton = CreateCloseButton( frame_paper, cbuttonsize, frame_paper:GetWide() - cbuttonsize - 3, 4 )

    local pickup = vgui.Create("DButton", frame_paper)
    pickup:SetSize( 70, 19 )
    pickup:SetPos( 2, 1 )
    pickup:SetText("Pick Up")
    pickup:SetEnabled( false )
    pickup:SetTooltip("You are not the owner of this object.")
    if ent:PlayerCanPickUp( LocalPlayer() ) then
        pickup:SetEnabled( true )
        pickup:SetTooltip("Pickup the object and place it in your inventory.")
    end
    function pickup:DoClick()
        net.Start("as_tool_pickup")
            net.WriteEntity( ent )
        net.SendToServer()
        frame_paper:Close()
    end

    local panel = vgui.Create("DPanel", frame_paper)
    local x, y, space = 26, 23, 56
    panel:SetPos( x, y )
    panel:SetSize( frame_paper:GetWide() - space, (frame_paper:GetTall() - x) - y - 6 )
    function panel:Paint( w, h ) end

    local curtitle = ent:GetTitle()
    local curtext = ent:GetParagraph()

    local title = vgui.Create("DTextEntry", panel)
    title:SetPos( 5, 5 )
    title:SetSize( panel:GetWide() - 10, 16 )
    title:SetPlaceholderText("Title")
    title:SetText( curtitle )

    local text = vgui.Create("DTextEntry", panel)
    text:SetPos( 5, 25 )
    text:SetSize( panel:GetWide() - 10, panel:GetTall() - 55 )
    text:SetPlaceholderText("Text (" .. ent.CharacterLimit .. " Max Characters)")
    text:SetText( curtext )
    text:SetMultiline( true )

    local update = vgui.Create("DButton", panel)
    update:SetSize( 217, 20 )
    update:SetPos( 5, panel:GetTall() - 25 )
    update:SetText("Update Text")
    function update:DoClick()
        net.Start("as_paper_modify")
            net.WriteEntity( ent )
            net.WriteString( title:GetText() )
            net.WriteString( text:GetText() )
        net.SendToServer()
    end

    local read = vgui.Create("DButton", panel)
    read:SetSize( update:GetWide(), update:GetTall() )
    read:SetPos( update:GetX() + update:GetWide(), panel:GetTall() - 25 )
    read:SetText("Read Paper")
    function read:DoClick()
        frame_paper:Close()
        ReadPaper( ent )
    end
end)

net.Receive( "as_paper_read", function()
    local ent = net.ReadEntity()
    ReadPaper( ent )
end)