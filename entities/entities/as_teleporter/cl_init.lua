include( "shared.lua" )

function ENT:Draw()
    if LocalPlayer():IsDeveloping() then
        self:DrawModel()
        self:DrawShadow(true)

        local col = COLHUD_DEFAULT or Color( 255, 255, 255 )
        render.SetColorMaterial()
        render.DrawWireframeBox( self:GetSpawnPos(), Angle( 0, 0, 0 ), Vector( -15, -15, 0 ), Vector( 15, 15, 70 ), col, true )
    else
        self:DrawShadow(false)
    end
end

hook.Add( "HUDPaint", "AS_Teleporter", function()
    for k, v in pairs( ents.FindByClass("as_teleporter") ) do
        if LocalPlayer():GetPos():Distance(v:GetPos()) > 150 then continue end
        local trace = util.TraceLine({
            start = LocalPlayer():EyePos(),
            endpos = v:GetPos() + v:OBBCenter(),
            filter = LocalPlayer(),
        })
        if trace.HitWorld then continue end

        local pos = v:GetPos():ToScreen()

        draw.SimpleTextOutlined( "[" .. string.upper(KEYBIND_USE) .. "] " .. v:GetLocationName(), "TargetID", pos.x, pos.y, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
    end
end)