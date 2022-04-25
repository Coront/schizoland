Plant = Plant or {}
local ent

function Plant.Menu()
    ent = net.ReadEntity()
    if not IsValid(ent) then return end

    if IsValid(frame_plant) then frame_plant:Close() end

    frame_plant = vgui.Create("DFrame")
    frame_plant:SetSize(400, 105)
    frame_plant:Center()
    frame_plant:MakePopup()
    frame_plant:SetDraggable( false )
    frame_plant:SetTitle( "" )
    frame_plant:ShowCloseButton( false )
    frame_plant.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local closebutton = vgui.Create("DButton", frame_plant)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_plant:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_plant) then
            frame_plant:Close()
        end
    end

    local pickup = vgui.Create("DButton", frame_plant)
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
        frame_plant:Close()
    end

    local panel = vgui.Create("DPanel", frame_plant)
    panel:SetPos( 5, 25 )
    panel:SetSize( frame_plant:GetWide() - (panel:GetX() + 5), frame_plant:GetTall() - (panel:GetY() + 5))
    panel.Paint = function(_, w, h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local prunetxt = vgui.Create("DLabel", panel)
    prunetxt:SetFont( "TargetID" )
    prunetxt:SetText( "Pruning: " .. math.Round( (ent.PruneAmount / ent.PruneMax) * 100 ) .. "%" )
    prunetxt:SetPos( 5, 5 )
    prunetxt:SizeToContents()

    local pruneamount = vgui.Create("DPanel", panel)
    pruneamount:SetPos( 5, 25 )
    pruneamount:SetSize( panel:GetWide() - (pruneamount:GetX() + 5), 20 )
    pruneamount.Paint = function( _, w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawRect( 0, 0, (ent.PruneAmount / ent.PruneMax) * w, h )
    end

    local prune = vgui.Create("DButton", panel)
    prune:SetSize( 100, 20 )
    prune:SetPos( (panel:GetWide() / 2) - (prune:GetWide() / 2), panel:GetTall() - (prune:GetTall() + 5) )
    prune:SetText( "Prune" )
    prune:SetTooltip("You must be a cultivator to prune this.")
    prune:SetEnabled( false ) 
    if ent:CanPrune( LocalPlayer() ) then
        prune:SetTooltip("Prune this plant.")
        prune:SetEnabled( true )
    end
    prune.DoClick = function()
        surface.PlaySound("buttons/button15.wav")
        net.Start("as_plant_prune")
            net.WriteEntity( ent )
        net.SendToServer()
        frame_plant:Close()
    end

end
net.Receive( "as_plant_open", Plant.Menu )