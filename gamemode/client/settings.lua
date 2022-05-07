AS.Settings = {}

function AS.Settings.SetToDefault()
    for k, v in pairs( ConVarDefaults ) do
        RunConsoleCommand( k, v )
    end
end

function AS.Settings.Menu()
    if IsValid(frame_settings) then frame_settings:Close() end

    frame_settings = vgui.Create("DFrame")
    frame_settings:SetSize(500, 500)
    frame_settings:Center()
    frame_settings:MakePopup()
    frame_settings:SetTitle( "Settings" )

    settings_scroll = vgui.Create("DScrollPanel", frame_settings)
    settings_scroll:Dock( FILL )
    function settings_scroll:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    AS.Settings.BuildOptions()

    function frame_settings:OnClose()
        SettingsOpen = false
    end
end
concommand.Add("as_settings", AS.Settings.Menu)

function AS.Settings.BuildOptions()
    local xpos = 10
    local ypos = 5
    local function addSpace(x, y)
        xpos = (xpos + (x or 0))
        ypos = (ypos + (y or 0)) 
    end
    local function resetX()
        xpos = 10
    end

--  ██████╗ ██████╗ ██╗      ██████╗ ██████╗ ███████╗
-- ██╔════╝██╔═══██╗██║     ██╔═══██╗██╔══██╗██╔════╝
-- ██║     ██║   ██║██║     ██║   ██║██████╔╝███████╗
-- ██║     ██║   ██║██║     ██║   ██║██╔══██╗╚════██║
-- ╚██████╗╚██████╔╝███████╗╚██████╔╝██║  ██║███████║
--  ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

    DefaultButton( "Use Default Settings", xpos, ypos, 150, 20, settings_scroll, AS.Settings.SetToDefault )
    addSpace( 0, 20 )

    SectionLabel( "Colors", xpos, ypos, settings_scroll )
    addSpace( 0, 35 )

    ValueSlider( "Default - Red", xpos, ypos, 0, 255, settings_scroll, "as_hud_color_default_r", "default" )
    addSpace( 0, 20 )

    ValueSlider( "Default - Green", xpos, ypos, 0, 255, settings_scroll, "as_hud_color_default_g", "default" )
    addSpace( 0, 20 )

    ValueSlider( "Default - Blue", xpos, ypos, 0, 255, settings_scroll, "as_hud_color_default_b", "default" )
    addSpace( 0, 30 )

    ValueSlider( "Good - Red", xpos, ypos, 0, 255, settings_scroll, "as_hud_color_good_r", "good" )
    addSpace( 0, 20 )

    ValueSlider( "Good - Green", xpos, ypos, 0, 255, settings_scroll, "as_hud_color_good_g", "good" )
    addSpace( 0, 20 )

    ValueSlider( "Good - Blue", xpos, ypos, 0, 255, settings_scroll, "as_hud_color_good_b", "good" )
    addSpace( 0, 30 )

    ValueSlider( "Bad - Red", xpos, ypos, 0, 255, settings_scroll, "as_hud_color_bad_r", "bad" )
    addSpace( 0, 20 )

    ValueSlider( "Bad - Green", xpos, ypos, 0, 255, settings_scroll, "as_hud_color_bad_g", "bad" )
    addSpace( 0, 20 )

    ValueSlider( "Bad - Blue", xpos, ypos, 0, 255, settings_scroll, "as_hud_color_bad_b", "bad" )
    addSpace( 0, 20 )

    resetX()

--  ██████╗  █████╗ ███╗   ███╗███████╗██████╗ ██╗      █████╗ ██╗   ██╗
-- ██╔════╝ ██╔══██╗████╗ ████║██╔════╝██╔══██╗██║     ██╔══██╗╚██╗ ██╔╝
-- ██║  ███╗███████║██╔████╔██║█████╗  ██████╔╝██║     ███████║ ╚████╔╝
-- ██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  ██╔═══╝ ██║     ██╔══██║  ╚██╔╝
-- ╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗██║     ███████╗██║  ██║   ██║
--  ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝

    SectionLabel( "Gameplay", xpos, ypos, settings_scroll )
    addSpace( 0, 35 )

    ToggleButton("Verify certain actions - Example: Destroying Items", xpos, ypos, settings_scroll, "as_gameplay_verify")
    addSpace( 0, 20 )

    ToggleButton("Play Container Sounds", xpos, ypos, settings_scroll, "as_container_sounds")
    addSpace( 0, 20 )

    ToggleButton("Play Death Stingers", xpos, ypos, settings_scroll, "as_gameplay_deathstinger")
    addSpace( 0, 20 )

    ValueSlider( "Thirdperson - Back", xpos, ypos, 5, 150, settings_scroll, "as_thirdperson_distance" )
    addSpace( 0, 20 )

    ValueSlider( "Thirdperson - Up", xpos, ypos, -10, 20, settings_scroll, "as_thirdperson_up" )
    addSpace( 0, 20 )

    ValueSlider( "Thirdperson - Side", xpos, ypos, -30, 30, settings_scroll, "as_thirdperson_side" )
    addSpace( 0, 20 )

    resetX()

