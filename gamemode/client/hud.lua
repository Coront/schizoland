COLHUD_DEFAULT = nil
COLHUD_GOOD = nil
COLHUD_BAD = nil

-- Enable HUD
CreateClientConVar( "as_hud", "1", true, false )
-- Default Colors
CreateClientConVar( "as_hud_color_default_r", "0", true, false )
CreateClientConVar( "as_hud_color_default_g", "105", true, false )
CreateClientConVar( "as_hud_color_default_b", "185", true, false )
-- Good Colors
CreateClientConVar( "as_hud_color_good_r", "0", true, false )
CreateClientConVar( "as_hud_color_good_g", "145", true, false )
CreateClientConVar( "as_hud_color_good_b", "20", true, false )
-- Bad Colors
CreateClientConVar( "as_hud_color_bad_r", "255", true, false )
CreateClientConVar( "as_hud_color_bad_g", "50", true, false )
CreateClientConVar( "as_hud_color_bad_b", "50", true, false )
-- Crosshair
CreateClientConVar( "as_hud_crosshair", "1", true, false ) --Enable?
CreateClientConVar( "as_hud_crosshair_multidots", "1", true, false ) --Multiple Dots
-- Health Bar
CreateClientConVar( "as_hud_healthbar", "1", true, false ) --Enable?
CreateClientConVar( "as_hud_healthbar_amount", "1", true, false ) --Enable amount?
CreateClientConVar( "as_hud_healthbar_xadd", "0", true, false ) --X position add
CreateClientConVar( "as_hud_healthbar_yadd", "0", true, false ) --Y position add
CreateClientConVar( "as_hud_healthbar_width", "200", true, false ) --Width
CreateClientConVar( "as_hud_healthbar_height", "20", true, false ) --Height
-- Satiation Bars
CreateClientConVar( "as_hud_satiationbars", "1", true, false ) --Enable?
CreateClientConVar( "as_hud_satiationbars_amount", "0", true, false ) --Enable amount?
CreateClientConVar( "as_hud_satiationbars_xadd", "0", true, false ) --X position add
CreateClientConVar( "as_hud_satiationbars_yadd", "0", true, false ) --Y position add
CreateClientConVar( "as_hud_satiationbars_width", "150", true, false ) --Width
CreateClientConVar( "as_hud_satiationbars_height", "10", true, false ) --Height
-- Player Info
CreateClientConVar( "as_hud_playerinfo", "1", true, false )

-- Connection Information
CreateClientConVar( "as_connectioninfo", "1", true, false ) --Show connection information?
CreateClientConVar( "as_connectioninfo_update", "1", true, false ) --How fast should information update?
CreateClientConVar( "as_connectioninfo_ping", "1", true, false ) --Show ping?
CreateClientConVar( "as_connectioninfo_ping_warning", "1", true, false ) --Only show ping when spiking?
CreateClientConVar( "as_connectioninfo_ping_warning_amt", "140", true, false ) --Above what ping is considered spiking?
CreateClientConVar( "as_connectioninfo_fps", "1", true, false ) --Show framerate?
CreateClientConVar( "as_connectioninfo_fps_warning", "1", true, false ) --Only show fps when dropping?
CreateClientConVar( "as_connectioninfo_fps_warning_amt", "40", true, false ) --Below what rate is considered dropping?

