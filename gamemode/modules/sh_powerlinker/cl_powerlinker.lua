function PowerlessMenu()
    ent = net.ReadEntity()
    if not IsValid(ent) then return end

    if IsValid(frame_nopower) then frame_nopower:Close() end

    frame_nopower = vgui.Create("DFrame")
    frame_nopower:SetSize(400, 190)
    frame_nopower:Center()
    frame_nopower:MakePopup()
    frame_nopower:SetDraggable( false )
    frame_nopower:SetTitle( "" )
    frame_nopower:ShowCloseButton( false )
    frame_nopower.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local closebutton = vgui.Create("DButton", frame_nopower)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_nopower:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_nopower) then
            frame_nopower:Close()
        end
    end

    local pickup = vgui.Create("DButton", frame_nopower)
    pickup:SetSize( 80, 20 )
    pickup:SetPos( 5, 3 )
    pickup:SetText("Pick Up")
    pickup:SetEnabled( false )
    pickup:SetTooltip("You are not the owner of this object.")
    if ent:PlayerCanPickUp( LocalPlayer() ) then
        pickup:SetEnabled( true )
        pickup:SetTooltip("Pickup the entity and place it in your inventory.")
    end
    pickup.DoClick = function()
        net.Start("as_tool_pickup")
            net.WriteEntity( ent )
        net.SendToServer()
        frame_nopower:Close()
    end

    local panel = vgui.Create("DPanel", frame_nopower)
    panel:SetPos( 5, 25 )
    panel:SetSize( frame_nopower:GetWide() - (panel:GetX() + 5), frame_nopower:GetTall() - (panel:GetY() + 5))
    panel.Paint = function(_, w, h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local name = vgui.Create( "DLabel", panel )
    name:SetFont( "TargetID" )
    name:SetText( "No Power!\n(Need " .. ent:GetPowerUsage() .. ")" )
    name:SetContentAlignment( 4 )
    name:SizeToContents()
    name:SetPos( panel:GetWide() / 2 - name:GetWide() / 2, panel:GetTall() / 2 - name:GetTall() / 2 )
end
net.Receive( "as_tool_nopower", PowerlessMenu )