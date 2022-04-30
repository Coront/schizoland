Vendor = Vendor or {}
local ent

function Vendor.Menu()
    ent = net.ReadEntity()
    if not IsValid(ent) then return end
    local profiles = net.ReadTable()

    if IsValid(frame_vendor) then frame_vendor:Close() end

    frame_vendor = vgui.Create("DFrame")
    frame_vendor:SetSize(700, 500)
    frame_vendor:Center()
    frame_vendor:MakePopup()
    frame_vendor:SetDraggable( false )
    frame_vendor:SetTitle( "" )
    frame_vendor:ShowCloseButton( false )
    frame_vendor.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local closebutton = vgui.Create("DButton", frame_vendor)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_vendor:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_vendor) then
            frame_vendor:Close()
        end
    end

    local pickup = vgui.Create("DButton", frame_vendor)
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
        frame_vendor:Close()
    end

    local panel = vgui.Create("DPanel", frame_vendor)
    local x, y, space = 3, 25, 6
    panel:SetPos( x, y )
    panel:SetSize( frame_vendor:GetWide() - space, (frame_vendor:GetTall() - x) - y )
    panel.Paint = function( self, w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    if #profiles <= 0 then
        Vendor.NewProfile( panel )
    else
        Vendor.SelectProfile( panel, profiles )
    end
end

function Vendor.NewProfile( parent )
    local title = SimpleLabel( parent, "Create a new profile", 0, 0 )
    title:SetPos( (parent:GetWide() / 2) - (title:GetWide() / 2), 150 )

    local spawnicon = SimpleSpawnIcon( parent, "models/props_c17/consolebox01a.mdl", 64, 180, 180, "" )

    local name = SimpleTextEntry( parent, "Enter your profile's name", 250, 20, spawnicon:GetX() + spawnicon:GetWide() + 5, spawnicon:GetY() + ((spawnicon:GetTall() / 2) - 10) )

    local create = SimpleButton( parent, "Finish Profile", 100, 20, 0, 0, function()
        frame_vendor:Close()
        net.Start("as_vendor_createprofile")
            net.WriteEntity( ent )
            net.WriteString( name:GetText() )
        net.SendToServer()
    end)
    create:SetPos( (spawnicon:GetX() + spawnicon:GetWide() + 5 + name:GetWide()) / 2 + (create:GetWide() / 2), spawnicon:GetY() + spawnicon:GetTall() + 5 )
end

function Vendor.SelectProfile( parent, profiles )
    local title = SimpleLabel( parent, "Select a profile", 5, 5, "TargetID" )

    local profilescroll = SimpleScroll( parent, parent:GetWide() - 10, parent:GetTall() - 30, 5, 25, Color( 0, 0, 0, 0 ) )

    local x, y = 0, 0
    for k, v in pairs( profiles ) do
        local panel = SimplePanel( profilescroll, profilescroll:GetWide() - 20, 80, x, y, COLHUD_PRIMARY )
        local icon = SimpleSpawnIcon( panel, "models/props_c17/consolebox01a.mdl", panel:GetTall() - 6, 3, 3, "" )

        local name = SimpleLabel( panel, v.name, icon:GetWide() + 5, icon:GetY(), "TargetIDSmall" )

        local selectprof = SimpleButton( panel, "Load Profile", 100, 20, 0, 0, function()
            frame_vendor:Close()
            net.Start("as_vendor_setprofile")
                net.WriteEntity( ent )
                net.WriteInt( v.vid, 32 )
            net.SendToServer()
        end)
        selectprof:SetPos( panel:GetWide() - (selectprof:GetWide() + 5), panel:GetTall() - ( selectprof:GetTall() + 5 ) )

        y = y + panel:GetTall() + 3
    end
end

function Vendor.BuildShop( profile )

end

net.Receive( "as_vendor_open", Vendor.Menu )