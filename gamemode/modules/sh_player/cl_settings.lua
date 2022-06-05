AS.CLSettings = {}

function AS.CLSettings.SetToDefault()
    for k, v in pairs( ConVarDefaults ) do
        RunConsoleCommand( k, v )
    end
end

function AS.CLSettings.Menu()
    if IsValid(frame_settings) then frame_settings:Close() end

    frame_settings = vgui.Create("DFrame")
    frame_settings:SetSize(600, 600)
    frame_settings:Center()
    frame_settings:MakePopup()
    frame_settings:SetTitle( "" )
    frame_settings:ShowCloseButton( false )
    function frame_settings:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetMaterial( Material("gui/aftershock/default.png") )
        surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
        surface.DrawTexturedRect( 0, 0, w, h )
    end

    local cbuttonsize = 18
    local closebutton = CreateCloseButton( frame_settings, cbuttonsize, frame_settings:GetWide() - cbuttonsize - 5, 3 )

    local x, y = 32, 25
    local sheets = CreateSheetPanel( frame_settings, frame_settings:GetWide() - x - 36, frame_settings:GetTall() - y - 35, x, y )

    AddSheet( sheets, "Gameplay", "icon16/controller.png", AS.CLSettings.BuildGameplay( sheets ) )
    AddSheet( sheets, "Audio", "icon16/sound.png", AS.CLSettings.BuildAudio( sheets ) )
    AddSheet( sheets, "Colors", "icon16/color_wheel.png", AS.CLSettings.BuildColors( sheets ) )
    AddSheet( sheets, "GUI", "icon16/application.png", AS.CLSettings.BuildGUI( sheets ) )
    AddSheet( sheets, "HUD", "icon16/monitor.png", AS.CLSettings.BuildHUD( sheets ) )
    AddSheet( sheets, "Performance", "icon16/chart_bar.png", AS.CLSettings.BuildPerformance( sheets ) )
    AddSheet( sheets, "Key Binds", "icon16/keyboard.png", AS.CLSettings.BuildBinds( sheets ) )
    AddSheet( sheets, "Other", "icon16/asterisk_yellow.png", AS.CLSettings.BuildOthers( sheets ) )
    AddSheet( sheets, "Credits", "icon16/group.png", AS.CLSettings.BuildCredits( sheets ) )

    function frame_settings:OnClose()
        SettingsOpen = false
    end
end
concommand.Add("as_settings", AS.CLSettings.Menu)

