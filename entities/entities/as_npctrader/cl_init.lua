include( "shared.lua" )

hook.Add( "HUDPaint", "AS_NPCTraders", function()
    local ply = LocalPlayer()
    local tr = util.TraceLine({
        start = ply:EyePos(),
        endpos = ply:EyePos() + ply:EyeAngles():Forward() * 150,
        filter = ply
    })

    if tr.Entity and IsValid(tr.Entity) and tr.Entity:GetClass() == "as_npctrader" then
        surface.SetDrawColor( COLHUD_DEFAULT )
        local w, h = 200, 25
        local x, y = (ScrW() / 2) - (w / 2), ScrH() * 0.53
        surface.DrawOutlinedRect( x, y, w, h, 1 )
        local col = COLHUD_DEFAULT:ToTable()
        surface.SetDrawColor( col[1], col[2], col[3], 10 )
        surface.DrawRect( x, y, w, h )
        
        local npcTraderName = tr.Entity:GetNWString("TraderName")
        draw.SimpleTextOutlined( npcTraderName, "TargetID", (ScrW() / 2), (ScrH() * 0.53) + 10, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
        draw.SimpleTextOutlined( "Press 'E' to trade.", "DefaultSmall", (ScrW() / 2), (ScrH() * 0.55) + 10, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )

    end
end)