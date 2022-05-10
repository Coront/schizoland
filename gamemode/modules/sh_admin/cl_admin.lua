function AdminMenu()
    if not LocalPlayer():IsAdmin() then return end

    frame_admin = vgui.Create("DFrame")
    frame_admin:SetSize(400, 500)
    frame_admin:Center()
    frame_admin:MakePopup()
    frame_admin:SetDraggable( false )
    frame_admin:SetTitle( "Admin Menu" )
    frame_admin:ShowCloseButton( true )

    admin_sheets = vgui.Create("DPropertySheet", frame_admin)
    admin_sheets:SetPos(5, 5)
    admin_sheets:SetFadeTime( 0 )
    admin_sheets:Dock( FILL )
    admin_sheets.Paint = function( _, w, h ) 
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    admin_sheets:AddSheet("Server Vars", AdminMenu_Server(), "icon16/computer_link.png")
    admin_sheets:AddSheet("Mob Spawner", AdminMenu_Mobspawner(), "icon16/bug.png")
    admin_sheets:AddSheet("Events", AdminMenu_Events(), "icon16/script_gear.png")
    admin_sheets:AddSheet("Other", AdminMenu_Other(), "icon16/wand.png")
end
concommand.Add("as_admin", AdminMenu)

function AdminMenu_Server()
    local parent = admin_sheets

    local panel = vgui.Create("DPanel", parent)
    panel:SetPos( 0, 0 )
    panel:SetSize( parent:GetWide(), parent:GetTall() )
    panel.Paint = function( _, w, h ) end

    local scroll = vgui.Create("DScrollPanel", panel)
    scroll:Dock( FILL )

    local xpos, ypos = 5, 5
    local function YAdd( amt ) ypos = ypos + amt end

    ToggleButtonFunction( "All Talk", xpos, ypos, scroll, GetConVar("as_alltalk"):GetBool(), function( bool )
        net.Start("as_admin_modifyconvar")
            net.WriteString("as_alltalk")
            net.WriteString( bool )
        net.SendToServer()
    end)
    YAdd( 20 )

    ToggleButtonFunction( "Spawn Mobs?", xpos, ypos, scroll, GetConVar("as_mobs"):GetBool(), function( bool )
        net.Start("as_admin_modifyconvar")
            net.WriteString("as_mobs")
            net.WriteString( bool )
        net.SendToServer()
    end)
    YAdd( 20 )

    ToggleButtonFunction( "Spawn Nodes?", xpos, ypos, scroll, GetConVar("as_nodes"):GetBool(), function( bool )
        net.Start("as_admin_modifyconvar")
            net.WriteString("as_nodes")
            net.WriteString( bool )
        net.SendToServer()
    end)
    YAdd( 20 )

    ToggleButtonFunction( "Enable Automated Events?", xpos, ypos, scroll, GetConVar("as_events"):GetBool(), function( bool )
        net.Start("as_admin_modifyconvar")
            net.WriteString("as_events")
            net.WriteString( bool )
        net.SendToServer()
    end)
    YAdd( 20 )

    ToggleButtonFunction( "Enable Occupational Zones?", xpos, ypos, scroll, GetConVar("as_occupation"):GetBool(), function( bool )
        net.Start("as_admin_modifyconvar")
            net.WriteString("as_occupation")
            net.WriteString( bool )
        net.SendToServer()
    end)
    YAdd( 20 )

    ToggleButtonFunction( "Disable All PvP?", xpos, ypos, scroll, GetConVar("as_pve"):GetBool(), function( bool )
        net.Start("as_admin_modifyconvar")
            net.WriteString("as_pve")
            net.WriteString( bool )
        net.SendToServer()
    end)
    YAdd( 20 )

    ToggleButtonFunction( "Disable Sandboxing? (Player Free-building)", xpos, ypos, scroll, GetConVar("as_nosandbox"):GetBool(), function( bool )
        net.Start("as_admin_modifyconvar")
            net.WriteString("as_nosandbox")
            net.WriteString( bool )
        net.SendToServer()
    end)
    YAdd( 20 )

    ToggleButtonFunction( "Enable Satiation? (Hunger/Thirst Ticking)", xpos, ypos, scroll, GetConVar("as_satiation"):GetBool(), function( bool )
        net.Start("as_admin_modifyconvar")
            net.WriteString("as_satiation")
            net.WriteString( bool )
        net.SendToServer()
    end)
    YAdd( 20 )

    ToggleButtonFunction( "Enable Player Collision?", xpos, ypos, scroll, GetConVar("as_collisions"):GetBool(), function( bool )
        net.Start("as_admin_modifyconvar")
            net.WriteString("as_collisions")
            net.WriteString( bool )
        net.SendToServer()
    end)
    YAdd( 20 )

    ToggleButtonFunction( "Enable Respawn Delay? (Waiting a period before respawning)", xpos, ypos, scroll, GetConVar("as_respawnwait"):GetBool(), function( bool )
        net.Start("as_admin_modifyconvar")
            net.WriteString("as_respawnwait")
            net.WriteString( bool )
        net.SendToServer()
    end)
    YAdd( 20 )

    ToggleButtonFunction( "Enable Class Changing?", xpos, ypos, scroll, GetConVar("as_classchange"):GetBool(), function( bool )
        net.Start("as_admin_modifyconvar")
            net.WriteString("as_classchange")
            net.WriteString( bool )
        net.SendToServer()
    end)
    YAdd( 20 )

    ToggleButtonFunction( "Enable Class Change Cost?", xpos, ypos, scroll, GetConVar("as_classchangecost"):GetBool(), function( bool )
        net.Start("as_admin_modifyconvar")
            net.WriteString("as_classchangecost")
            net.WriteString( bool )
        net.SendToServer()
    end)
    YAdd( 20 )

    ToggleButtonFunction( "Enable Combat Timers?", xpos, ypos, scroll, GetConVar("as_stress"):GetBool(), function( bool )
        net.Start("as_admin_modifyconvar")
            net.WriteString("as_stress")
            net.WriteString( bool )
        net.SendToServer()
    end)
    YAdd( 20 )

    ToggleButtonFunction( "Drop Player Cases on death? (Will return items if off)", xpos, ypos, scroll, GetConVar("as_cases"):GetBool(), function( bool )
        net.Start("as_admin_modifyconvar")
            net.WriteString("as_cases")
            net.WriteString( bool )
        net.SendToServer()
    end)
    YAdd( 20 )

    return panel
