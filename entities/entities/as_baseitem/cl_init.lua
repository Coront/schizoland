include( "shared.lua" )

AS_ClientConVar( "as_item_renderdist", "3000", true, false )

function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) < GetConVar("as_item_renderdist"):GetInt() then
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

    if trace.Entity:GetClass() == "as_baseitem" then
        local ent = trace.Entity
        local entpos = ent:GetPos() + ent:OBBCenter()

        local pos = entpos:ToScreen()
        local id = ent:GetItem()
        local amt = ent:GetAmount()
        local name = AS.Items[id] and AS.Items[id].name or "item?name"

        local distance = EyePos():Distance(entpos)
        local diff = maxdist - pickupdist
        local opacity = 255
        if distance > pickupdist then
            opacity = 255 * Lerp( (maxdist - distance) / diff, 0, 1 )
        end
        local pickupkey = distance < pickupdist and "[" .. string.upper(KEYBIND_USE) .. "] Pickup" or ""
        local col = COLHUD_DEFAULT:ToTable()
    
        draw.SimpleTextOutlined( name .. " (" .. amt .. ")", "TargetID", pos.x, pos.y, Color( col[1], col[2], col[3], opacity ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, opacity ) )
        draw.SimpleTextOutlined( pickupkey, "TargetID", pos.x, pos.y + 20, Color( col[1], col[2], col[3], opacity ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, opacity ) )
    end
end)