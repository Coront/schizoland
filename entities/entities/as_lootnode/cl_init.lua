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
    local trace = util.TraceLine({
        start = LocalPlayer():EyePos(),
        endpos = LocalPlayer():EyePos() + LocalPlayer():EyeAngles():Forward() * 400,
        filter = {LocalPlayer()},
    })

    if not IsValid(trace.Entity) then return end
    if trace.Entity:GetClass() != "as_lootnode" then return end
    if trace.Entity:GetPos():Distance(LocalPlayer():EyePos()) > 400 then return end
    if LocalPlayer():IsEventActive() then return end

    local maxdist = 400
    local usedist = 150
    local diff = maxdist - usedist

    local ent = trace.Entity
    local entpos = ent:GetPos() + ent:OBBCenter()
    local opacity = 255
    local distance = EyePos():Distance(entpos)
    if distance > usedist then
        opacity = 255 * Lerp( (maxdist - distance) / (diff), 0, 1 )
    end

    local pos = trace.Entity:GetPos() + trace.Entity:OBBCenter()
    local screen = pos:ToScreen()
    local text = "Scavengable Node"
    local bind = input.LookupBinding( "+use" )

    if trace.Entity:GetPos():Distance(LocalPlayer():EyePos()) < 150 then
        text = "Press [" .. string.upper(bind) .. "] to Scavenge"
    end

    local col = COLHUD_DEFAULT:ToTable()
    draw.SimpleTextOutlined( text, "TargetID", screen.x, screen.y, Color( col[1], col[2], col[3], opacity ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, Color( 0, 0, 0, opacity ) )
end)

net.Receive( "as_lootnode_syncskillinc", function()
    LocalPlayer():IncreaseSkillExperience("salvaging", SKL.Salvaging.incamt)
end)