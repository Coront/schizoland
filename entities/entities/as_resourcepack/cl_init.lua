include( "shared.lua" )

function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) < GetConVar("as_entity_renderdist"):GetInt() then
        self:DrawModel()
        self:DrawShadow(true)
    else
        self:DrawShadow(false)
    end
end

hook.Add( "HUDPaint", "AS_ItemInfo", function()
    local maxdist = 300
    local pickupdist = 100

    local trace = util.TraceLine({
        start = LocalPlayer():EyePos(),
        endpos = LocalPlayer():EyePos() + LocalPlayer():EyeAngles():Forward() * maxdist,
        filter = LocalPlayer(),
    })
    if trace.Entity and not IsValid(trace.Entity) then return end

    if trace.Entity:GetClass() == "as_resourcepack" then
        local ent = trace.Entity
        local entpos = ent:GetPos() + ent:OBBCenter()

        local pos = entpos:ToScreen()
        local scrap = ent:GetScrap()
        local smallparts = ent:GetSmallParts()
        local chemical = ent:GetChemicals()

        local distance = EyePos():Distance(entpos)
        local diff = maxdist - pickupdist
        local opacity = 255
        if distance > pickupdist then
            opacity = 255 * Lerp( (maxdist - distance) / diff, 0, 1 )
        end
        local pickupkey = distance < pickupdist and "[" .. string.upper(KEYBIND_USE) .. "] Pickup" or ""
        local col = COLHUD_DEFAULT:ToTable()
    
        draw.SimpleTextOutlined( "Scrap (" .. scrap .. ")", "TargetID", pos.x, pos.y, Color( col[1], col[2], col[3], opacity ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, opacity ) )
        draw.SimpleTextOutlined( "Small Parts (" .. smallparts .. ")", "TargetID", pos.x, pos.y + 20, Color( col[1], col[2], col[3], opacity ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, opacity ) )
        draw.SimpleTextOutlined( "Chemicals (" .. chemical .. ")", "TargetID", pos.x, pos.y + 40, Color( col[1], col[2], col[3], opacity ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, opacity ) )
        draw.SimpleTextOutlined( pickupkey, "TargetID", pos.x, pos.y + 60, Color( col[1], col[2], col[3], opacity ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, opacity ) )
    end
end)