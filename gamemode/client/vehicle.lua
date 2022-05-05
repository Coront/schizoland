hook.Add("HUDPaint", "AS_VehicleInfo", function()
    local trace = util.TraceLine({
        start = LocalPlayer():EyePos(),
        endpos = LocalPlayer():EyePos() + LocalPlayer():EyeAngles():Forward() * 150,
        filter = LocalPlayer(),
    })
    local ent = trace.Entity
    if not IsValid(ent) then return end
    if ent:GetClass() != "prop_vehicle_jeep" then return end
    if ent:GetObjectOwner() != LocalPlayer() then return end
    if LocalPlayer():InVehicle() then return end

    local center = ent:OBBCenter():ToTable()
    local pos = (ent:GetPos() + Vector( 0, 0, center[3] )):ToScreen()

    draw.SimpleTextOutlined( "[" .. string.upper(KEYBIND_USE) .. "] Drive", "TargetID", pos.x, pos.y, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
    draw.SimpleTextOutlined( "[" .. string.upper(GetConVarString("as_bind_inventory")) .. "] Access Inventory", "TargetID", pos.x, pos.y + 20, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
end)