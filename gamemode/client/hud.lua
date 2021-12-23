COLHUD_DEFAULT = nil
COLHUD_GOOD = nil
COLHUD_BAD = nil

-- Enable HUD
CreateClientConVar( "as_hud", "1", true, false )
-- Default Colors
CreateClientConVar( "as_hud_color_default_r", "200", true, false )
CreateClientConVar( "as_hud_color_default_g", "200", true, false )
CreateClientConVar( "as_hud_color_default_b", "200", true, false )
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
-- Health Bar
CreateClientConVar( "as_hud_healthbar", "1", true, false ) --Enable?
CreateClientConVar( "as_hud_healthbar_amount", "1", true, false ) --Enable amount?
CreateClientConVar( "as_hud_healthbar_xadd", "0", true, false ) --X position add
CreateClientConVar( "as_hud_healthbar_yadd", "0", true, false ) --Y position add
CreateClientConVar( "as_hud_healthbar_width", "200", true, false ) --Width
CreateClientConVar( "as_hud_healthbar_height", "20", true, false ) --Height

function AftershockHUD()
    local ply = LocalPlayer()

    if ply:GetNW2Bool("as_spawned", false) == false or not ply:Alive() then return end

    local crosshair = tobool(GetConVar("as_hud_crosshair"):GetInt())
    if crosshair then
        local x, y = ScrW() / 2, ScrH() / 2
        surface.SetDrawColor(Color(0,0,0))
        surface.DrawRect( x, y, 3, 3 )
        surface.DrawRect( x+10, y, 3, 3 )
        surface.DrawRect( x-10, y, 3, 3 )
        surface.DrawRect( x, y+10, 3, 3 )
        surface.DrawRect( x, y-10, 3, 3 )
        surface.SetDrawColor(COLHUD_DEFAULT)
        surface.DrawRect( x, y, 2, 2 )
        surface.DrawRect( x+10, y, 2, 2 )
        surface.DrawRect( x-10, y, 2, 2 )
        surface.DrawRect( x, y+10, 2, 2 )
        surface.DrawRect( x, y-10, 2, 2 )
    end

    local bar = tobool(GetConVar("as_hud_healthbar"):GetInt())
    if bar then
        local health = ply:Health()
        local maxhealth = ply:GetMaxHealth()
        local xpos = GetConVar("as_hud_healthbar_xadd"):GetInt()
        local ypos = GetConVar("as_hud_healthbar_yadd"):GetInt()
        local width = GetConVar("as_hud_healthbar_width"):GetInt()
        local height = GetConVar("as_hud_healthbar_height"):GetInt()
        local barx, bary, width, height, outline = (100 + xpos), (math.Clamp((ScrH() * 0.91) + ypos, 0, ScrH())), (width), (height), (1)
        surface.SetDrawColor(COLHUD_DEFAULT)
        surface.DrawOutlinedRect(barx, bary, width, height, outline) --Health bar outline
        surface.DrawRect(barx + 2, bary + 2, (health / maxhealth) * (width - 4), height - 4) --Health bar

        local amt = tobool(GetConVar("as_hud_healthbar_amount"):GetInt())
        if amt then
            local hp, amtx, amty, outline = (health), (xpos + width + 110), (math.Clamp((ScrH() * 0.928) + ypos, 0, ScrH())), (1)
            draw.SimpleTextOutlined(hp, "AftershockHUD", amtx, amty, COLHUD_DEFAULT, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, outline, Color(0,0,0))
        end
    end
end

function GM:HUDShouldDraw( type )
    local hideHud = {
        ["CHudAmmo"] = true,
        ["CHudBattery"] = true,
        ["CHudCrosshair"] = true,
        ["CHudCloseCaption"] = true,
        ["CHudDamageIndicator"] = true,
        ["CHudGeiger"] = true,
        ["CHudHealth"] = true,
        ["CHudHintDisplay"] = true,
        ["CHudMessage"] = true,
        ["CHudPoisonDamageIndicator"] = true,
        ["CHudSquadStatus"] = true,
        ["CHudTrain"] = true,
        ["CHudVehicle"] = true,
        ["CHudWeapon"] = true,
        ["CHudWeaponSelection"] = true,
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

function GM:HUDPaint()
    COLHUD_DEFAULT = Color(GetConVar("as_hud_color_default_r"):GetInt(), GetConVar("as_hud_color_default_g"):GetInt(), GetConVar("as_hud_color_default_b"):GetInt(), 255)
    COLHUD_GOOD = Color(GetConVar("as_hud_color_good_r"):GetInt(), GetConVar("as_hud_color_good_g"):GetInt(), GetConVar("as_hud_color_good_b"):GetInt(), 255)
    COLHUD_BAD = Color(GetConVar("as_hud_color_bad_r"):GetInt(), GetConVar("as_hud_color_bad_g"):GetInt(), GetConVar("as_hud_color_bad_b"):GetInt(), 255)

    if tobool(GetConVar("as_hud"):GetInt()) then
        AftershockHUD()
    end
end