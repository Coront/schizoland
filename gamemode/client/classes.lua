AS.Class = {} --Not to be confused with AS.Class'es', im dumb lol

function AS.Class.Open()
    if not LocalPlayer():IsLoaded() then return end
    if not LocalPlayer():Alive() then return end
    if IsValid(frame_class) then frame_class:Close() end

    frame_class = vgui.Create("DFrame")
    frame_class:SetSize(700, 465)
    frame_class:Center()
    frame_class:MakePopup()
    frame_class:SetDraggable( false )
    frame_class:SetTitle( "Class Menu" )
    frame_class:ShowCloseButton( false )
    frame_class.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local scroll_classes = vgui.Create("DScrollPanel", frame_class)
    local xpos, ypos = 5, 25
    scroll_classes:SetPos( xpos, ypos )
    scroll_classes:SetSize( scroll_classes:GetParent():GetWide() - (xpos * 2), 435 )
    scroll_classes.Paint = function( self, w, h ) 
        draw.RoundedBox( 0, 0, 0, w, h, COLHUD_SECONDARY )
    end

    local itemlist = vgui.Create("DIconLayout", scroll_classes)
    itemlist:SetPos( 5, 5 )
    itemlist:SetSize(scroll_classes:GetWide() - 10, scroll_classes:GetTall())
    itemlist:SetSpaceY( 5 )
    itemlist:SetSpaceX( 5 )

    local closebutton = vgui.Create("DButton", frame_class)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_class:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_class) then
            frame_class:Close()
        end
    end

    local disclaimer = itemlist:Add("DLabel")
    disclaimer:SetFont("TargetIDSmall")
    disclaimer:SetColor( COLHUD_GOOD )
    local disclaimertext = "Class Changing is ENABLED."
    if not tobool(GetConVar("as_classchange"):GetInt()) then
        disclaimer:SetColor( COLHUD_BAD )
        disclaimertext = "Class Changing is DISABLED."
    end
    disclaimer:SetText( disclaimertext )
    disclaimer:SetContentAlignment(4)
    disclaimer:SetSize( 600, 15 )

    local disclaimer2 = itemlist:Add("DLabel")
    disclaimer2:SetFont("TargetIDSmall")
    local disclaimertext2 = "Class Change Cost is OFF."
    if tobool(GetConVar("as_classchangecost"):GetInt()) then
        disclaimertext2 = "Class Change Cost is ON. You will have to pay:\n"
        for k, v in pairs( SET.ClassChangeCostTbl ) do
            disclaimertext2 = disclaimertext2 .. v .. " " .. AS.Items[k].name .. ", "
        end
    end
    disclaimer2:SetText( disclaimertext2 )
    disclaimer2:SetContentAlignment(4)
    disclaimer2:SizeToContents()

    AS.Class.BuildList( itemlist )
end

function AS.Class.BuildList( parent )
    for k, v in pairs( AS.Classes ) do
        local panel = parent:Add("DPanel")
        panel:SetSize( parent:GetWide(), 70 )
        function panel:Paint(w, h)
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        local icon = vgui.Create("SpawnIcon", panel)
        icon:SetSize( 60, 60 )
        icon:SetPos( 5, panel:GetTall() / 2 - icon:GetTall() / 2 )
        icon:SetModel( v.icon )
        icon:SetTooltip( "" )

        local name = vgui.Create("DLabel", panel)
        name:SetFont("TargetIDSmall")
        name:SetColor( v.color )
        name:SetText( v.name )
        name:SetContentAlignment(4)
        name:SizeToContents()
        name:SetPos( 70, 0 )

        local scroll_desc = vgui.Create("DScrollPanel", panel)
        scroll_desc:SetSize( 500, 50 )
        scroll_desc:SetPos( 85, 15 )

        local desc = vgui.Create("DLabel", scroll_desc)
        desc:SetText( v.desc )
        desc:SetSize( scroll_desc:GetWide() - 15, scroll_desc:GetTall() )
        desc:SetWrap( true )
        desc:SetAutoStretchVertical( true )

        local change = vgui.Create("DButton", panel)
        change:SetSize( 85, 17 )
        change:SetPos( panel:GetWide() - (change:GetWide() + 5), panel:GetTall() - (change:GetTall() + 5) )
        if LocalPlayer():GetASClass() == k then
            change:SetText("Current Class")
        else
            change:SetText( "Become" )
        end
        if not LocalPlayer():CanChangeClass( k ) then
            change:SetEnabled( false )
        end
        function change:DoClick()
            frame_class:Close()
            RunConsoleCommand( "as_changeclass", k )
        end
    end
end