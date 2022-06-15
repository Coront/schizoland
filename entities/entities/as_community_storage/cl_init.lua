include( "shared.lua" )
include( "menu.lua" )

function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) < GetConVar("as_entity_renderdist"):GetInt() then
        self:DrawModel()
        self:DrawShadow(true)
    else
        self:DrawShadow(false)
    end
end

hook.Add("HUDPaint", "AS_CStorage", function()
    local ply = LocalPlayer()
    local maxdist = 500
    local accessdist = 250

    for k, v in pairs( ents.FindByClass("as_community_storage") ) do
        if LocalPlayer():GetPos():Distance(v:GetPos()) > maxdist then continue end

        local ent = v
        local obbc = ent:OBBCenter():ToTable()
        local ang = ent:GetAngles()
        local entpos = ent:GetPos() + obbc[3] * ang:Up()

        local pos = entpos:ToScreen()

        local distance = EyePos():Distance(entpos)
        local diff = maxdist - accessdist
        local opacity = 255
        if distance > accessdist then
            opacity = 255 * Lerp( (maxdist - distance) / diff, 0, 1 )
        end
        local pickupkey = distance < accessdist and "[" .. string.upper(KEYBIND_USE) .. "] Pickup" or ""
        local col = COLHUD_DEFAULT:ToTable()

        draw.SimpleTextOutlined( ent:GetCommunityName() .. "'s Community Locker", "TargetID", pos.x, pos.y, Color( col[1], col[2], col[3], opacity ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, opacity ) )
        if distance < accessdist then
            draw.SimpleTextOutlined( "[" .. string.upper(KEYBIND_USE) .. "] Access", "TargetID", pos.x, pos.y + 20, Color( col[1], col[2], col[3], opacity ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, opacity ) )
        end
        if ent:GetCommunity() != LocalPlayer():GetCommunity() then
            col = COLHUD_BAD:ToTable()
            draw.SimpleTextOutlined( "You may be attacked for approaching or accessing.", "CloseCaption_Bold", pos.x, pos.y + 45, Color( col[1], col[2], col[3], opacity ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, opacity ) )
        end
    end
end)