--  ██████╗ ██╗   ██╗██╗
-- ██╔════╝ ██║   ██║██║
-- ██║  ███╗██║   ██║██║
-- ██║   ██║██║   ██║██║
-- ╚██████╔╝╚██████╔╝██║
--  ╚═════╝  ╚═════╝ ╚═╝

    SectionLabel( "GUI", xpos, ypos, settings_scroll )
    addSpace( 0, 35 )

    ToggleButton("Inventory: Hold-To-Open", xpos, ypos, settings_scroll, "as_menu_inventory_holdtoopen")
    addSpace( 0, 20 )

    ToggleButton("Inventory: Disable Categorization", xpos, ypos, settings_scroll, "as_menu_inventory_singlepanel")
    addSpace( 0, 20 )

    resetX()

-- ██╗  ██╗██╗   ██╗██████╗
-- ██║  ██║██║   ██║██╔══██╗
-- ███████║██║   ██║██║  ██║
-- ██╔══██║██║   ██║██║  ██║
-- ██║  ██║╚██████╔╝██████╔╝
-- ╚═╝  ╚═╝ ╚═════╝ ╚═════╝

    SectionLabel( "HUD", xpos, ypos, settings_scroll )
    addSpace( 0, 35 )

    ToggleButton( "Enable HUD", xpos, ypos, settings_scroll, "as_hud")
    addSpace( 0, 20 )

    ValueSlider( "HUD Scale", xpos, ypos, 0.6, 2.5, settings_scroll, "as_hud_scale", nil, true )
    addSpace( 20, 20 )

    ToggleButton("Enable Health Bar", xpos, ypos, settings_scroll, "as_hud_healthbar")
    addSpace( 20, 20 )

    ToggleButton("Enable Health Bar Amounts", xpos, ypos, settings_scroll, "as_hud_healthbar_amount")
    addSpace( 0, 20 )

    ValueSlider( "Health Bar X-Pos", xpos, ypos, -2000, 2000, settings_scroll, "as_hud_healthbar_xadd" )
    addSpace( 0, 20 )

    ValueSlider( "Health Bar Y-Pos", xpos, ypos, -2000, 2000, settings_scroll, "as_hud_healthbar_yadd" )
    addSpace( 0, 20 )

    ValueSlider( "Health Bar Width", xpos, ypos, 5, 2000, settings_scroll, "as_hud_healthbar_width" )
    addSpace( 0, 20 )

    ValueSlider( "Health Bar Height", xpos, ypos, 5, 50, settings_scroll, "as_hud_healthbar_height" )
    addSpace( -20, 20 )

    ToggleButton("Enable Satiation Bars", xpos, ypos, settings_scroll, "as_hud_satiationbars")
    addSpace( 20, 20 )

    ToggleButton("Enable Satiation Bars Amount", xpos, ypos, settings_scroll, "as_hud_satiationbars_amount")
    addSpace( 0, 20 )

    ToggleButton("Show Satiated Indicator", xpos, ypos, settings_scroll, "as_hud_satiationbars_showindic")
    addSpace( 0, 20 )

    ValueSlider( "Satiation Bars X-Pos", xpos, ypos, -2000, 2000, settings_scroll, "as_hud_satiationbars_xadd" )
    addSpace( 0, 20 )

    ValueSlider( "Satiation Bars Y-Pos", xpos, ypos, -2000, 2000, settings_scroll, "as_hud_satiationbars_yadd" )
    addSpace( 0, 20 )

    ValueSlider( "Satiation Bars Width", xpos, ypos, 5, 2000, settings_scroll, "as_hud_satiationbars_width" )
    addSpace( 0, 20 )

    ValueSlider( "Satiation Bars Height", xpos, ypos, 5, 50, settings_scroll, "as_hud_satiationbars_height" )
    addSpace( -20, 20 )

    ToggleButton("Enable Effects", xpos, ypos, settings_scroll, "as_hud_effects")
    addSpace( 20, 20 )

    ToggleButton("Enable Effects Amounts", xpos, ypos, settings_scroll, "as_hud_effects_amount")
    addSpace( 0, 20 )

    ValueSlider( "Effects X-Pos", xpos, ypos, -2000, 2000, settings_scroll, "as_hud_effects_xadd" )
    addSpace( 0, 20 )

    ValueSlider( "Effects Y-Pos", xpos, ypos, -2000, 2000, settings_scroll, "as_hud_effects_yadd" )
    addSpace( 0, 20 )

    ValueSlider( "Effects Icon Size", xpos, ypos, 16, 32, settings_scroll, "as_hud_effects_iconsize" )
    addSpace( 0, 20 )

    ValueSlider( "Effects Bar Width", xpos, ypos, 5, 2000, settings_scroll, "as_hud_effects_width" )
    addSpace( 0, 20 )

    ValueSlider( "Effects Bar Height", xpos, ypos, 5, 50, settings_scroll, "as_hud_effects_height" )
    addSpace( 0, 20 )

    ValueSlider( "Y Spacing Between Effects", xpos, ypos, 0, 15, settings_scroll, "as_hud_effects_barspacing" )
    addSpace( -20, 20 )

    ToggleButton("Enable Resource Count", xpos, ypos, settings_scroll, "as_hud_resources")
    addSpace( 20, 20 )

    ValueSlider("Resource X-Pos", xpos, ypos, -2000, 2000, settings_scroll, "as_hud_resources_xadd")
    addSpace( 0, 20 )

    ValueSlider("Resource Y-Pos", xpos, ypos, -2000, 2000, settings_scroll, "as_hud_resources_yadd")
    addSpace( -20, 20 )

    ToggleButton( "Enable Target Info", xpos, ypos, settings_scroll, "as_hud_targetinfo" )
    addSpace( 20, 20 )

    ToggleButton( "Enable Target Info Amounts", xpos, ypos, settings_scroll, "as_hud_targetinfo_amount" )
    addSpace( 0, 20 )

    ValueSlider( "Target Info X-Pos", xpos, ypos, -2000, 2000, settings_scroll, "as_hud_targetinfo_xadd" )
    addSpace( 0, 20 )

    ValueSlider( "Target Info Y-Pos", xpos, ypos, -2000, 2000, settings_scroll, "as_hud_targetinfo_yadd" )
    addSpace( 0, 20 )

    ValueSlider( "Target Info Width", xpos, ypos, 5, 2000, settings_scroll, "as_hud_targetinfo_width" )
    addSpace( 0, 20 )

    ValueSlider( "Target Info Height", xpos, ypos, 5, 50, settings_scroll, "as_hud_targetinfo_height" )
    addSpace( -20, 20 )

    ToggleButton( "Enable Combat Warning", xpos, ypos, settings_scroll, "as_hud_stress" )
    addSpace( 20, 20 )

    ValueSlider( "Combat Warning X-Pos", xpos, ypos, -2000, 2000, settings_scroll, "as_hud_stress_xadd" )
    addSpace( 0, 20 )

    ValueSlider( "Combat Warning Y-Pos", xpos, ypos, -2000, 2000, settings_scroll, "as_hud_stress_yadd" )
    addSpace( -20, 20 )

    ToggleButton("Enable Event Bars", xpos, ypos, settings_scroll, "as_hud_timeevent")
    addSpace( 20, 20 )

    ToggleButton("Show Event Bar Percent", xpos, ypos, settings_scroll, "as_hud_timeevent_percent")
    addSpace( 0, 20 )

    resetX()

