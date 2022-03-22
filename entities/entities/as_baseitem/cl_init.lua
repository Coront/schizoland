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
        if LocalPlayer():GetPos():Distance(v:GetPos()) > 250 then continue end
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

        local pickupkey = LocalPlayer():GetPos():Distance(v:GetPos()) < 100 and "[" .. string.upper(KEYBIND_USE) .. "] Pickup" or ""
        draw.SimpleTextOutlined( name .. " (" .. amt .. ")", "TargetID", pos.x, pos.y, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
        draw.SimpleTextOutlined( pickupkey, "TargetID", pos.x, pos.y + 20, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
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