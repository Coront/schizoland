AS.Settings = {}

SettingsOpen = false

function AS.Settings.Menu()
    if SettingsOpen then return end
    SettingsOpen = true

    frame_settings = vgui.Create("DFrame")
    frame_settings:SetSize(500, 500)
    frame_settings:Center()
    frame_settings:MakePopup()
    frame_settings:SetTitle( "Settings" )

    local scroll = vgui.Create("DScrollPanel", frame_settings)
    scroll:Dock( FILL )

    AS.Settings.BuildOptions()

    function frame_settings:OnClose()
        SettingsOpen = false
    end
end
concommand.Add("as_settings", AS.Settings.Menu)

function AS.Settings.BuildOptions()
    local xpos = 10
    local ypos = 30
    local function addSpace(x, y)
        xpos = (xpos + (x or 0))
        ypos = (ypos + (y or 0)) 
    end
    local function resetX()
        xpos = 10
    end

    SectionLabel( "Colors", xpos, ypos, frame_settings )
    addSpace( 0, 35 )

    ValueSlider( "Default - Red", xpos, ypos, 0, 255, frame_settings, "as_hud_color_default_r", "default" )
    addSpace( 0, 20 )

    ValueSlider( "Default - Green", xpos, ypos, 0, 255, frame_settings, "as_hud_color_default_g", "default" )
    addSpace( 0, 20 )

    ValueSlider( "Default - Blue", xpos, ypos, 0, 255, frame_settings, "as_hud_color_default_b", "default" )
    addSpace( 0, 30 )

    ValueSlider( "Good - Red", xpos, ypos, 0, 255, frame_settings, "as_hud_color_good_r", "good" )
    addSpace( 0, 20 )

    ValueSlider( "Good - Green", xpos, ypos, 0, 255, frame_settings, "as_hud_color_good_g", "good" )
    addSpace( 0, 20 )

    ValueSlider( "Good - Blue", xpos, ypos, 0, 255, frame_settings, "as_hud_color_good_b", "good" )
    addSpace( 0, 30 )

    ValueSlider( "Bad - Red", xpos, ypos, 0, 255, frame_settings, "as_hud_color_bad_r", "bad" )
    addSpace( 0, 20 )

    ValueSlider( "Bad - Green", xpos, ypos, 0, 255, frame_settings, "as_hud_color_bad_g", "bad" )
    addSpace( 0, 20 )

    ValueSlider( "Bad - Blue", xpos, ypos, 0, 255, frame_settings, "as_hud_color_bad_b", "bad" )
    addSpace( 0, 20 )

    resetX()

    SectionLabel( "HUD / VGUI", xpos, ypos, frame_settings )
    addSpace( 0, 35 )

    ToggleButton("Enable HUD", xpos, ypos, frame_settings, "as_hud")
    addSpace( 20, 20 )

    ToggleButton("Enable Crosshair", xpos, ypos, frame_settings, "as_hud_crosshair")
    addSpace( 0, 20 )

    ToggleButton("Enable Healthbar", xpos, ypos, frame_settings, "as_hud_healthbar")
    addSpace( 20, 20 )

    ToggleButton("Enable Healthbar Amounts", xpos, ypos, frame_settings, "as_hud_healthbar_amount")
    addSpace( 20, 20 )

    ValueSlider( "Healthbar X-Pos", xpos, ypos, -2000, 2000, frame_settings, "as_hud_healthbar_xadd" )
    addSpace( 0, 20 )

    ValueSlider( "Healthbar Y-Pos", xpos, ypos, -2000, 2000, frame_settings, "as_hud_healthbar_yadd" )
    addSpace( 0, 20 )

    ValueSlider( "Healthbar Width", xpos, ypos, 5, 2000, frame_settings, "as_hud_healthbar_width" )
    addSpace( 0, 20 )

    ValueSlider( "Healthbar Height", xpos, ypos, 5, 50, frame_settings, "as_hud_healthbar_height" )
    addSpace( 0, 20 )
end