function AftershockHUD()
    local ply = LocalPlayer()

    if not ply:IsLoaded() or not ply:Alive() then return end

    local bar = tobool(GetConVar("as_hud_healthbar"):GetInt())
    if bar then
        local health = ply:Health()
        local maxhealth = ply:GetMaxHealth()
        local xpos = GetConVar("as_hud_healthbar_xadd"):GetInt()
        local ypos = GetConVar("as_hud_healthbar_yadd"):GetInt()
        local width = GetConVar("as_hud_healthbar_width"):GetInt()
        local height = GetConVar("as_hud_healthbar_height"):GetInt()
        local barx, bary, width, height, outline = (math.Clamp(100 + xpos, 0, ScrW() - width)), (math.Clamp((ScrH() * 0.91) + ypos, 0, ScrH() - height)), (width), (height), (1)

        surface.SetDrawColor(COLHUD_DEFAULT) --Set color to hud color
        surface.DrawOutlinedRect(barx, bary, width, height, outline) --Health bar outline
        surface.DrawRect(barx + 2, bary + 2, (health / maxhealth) * (width - 4), height - 4) --Health bar

        local amt = tobool(GetConVar("as_hud_healthbar_amount"):GetInt())
        if amt then --Will draw health amount if enabled
            local hp, amtx, amty, outline = (health), (math.Clamp(xpos + width + 110, width + 10, ScrW())), (math.Clamp((ScrH() * 0.928) + ypos, 0, ScrH())), (1)
            draw.SimpleTextOutlined(hp, "AftershockHUD", amtx, amty, COLHUD_DEFAULT, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, outline, Color(0,0,0))
        end
    end

    local satiation = tobool(GetConVar("as_hud_satiationbars"):GetInt())
    if satiation then
        local hunger = ply:GetHunger()
        local thirst = ply:GetThirst()
        local maxhunger = ply:GetMaxHunger()
        local maxthirst = ply:GetMaxThirst()
        local xpos = GetConVar("as_hud_satiationbars_xadd"):GetInt()
        local ypos = GetConVar("as_hud_satiationbars_yadd"):GetInt()
        local width = GetConVar("as_hud_satiationbars_width"):GetInt()
        local height = GetConVar("as_hud_satiationbars_height"):GetInt()
        local barx, bary, width, height, outline = (math.Clamp(100 + xpos, 0, ScrW() - width)), (math.Clamp((ScrH() * 0.91) + ypos + 21, 0, ScrH() - (height * 2) + 1)), (width), (height), (1)

        surface.SetDrawColor(COLHUD_DEFAULT) --Set color to hud color
        --Hunger Bar
        surface.DrawOutlinedRect(barx, bary, width, height, outline) --Hunger bar outline
        surface.DrawRect(barx + 2, bary + 2, (hunger / maxhunger) * (width - 4), height - 4) --Hunger bar
        --Thirst Bar
        bary = bary + (height + 1)
        surface.DrawOutlinedRect(barx, bary, width, height) --Thirst bar outline
        surface.DrawRect( barx + 2, bary + 2, (thirst / maxthirst) * (width - 4), height - 4) --Thirst bar

        local amt = tobool(GetConVar("as_hud_satiationbars_amount"):GetInt())
        if amt then --Will draw satiation amount if enabled
            local hunger, thirst, amtx, amty, outline = (hunger), (thirst), (math.Clamp(xpos + width + 103, width + 10, ScrW())), (math.Clamp((ScrH() * 0.91) + ypos + 30, 0, ScrH())), (1)
            draw.SimpleTextOutlined(hunger, "AftershockHUDVerySmall", amtx, amty, COLHUD_DEFAULT, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, outline, Color(0,0,0))
            amty = amty + 10
            draw.SimpleTextOutlined(thirst, "AftershockHUDVerySmall", amtx, amty, COLHUD_DEFAULT, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, outline, Color(0,0,0))
        end
    end

    local playerinfo = tobool(GetConVar("as_hud_playerinfo"):GetInt())
    if playerinfo then
        for k, v in pairs( player.GetAll() ) do
            if v == LocalPlayer() then continue end --Don't show us to ourself.
            if v:GetPos():Distance(LocalPlayer():GetPos()) > 250 then continue end --Hide people's labels who are far away.
            if not v:IsLoaded() then continue end --Don't show us info of players who are just spawning.
            if not v:Alive() or not IsValid(v) then continue end
            local trace = util.TraceLine( {
                start = LocalPlayer():EyePos(),
                endpos = (v:GetPos() + v:OBBCenter()),
                filter = LocalPlayer(),
                mask = MASK_SOLID,
            } )
            if trace.Entity != v then continue end --Don't show info if we cannot trace the player.

            local pos = (v:GetPos() + v:OBBCenter() + Vector(0, 0, 50)):ToScreen()
            local barx, bary, width, height, outline = pos.x, pos.y, 150, 50, 1
            surface.SetDrawColor(COLHUD_DEFAULT)
            surface.DrawOutlinedRect(barx - (width / 2), bary - (height / 2), width, height, outline) --Info Outline
            local coltbl = COLHUD_DEFAULT:ToTable()
            surface.SetDrawColor( coltbl[1], coltbl[2], coltbl[3], 50 )
            surface.DrawRect((barx - (width / 2)) + outline, (bary - (height / 2)) + outline, width - outline, height - outline) --Info
            local charname, charhealth = v:GetNW2String( "as_name", "unknown" ), v:Health()
            draw.SimpleTextOutlined( charname, "AftershockHUD", barx, bary, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, outline, Color(0,0,0) )
            surface.SetDrawColor( coltbl[1], coltbl[2], coltbl[3], 255 )
            local hpbarx, hpbary, hpbarwidth, hpbarheight = barx - (width / 2), bary + (height / 2), width - 10, 15
            surface.DrawOutlinedRect(hpbarx + 5, hpbary - (hpbarheight + 5), hpbarwidth, hpbarheight, 1)
            surface.DrawRect(hpbarx + 6, hpbary - (hpbarheight + 4), (v:Health() / v:GetMaxHealth()) * hpbarwidth - 2, 14)
        end
    end

    local crosshair = tobool(GetConVar("as_hud_crosshair"):GetInt())
    local weaponcrosshair = tobool(GetConVar("as_hud_crosshair_weaponcrosshair"):GetInt())
    if crosshair and not (weaponcrosshair and LocalPlayer():GetActiveWeapon().Base == "as_basewep" and not LocalPlayer():GetActiveWeapon().DefaultCrosshair) then
        local multidots = tobool(GetConVar("as_hud_crosshair_multidots"):GetInt())
        local x, y = ScrW() / 2, ScrH() / 2
        surface.SetDrawColor(Color(0,0,0))
        surface.DrawRect( x, y, 3, 3 )
        if multidots then
            surface.DrawRect( x+10, y, 3, 3 )
            surface.DrawRect( x-10, y, 3, 3 )
            surface.DrawRect( x, y+10, 3, 3 )
            surface.DrawRect( x, y-10, 3, 3 )
        end
        surface.SetDrawColor(COLHUD_DEFAULT)
        surface.DrawRect( x, y, 2, 2 )
        if multidots then
            surface.DrawRect( x+10, y, 2, 2 )
            surface.DrawRect( x-10, y, 2, 2 )
            surface.DrawRect( x, y+10, 2, 2 )
            surface.DrawRect( x, y-10, 2, 2 )
        end
    end