--Connection Information

    ToggleButton("Enable Connection Information", xpos, ypos, settings_scroll, "as_connectioninfo")
    addSpace( 20, 20 )

    ValueSlider( "Update Rate", xpos, ypos, 0, 3, settings_scroll, "as_connectioninfo_update", nil, true )
    addSpace( 0, 20 )

    ToggleButton("Show Ping", xpos, ypos, settings_scroll, "as_connectioninfo_ping")
    addSpace( 20, 20 )

    ToggleButton("Only show Ping when spiking", xpos, ypos, settings_scroll, "as_connectioninfo_ping_warning")
    addSpace( 0, 20 )

    ValueSlider( "Spiking Ping", xpos, ypos, 30, 400, settings_scroll, "as_connectioninfo_ping_warning_amt" )
    addSpace( -20, 20 )

    ToggleButton("Show FPS", xpos, ypos, settings_scroll, "as_connectioninfo_fps")
    addSpace( 20, 20 )

    ToggleButton("Only show FPS when dropping", xpos, ypos, settings_scroll, "as_connectioninfo_fps_warning")
    addSpace( 0, 20 )

    ValueSlider( "Dropping FPS", xpos, ypos, 1, 200, settings_scroll, "as_connectioninfo_fps_warning_amt" )
    addSpace( 0, 20 )

    resetX()

