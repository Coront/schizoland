AS_ClientConVar( "as_hud_timeevent", "1", true, false )
AS_ClientConVar( "as_hud_timeevent_percent", "0", true, false )

hook.Add( "HUDPaint", "AS_TimedEvents", function()

    if GetConVar( "as_hud_timeevent" ):GetInt() <= 0 then return end
    if LocalPlayer():GetEventTime() <= 0 or CurTime() >= LocalPlayer():GetEventTime() then return end
    surface.SetDrawColor( COLHUD_DEFAULT )
    local width, height, ply = 100, 20, LocalPlayer()
    surface.DrawOutlinedRect( (ScrW() / 2) - (width / 2), ((ScrH() / 2) + height) * 1.02, width, height )
    local percent = (CurTime() - (EventStartTime or 0)) / EventTimeLength
    surface.DrawRect( (ScrW() / 2) - (width / 2), ((ScrH() / 2) + height) * 1.02, math.Clamp(percent * 100, 0, 100), height )
    if GetConVar( "as_hud_timeevent_percent" ):GetInt() >= 1 then
        draw.SimpleTextOutlined( math.Round(percent * 100) .. "%", "TargetID", (ScrW() / 2), ((ScrH() / 2) + height) * 1.02, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0 ) )
    end

end)