end

function ConnectionInformation()
    if CurTime() > (NextConnectionUpdate or 0) then
        LastFrameTime = FrameTime()
        LastPing = LocalPlayer():Ping()

        NextConnectionUpdate = CurTime() + GetConVar("as_connectioninfo_update"):GetFloat()
    end

    local ypos = 0
    local function addYspace()
        ypos = ypos + 16
    end
    --Ping
    if tobool(GetConVar("as_connectioninfo_ping"):GetInt()) then
        local ping = LastPing
        if not tobool(GetConVar("as_connectioninfo_ping_warning"):GetInt()) or tobool(GetConVar("as_connectioninfo_ping_warning"):GetInt()) and ping >= GetConVar("as_connectioninfo_ping_warning_amt"):GetInt() then
            local pingicon = Material("icon16/feed.png")
            local pingcolor = ping < GetConVar("as_connectioninfo_ping_warning_amt"):GetInt() and COLHUD_GOOD or COLHUD_BAD
            surface.SetMaterial( pingicon )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawTexturedRect( 1, ypos + 1, 16, 16 )
            draw.SimpleTextOutlined( ping, "TargetID", 20, ypos, pingcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0,0,0) )
            addYspace()
        end
    end
    --FPS
    if tobool(GetConVar("as_connectioninfo_fps"):GetInt()) then
        local fps = math.Round( 1 / (LastFrameTime or 1) )
        if not tobool(GetConVar("as_connectioninfo_fps_warning"):GetInt()) or tobool(GetConVar("as_connectioninfo_fps_warning"):GetInt()) and fps <= GetConVar("as_connectioninfo_fps_warning_amt"):GetInt() then
            local fpsicon = Material("icon16/monitor.png")
            local fpscolor = fps > GetConVar("as_connectioninfo_fps_warning_amt"):GetInt() and COLHUD_GOOD or COLHUD_BAD
            surface.SetMaterial( fpsicon )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawTexturedRect( 1, ypos + 1, 16, 16 )
            draw.SimpleTextOutlined( fps, "TargetID", 20, ypos, fpscolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0,0,0) )
            addYspace()
        end
    end
end

function GM:HUDShouldDraw( type )
    local hideHud = {
        ["CHudAmmo"] = true,
        ["CHudSecondaryAmmo"] = true,
        ["CHudBattery"] = true,
        ["CHudCrosshair"] = true,
        ["CHudCloseCaption"] = true,
        ["CHudDamageIndicator"] = true,
        ["CHudGeiger"] = true,
        ["CHudHealth"] = true,
        ["CHudHintDisplay"] = true,
        ["CHudPoisonDamageIndicator"] = true,
        ["CHudSquadStatus"] = true,
        ["CHudTrain"] = true,
        ["CHudVehicle"] = true,
        ["CHudWeapon"] = true,
        ["CHudZoom"] = true,
        ["CHudQuickInfo"] = true,
        ["CHudSuitPower"] = true,
    }

    if hideHud[type] then return false else return true end
end

function GM:HUDDrawTargetID()
    return false
end

function GM:HUDItemPickedUp()
    return false
end

function GM:ScoreboardShow()
    return false
end

function GM:ScoreboardHide()
    return false
end

function GM:DrawDeathNotice()
    return false 
end

hook.Add( "HUDPaint", "AS_HUD", function()
    COLHUD_DEFAULT = Color(GetConVar("as_hud_color_default_r"):GetInt(), GetConVar("as_hud_color_default_g"):GetInt(), GetConVar("as_hud_color_default_b"):GetInt(), 255)
    COLHUD_GOOD = Color(GetConVar("as_hud_color_good_r"):GetInt(), GetConVar("as_hud_color_good_g"):GetInt(), GetConVar("as_hud_color_good_b"):GetInt(), 255)
    COLHUD_BAD = Color(GetConVar("as_hud_color_bad_r"):GetInt(), GetConVar("as_hud_color_bad_g"):GetInt(), GetConVar("as_hud_color_bad_b"):GetInt(), 255)

    if tobool(GetConVar("as_connectioninfo"):GetInt()) then
        ConnectionInformation()
    end

    if tobool(GetConVar("as_hud"):GetInt()) then
        AftershockHUD()
    end
end)