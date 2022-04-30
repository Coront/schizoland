Grub = Grub or {}
local ent

function Grub.Menu()
    ent = net.ReadEntity()
    if not IsValid(ent) then return end

    if IsValid(frame_grub) then frame_grub:Close() end

    frame_grub = vgui.Create("DFrame")
    frame_grub:SetSize(400, 190)
    frame_grub:Center()
    frame_grub:MakePopup()
    frame_grub:SetDraggable( false )
    frame_grub:SetTitle( "" )
    frame_grub:ShowCloseButton( false )
    frame_grub.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local closebutton = vgui.Create("DButton", frame_grub)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_grub:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_grub) then
            frame_grub:Close()
        end
    end

    local pickup = vgui.Create("DButton", frame_grub)
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
        frame_grub:Close()
    end

    local panel = vgui.Create("DPanel", frame_grub)
    panel:SetPos( 5, 25 )
    panel:SetSize( frame_grub:GetWide() - (panel:GetX() + 5), frame_grub:GetTall() - (panel:GetY() + 5))
    panel.Paint = function(_, w, h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local icon = vgui.Create( "SpawnIcon", panel )
    icon:SetSize( 64, 64 )
    icon:SetPos( 5, 5 )
    icon:SetModel( ent:GetModel() )
    icon:SetTooltip( "" )

    local name = vgui.Create( "DLabel", panel )
    name:SetFont( "TargetID" )
    name:SetText( ent.PrintName )
    name:SetContentAlignment( 4 )
    name:SizeToContents()
    name:SetPos( 75, 5 )

    local takeitems = vgui.Create("DButton", panel)
    takeitems:SetSize( 150, 20 )
    takeitems:SetPos( 5, panel:GetTall() - ( takeitems:GetTall() + 5 ) )
    takeitems:SetText("Take Items")
    takeitems.DoClick = function()
        net.Start( "as_grub_takeitems" )
            net.WriteEntity( ent )
        net.SendToServer()
        frame_grub:Close()
    end

    local resources = vgui.Create("DListView", panel)
    resources:SetSize( 150, 60 )
    resources:SetPos( 5, panel:GetTall() - (resources:GetTall() + takeitems:GetTall() + 5) )
    resources:SetMultiSelect( false )
    resources:AddColumn( "Item" )
    resources:AddColumn( "Amount" )

    for k, v in pairs( ent:GetInventory() ) do
        resources:AddLine( AS.Items[k].name, v )
    end

    local hp = ent:Health()
    local maxhp = ent.MaxHealth

    local healthpanel = vgui.Create("DPanel", panel)
    healthpanel:SetSize( 160, 20 )

    local health = vgui.Create( "DLabel", healthpanel )
    health:SetFont( "TargetID" )
    health:SetText( hp .. " / " .. maxhp )
    health:SetContentAlignment( 6 )
    health:SizeToContents()
    health:SetPos( (healthpanel:GetWide() / 2) - (health:GetWide() / 2), 0 )
    health:Hide()

    healthpanel:SetPos( panel:GetWide() - ( healthpanel:GetWide() + 5 ), panel:GetTall() - ( healthpanel:GetTall() + 5 ) )
    healthpanel.Paint = function(_, w, h)
        surface.SetDrawColor( COLHUD_BAD )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_GOOD )
        surface.DrawRect( 0, 0, ( hp / maxhp ) * w, h )
    end
    healthpanel.Think = function( self )
        if self:IsHovered() then
            health:Show()
        else
            health:Hide()
        end
    end

end
net.Receive( "as_grub_open", Grub.Menu )