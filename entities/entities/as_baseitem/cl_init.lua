include( "shared.lua" )

CreateClientConVar( "as_item_renderdist", "500", true, false )

function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) < GetConVar("as_item_renderdist"):GetInt() then
        self:DrawModel()
        self:DrawShadow(true)
    else
        self:DrawShadow(false)
    end
end

hook.Add( "HUDPaint", "AS_ItemInfo", function()
    for k, v in pairs( ents.FindByClass("as_baseitem") ) do
        if LocalPlayer():GetPos():Distance(v:GetPos()) > GetConVar("as_item_renderdist"):GetInt() then continue end
        local trace = util.TraceLine({
            start = LocalPlayer():EyePos(),
            endpos = v:GetPos() + v:OBBCenter(),
            filter = LocalPlayer(),
        })
        if trace.Entity != v then continue end

        local pos = v:GetPos():ToScreen()
        local id = v:GetItem()
        local amt = v:GetAmount()
        local name = AS.Items[id] and AS.Items[id].name or "item?name"

        local pickupkey = LocalPlayer():GetPos():Distance(v:GetPos()) < 100 and "\n[" .. string.upper(KEYBIND_USE) .. "] Pickup" or ""
        draw.DrawText( name .. " (x" .. amt .. ")" .. pickupkey, "TargetID", pos.x, pos.y, Color(255,255,255,255), TEXT_ALIGN_CENTER )
    end
end)

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

net.Receive( "as_item_pickup", function()
    local item = net.ReadString()
    local amt = net.ReadInt(32)

    LocalPlayer():AddItemToInventory( item, amt )
end)