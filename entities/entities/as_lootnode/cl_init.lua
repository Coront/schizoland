include( "shared.lua" )

function ENT:Draw()
    self:DrawModel()

    local ply = LocalPlayer()
    if ply:IsAdmin() and ply:IsDeveloping() then
        local tracedata = {}
        tracedata.start = ply:GetShootPos()
        tracedata.endpos = tracedata.start + (ply:GetAimVector() * 1000)
        tracedata.filter = ply
        local trace = util.TraceLine(tracedata)

        render.DrawLine( self:GetPos(), self:GetPos() + Vector(0,0,10000), COLHUD_DEFAULT, true )
    end
end

hook.Add( "HUDPaint", "AS_Node_Indicator", function()
    for k, v in pairs( ents.FindByClass("as_lootnode") ) do
        if v:GetPos():Distance(LocalPlayer():GetPos()) > 400 then continue end
        if LocalPlayer():IsEventActive() then continue end
        local trace = util.TraceLine({
            start = LocalPlayer():EyePos(),
            endpos = v:GetPos() + v:OBBCenter(),
            filter = {LocalPlayer()},
        })
        if trace.Entity != v then continue end

        local pos = v:GetPos() + v:OBBCenter()
        local screen = pos:ToScreen()
        local text = "Scavengable Node"
        local bind = input.LookupBinding( "+use" )

        if v:GetPos():Distance(LocalPlayer():GetPos()) < 150 then
            text = "Press [" .. string.upper(bind) .. "] to Scavenge"
        end

        draw.SimpleTextOutlined( text, "TargetID", screen.x, screen.y, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, Color( 0, 0, 0 ) )
    end
end)

net.Receive( "as_lootnode_syncnewitem", function() --I intentionally sync like this because i don't want to rewrite a player's entire inventory when we're just adding one item.
    local item = net.ReadString()
    local amt = net.ReadInt(32)

    LocalPlayer():AddItemToInventory( item, amt )
end)

net.Receive( "as_lootnode_syncskillinc", function()
    LocalPlayer():IncreaseSkillExperience("salvaging", SKL.Salvaging.incamt)
end)