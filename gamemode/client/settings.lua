AS.Settings = {}

function AS.Settings.Menu()
    if IsValid(frame_settings) then frame_settings:Close() end

    frame_settings = vgui.Create("DFrame")
    frame_settings:SetSize(500, 500)
    frame_settings:Center()
    frame_settings:MakePopup()
    frame_settings:SetTitle( "Settings" )

    settings_scroll = vgui.Create("DScrollPanel", frame_settings)
    settings_scroll:Dock( FILL )

    AS.Settings.BuildOptions()

    function frame_settings:OnClose()
        SettingsOpen = false
    end
end
concommand.Add("as_settings", AS.Settings.Menu)

function AS.Settings.BuildOptions()
    local xpos = 10
    local ypos = 0
    local function addSpace(x, y)
        xpos = (xpos + (x or 0))
        ypos = (ypos + (y or 0)) 
    end
    local function resetX()
        xpos = 10
    end

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

    SectionLabel( "Gameplay", xpos, ypos, settings_scroll )
    addSpace( 0, 35 )

    ToggleButton("Verify certain actions - Example: Destroying Items", xpos, ypos, settings_scroll, "as_gameplay_verify")
    addSpace( 20, 20 )

    resetX()

    SectionLabel( "HUD / VGUI", xpos, ypos, settings_scroll )
    addSpace( 0, 35 )

    ToggleButton("Enable HUD", xpos, ypos, settings_scroll, "as_hud")
    addSpace( 20, 20 )

    ToggleButton("Enable Crosshair", xpos, ypos, settings_scroll, "as_hud_crosshair")
    addSpace( 20, 20 )

    ToggleButton("Multiple Dots Crosshair", xpos, ypos, settings_scroll, "as_hud_crosshair_multidots")
    addSpace( -20, 20 )

    ToggleButton("Enable Player Info", xpos, ypos, settings_scroll, "as_hud_playerinfo")
    addSpace( 0, 20 )

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

    ValueSlider( "Satiation Bars X-Pos", xpos, ypos, -2000, 2000, settings_scroll, "as_hud_satiationbars_xadd" )
    addSpace( 0, 20 )

    ValueSlider( "Satiation Bars Y-Pos", xpos, ypos, -2000, 2000, settings_scroll, "as_hud_satiationbars_yadd" )
    addSpace( 0, 20 )

    ValueSlider( "Satiation Bars Width", xpos, ypos, 5, 2000, settings_scroll, "as_hud_satiationbars_width" )
    addSpace( 0, 20 )

    ValueSlider( "Satiation Bars Height", xpos, ypos, 5, 50, settings_scroll, "as_hud_satiationbars_height" )
    addSpace( -40, 20 )

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

    SectionLabel( "Performance", xpos, ypos, settings_scroll )
    addSpace( 0, 35 )

    ValueSlider( "Item Render Distance", xpos, ypos, 100, 1000, settings_scroll, "as_item_renderdist" )
    addSpace( 0, 20 )
end