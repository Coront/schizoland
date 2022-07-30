local ent

net.Receive( "as_missiongiver_open", function()
    ent = net.ReadEntity()
    if not IsValid( ent ) then return end

    if IsValid(frame_missiongiver) then frame_missiongiver:Close() end

    selectedMission = nil

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

    local giverdata = AS.MissionGivers[ent.GiverID]

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

    local activeamt = 0
    if #LocalPlayer():GetMissionsByGiver( ent.GiverID ) > 0 then
        local active = missionlist:Add("DLabel")
        active:SetFont("Trebuchet24")
        active:SetText( "Active" )
        active:SetContentAlignment(4)
        active:SizeToContents()
        active:SetWide( scroll_missions:GetWide() - 15 )
        function active:Paint( w, h )
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        for k, v in pairs( LocalPlayer():GetMissions() ) do
            local char = FindCharacterByMission( k )
            if char != ent.GiverID then continue end --Mission giver doesnt own this mission.
            local minfo = FetchMissionInfo( k )
            BuildMission( missionlist, k, minfo )
        end
    end

    local pending = missionlist:Add("DLabel")
    pending:SetFont("Trebuchet24")
    pending:SetText( "Pending" )
    pending:SetContentAlignment(4)
    pending:SizeToContents()
    pending:SetWide( scroll_missions:GetWide() - 15 )
    function pending:Paint( w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

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
    function unavailable:Paint( w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    for k, v in SortedPairs( giverdata.missions ) do
        if LocalPlayer():CanAcceptMission( k ) then continue end
        if LocalPlayer():HasMission( k ) then continue end
        if v.hidden then continue end
        BuildMission( missionlist, k, v )
    end

    info = vgui.Create("DPanel", panel)
    info:SetPos( scroll_missions:GetX() + scroll_missions:GetWide() + 5, scroll_desc:GetY() + scroll_desc:GetTall() + 5 )
    info:SetSize( scroll_desc:GetWide() - missionlist:GetWide() - 5, panel:GetTall() - (scroll_desc:GetY() + scroll_desc:GetTall() + 10) )
    function info:Paint( w, h )
        local col = COLHUD_PRIMARY:ToTable()
        surface.SetDrawColor( col[1], col[2], col[3], 100 )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    mtitle = vgui.Create("DLabel", info)
    mtitle:SetFont("Trebuchet24")
    mtitle:SetText( "Select a mission." )
    mtitle:SetContentAlignment(4)
    mtitle:SizeToContents()
    mtitle:SetPos( 5, 5 )

    mdesc_scroll = vgui.Create("DScrollPanel", info)
    mdesc_scroll:SetPos( 10, 30 )
    mdesc_scroll:SetSize( info:GetWide() - mdesc_scroll:GetX() * 2, info:GetTall() - 350 )

    mdesc = vgui.Create("DLabel", mdesc_scroll)
    mdesc:SetText( "" )
    mdesc:SetSize( mdesc_scroll:GetWide() - 15, mdesc_scroll:GetTall() )
    mdesc:SetWrap( true )
    mdesc:SetAutoStretchVertical( true )
end)

function UpdateSelectedMission( id )
    selectedMission = id

    local missioninfo = FetchMissionInfo( selectedMission )

    mtitle:SetText( missioninfo.name )
    mdesc:SetText( missioninfo.desc )

    local objtext = ""
    for k, v in pairs( missioninfo.data ) do
        objtext = objtext .. "- " .. TranslateTaskToText( v.type, (v.targetname or v.target), v.amt ) .. "\n"
    end

    if not IsValid( mobj_scroll ) then
        mobj_scroll = vgui.Create("DScrollPanel", info)
        mobj_scroll:SetPos( 10, mdesc_scroll:GetTall() + mdesc_scroll:GetY() + 5 )
        mobj_scroll:SetSize( info:GetWide() - mobj_scroll:GetX() * 2, info:GetTall() - (mdesc_scroll:GetTall() + mdesc_scroll:GetY()) - 150 )
        function mobj_scroll:Paint( w, h )
            local col = COLHUD_PRIMARY:ToTable()
            surface.SetDrawColor( col[1], col[2], col[3], 100 )
            surface.DrawRect( 0, 0, w, h )

            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawOutlinedRect( 0, 0, w, h, 1 )
        end

        local obj = SimpleLabel( mobj_scroll, "Objectives:", 3, 0, "Trebuchet18" )

        mobj = vgui.Create("DLabel", mobj_scroll)
        mobj:SetText( objtext )
        mobj:SetPos( 5, 20 )
        mobj:SetSize( mobj_scroll:GetWide() - 15, mobj_scroll:GetTall() )
        mobj:SetWrap( true )
        mobj:SetAutoStretchVertical( true )
    else
        mobj:SetText( objtext )
    end

    local rwdtext = ""
    for k, v in pairs( missioninfo.reward ) do
        rwdtext = rwdtext .. "- " .. AS.Items[k].name .. " (" .. v .. ")" .. "\n"
    end

    if not IsValid( mreward_scroll ) then
        mreward_scroll = vgui.Create("DScrollPanel", info)
        mreward_scroll:SetPos( 10, mobj_scroll:GetY() + mobj_scroll:GetTall() + 5 )
        mreward_scroll:SetSize( info:GetWide() - mreward_scroll:GetX() * 2, info:GetTall() - (mobj_scroll:GetTall() + mobj_scroll:GetY()) - 45 )
        function mreward_scroll:Paint( w, h )
            local col = COLHUD_PRIMARY:ToTable()
            surface.SetDrawColor( col[1], col[2], col[3], 100 )
            surface.DrawRect( 0, 0, w, h )

            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawOutlinedRect( 0, 0, w, h, 1 )
        end

        local reward = SimpleLabel( mreward_scroll, "Rewards:", 3, 0, "Trebuchet18" )

        mreward = vgui.Create("DLabel", mreward_scroll)
        mreward:SetText( rwdtext )
        mreward:SetPos( 5, 20 )
        mreward:SetSize( mreward_scroll:GetWide() - 15, mreward_scroll:GetTall() )
        mreward:SetWrap( true )
        mreward:SetAutoStretchVertical( true )
    else
        mreward:SetText( rwdtext )
    end

    local tall = 25
    local button = DefaultButton( "Accept Mission", 10, info:GetTall() - tall - 10, info:GetWide() - 20, tall, info, function()
        frame_missiongiver:Close()
        net.Start("as_missiongiver_acceptmission")
            net.WriteEntity( ent )
            net.WriteString( id )
        net.SendToServer()
    end)
end

function ViewSelectedMission( id )
    selectedMission = id

    local missioninfo = FetchMissionInfo( selectedMission )

    mtitle:SetText( missioninfo.name )
    mdesc:SetText( missioninfo.desc )

    if IsValid( turnInbutton ) then
        turnInbutton:Remove()
    end

    local objtext = ""
    for k, v in pairs( missioninfo.data ) do
        objtext = objtext .. "- " .. TranslateTaskToText( v.type, (v.targetname or v.target), v.amt ) .. "\n"
    end

    if not IsValid( mobj_scroll ) then
        mobj_scroll = vgui.Create("DScrollPanel", info)
        mobj_scroll:SetPos( 10, mdesc_scroll:GetTall() + mdesc_scroll:GetY() + 5 )
        mobj_scroll:SetSize( info:GetWide() - mobj_scroll:GetX() * 2, info:GetTall() - (mdesc_scroll:GetTall() + mdesc_scroll:GetY()) - 150 )
        function mobj_scroll:Paint( w, h )
            local col = COLHUD_PRIMARY:ToTable()
            surface.SetDrawColor( col[1], col[2], col[3], 100 )
            surface.DrawRect( 0, 0, w, h )

            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawOutlinedRect( 0, 0, w, h, 1 )
        end

        local obj = SimpleLabel( mobj_scroll, "Objectives:", 3, 0, "Trebuchet18" )

        mobj = vgui.Create("DLabel", mobj_scroll)
        mobj:SetText( objtext )
        mobj:SetPos( 5, 20 )
        mobj:SetSize( mobj_scroll:GetWide() - 15, mobj_scroll:GetTall() )
        mobj:SetWrap( true )
        mobj:SetAutoStretchVertical( true )
    else
        mobj:SetText( objtext )
    end

    local rwdtext = ""
    for k, v in pairs( missioninfo.reward ) do
        rwdtext = rwdtext .. "- " .. AS.Items[k].name .. " (" .. v .. ")" .. "\n"
    end

    if not IsValid( mreward_scroll ) then
        mreward_scroll = vgui.Create("DScrollPanel", info)
        mreward_scroll:SetPos( 10, mobj_scroll:GetY() + mobj_scroll:GetTall() + 5 )
        mreward_scroll:SetSize( info:GetWide() - mreward_scroll:GetX() * 2, info:GetTall() - (mobj_scroll:GetTall() + mobj_scroll:GetY()) - 45 )
        function mreward_scroll:Paint( w, h )
            local col = COLHUD_PRIMARY:ToTable()
            surface.SetDrawColor( col[1], col[2], col[3], 100 )
            surface.DrawRect( 0, 0, w, h )

            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawOutlinedRect( 0, 0, w, h, 1 )
        end

        local reward = SimpleLabel( mreward_scroll, "Rewards:", 3, 0, "Trebuchet18" )

        mreward = vgui.Create("DLabel", mreward_scroll)
        mreward:SetText( rwdtext )
        mreward:SetPos( 5, 20 )
        mreward:SetSize( mreward_scroll:GetWide() - 15, mreward_scroll:GetTall() )
        mreward:SetWrap( true )
        mreward:SetAutoStretchVertical( true )
    else
        mreward:SetText( rwdtext )
    end

    local turnIn = LocalPlayer():CanTurnMissionIn( id )
    local tall = 25
    if turnIn then
        turnInbutton = DefaultButton( "Turn In", 10, info:GetTall() - tall - 10, info:GetWide() - 20, tall, info, function()
            frame_missiongiver:Close()
            net.Start("as_missiongiver_finishmission")
                net.WriteEntity( ent )
                net.WriteString( id )
            net.SendToServer()
        end)
    end
end

function BuildMission( parent, k, v )
    local canAccept = LocalPlayer():CanAcceptMission( k )
    local alreadyHas = LocalPlayer():HasMission( k )
    local turnIn = LocalPlayer():CanTurnMissionIn( k )

    local mission = parent:Add("DPanel")
    local height = 60
    mission:SetSize(parent:GetWide() - 15, height)
    function mission:Paint(w, h)
        local col = selectedMission == k and COLHUD_DEFAULT:ToTable() or turnIn and COLHUD_GOOD:ToTable() or COLHUD_PRIMARY:ToTable()
        local alpha = (canAccept or alreadyHas) and 100 or 50
        surface.SetDrawColor( col[1], col[2], col[3], alpha )
        surface.DrawRect( 0, 0, w, h )

        local nc = turnIn and COLHUD_GOOD or (canAccept or alreadyHas) and COLHUD_DEFAULT or COLHUD_BAD
        surface.SetDrawColor( nc )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    local size = 16
    local mat = v.icon or "icon16/asterisk_yellow.png"
    local iconpanel = SimpleMatIcon( mission, mat, size, 5, mission:GetTall() / 2 - size / 2 )

    local name = vgui.Create("DLabel", mission)
    name:SetFont("TargetIDSmall")
    name:SetText( v.name )
    name:SetContentAlignment(4)
    name:SizeToContents()
    name:SetPos( iconpanel:GetX() + iconpanel:GetWide() + 5, mission:GetTall() / 2 - name:GetTall() / 2 )

    if alreadyHas or canAccept then
        local size = 35
        local button = DefaultButton( turnIn and "?" or ">", mission:GetWide() - size - 5, mission:GetTall() / 2 - size / 2, size, size, mission, function()
            if alreadyHas then
                ViewSelectedMission( k )
            else
                UpdateSelectedMission( k )
            end
        end)
    else
        local size = 16
        local locked = SimpleMatIcon( mission, "icon16/lock.png", size, mission:GetWide() - size - 10, mission:GetTall() / 2 - 8, "This mission is unavailable." )
    end
end