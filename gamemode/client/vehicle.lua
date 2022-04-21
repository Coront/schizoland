hook.Add("HUDPaint", "AS_VehicleInfo", function()
    for k, v in pairs( ents.FindByClass("prop_vehicle_jeep") ) do
        if LocalPlayer():GetPos():Distance(v:GetPos()) > 250 then continue end
        if v:GetObjectOwner() != LocalPlayer() then continue end
        if LocalPlayer():InVehicle() then continue end
        local trace = util.TraceLine({
            start = LocalPlayer():EyePos(),
            endpos = v:GetPos() + v:OBBCenter(),
            filter = LocalPlayer(),
        })
        if trace.HitWorld then continue end

        local center = v:OBBCenter():ToTable()
        local pos = (v:GetPos() + Vector( 0, 0, center[3] )):ToScreen()

        draw.SimpleTextOutlined( "[" .. string.upper(KEYBIND_USE) .. "] Drive", "TargetID", pos.x, pos.y, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
        draw.SimpleTextOutlined( "[" .. string.upper(GetConVarString("as_bind_inventory")) .. "] Access Inventory", "TargetID", pos.x, pos.y + 20, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
    end
end)