end

function AdminMenu_Mobspawner()
    local parent = admin_sheets

    local panel = vgui.Create("DPanel", parent)
    panel:SetPos( 0, 0 )
    panel:SetSize( parent:GetWide(), parent:GetTall() )
    panel.Paint = function( _, w, h ) end

    local scroll = vgui.Create("DScrollPanel", panel)
    scroll:Dock( FILL )

    local xpos, ypos = 5, 5
    local function YAdd( amt ) ypos = ypos + amt end

    SmallLabel( "Diagnostics", xpos, ypos, scroll )
    YAdd( 25 )

    DefaultButton( "Perform Mob Count", xpos, ypos, 200, 25, scroll, function()
        LocalPlayer():ChatPrint("Check Console.")
        RunConsoleCommand( "as_mobs_count" )
    end)
    YAdd( 30 )

    DefaultButton( "Perform Node Count", xpos, ypos, 200, 25, scroll, function()
        LocalPlayer():ChatPrint("Check Console.")
        RunConsoleCommand( "as_nodes_count" )
    end)
    YAdd( 30 )

    DefaultButton( "Perform Event Count", xpos, ypos, 200, 25, scroll, function()
        LocalPlayer():ChatPrint("Check Console.")
        RunConsoleCommand( "as_events_count" )
    end)
    YAdd( 30 )

    SmallLabel( "Management", xpos, ypos, scroll )
    YAdd( 25 )

    DefaultButton( "Clear Mobs", xpos, ypos, 200, 25, scroll, function()
        RunConsoleCommand( "as_mobs_clear" )
    end)
    YAdd( 30 )

    DefaultButton( "Clear Nodes", xpos, ypos, 200, 25, scroll, function()
        RunConsoleCommand( "as_nodes_clear" )
    end)
    YAdd( 30 )

    DefaultButton( "Clear Events", xpos, ypos, 200, 25, scroll, function()
        RunConsoleCommand( "as_events_clear" )
    end)
    YAdd( 30 )

    return panel
end

