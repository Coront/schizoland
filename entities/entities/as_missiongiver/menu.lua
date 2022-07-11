net.Receive( "as_missiongiver_open", function()
    local ent = net.ReadEntity()
    if not IsValid( ent ) then return end

    if IsValid(frame_missiongiver) then frame_missiongiver:Close() end

    frame_missiongiver = vgui.Create("DFrame")
    frame_missiongiver:SetSize(800, 700)
    frame_missiongiver:Center()
    frame_missiongiver:MakePopup()
    frame_missiongiver:SetDraggable( false )
    frame_missiongiver:SetTitle( "" )
    frame_missiongiver:ShowCloseButton( false )
    function frame_missiongiver:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetMaterial( Material("gui/aftershock/default.png") )
        surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
        surface.DrawTexturedRect( 0, 0, w, h )
    end

    local cbuttonsize = 18
    local closebutton = CreateCloseButton( frame_missiongiver, cbuttonsize, frame_missiongiver:GetWide() - cbuttonsize - 5, 3 )

    local panel = vgui.Create("DPanel", frame_missiongiver)
    local x, y, space = 43, 29, 92
    panel:SetPos( x, y )
    panel:SetSize( frame_missiongiver:GetWide() - space, (frame_missiongiver:GetTall() - 40) - y - 1 )
    function panel:Paint( w, h ) end

    local giverdata = AS.Missions[ent.GiverID]

    local name = vgui.Create("DLabel", panel)
    name:SetFont("DermaLarge")
    name:SetText( giverdata.name )
    name:SetContentAlignment(4)
    name:SizeToContents()
    name:SetPos( 5, 5 )

    local scroll_desc = vgui.Create("DScrollPanel", panel)
    scroll_desc:SetSize( panel:GetWide() - 10, 60 )
    scroll_desc:SetPos( 5, 35 )

    local desc = vgui.Create("DLabel", scroll_desc)
    desc:SetText( giverdata.desc )
    desc:SetSize( scroll_desc:GetWide() - 15, scroll_desc:GetTall() )
    desc:SetWrap( true )
    desc:SetAutoStretchVertical( true )

    local scroll_missions = vgui.Create("DScrollPanel", panel)
    scroll_missions:SetPos( 5, scroll_desc:GetY() + scroll_desc:GetTall() + 5)
    scroll_missions:SetSize( 350, panel:GetTall() - (scroll_desc:GetY() + scroll_desc:GetTall() + 10) )

    missionlist = vgui.Create( "DIconLayout", scroll_missions )
    missionlist:SetSize( scroll_missions:GetWide(), scroll_missions:GetTall() )
    missionlist:SetSpaceY( 2 )
    missionlist:SetSpaceX( 0 )

    if table.Count( LocalPlayer():GetMissions() ) > 0 then
        local active = missionlist:Add("DLabel")
        active:SetFont("Trebuchet24")
        active:SetText( "Active" )
        active:SetContentAlignment(4)
        active:SizeToContents()
        active:SetWide( scroll_missions:GetWide() - 15 )
    end

    local pending = missionlist:Add("DLabel")
    pending:SetFont("Trebuchet24")
    pending:SetText( "Pending" )
    pending:SetContentAlignment(4)
    pending:SizeToContents()
    pending:SetWide( scroll_missions:GetWide() - 15 )

    for k, v in SortedPairs( giverdata.missions ) do
        if not LocalPlayer():CanAcceptMission( k ) then continue end
        BuildMission( missionlist, k, v )
    end

    local unavailable = missionlist:Add("DLabel")
    unavailable:SetFont("Trebuchet24")
    unavailable:SetText( "Unavailable" )
    unavailable:SetContentAlignment(4)
    unavailable:SizeToContents()
    unavailable:SetWide( scroll_missions:GetWide() - 15 )

    for k, v in SortedPairs( giverdata.missions ) do
        if LocalPlayer():CanAcceptMission( k ) then continue end
        BuildMission( missionlist, k, v )
    end

    local info = vgui.Create("DPanel", panel)
    info:SetPos( scroll_missions:GetX() + scroll_missions:GetWide() + 5, scroll_desc:GetY() + scroll_desc:GetTall() + 5 )
    info:SetSize( scroll_desc:GetWide() - missionlist:GetWide() - 5, panel:GetTall() - (scroll_desc:GetY() + scroll_desc:GetTall() + 10) )
    function info:Paint( w, h )
        surface.SetDrawColor( Color( 0, 0, 0 ) )
        surface.DrawRect( 0, 0, w, h )
    end
end)

function BuildMission( parent, k, v )
    local canAccept = LocalPlayer():CanAcceptMission( k )

    local mission = parent:Add("DPanel")
    local height = 70
    mission:SetSize(parent:GetWide() - 15, height)
    function mission:Paint(w, h)
        local col = COLHUD_PRIMARY:ToTable()
        local alpha = canAccept and 100 or 50
        surface.SetDrawColor( col[1], col[2], col[3], alpha )
        surface.DrawRect( 0, 0, w, h )

        local nc = canAccept and COLHUD_DEFAULT or COLHUD_BAD
        surface.SetDrawColor( nc )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    local name = vgui.Create("DLabel", mission)
    name:SetFont("TargetIDSmall")
    name:SetText( v.name )
    name:SetContentAlignment(4)
    name:SizeToContents()
    name:SetPos( 5, 5 )

    if canAccept then
        local size = 35
        local button = DefaultButton( ">", mission:GetWide() - size - 5, mission:GetTall() / 2 - size / 2, size, size, mission, function()
        
        end)
    else

    end
end