-- ██████╗ ███████╗██████╗ ███████╗ ██████╗ ██████╗ ███╗   ███╗ █████╗ ███╗   ██╗ ██████╗███████╗
-- ██╔══██╗██╔════╝██╔══██╗██╔════╝██╔═══██╗██╔══██╗████╗ ████║██╔══██╗████╗  ██║██╔════╝██╔════╝
-- ██████╔╝█████╗  ██████╔╝█████╗  ██║   ██║██████╔╝██╔████╔██║███████║██╔██╗ ██║██║     █████╗
-- ██╔═══╝ ██╔══╝  ██╔══██╗██╔══╝  ██║   ██║██╔══██╗██║╚██╔╝██║██╔══██║██║╚██╗██║██║     ██╔══╝
-- ██║     ███████╗██║  ██║██║     ╚██████╔╝██║  ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║╚██████╗███████╗
-- ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝

    SectionLabel( "Performance", xpos, ypos, settings_scroll )
    addSpace( 0, 30 )

    ToggleButton("GMod Multi-Core", xpos, ypos, settings_scroll, "gmod_mcore_test")
    addSpace( 0, 20 )

    ValueSlider( "Item Render Distance", xpos, ypos, 100, 4000, settings_scroll, "as_item_renderdist" )
    addSpace( 0, 20 )

    ValueSlider( "Entity Render Distance", xpos, ypos, 500, 8000, settings_scroll, "as_entity_renderdist" )
    addSpace( 0, 20 )

    resetX()

-- ██████╗ ██╗███╗   ██╗██████╗ ███████╗
-- ██╔══██╗██║████╗  ██║██╔══██╗██╔════╝
-- ██████╔╝██║██╔██╗ ██║██║  ██║███████╗
-- ██╔══██╗██║██║╚██╗██║██║  ██║╚════██║
-- ██████╔╝██║██║ ╚████║██████╔╝███████║
-- ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝

    SectionLabel( "Key Binds", xpos, ypos, settings_scroll )
    addSpace( 0, 30 )

    SmallLabel( "Left click the button to start a bind, press any button to\nset the bind. Press 'Escape' to cancel a bind.", xpos, ypos, settings_scroll )
    addSpace( 0, 40 )

    KeyBind( "Inventory", xpos, ypos, settings_scroll, "as_bind_inventory" )
    addSpace( 0, 20 )

    KeyBind( "Skills", xpos, ypos, settings_scroll, "as_bind_skills" )
    addSpace( 0, 20 )

    KeyBind( "Missions", xpos, ypos, settings_scroll, "as_bind_missions" )
    addSpace( 0, 20 )

    KeyBind( "Statistics", xpos, ypos, settings_scroll, "as_bind_stats" )
    addSpace( 0, 20 )

    KeyBind( "Players", xpos, ypos, settings_scroll, "as_bind_players" )
    addSpace( 0, 20 )

    KeyBind( "Classes", xpos, ypos, settings_scroll, "as_bind_class" )
    addSpace( 0, 20 )

    KeyBind( "Crafting", xpos, ypos, settings_scroll, "as_bind_craft" )
    addSpace( 0, 20 )

    KeyBind( "Own/Unown Objects", xpos, ypos, settings_scroll, "as_bind_ownership" )
    addSpace( 0, 20 )

    KeyBind( "Thirdperson", xpos, ypos, settings_scroll, "as_bind_thirdperson" )
    addSpace( 0, 20 )
end