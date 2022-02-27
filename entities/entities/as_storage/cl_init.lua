include( "shared.lua" )

function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) < GetConVar("as_entity_renderdist"):GetInt() then
        self:DrawModel()
        self:DrawShadow(true)
    else
        self:DrawShadow(false)
    end
end

hook.Add( "HUDPaint", "AS_StorageBox", function()
    for k, v in pairs( ents.FindByClass("as_storage") ) do
        if LocalPlayer():GetPos():Distance(v:GetPos()) > 300 then continue end
        local trace = util.TraceLine({
            start = LocalPlayer():EyePos(),
            endpos = v:GetPos() + v:OBBCenter(),
            filter = LocalPlayer(),
        })
        if trace.Entity != v then continue end

        local pos = v:GetPos():ToScreen()
        local usekey = LocalPlayer():GetPos():Distance(v:GetPos()) < 120 and "\n[" .. string.upper(KEYBIND_USE) .. "] Access Storage" or ""
        draw.DrawText( "Storage Container" .. usekey, "TargetID", pos.x, pos.y, Color(255,255,255,255), TEXT_ALIGN_CENTER )
    end
end)