function AdminMenu_Events()
    local parent = admin_sheets

    local panel = vgui.Create("DPanel", parent)
    panel:SetPos( 0, 0 )
    panel:SetSize( parent:GetWide(), parent:GetTall() )
    panel.Paint = function( _, w, h ) end

    local scroll = vgui.Create("DScrollPanel", panel)
    scroll:Dock( FILL )

    local xpos, ypos = 5, 5
    local function YAdd( amt ) ypos = ypos + amt end

    SmallLabel( "Clicking a button will activate an event.", xpos, ypos, scroll )
    YAdd( 25 )

    for k, v in SortedPairs( AS.Events ) do
        DefaultButton( v.name, xpos, ypos, 200, 25, scroll, function()
            RunConsoleCommand( "as_event_spawn", k )
        end)
        YAdd( 30 )
    end

    return panel
end

function AdminMenu_Other()
    local parent = admin_sheets

    local panel = vgui.Create("DPanel", parent)
    panel:SetPos( 0, 0 )
    panel:SetSize( parent:GetWide(), parent:GetTall() )
    panel.Paint = function( _, w, h ) end

    local scroll = vgui.Create("DScrollPanel", panel)
    scroll:Dock( FILL )

    local xpos, ypos = 5, 5
    local function YAdd( amt ) ypos = ypos + amt end

    DefaultButton( "Item Menu", xpos, ypos, 200, 25, scroll, function()
        RunConsoleCommand( "as_itemmenu" )
    end)
    YAdd( 30 )

    DefaultButton( "Skills Menu", xpos, ypos, 200, 25, scroll, function()
        RunConsoleCommand( "as_skills" )
    end)
    YAdd( 30 )

    return panel
end

