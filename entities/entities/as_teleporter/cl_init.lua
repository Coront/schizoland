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
    local maxdist = 250
    local usedist = 100
    local diff = maxdist - usedist

    for k, v in pairs( ents.FindByClass("as_teleporter") ) do
        if LocalPlayer():GetPos():Distance(v:GetPos()) > maxdist then continue end
        local trace = util.TraceLine({
            start = LocalPlayer():EyePos(),
            endpos = v:GetPos() + v:OBBCenter(),
            filter = LocalPlayer(),
            mask = MASK_SHOT,
        })
        if not IsValid(trace.Entity) or trace.HitWorld then continue end

        local ent = trace.Entity
        local entpos = ent:GetPos() + ent:OBBCenter()
        local opacity = 255
        local distance = EyePos():Distance(entpos)
        if distance > usedist then
            opacity = 255 * Lerp( (maxdist - distance) / (diff), 0, 1 )
        end

        local pos = v:GetPos():ToScreen()
        local col = COLHUD_DEFAULT:ToTable()
        draw.SimpleTextOutlined( "[" .. string.upper(KEYBIND_USE) .. "] " .. v:GetLocationName(), "TargetID", pos.x, pos.y, Color( col[1], col[2], col[3], opacity ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, opacity ) )
    end
end)