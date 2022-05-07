hook.Add("HUDPaint", "AS_VehicleInfo", function()
    
    local maxdist = 400
    local invdist = 200
    
    local trace = util.TraceLine({
        start = LocalPlayer():EyePos(),
        endpos = LocalPlayer():EyePos() + LocalPlayer():EyeAngles():Forward() * maxdist,
        filter = LocalPlayer(),
    })
    local ent = trace.Entity

    if LocalPlayer():InVehicle() or ent:GetObjectOwner() != LocalPlayer() then return end
    if ent and not IsValid(ent) then return end

    if ent:GetClass() == "prop_vehicle_jeep" then
        local obbc = ent:OBBCenter():ToTable()
        local ang = ent:GetAngles()
        local entpos = ent:GetPos() + obbc[3] * ang:Up()

        local pos = entpos:ToScreen()

        local distance = EyePos():Distance(entpos)
        local diff = maxdist - invdist
        local opacity = 255
        if distance > invdist then
            opacity = 255 * Lerp( (maxdist - distance) / diff, 0, 1 )
        end
        local pickupkey = distance < invdist and "[" .. string.upper(KEYBIND_USE) .. "] Pickup" or ""
        local col = COLHUD_DEFAULT:ToTable()

        draw.SimpleTextOutlined( "[" .. string.upper(KEYBIND_USE) .. "] Drive", "TargetID", pos.x, pos.y, Color( col[1], col[2], col[3], opacity ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, opacity ) )
        if distance < invdist then
            draw.SimpleTextOutlined( "[" .. string.upper(GetConVarString("as_bind_inventory")) .. "] Access Inventory", "TargetID", pos.x, pos.y + 20, Color( col[1], col[2], col[3], opacity ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, opacity ) )
        end
    end
end)