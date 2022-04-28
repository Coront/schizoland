Miner = Miner or {}
local ent

function Miner.Menu()
    ent = net.ReadEntity()
    if not IsValid(ent) then return end

    if IsValid(frame_miner) then frame_miner:Close() end

    frame_miner = vgui.Create("DFrame")
    frame_miner:SetSize(400, 190)
    frame_miner:Center()
    frame_miner:MakePopup()
    frame_miner:SetDraggable( false )
    frame_miner:SetTitle( "" )
    frame_miner:ShowCloseButton( false )
    frame_miner.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local closebutton = vgui.Create("DButton", frame_miner)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_miner:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_miner) then
            frame_miner:Close()
        end
    end

    local pickup = vgui.Create("DButton", frame_miner)
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
        frame_miner:Close()
    end

    local panel = vgui.Create("DPanel", frame_miner)
    panel:SetPos( 5, 25 )
    panel:SetSize( frame_miner:GetWide() - (panel:GetX() + 5), frame_miner:GetTall() - (panel:GetY() + 5))
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

    local toggled = vgui.Create( "DLabel", panel )
    toggled:SetFont( "TargetID" )
    local str = ent:GetActiveState() and "True" or "False"
    toggled:SetText( "Running: " .. str )
    local col = ent:GetActiveState() and COLHUD_GOOD or COLHUD_BAD
    toggled:SetColor( col )
    toggled:SetContentAlignment( 4 )
    toggled:SizeToContents()
    toggled:SetPos( 75, 25 )

    local togglebtn = vgui.Create("DButton", panel)
    togglebtn:SetSize( 90, 20 )
    togglebtn:SetPos( panel:GetWide() - (togglebtn:GetWide() + 5), 5 )
    togglebtn:SetText("Toggle Power")
    if ent:GetActiveState() and ent:GetObjectOwner() != LocalPlayer() then
        togglebtn:SetEnabled( false )
        togglebtn:SetTooltip( "You cannot turn this off unless you're the owner." )
    end
    if ent:Health() <= 0 then
        togglebtn:SetEnabled( false )
        togglebtn:SetTooltip( "This miner is too damaged to function." )
    end
    if not ent:CanMine() then
        togglebtn:SetEnabled( false )
        togglebtn:SetTooltip( "The miner is unable to start." )
    end
    if LocalPlayer():GetASClass() != "scavenger" then
        togglebtn:SetEnabled( false )
        togglebtn:SetTooltip( "You must be a scavenger to manage this miner." )
    end
    togglebtn.DoClick = function()
        ent:TogglePower()
        net.Start( "as_miner_togglepower" )
            net.WriteEntity( ent )
        net.SendToServer()
        frame_miner:Close()
    end

    local takeitems = vgui.Create("DButton", panel)
    takeitems:SetSize( 150, 20 )
    takeitems:SetPos( 5, panel:GetTall() - ( takeitems:GetTall() + 5 ) )
    takeitems:SetText("Take Items")
    takeitems.DoClick = function()
        net.Start( "as_miner_takeitems" )
            net.WriteEntity( ent )
        net.SendToServer()
        frame_miner:Close()
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

    local repair = vgui.Create("DButton", panel)
    repair:SetSize( 160, 20 )
    repair:SetPos( panel:GetWide() - ( repair:GetWide() + 5 ), panel:GetTall() - ( repair:GetTall() + 5 ) )
    repair:SetText("Repair")
    repair.DoClick = function()
        net.Start( "as_miner_repair" )
            net.WriteEntity( ent )
        net.SendToServer()
        frame_miner:Close()
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

    healthpanel:SetPos( panel:GetWide() - ( healthpanel:GetWide() + 5 ), panel:GetTall() - ( healthpanel:GetTall() + repair:GetTall() + 5 ) )
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
net.Receive( "as_miner_open", Miner.Menu )