function ItemMenu()
    if not LocalPlayer():IsAdmin() then return end
    if IsValid(frame_itemmenu) then frame_itemmenu:Close() end

    frame_itemmenu = vgui.Create("DFrame")
    frame_itemmenu:SetSize(800, 600)
    frame_itemmenu:Center()
    frame_itemmenu:MakePopup()
    frame_itemmenu:SetDraggable( false )
    frame_itemmenu:SetTitle( "Left Click an item to give a single to yourself. Right Click an item to give yourself a bulk. Middle Click to fetch item's ID." )
    frame_itemmenu:ShowCloseButton( true )

    local itemscrollpanel = vgui.Create("DScrollPanel", frame_itemmenu)
    itemscrollpanel:SetSize( frame_itemmenu:GetWide(), 0 )
    itemscrollpanel:Dock( FILL )
    itemscrollpanel:DockMargin( 0, 5, 0, 0 )
    itemscrollpanel.Paint = function(self,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local searchbar = vgui.Create( "DTextEntry", frame_itemmenu )
    searchbar:Dock( TOP )
    searchbar:DockMargin( 0, 0, 0, 0 )
    searchbar:SetSize( 0, 25 )
    searchbar:SetPlaceholderText( "Search an item here. Hit enter to submit." )
    searchbar.OnEnter = function( self )
        itemscrollpanel:Clear()
        refreshList()
    end

    function refreshList()
        local itemlist = vgui.Create("DIconLayout", itemscrollpanel)
        itemlist:SetPos( 0, 0 )
        itemlist:SetSize( itemscrollpanel:GetWide(), itemscrollpanel:GetTall() )
        itemlist:SetSpaceY( 5 )
        itemlist:SetSpaceX( 5 )

        for k, v in SortedPairs( AS.Items ) do
            if not string.find( string.lower(v.name), searchbar:GetValue() ) and not string.find( string.lower(k), searchbar:GetValue() ) then continue end

            local panel = itemlist:Add("SpawnIcon")
            panel:SetSize( 60, 60 )
            panel:SetModel( v.model, v.skin or 0 )
            local name = v.name or "name?" .. k
            local desc = v.desc or "desc?" .. k
            local value = v.value or "value?" .. k
            local weight = v.weight or "weight?" .. k
            panel:SetTooltip(name .. "\n" .. desc .. "\nValue: " .. value .. "\nWeight: " .. weight)
            local function giveItem( item, amt )
                if not LocalPlayer():IsAdmin() then return end
                LocalPlayer():AddItemToInventory( item, amt )
                net.Start("as_admin_spawnitem")
                    net.WriteString(item)
                    net.WriteUInt( amt, NWSetting.ItemAmtBits )
                net.SendToServer()
            end
            panel.DoClick = function()
                giveItem( k, 1 )
            end
            panel.DoMiddleClick = function()
                SetClipboardText( k )
                LocalPlayer():ChatPrint( k )
            end
            panel.DoRightClick = function()
                local slideramt = SET.RawResources[k] and 10000 or 100
                VerifySlider( slideramt, function( amt ) 
                    giveItem( k, amt )
                end )
            end
            panel.Paint = function(self,w,h)
                if v.color then
                    surface.SetDrawColor( v.color )
                else
                    surface.SetDrawColor( COLHUD_PRIMARY )
                end
                surface.DrawRect( 0, 0, w, h )
            end

            local itemname = vgui.Create("DLabel", panel)
            itemname:SetSize( panel:GetWide(), 14)
            itemname:SetPos( 1, panel:GetTall() - itemname:GetTall())
            itemname:SetText(name)
        end
    end
    refreshList()
end
concommand.Add("as_itemmenu", ItemMenu)

function SkillsMenu()
    if not LocalPlayer():IsAdmin() then return end
    local ply = LocalPlayer()

    frame_skillsmenu = vgui.Create("DFrame")
    frame_skillsmenu:SetSize(400, 500)
    frame_skillsmenu:Center()
    frame_skillsmenu:MakePopup()
    frame_skillsmenu:SetDraggable( false )
    frame_skillsmenu:SetTitle( "Skills Menu" )
    frame_skillsmenu:ShowCloseButton( true )

    skills_scroll = vgui.Create("DScrollPanel", frame_skillsmenu)
    skills_scroll:SetPos( 5, 25 )
    skills_scroll:SetSize( frame_skillsmenu:GetWide() - (skills_scroll:GetX() * 2), frame_skillsmenu:GetTall() - (skills_scroll:GetY() + 5) )
    function skills_scroll:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local xpos, ypos = 5, 5
    local function yadd( amt ) ypos = ypos + amt end

    for k, v in SortedPairs( AS.Skills ) do

        local panel = vgui.Create("DPanel", skills_scroll)
        panel:SetSize( skills_scroll:GetWide() - ((xpos * 2) + 15), 70)
        panel:SetPos( xpos, ypos )
        function panel:Paint( w, h )
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        local skill = vgui.Create("DLabel", panel)
        skill:SetPos( 5, 5 )
        skill:SetFont( "TargetID" )
        skill:SetText( v.name )
        skill:SizeToContents()

        local exp = vgui.Create("DPanel", panel)
        exp:SetSize( panel:GetWide() - 10, 15)
        exp:SetPos( 5, panel:GetTall() - (exp:GetTall() + 5) )
        function exp:Paint( w, h )
            surface.SetDrawColor( COLHUD_SECONDARY )
            surface.DrawRect( 0, 0, w, h )

            local ply = LocalPlayer()
            local curxp = ply:GetSkillExperience( k ) - ExpForLevel( k, ply:GetSkillLevel( k ) - 1 )
            local nextxp = ExpForLevel( k, ply:GetSkillLevel( k ) + 1 ) - ExpForLevel( k, ply:GetSkillLevel( k ))

            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawRect( 0, 0, (curxp / nextxp) * w, h )
        end

        local amt = vgui.Create("DLabel", panel)
        amt:SetPos( 5, exp:GetY() - 15 )
        amt:SetText( "Level " .. ply:GetSkillLevel(k) .. "/" .. v.max .. " - " .. ply:GetSkillExperience(k) .. "/" .. ExpForLevel( k, ply:GetSkillLevel(k) + 1 ) .. " Experience" )
        amt:SizeToContents()

        local btn = vgui.Create("DButton", panel)
        btn:SetSize( 70, 20 )
        btn:SetPos( panel:GetWide() - (btn:GetWide() + 5), 5 )
        btn:SetText("Add XP")
        function btn:DoClick()
            VerifySlider( 100, function( amt )
                net.Start("as_admin_changeskillxp")
                    net.WriteString( k )
                    net.WriteInt( amt, 32 )
                net.SendToServer()
            end)
        end

        local btn2 = vgui.Create("DButton", panel)
        btn2:SetSize( 70, 20 )
        btn2:SetPos( panel:GetWide() - (btn2:GetWide() + 5), 25 )
        btn2:SetText("Take XP")
        function btn2:DoClick()
            VerifySlider( 100, function( amt )
                net.Start("as_admin_changeskillxp")
                    net.WriteString( k )
                    net.WriteInt( -amt, 32 )
                net.SendToServer()
            end)
        end

        yadd( panel:GetTall() + 5 )
    end
end
concommand.Add("as_skills", SkillsMenu)