COLHUD_DEFAULT = nil
COLHUD_COMMUNITY = nil
COLHUD_GOOD = nil
COLHUD_BAD = nil
HUD_SCALE = 1
HUD_TALKINGPLAYERS = HUD_TALKINGPLAYERS or {}
HUD_TALKINGPLAYERSPANELS = HUD_TALKINGPLAYERSPANELS or {}
CommunityAllies = CommunityAllies or {}
CommunityWars = CommunityWars or {}

-- Enable HUD
AS_ClientConVar( "as_hud", "1", true, false )
-- Scaling
AS_ClientConVar( "as_hud_scale", "1.0", true, false )
-- Default Colors
AS_ClientConVar( "as_hud_color_default_r", "0", true, false )
AS_ClientConVar( "as_hud_color_default_g", "105", true, false )
AS_ClientConVar( "as_hud_color_default_b", "185", true, false )
-- Community Colors
AS_ClientConVar( "as_hud_color_community_r", "0", true, false )
AS_ClientConVar( "as_hud_color_community_g", "205", true, false )
AS_ClientConVar( "as_hud_color_community_b", "255", true, false )
-- Good Colors
AS_ClientConVar( "as_hud_color_good_r", "0", true, false )
AS_ClientConVar( "as_hud_color_good_g", "145", true, false )
AS_ClientConVar( "as_hud_color_good_b", "20", true, false )
-- Bad Colors
AS_ClientConVar( "as_hud_color_bad_r", "255", true, false )
AS_ClientConVar( "as_hud_color_bad_g", "50", true, false )
AS_ClientConVar( "as_hud_color_bad_b", "50", true, false )
-- Health Bar
AS_ClientConVar( "as_hud_healthbar", "1", true, false ) --Enable?
AS_ClientConVar( "as_hud_healthbar_amount", "0", true, false ) --Enable amount?
AS_ClientConVar( "as_hud_healthbar_xadd", "0", true, false ) --X position add
AS_ClientConVar( "as_hud_healthbar_yadd", "0", true, false ) --Y position add
AS_ClientConVar( "as_hud_healthbar_width", "200", true, false ) --Width
AS_ClientConVar( "as_hud_healthbar_height", "15", true, false ) --Height
-- Satiation Bars
AS_ClientConVar( "as_hud_satiationbars", "1", true, false ) --Enable?
AS_ClientConVar( "as_hud_satiationbars_amount", "0", true, false ) --Enable amount?
AS_ClientConVar( "as_hud_satiationbars_xadd", "0", true, false ) --X position add
AS_ClientConVar( "as_hud_satiationbars_yadd", "0", true, false ) --Y position add
AS_ClientConVar( "as_hud_satiationbars_width", "100", true, false ) --Width
AS_ClientConVar( "as_hud_satiationbars_height", "10", true, false ) --Height
AS_ClientConVar( "as_hud_satiationbars_showwhenneeded", "1", true, false ) --Show only hunger or thirst needed?
AS_ClientConVar( "as_hud_satiationbars_showindic", "1", true, false )
-- Toxication Bar
AS_ClientConVar( "as_hud_toxicationbar", "1", true, false ) --Enable?
AS_ClientConVar( "as_hud_toxicationbar_amount", "0", true, false ) --Enable amount?
AS_ClientConVar( "as_hud_toxicationbar_xadd", "0", true, false ) --X position add
AS_ClientConVar( "as_hud_toxicationbar_yadd", "0", true, false ) --Y position add
AS_ClientConVar( "as_hud_toxicationbar_width", "350", true, false ) --Width
AS_ClientConVar( "as_hud_toxicationbar_height", "15", true, false ) --Height
AS_ClientConVar( "as_hud_toxicationbar_showwhenneeded", "1", true, false ) --Show only when needed?
-- Effects
AS_ClientConVar( "as_hud_effects", "1", true, false ) --Enable
AS_ClientConVar( "as_hud_effects_amount", "0", true, false ) --Enable amount
AS_ClientConVar( "as_hud_effects_xadd", "0", true, false ) --X position add
AS_ClientConVar( "as_hud_effects_yadd", "0", true, false ) --Y position add
AS_ClientConVar( "as_hud_effects_iconsize", "24", true, false ) --Icon Size
AS_ClientConVar( "as_hud_effects_width", "150", true, false ) --Width
AS_ClientConVar( "as_hud_effects_height", "10", true, false ) --Height
AS_ClientConVar( "as_hud_effects_barspacing", "3", true, false ) --Spacing between bars
-- Resources
AS_ClientConVar( "as_hud_resources", "1", true, false ) --Enable?
AS_ClientConVar( "as_hud_resources_xadd", "0", true, false ) --X position add
AS_ClientConVar( "as_hud_resources_yadd", "0", true, false ) --Y position add
-- Target Info
AS_ClientConVar( "as_hud_targetinfo", "1", true, false )
AS_ClientConVar( "as_hud_targetinfo_amount", "1", true, false )
AS_ClientConVar( "as_hud_targetinfo_xadd", "0", true, false )
AS_ClientConVar( "as_hud_targetinfo_yadd", "0", true, false )
AS_ClientConVar( "as_hud_targetinfo_width", "150", true, false )
AS_ClientConVar( "as_hud_targetinfo_height", "20", true, false )
-- Mission Info
AS_ClientConVar( "as_hud_missioninfo", "1", true, false )
AS_ClientConVar( "as_hud_missioninfo_amount", "1", true, false )
AS_ClientConVar( "as_hud_missioninfo_xadd", "0", true, false )
AS_ClientConVar( "as_hud_missioninfo_yadd", "0", true, false )
AS_ClientConVar( "as_hud_missioninfo_width", "250", true, false )
AS_ClientConVar( "as_hud_missioninfo_height", "15", true, false )
AS_ClientConVar( "as_hud_missioninfo_barspacing", "5", true, false )
-- Ownership Info
AS_ClientConVar( "as_hud_ownership", "1", true, false )
-- Stress
AS_ClientConVar( "as_hud_stress", "1", true, false )
AS_ClientConVar( "as_hud_stress_xadd", "0", true, false )
AS_ClientConVar( "as_hud_stress_yadd", "0", true, false )
-- Injured Indication
AS_ClientConVar( "as_hud_injured", "1", true, false )
AS_ClientConVar( "as_hud_injured_heartbeat", "1", true, false )
AS_ClientConVar( "as_hud_injured_wake", "40", true, false ) --Percentage of health the player needs to be below for the injured hud to awake.