function AS.CLSettings.BuildGameplay( parent )
    local scroll = vgui.Create("DScrollPanel", parent)
    scroll:SetPos( 27, 21 )
    scroll:SetSize( parent:GetWide() - (scroll:GetX() * 2) - 3, parent:GetTall() - (scroll:GetY() * 2) - 8 )

    local xpos = 0
    local ypos = 5
    local function addSpace(x, y)
        xpos = (xpos + (x or 0))
        ypos = (ypos + (y or 0)) 
    end
    local function resetX()
        xpos = 3
    end

    -- General

    SectionLabel( "General", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ToggleButton("Prompt Irreversible Actions (Example: Verification for salvaging an item)", xpos, ypos, scroll, "as_gameplay_verify")
    addSpace( 0, 20 )

    -- Low Health Indication

    SectionLabel( "Low Health Indication", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ToggleButton("Enable Low Health Indication", xpos, ypos, scroll, "as_hud_injured")
    addSpace( 20, 20 )

    ValueSlider( "Awake at Health Amt (%)", xpos, ypos, 1, 99, scroll, "as_hud_injured_wake" )
    addSpace( -20, 20 )

    -- Thirdperson

    SectionLabel( "Thirdperson", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ToggleButton("Firstperson when ADS", xpos, ypos, scroll, "as_thirdperson_fpads")
    addSpace( 0, 20 )

    ValueSlider( "Camera - Back", xpos, ypos, 5, 150, scroll, "as_thirdperson_distance" )
    addSpace( 0, 20 )

    ValueSlider( "Camera - Up", xpos, ypos, -10, 20, scroll, "as_thirdperson_up" )
    addSpace( 0, 20 )

    ValueSlider( "Camera - Side", xpos, ypos, -30, 30, scroll, "as_thirdperson_side" )
    addSpace( 0, 20 )

    return scroll
end

function AS.CLSettings.BuildAudio( parent )
    local scroll = vgui.Create("DScrollPanel", parent)
    scroll:SetPos( 27, 21 )
    scroll:SetSize( parent:GetWide() - (scroll:GetX() * 2) - 3, parent:GetTall() - (scroll:GetY() * 2) - 8 )

    local xpos = 0
    local ypos = 5
    local function addSpace(x, y)
        xpos = (xpos + (x or 0))
        ypos = (ypos + (y or 0)) 
    end
    local function resetX()
        xpos = 3
    end

    -- General

    SectionLabel( "General", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ToggleButton("Loot Container Sounds", xpos, ypos, scroll, "as_container_sounds")
    addSpace( 0, 20 )

    ToggleButton("Play Music on Death", xpos, ypos, scroll, "as_gameplay_deathstinger")
    addSpace( 0, 20 )

    -- Low Health Indication

    SectionLabel( "Low Health Indication", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ToggleButton("Heartbeat Sounds", xpos, ypos, scroll, "as_hud_injured_heartbeat")
    addSpace( 0, 20 )

    return scroll
end

function AS.CLSettings.BuildColors( parent )
    local scroll = vgui.Create("DScrollPanel", parent)
    scroll:SetPos( 27, 21 )
    scroll:SetSize( parent:GetWide() - (scroll:GetX() * 2) - 3, parent:GetTall() - (scroll:GetY() * 2) - 8 )

    local xpos = 0
    local ypos = 5
    local function addSpace(x, y)
        xpos = (xpos + (x or 0))
        ypos = (ypos + (y or 0)) 
    end
    local function resetX()
        xpos = 3
    end

    SectionLabel( "Default / HUD", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ValueSlider( "Red", xpos, ypos, 0, 255, scroll, "as_hud_color_default_r", "default" )
    addSpace( 0, 20 )

    ValueSlider( "Green", xpos, ypos, 0, 255, scroll, "as_hud_color_default_g", "default" )
    addSpace( 0, 20 )

    ValueSlider( "Blue", xpos, ypos, 0, 255, scroll, "as_hud_color_default_b", "default" )
    addSpace( 0, 20 )

    SectionLabel( "Good Indication", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ValueSlider( "Red", xpos, ypos, 0, 255, scroll, "as_hud_color_good_r", "good" )
    addSpace( 0, 20 )

    ValueSlider( "Green", xpos, ypos, 0, 255, scroll, "as_hud_color_good_g", "good" )
    addSpace( 0, 20 )

    ValueSlider( "Blue", xpos, ypos, 0, 255, scroll, "as_hud_color_good_b", "good" )
    addSpace( 0, 20 )

    SectionLabel( "Bad Indication", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ValueSlider( "Red", xpos, ypos, 0, 255, scroll, "as_hud_color_bad_r", "bad" )
    addSpace( 0, 20 )

    ValueSlider( "Green", xpos, ypos, 0, 255, scroll, "as_hud_color_bad_g", "bad" )
    addSpace( 0, 20 )

    ValueSlider( "Blue", xpos, ypos, 0, 255, scroll, "as_hud_color_bad_b", "bad" )
    addSpace( 0, 20 )

    return scroll
end

function AS.CLSettings.BuildGUI( parent )
    local scroll = vgui.Create("DScrollPanel", parent)
    scroll:SetPos( 27, 21 )
    scroll:SetSize( parent:GetWide() - (scroll:GetX() * 2) - 3, parent:GetTall() - (scroll:GetY() * 2) - 8 )

    local xpos = 0
    local ypos = 5
    local function addSpace(x, y)
        xpos = (xpos + (x or 0))
        ypos = (ypos + (y or 0)) 
    end
    local function resetX()
        xpos = 3
    end

    SectionLabel( "Inventory", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ToggleButton("Hold To Open", xpos, ypos, scroll, "as_menu_inventory_holdtoopen")
    addSpace( 0, 20 )

    ToggleButton("No Item Categorization", xpos, ypos, scroll, "as_menu_inventory_singlepanel")
    addSpace( 0, 20 )

    return scroll
end

function AS.CLSettings.BuildHUD( parent )
    local scroll = vgui.Create("DScrollPanel", parent)
    scroll:SetPos( 27, 21 )
    scroll:SetSize( parent:GetWide() - (scroll:GetX() * 2) - 3, parent:GetTall() - (scroll:GetY() * 2) - 8 )

    local xpos = 0
    local ypos = 5
    local function addSpace(x, y)
        xpos = (xpos + (x or 0))
        ypos = (ypos + (y or 0)) 
    end
    local function resetX()
        xpos = 3
    end

    SectionLabel( "Gameplay HUD", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ToggleButton( "Enable HUD", xpos, ypos, scroll, "as_hud")
    addSpace( 0, 20 )

    ValueSlider( "HUD Scale", xpos, ypos, 0.6, 2.5, scroll, "as_hud_scale", nil, true )
    addSpace( 20, 20 )

    SectionLabel( "Health Bar", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ToggleButton("Enable Health Bar", xpos, ypos, scroll, "as_hud_healthbar")
    addSpace( 20, 20 )

    ToggleButton("Enable Health Bar Amounts", xpos, ypos, scroll, "as_hud_healthbar_amount")
    addSpace( 0, 20 )

    ValueSlider( "Health Bar X-Pos", xpos, ypos, -2000, 2000, scroll, "as_hud_healthbar_xadd" )
    addSpace( 0, 20 )

    ValueSlider( "Health Bar Y-Pos", xpos, ypos, -2000, 2000, scroll, "as_hud_healthbar_yadd" )
    addSpace( 0, 20 )

    ValueSlider( "Health Bar Width", xpos, ypos, 5, 2000, scroll, "as_hud_healthbar_width" )
    addSpace( 0, 20 )

    ValueSlider( "Health Bar Height", xpos, ypos, 5, 50, scroll, "as_hud_healthbar_height" )
    addSpace( -20, 20 )

    SectionLabel( "Satiation Bars", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ToggleButton("Enable Satiation Bars", xpos, ypos, scroll, "as_hud_satiationbars")
    addSpace( 20, 20 )

    ToggleButton("Only Show When Needed", xpos, ypos, scroll, "as_hud_satiationbars_showwhenneeded")
    addSpace( 0, 20 )

    ToggleButton("Enable Satiation Bars Amount", xpos, ypos, scroll, "as_hud_satiationbars_amount")
    addSpace( 0, 20 )

    ToggleButton("Show Satiated Indicator", xpos, ypos, scroll, "as_hud_satiationbars_showindic")
    addSpace( 0, 20 )

    ValueSlider( "Satiation Bars X-Pos", xpos, ypos, -2000, 2000, scroll, "as_hud_satiationbars_xadd" )
    addSpace( 0, 20 )

    ValueSlider( "Satiation Bars Y-Pos", xpos, ypos, -2000, 2000, scroll, "as_hud_satiationbars_yadd" )
    addSpace( 0, 20 )

    ValueSlider( "Satiation Bars Width", xpos, ypos, 5, 2000, scroll, "as_hud_satiationbars_width" )
    addSpace( 0, 20 )

    ValueSlider( "Satiation Bars Height", xpos, ypos, 5, 50, scroll, "as_hud_satiationbars_height" )
    addSpace( -20, 20 )

    SectionLabel( "Status Effects", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ToggleButton("Enable Effects", xpos, ypos, scroll, "as_hud_effects")
    addSpace( 20, 20 )

    ToggleButton("Enable Effects Amounts", xpos, ypos, scroll, "as_hud_effects_amount")
    addSpace( 0, 20 )

    ValueSlider( "Effects X-Pos", xpos, ypos, -2000, 2000, scroll, "as_hud_effects_xadd" )
    addSpace( 0, 20 )

    ValueSlider( "Effects Y-Pos", xpos, ypos, -2000, 2000, scroll, "as_hud_effects_yadd" )
    addSpace( 0, 20 )

    ValueSlider( "Effects Icon Size", xpos, ypos, 16, 32, scroll, "as_hud_effects_iconsize" )
    addSpace( 0, 20 )

    ValueSlider( "Effects Bar Width", xpos, ypos, 5, 2000, scroll, "as_hud_effects_width" )
    addSpace( 0, 20 )

    ValueSlider( "Effects Bar Height", xpos, ypos, 5, 50, scroll, "as_hud_effects_height" )
    addSpace( 0, 20 )

    ValueSlider( "Y Spacing Between Effects", xpos, ypos, 0, 15, scroll, "as_hud_effects_barspacing" )
    addSpace( -20, 20 )

    SectionLabel( "Resource Display", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ToggleButton("Enable Resource Count", xpos, ypos, scroll, "as_hud_resources")
    addSpace( 20, 20 )

    ValueSlider("Resource X-Pos", xpos, ypos, -2000, 2000, scroll, "as_hud_resources_xadd")
    addSpace( 0, 20 )

    ValueSlider("Resource Y-Pos", xpos, ypos, -2000, 2000, scroll, "as_hud_resources_yadd")
    addSpace( -20, 20 )

    SectionLabel( "Target Information", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ToggleButton( "Enable Target Info", xpos, ypos, scroll, "as_hud_targetinfo" )
    addSpace( 20, 20 )

    ToggleButton( "Enable Target Info Amounts", xpos, ypos, scroll, "as_hud_targetinfo_amount" )
    addSpace( 0, 20 )

    ValueSlider( "Target Info X-Pos", xpos, ypos, -2000, 2000, scroll, "as_hud_targetinfo_xadd" )
    addSpace( 0, 20 )

    ValueSlider( "Target Info Y-Pos", xpos, ypos, -2000, 2000, scroll, "as_hud_targetinfo_yadd" )
    addSpace( 0, 20 )

    ValueSlider( "Target Info Width", xpos, ypos, 5, 2000, scroll, "as_hud_targetinfo_width" )
    addSpace( 0, 20 )

    ValueSlider( "Target Info Height", xpos, ypos, 5, 50, scroll, "as_hud_targetinfo_height" )
    addSpace( -20, 20 )

    SectionLabel( "Combat Warning", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ToggleButton( "Enable Combat Warning", xpos, ypos, scroll, "as_hud_stress" )
    addSpace( 20, 20 )

    ValueSlider( "Combat Warning X-Pos", xpos, ypos, -2000, 2000, scroll, "as_hud_stress_xadd" )
    addSpace( 0, 20 )

    ValueSlider( "Combat Warning Y-Pos", xpos, ypos, -2000, 2000, scroll, "as_hud_stress_yadd" )
    addSpace( -20, 20 )

    SectionLabel( "Timer Bars", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ToggleButton("Enable Timer Bars", xpos, ypos, scroll, "as_hud_timeevent")
    addSpace( 20, 20 )

    ToggleButton("Show Timer Bar Percent", xpos, ypos, scroll, "as_hud_timeevent_percent")
    addSpace( 0, 20 )

    resetX()

    SectionLabel( "Connection Information", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ToggleButton("Enable Connection Information", xpos, ypos, scroll, "as_connectioninfo")
    addSpace( 20, 20 )

    ValueSlider( "Update Rate", xpos, ypos, 0, 3, scroll, "as_connectioninfo_update", nil, true )
    addSpace( 0, 20 )

    ToggleButton("Show Ping", xpos, ypos, scroll, "as_connectioninfo_ping")
    addSpace( 20, 20 )

    ToggleButton("Only show Ping when spiking", xpos, ypos, scroll, "as_connectioninfo_ping_warning")
    addSpace( 0, 20 )

    ValueSlider( "Spiking Ping", xpos, ypos, 30, 400, scroll, "as_connectioninfo_ping_warning_amt" )
    addSpace( -20, 20 )

    ToggleButton("Show FPS", xpos, ypos, scroll, "as_connectioninfo_fps")
    addSpace( 20, 20 )

    ToggleButton("Only show FPS when dropping", xpos, ypos, scroll, "as_connectioninfo_fps_warning")
    addSpace( 0, 20 )

    ValueSlider( "Dropping FPS", xpos, ypos, 1, 200, scroll, "as_connectioninfo_fps_warning_amt" )
    addSpace( 0, 20 )

    return scroll
end

function AS.CLSettings.BuildPerformance( parent )
    local scroll = vgui.Create("DScrollPanel", parent)
    scroll:SetPos( 27, 21 )
    scroll:SetSize( parent:GetWide() - (scroll:GetX() * 2) - 3, parent:GetTall() - (scroll:GetY() * 2) - 8 )

    local xpos = 0
    local ypos = 5
    local function addSpace(x, y)
        xpos = (xpos + (x or 0))
        ypos = (ypos + (y or 0)) 
    end
    local function resetX()
        xpos = 3
    end

    SectionLabel( "General", xpos, ypos, scroll )
    addSpace( 0, 35 )

    ToggleButton("GMod Multi-Core", xpos, ypos, scroll, "gmod_mcore_test")
    addSpace( 0, 20 )

    ToggleButton("Draw 3D Skybox", xpos, ypos, scroll, "r_3dsky")
    addSpace( 0, 20 )

    ToggleButton("Draw NPC Guns", xpos, ypos, scroll, "asnpc_drawing_guns")
    addSpace( 0, 20 )

    ValueSlider( "LOD Quality ( > = Worse )", xpos, ypos, -1, 2, scroll, "r_lod" )
    addSpace( 0, 20 )

    ValueSlider( "Item Render Distance", xpos, ypos, 100, 4000, scroll, "as_item_renderdist" )
    addSpace( 0, 20 )

    ValueSlider( "Entity Render Distance", xpos, ypos, 500, 8000, scroll, "as_entity_renderdist" )
    addSpace( 0, 20 )

    return scroll
end

function AS.CLSettings.BuildBinds( parent )
    local scroll = vgui.Create("DScrollPanel", parent)
    scroll:SetPos( 27, 21 )
    scroll:SetSize( parent:GetWide() - (scroll:GetX() * 2) - 3, parent:GetTall() - (scroll:GetY() * 2) - 8 )

    local xpos = 0
    local ypos = 5
    local function addSpace(x, y)
        xpos = (xpos + (x or 0))
        ypos = (ypos + (y or 0)) 
    end
    local function resetX()
        xpos = 3
    end

    SmallLabel( "Left click the button to start a bind, press any button to\nset the bind. Press 'Escape' to cancel a bind.", xpos, ypos, scroll )
    addSpace( 0, 40 )

    KeyBind( "Inventory", xpos, ypos, scroll, "as_bind_inventory" )
    addSpace( 0, 20 )

    KeyBind( "Skills", xpos, ypos, scroll, "as_bind_skills" )
    addSpace( 0, 20 )

    KeyBind( "Statistics", xpos, ypos, scroll, "as_bind_stats" )
    addSpace( 0, 20 )

    KeyBind( "Players", xpos, ypos, scroll, "as_bind_players" )
    addSpace( 0, 20 )

    KeyBind( "Classes", xpos, ypos, scroll, "as_bind_class" )
    addSpace( 0, 20 )

    KeyBind( "Crafting", xpos, ypos, scroll, "as_bind_craft" )
    addSpace( 0, 20 )

    KeyBind( "Own/Unown Objects", xpos, ypos, scroll, "as_bind_ownership" )
    addSpace( 0, 20 )

    KeyBind( "Thirdperson", xpos, ypos, scroll, "as_bind_thirdperson" )
    addSpace( 0, 20 )

    return scroll
end

function AS.CLSettings.BuildOthers( parent )
    local scroll = vgui.Create("DScrollPanel", parent)
    scroll:SetPos( 27, 21 )
    scroll:SetSize( parent:GetWide() - (scroll:GetX() * 2) - 3, parent:GetTall() - (scroll:GetY() * 2) - 8 )

    local xpos = 0
    local ypos = 5
    local function addSpace(x, y)
        xpos = (xpos + (x or 0))
        ypos = (ypos + (y or 0)) 
    end
    local function resetX()
        xpos = 0
    end

    DefaultButton( "Reset All Settings", xpos, ypos, 515, 25, scroll, function()
        Verify( function()
            AS.CLSettings.SetToDefault()
        end, true)
    end)
    addSpace( 0, 20 )

    return scroll
end

function AS.CLSettings.BuildCredits( parent )
    local scroll = vgui.Create("DScrollPanel", parent)
    scroll:SetPos( 27, 21 )
    scroll:SetSize( parent:GetWide() - (scroll:GetX() * 2) - 3, parent:GetTall() - (scroll:GetY() * 2) - 8 )

    local xpos = 0
    local ypos = 5
    local function addSpace(x, y)
        xpos = (xpos + (x or 0))
        ypos = (ypos + (y or 0)) 
    end
    local function resetX()
        xpos = 0
    end

    SectionLabel( "Aftershock Credits", xpos, ypos, scroll )
    addSpace( 0, 30 )

    for k, v in SortedPairs( SET.Credits ) do
        DefaultButton( "*", xpos, ypos, 20, 20, scroll, function()
            gui.OpenURL( v.profile )
        end)
        addSpace( 22, 0 )
        SmallLabel( v.player, xpos, ypos, scroll )
        addSpace( -22, 22 )
    end

    return scroll
end