-- Connection Information
AS_ClientConVar( "as_connectioninfo", "1", true, false ) --Show connection information?
AS_ClientConVar( "as_connectioninfo_update", "1", true, false ) --How fast should information update?
AS_ClientConVar( "as_connectioninfo_ping", "1", true, false ) --Show ping?
AS_ClientConVar( "as_connectioninfo_ping_warning", "1", true, false ) --Only show ping when spiking?
AS_ClientConVar( "as_connectioninfo_ping_warning_amt", "140", true, false ) --Above what ping is considered spiking?
AS_ClientConVar( "as_connectioninfo_fps", "1", true, false ) --Show framerate?
AS_ClientConVar( "as_connectioninfo_fps_warning", "1", true, false ) --Only show fps when dropping?
AS_ClientConVar( "as_connectioninfo_fps_warning_amt", "40", true, false ) --Below what rate is considered dropping?

function AftershockHUD()
    local ply = LocalPlayer()

    if not ply:IsLoaded() then return end
    if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "gmod_camera" then return end
    if not ply:Alive() then AftershockHUDDeath() return end
    AftershockHUDVoice()
    AftershockHUDInjured()

    local bar = tobool(GetConVar("as_hud_healthbar"):GetInt())
    if bar then
        local health = ply:Health()
        local maxhealth = ply:GetMaxHealth()
        local xpos = GetConVar("as_hud_healthbar_xadd"):GetInt()
        local ypos = GetConVar("as_hud_healthbar_yadd"):GetInt()
        local width = GetConVar("as_hud_healthbar_width"):GetInt() * HUD_SCALE
        local height = GetConVar("as_hud_healthbar_height"):GetInt() * HUD_SCALE
        local barx, bary, width, height, outline = (xpos + (100)), ((ypos - height) + (ScrH() * 0.92)), (width), (height), (1)

        draw.SimpleTextOutlined("HP", "AftershockHUD", barx, bary + (height / 2) - (2 * HUD_SCALE), COLHUD_DEFAULT, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, outline, Color(0,0,0))
        barx = barx + (35 * HUD_SCALE)

        surface.SetDrawColor(COLHUD_DEFAULT) --Set color to hud color
        surface.DrawOutlinedRect(barx, bary, width, height, outline) --Health bar outline
        surface.DrawRect(barx + 2, bary + 2, (health / maxhealth) * (width - 4), height - 4) --Health bar

        local hp, amtx, amty, outline = (health), ((width + barx) + (5)), bary + (height / 2) - (2 * HUD_SCALE), (1)
        if ply.Devmode then
            surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
            surface.SetMaterial( Material( "icon16/shield.png" ) )
            surface.DrawTexturedRect( barx + width + 4, bary, height, height )
            amtx = amtx + height
        end

        local amt = tobool(GetConVar("as_hud_healthbar_amount"):GetInt())
        if amt then --Will draw health amount if enabled
            draw.SimpleTextOutlined(hp, "AftershockHUD", amtx, amty, COLHUD_DEFAULT, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, outline, Color(0,0,0))
        end

    end

    local satiation = tobool(GetConVar("as_hud_satiationbars"):GetInt())
    if satiation then
        local hunger = ply:GetHunger()
        local thirst = ply:GetThirst()
        local maxhunger = ply:GetMaxHunger()
        local maxthirst = ply:GetMaxThirst()
        local showwhenneeded = tobool(GetConVar("as_hud_satiationbars_showwhenneeded"):GetInt())
        local xpos = GetConVar("as_hud_satiationbars_xadd"):GetInt()
        local ypos = GetConVar("as_hud_satiationbars_yadd"):GetInt()
        local width = GetConVar("as_hud_satiationbars_width"):GetInt() * HUD_SCALE
        local height = GetConVar("as_hud_satiationbars_height"):GetInt() * HUD_SCALE
        local iconsize = 10
        local barx, bary, width, height, outline = (xpos + (100) + ((35 - iconsize - 2) * HUD_SCALE)), (ypos + (ScrH() * 0.922)), (width), (height), (1)
        local col = COLHUD_DEFAULT:ToTable()
        local colgood = COLHUD_GOOD:ToTable()

        Hunger_Alpha = Hunger_Alpha or 0
        Thirst_Alpha = Thirst_Alpha or 0
        if not showwhenneeded or showwhenneeded and hunger < SAT.SatBuffs then
            Hunger_Alpha = math.Approach( Hunger_Alpha, 255, FrameTime() * 400 )
        else
            Hunger_Alpha = math.Approach( Hunger_Alpha, 0, FrameTime() * -400 )
        end
        if not showwhenneeded or showwhenneeded and thirst < SAT.SatBuffs then
            Thirst_Alpha = math.Approach( Thirst_Alpha, 255, FrameTime() * 400 )
        else
            Thirst_Alpha = math.Approach( Thirst_Alpha, 0, FrameTime() * -400 )
        end

        if Hunger_Alpha > 0 then
            --Hunger Bar
            surface.SetDrawColor( Color( 255, 255, 255, Hunger_Alpha ) )
            surface.SetMaterial( Material( "icon16/cup.png" ) )
            surface.DrawTexturedRect( barx, bary, iconsize * HUD_SCALE, iconsize * HUD_SCALE )
            barx = barx + (12 * HUD_SCALE)
            surface.SetDrawColor( Color( col[1], col[2], col[3], Hunger_Alpha ) ) --Set color to hud color
            surface.DrawOutlinedRect(barx, bary, width, height, outline) --Hunger bar outline
            surface.DrawRect(barx + 2, bary + 2, (hunger / maxhunger) * (width - 4), height - 4) --Hunger bar
            --Buff Pos
            if tobool(GetConVar("as_hud_satiationbars_showindic"):GetInt()) then
                surface.SetDrawColor( Color( colgood[1], colgood[2], colgood[3], Hunger_Alpha ) )
                surface.DrawRect( (barx - 1) + ((width / maxhunger) * SAT.SatBuffs), bary + 1, 1, height - 2)
            end
            barx = barx - (12 * HUD_SCALE)
            bary = bary + (height + 1)
        end
        if Thirst_Alpha > 0 then
            --Thirst Bar
            surface.SetDrawColor( Color( 255, 255, 255, Thirst_Alpha ) )
            surface.SetMaterial( Material( "icon16/drink.png" ) )
            surface.DrawTexturedRect(barx, bary, iconsize * HUD_SCALE, iconsize * HUD_SCALE )
            surface.SetDrawColor( Color( col[1], col[2], col[3], Thirst_Alpha ) )
            surface.DrawOutlinedRect(barx + (12 * HUD_SCALE), bary, width, height) --Thirst bar outline
            surface.DrawRect( barx + (12 * HUD_SCALE) + 2, bary + 2, (thirst / maxthirst) * (width - 4), height - 4) --Thirst bar
            --Buff Pos
            if tobool(GetConVar("as_hud_satiationbars_showindic"):GetInt()) then
                surface.SetDrawColor( Color( colgood[1], colgood[2], colgood[3], Thirst_Alpha ))
                surface.DrawRect( (barx + (12 * HUD_SCALE) - 1) + ((width / maxthirst) * SAT.SatBuffs), bary + 1, 1, height - 2)
            end
        end

        local amt = tobool(GetConVar("as_hud_satiationbars_amount"):GetInt())
        if amt then --Will draw satiation amount if enabled
            local hunger, thirst, amtx, amty, outline = (hunger), (thirst), (barx + width + (15 * HUD_SCALE)), (bary - (height) / 2 - 2), (1)
            if Hunger_Alpha > 0 then
                draw.SimpleTextOutlined(hunger, "AftershockHUDVerySmall", amtx, amty, Color( col[1], col[2], col[3], Hunger_Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, outline, Color(0,0,0,Hunger_Alpha))
            end
            amty = amty + (height)
            if Thirst_Alpha > 0 then
                draw.SimpleTextOutlined(thirst, "AftershockHUDVerySmall", amtx, amty, Color( col[1], col[2], col[3], Thirst_Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, outline, Color(0,0,0,Thirst_Alpha))
            end
        end
    end

    Toxic_Alpha = Toxic_Alpha or 0
    local toxication = tobool(GetConVar("as_hud_toxicationbar"):GetInt())
    if toxication then
        local toxic = ply:GetToxic()
        local maxtoxic = ply:GetMaxToxic()
        local showwhenneeded = tobool(GetConVar("as_hud_toxicationbar_showwhenneeded"):GetInt())
        local xpos = GetConVar("as_hud_toxicationbar_xadd"):GetInt()
        local ypos = GetConVar("as_hud_toxicationbar_yadd"):GetInt()
        local width = GetConVar("as_hud_toxicationbar_width"):GetInt() * HUD_SCALE
        local height = GetConVar("as_hud_toxicationbar_height"):GetInt() * HUD_SCALE
        local barx, bary, width, height, outline = (xpos + (ScrW() - 100) - width), (ypos + (80)), (width), (height), (1)
        local colbad = COLHUD_BAD:ToTable()

        if not showwhenneeded or showwhenneeded and (showtoxic or 0) > CurTime() then
            Toxic_Alpha = math.Approach( Toxic_Alpha, 255, FrameTime() * 300 )
        else
            Toxic_Alpha = math.Approach( Toxic_Alpha, 0, FrameTime() * -300 )
        end

        if Toxic_Alpha > 0 then
            surface.SetDrawColor( colbad[1], colbad[2], colbad[3], Toxic_Alpha )
            surface.DrawOutlinedRect( barx, bary, width, height, outline ) --Outline
            surface.SetDrawColor( colbad[1], colbad[2], colbad[3], Toxic_Alpha )
            local length = (toxic / maxtoxic) * width - 4
            surface.DrawRect( barx + 2, bary + 2, length, height - 4)
            surface.DrawRect( (barx + (width / LocalPlayer():GetMaxToxic()) * SET.ToxicDebuff), bary, 1, height - 2)
            surface.DrawRect( (barx + (width / LocalPlayer():GetMaxToxic()) * SET.ToxicDebuffHeavy), bary, 1, height - 2)
            draw.SimpleTextOutlined("Toxicity", "AftershockHUD", barx, bary, Color( colbad[1], colbad[2], colbad[3], Toxic_Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, outline, Color(0,0,0,Toxic_Alpha))

            local amt = tobool(GetConVar("as_hud_toxicationbar_amount"):GetInt())
            if amt then
                draw.SimpleTextOutlined(toxic, "AftershockHUDSmall", barx + (width / 2), bary - 1, Color( colbad[1], colbad[2], colbad[3], Toxic_Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, outline, Color(0,0,0, Toxic_Alpha))
            end
        end
    end

    local effect = tobool(GetConVar("as_hud_effects"):GetInt())
    if effect then
        local iconsize = GetConVar("as_hud_effects_iconsize"):GetInt() * HUD_SCALE
        local xpos = GetConVar("as_hud_effects_xadd"):GetInt()
        local ypos = GetConVar("as_hud_effects_yadd"):GetInt()
        local width = GetConVar("as_hud_effects_width"):GetInt() * HUD_SCALE
        local height = GetConVar("as_hud_effects_height"):GetInt() * HUD_SCALE
        local barx, bary, width, height, outline = (xpos + 100), (ypos + (ScrH() * 0.915)), (width), (height), (1)
        local iconspace = 3
        local barspace = 2
        local spacebetweenbars = GetConVar("as_hud_effects_barspacing"):GetInt()

        for k, v in SortedPairsByMemberValue( LocalPlayer():GetStatuses(), "time", true ) do
            local name = AS.Effects[k].name
            local time = v.time - CurTime()
            local time_max = v.maxtime

            local color = AS.Effects[k] and (AS.Effects[k].type == "positive" and COLHUD_GOOD or AS.Effects[k].type == "negative" and COLHUD_BAD) or COLHUD_DEFAULT

            --Icon
            surface.SetDrawColor( color )
            surface.DrawOutlinedRect( barx, (bary - iconsize) - (GetConVar("as_hud_healthbar_height"):GetInt() * HUD_SCALE), iconsize, iconsize )
            surface.SetDrawColor( AS.Effects[k] and AS.Effects[k].color or Color( 255, 255, 255, 255 ) )
            surface.SetMaterial( Material( AS.Effects[k] and AS.Effects[k].icon or "icon16/lightning.png" ) )
            surface.DrawTexturedRect( barx + iconspace, (bary - iconsize) - (GetConVar("as_hud_healthbar_height"):GetInt() * HUD_SCALE) + iconspace, iconsize - (iconspace * 2), iconsize - (iconspace * 2) )
            --Bar
            surface.SetDrawColor( color )
            surface.DrawOutlinedRect( (barx + iconsize) - 1, bary - height - (GetConVar("as_hud_healthbar_height"):GetInt() * HUD_SCALE), width, height )
            surface.DrawRect( (barx + iconsize) - 1, bary - height - (GetConVar("as_hud_healthbar_height"):GetInt() * HUD_SCALE) + barspace, (time / time_max) * width - barspace, height - (barspace * 2) )
            --Name
            draw.SimpleTextOutlined(name, "AftershockHUDVerySmall", (barx + iconsize + 2), bary - (height + 2) - (GetConVar("as_hud_healthbar_height"):GetInt() * HUD_SCALE), color, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, outline, Color(0,0,0))

            local amt = tobool(GetConVar("as_hud_effects_amount"):GetInt())
            if amt then
                draw.SimpleTextOutlined(math.Round(time, 1), "AftershockHUDVerySmall", barx + iconsize + width + 1, bary - (height / 2) - 1 - (GetConVar("as_hud_healthbar_height"):GetInt() * HUD_SCALE), color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, outline, Color(0,0,0))
            end

            bary = bary - (iconsize + spacebetweenbars)
        end
    end

    local resources = tobool(GetConVar("as_hud_resources"):GetInt())
    if resources then
        local inv = ply:GetInventory()
        local res = {}
        res[1] = {name = "Scrap", amt = inv and inv["misc_scrap"] or 0}
        res[2] = {name = "Small Parts", amt = inv and inv["misc_smallparts"] or 0}
        res[3] = {name = "Chemicals", amt = inv and inv["misc_chemical"] or 0}
        local xpos = GetConVar("as_hud_resources_xadd"):GetInt()
        local ypos = GetConVar("as_hud_resources_yadd"):GetInt()
        local width = 80 * HUD_SCALE
        local height = 20 * HUD_SCALE
        local barx, bary, width, height, spacing, outline = (xpos - width + (ScrW() - 100)), (ypos - height + (ScrH() - 80)), (width), (height), 13 * HUD_SCALE, 1

        for k, v in SortedPairs( res, true ) do
            surface.SetDrawColor( 20, 20, 20, 150 )
            surface.DrawRect( barx, bary, width, height )
            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawOutlinedRect( barx, bary, width, height, 1 )

            draw.SimpleTextOutlined( v.name .. ":", "AftershockHUDSmall", barx + width, bary - 1, COLHUD_DEFAULT, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, outline, Color(0,0,0))
            draw.SimpleTextOutlined( v.amt, "AftershockHUDSmall", barx + width - 5, bary + (height / 2), COLHUD_DEFAULT, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, outline, Color(0,0,0))
            bary = bary - ((24 * HUD_SCALE) + spacing)
        end
    end

    local targetinfo = tobool(GetConVar("as_hud_targetinfo"):GetInt())
    local target = LocalPlayer():GetActiveTarget()
    if targetinfo and target and IsValid(target) and target:Alive() then
        local col = (target:IsNextBot() or target:IsNPC()) and (target.Hostile and target:Hostile() or false) and COLHUD_BAD:ToTable() or COLHUD_DEFAULT:ToTable()
        col = target:IsPlayer() and target:InCommunity() and target:GetCommunity() == LocalPlayer():GetCommunity() and COLHUD_COMMUNITY:ToTable() or col
        col = target:IsPlayer() and target:InCommunity() and LocalPlayer():IsAllied( target:GetCommunity() ) and COLHUD_GOOD:ToTable() or col
        col = target:IsPlayer() and target:InCommunity() and (CommunityWars[target:GetCommunity()]) and COLHUD_BAD:ToTable() or col
        if (LocalPlayer():GetActiveTargetLength() - CurTime()) > 1.2 then
            Target_Alpha = math.Approach((Target_Alpha or 0), 255, FrameTime() * 300) or 0
        end
        local newcol = Color( col[1], col[2], col[3], Target_Alpha )
        surface.SetDrawColor( newcol )
        local xadd, yadd = GetConVar("as_hud_targetinfo_xadd"):GetInt(), GetConVar("as_hud_targetinfo_yadd"):GetInt()
        local x, y, width, height, outline = ((ScrW() * 0.5) + xadd), ((ScrH() * 0.88) + yadd), (GetConVar("as_hud_targetinfo_width"):GetInt() * HUD_SCALE), (GetConVar("as_hud_targetinfo_height"):GetInt() * HUD_SCALE), (1)
        local health, maxhealth = (math.Clamp(target:Health(), 0, target:GetMaxHealth())), (target:GetMaxHealth())
        local name = target:IsPlayer() and target:Nickname() or target:GetNWString("Name", "") != "" and target:GetNWString("Name", "") or target.PrintName or target:GetClass()
        local namey = y - 5
        if target:IsPlayer() and target:InCommunity() then
            draw.SimpleTextOutlined( target:GetCommunityName() .. " - " .. target:GetTitle(), "AftershockHUDVerySmall", x, y - 5, newcol, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, outline, Color(0,0,0,Target_Alpha))
            namey = namey - (12 * HUD_SCALE)
        end
        draw.SimpleTextOutlined(name, "AftershockHUD", x, namey, newcol, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, outline, Color(0,0,0,Target_Alpha))
        x = x - (width / 2)
        surface.DrawOutlinedRect( x, y, width, height, outline )
        surface.DrawRect( x + 2, y + 2, ((health / maxhealth) * width) - 4, height - 4 )

        if target.Devmode then
            surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
            surface.SetMaterial( Material( "icon16/shield.png" ) )
            surface.DrawTexturedRect( x - (height + 4), y, height, height )
        end

        if tobool(GetConVar("as_hud_targetinfo_amount"):GetInt()) then
            x = x + (width / 2)
            y = y + height
            draw.SimpleTextOutlined( target:Health() .. " / " .. maxhealth, "AftershockHUDSmall", x, y, newcol, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, outline, Color(0,0,0,Target_Alpha) )
        end

        if (LocalPlayer():GetActiveTargetLength() - CurTime()) < 1.2 then
            Target_Alpha = math.Approach(Target_Alpha, 0, FrameTime() * -200) or 0
        end
    end
    if not target and (Target_Alpha or 0) > 0 then
        Target_Alpha = 0
    end

    local missioninfo = tobool(GetConVar("as_hud_missioninfo"):GetInt())
    if missioninfo then
        local amounts = tobool( GetConVar("as_hud_missioninfo_amount"):GetInt() )
        local width, height, xadd, yadd, space = (GetConVar("as_hud_missioninfo_width"):GetInt() * HUD_SCALE), (GetConVar("as_hud_missioninfo_height"):GetInt() * HUD_SCALE), GetConVar("as_hud_missioninfo_xadd"):GetInt(), GetConVar("as_hud_missioninfo_yadd"):GetInt(), GetConVar("as_hud_missioninfo_barspacing"):GetInt()
        local x, y, outline = ((ScrW() * 0.935) + xadd) - width, (100 + yadd), (1 * HUD_SCALE)
        local indent = 20 --task Indentation
        local titletaskspace = 25 --Space between title and tasks
        local typebarspace = 15 --Space between task type and bar

        for k, v in pairs( LocalPlayer():GetMissions() ) do
            local minfo = FetchMissionInfo( k )
            draw.SimpleTextOutlined( minfo.name, "AftershockHUD", x, y, COLHUD_DEFAULT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, outline, Color(0,0,0,255) )

            x = x + (indent * HUD_SCALE)
            y = y + (titletaskspace * HUD_SCALE)
            for k2, v2 in pairs( minfo.data ) do
                local col = COLHUD_DEFAULT
                if (v[k2] or 0) >= v2.amt then col = COLHUD_GOOD end
                draw.SimpleTextOutlined( TranslateTaskToShortText( v2.type, (v2.targetname or v2.target) ), "AftershockHUDSmall", x, y, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, outline, Color(0,0,0,255) )
                y = y + (typebarspace * HUD_SCALE)
                surface.SetDrawColor( col )
                surface.DrawOutlinedRect( x, y, width, height, outline )
                surface.DrawRect( x + 2, y + 2, ( (v[k2] or 0) / v2.amt * width ) - 4, height - 4 )
                if amounts then
                    draw.SimpleTextOutlined( ( v[k2] or 0) .. " / " .. v2.amt, "AftershockHUDSmall", x + (width / 2), y + (height / 2), col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, outline, Color(0,0,0,255) )
                end
                y = y - (typebarspace * HUD_SCALE)
                
                y = y + (height + (typebarspace * HUD_SCALE)) + space
            end
            y = y + (height - (typebarspace * HUD_SCALE)) - space
            x = x - (indent * HUD_SCALE)
        end
    end

    local ownership = tobool(GetConVar("as_hud_ownership"):GetInt())
    if ownership then
        local trace = LocalPlayer():TraceFromEyes( 150 )

        if trace.Entity and IsValid(trace.Entity) and trace.Entity:IsObjectOwnable() then
            local xpos, ypos = (ScrW() * 0.5), (15)
            local key = string.upper(GetConVarString("as_bind_ownership"))
            local txt = IsValid(trace.Entity:GetObjectOwner()) and "Owner: " .. trace.Entity:GetObjectOwner():Nickname() or "Press [" .. key .. "] to own"
            draw.SimpleTextOutlined( txt, "AftershockHUD", xpos, ypos, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0,0,0) )
        end
    end

    local combat = tobool(GetConVar("as_hud_stress"):GetInt()) and LocalPlayer():InCombat()
    if combat then
        local xadd = GetConVar("as_hud_stress_xadd"):GetInt()
        local yadd = GetConVar("as_hud_stress_yadd"):GetInt()
        local xpos, ypos = (xadd + (ScrW() * 0.5)), (yadd + (ScrH() - 5))
        draw.SimpleTextOutlined( "In Combat", "AftershockHUD", xpos, ypos, COLHUD_BAD, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, Color( 0, 0, 0 ) )
    end
end

function AftershockHUDDeath()
    local width = 200 * HUD_SCALE
    local height = 15 * HUD_SCALE
    local barx, bary, width, height, outline = ((ScrW() / 2) - (width / 2)), ((ScrH() * 0.8)), (width), (height), (1)

    surface.SetDrawColor(COLHUD_DEFAULT) --Set color to hud color
    surface.DrawOutlinedRect(barx, bary, width, height, outline) --Health bar outline
    local length = tobool(GetConVar("as_respawnwait"):GetInt()) and SET.DeathWait or 1
    local percent = (CurTime() - (LocalPlayer():GetNWInt("AS_LastDeath") or 0)) / length
    surface.DrawRect(barx + 2, bary + 2, math.Clamp((percent * 200 - 4), 0, 200 - 4), height - 4) --Health bar

    if CurTime() > LocalPlayer():GetNWInt("AS_NextManualRespawn", 0 ) then
        draw.SimpleTextOutlined( "You can press space or click to respawn.", "AftershockHUD", barx + (width / 2), bary - 20, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, Color( 0, 0, 0 ) )
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

function AftershockHUDInjured()
    local healthratio = Lerp( LocalPlayer():Health() / LocalPlayer():GetMaxHealth(), 0, 1 )
    local healthinjured = LocalPlayer():GetMaxHealth() * (GetConVar("as_hud_injured_wake"):GetInt() / 100)
    local injured = tobool(GetConVar("as_hud_injured"):GetInt()) and healthratio < (GetConVar("as_hud_injured_wake"):GetInt() / 100)
    if injured then
        local severityratio = Lerp( 1 - (LocalPlayer():Health() / healthinjured), 0, 1 )
        local alpha = 255 * severityratio
        surface.SetDrawColor( Color( 255, 255, 255, alpha ) )
        surface.SetMaterial( Material( "hud/aftershock/bloodoverlay" ) )
        surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )

        local heartbeat = tobool(GetConVar("as_hud_injured_heartbeat"):GetInt())
        if heartbeat and CurTime() > (NextHeartbeat or 0) then
            NextHeartbeat = CurTime() + (1.5 - (0.7 * severityratio))
            pitch = 100 + (30 * severityratio)
            LocalPlayer():EmitSound( "player/heartbeat.wav", 75, pitch, severityratio, CHAN_STATIC )
        end
    end
end

function AftershockHUDVoice()
    if table.Count(HUD_TALKINGPLAYERS) <= 0 then return end --No one is talking, lets not run this.

    for k, v in pairs( HUD_TALKINGPLAYERS ) do
        if not IsValid(k) then continue end
        ASHUDVOICE_ypos = ASHUDVOICE_ypos + ASHUDVOICE_height + ASHUDVOICE_spacing
    end
end

hook.Add( "PlayerStartVoice", "AS_VoiceStart", function( ply )
    if not tobool(GetConVar("as_voicechat"):GetInt()) and LocalPlayer() == ply and not LocalPlayer():IsAdmin() then
        LocalPlayer():ChatPrint("Voice Chat is disabled.")
    end

    HUD_TALKINGPLAYERS[ply] = true

    ASHUDVOICE_iconsize = 64 * HUD_SCALE

    local panel = vgui.Create("DPanel")
    panel:SetSize( ASHUDVOICE_width, ASHUDVOICE_height )
    panel:SetPos( (ASHUDVOICE_xpos or 0) + 1, (ASHUDVOICE_ypos or 0) + 1 )
    function panel:Paint( w, h )
        local col = COLHUD_SECONDARY:ToTable()
        surface.SetDrawColor( col[1], col[2], col[3], 100 )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    local label = vgui.Create("DLabel", panel)
    label:SetFont( "AftershockHUDSmall" )
    label:SetText(ply:Nickname())
    label:SetPos(5, (ASHUDVOICE_iconsize or 0) + 0)
    label:SizeToContents()
    label:SetColor( AS.Classes[ply:GetASClass()].color )

    local size = 60 * HUD_SCALE
    CharacterIcon( ply:GetModel(), 0, 0, size, size, panel, nil, Color( 0, 0, 0, 0 ))
    HUD_TALKINGPLAYERSPANELS[ply] = panel

    return true --Hides the default voice UI
end)

hook.Add( "PlayerEndVoice", "AS_VoiceEnd", function( ply )
    HUD_TALKINGPLAYERS[ply] = nil
    if HUD_TALKINGPLAYERSPANELS[ply] and IsValid( HUD_TALKINGPLAYERSPANELS[ply] ) then
        HUD_TALKINGPLAYERSPANELS[ply]:Remove()
        HUD_TALKINGPLAYERSPANELS[ply] = nil
    end
end)

timer.Create( "AS_CleanupVoice", 10, 0, function()
    for k, v in pairs( HUD_TALKINGPLAYERSPANELS ) do
        if not IsValid( k ) then
            v:Remove()
            HUD_TALKINGPLAYERS[ k ] = nil
        end
    end
end)

concommand.Add("as_flushvoices", function( ply, cmd, args )
    for k, v in pairs( HUD_TALKINGPLAYERSPANELS ) do
        v:Remove()
    end
end)

function GM:HUDShouldDraw( type )
    local hideHud = {
        ["CHudAmmo"] = true,
        ["CHudSecondaryAmmo"] = true,
        ["CHudBattery"] = true,
        --["CHudCrosshair"] = true,
        ["CHudCloseCaption"] = true,
        ["CHudDamageIndicator"] = true,
        ["CHudGeiger"] = true,
        ["CHudHealth"] = true,
        ["CHudHintDisplay"] = true,
        ["CHudPoisonDamageIndicator"] = true,
        ["CHudSquadStatus"] = true,
        ["CHudTrain"] = true,
        ["CHudVehicle"] = true,
        --["CHudWeapon"] = true,
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

function BuildASFonts()
    surface.CreateFont( "AftershockHUD", {
        font 		= "TargetID",
        extended 	= false,
        size 		= 24 * HUD_SCALE,
        weight 		= 400,
        blursize 	= 0,
        scanlines 	= 0,
        antialias 	= true,
        underline 	= false,
        italic 		= false,
        strikeout 	= false,
        symbol 		= false,
        rotary 		= false,
        shadow 		= false,
        additive 	= false,
        outline 	= false,
    })
    
    surface.CreateFont( "AftershockHUDSmall", {
        font 		= "TargetIDSmall",
        extended 	= false,
        size 		= 15 * HUD_SCALE,
        weight 		= 400,
        blursize 	= 0,
        scanlines 	= 0,
        antialias 	= true,
        underline 	= false,
        italic 		= false,
        strikeout 	= false,
        symbol 		= false,
        rotary 		= false,
        shadow 		= false,
        additive 	= false,
        outline 	= false,
    })

    surface.CreateFont( "AftershockHUDVerySmall", {
        font 		= "TargetID",
        extended 	= false,
        size 		= 11 * HUD_SCALE,
        weight 		= 400,
        blursize 	= 0,
        scanlines 	= 0,
        antialias 	= true,
        underline 	= false,
        italic 		= false,
        strikeout 	= false,
        symbol 		= false,
        rotary 		= false,
        shadow 		= false,
        additive 	= false,
        outline 	= false,
    })
end

hook.Add( "HUDPaint", "AS_HUD", function()
    COLHUD_DEFAULT = Color(GetConVar("as_hud_color_default_r"):GetInt(), GetConVar("as_hud_color_default_g"):GetInt(), GetConVar("as_hud_color_default_b"):GetInt(), 255)
    COLHUD_COMMUNITY = Color(GetConVar("as_hud_color_community_r"):GetInt(), GetConVar("as_hud_color_community_g"):GetInt(), GetConVar("as_hud_color_community_b"):GetInt(), 255)
    COLHUD_GOOD = Color(GetConVar("as_hud_color_good_r"):GetInt(), GetConVar("as_hud_color_good_g"):GetInt(), GetConVar("as_hud_color_good_b"):GetInt(), 255)
    COLHUD_BAD = Color(GetConVar("as_hud_color_bad_r"):GetInt(), GetConVar("as_hud_color_bad_g"):GetInt(), GetConVar("as_hud_color_bad_b"):GetInt(), 255)
    HUD_SCALE = GetConVar("as_hud_scale"):GetFloat() or 1

    --I hate myself for this
    ASHUDVOICE_height = 85 * HUD_SCALE
    ASHUDVOICE_width = 150 * HUD_SCALE
    ASHUDVOICE_spacing = 2 * HUD_SCALE
    ASHUDVOICE_xadd = tobool(GetConVar("as_hud_missioninfo"):GetInt()) and table.Count( LocalPlayer():GetMissions() ) > 0 and -(GetConVar("as_hud_missioninfo_width"):GetInt() * HUD_SCALE - 50) or 0
    ASHUDVOICE_yadd = 0
    ASHUDVOICE_xpos, ASHUDVOICE_ypos = (ASHUDVOICE_xadd + ScrW() * 0.9 - ASHUDVOICE_width), (ASHUDVOICE_yadd + 150)

    CurScale = CurScale or nil
    if CurScale != HUD_SCALE then
        CurScale = HUD_SCALE
        BuildASFonts()
    end

    if tobool(GetConVar("as_hud"):GetInt()) then
        AftershockHUD()
    end

    if tobool(GetConVar("as_connectioninfo"):GetInt()) then
        ConnectionInformation()
    end
end)