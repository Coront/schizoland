include( "shared.lua" )

function BoolToString( bool )
    if bool then
        return "True"
    else
        return "False"
    end
end

function ENT:Draw()
    if not LocalPlayer():IsDeveloping() then return end

	self:DrawModel()
    local id        = self:EntIndex()
    local distance  = self:GetNWInt( "Distance", 1000 )
    local nodes     = self:GetNWBool( "Nodes", true )
    local mobs      = self:GetNWBool( "Mobs", true )
    local events    = self:GetNWBool( "Events", false )
    local indoor    = self:GetNWBool( "Indoor", false )

    local trace = util.TraceLine({
        start = LocalPlayer():GetShootPos(),
        endpos = LocalPlayer():GetShootPos() + (LocalPlayer():GetAimVector() * 10000),
        filter = LocalPlayer(),
    })

    if trace.Entity == self then
        local wtiptext = "ID: " .. id .. "\n\nDistance: " .. distance .. "\nNodes: " .. BoolToString(nodes) .. "\nMobs: " .. BoolToString(mobs) .. "\nEvents: " .. BoolToString(events) .. "\nIndoor: " .. BoolToString(indoor)
        AddWorldTip( nil, wtiptext, nil, self:GetPos(), self )
    end

    local pos = self:GetPos():ToTable()
    local bound1 = Vector(pos[1] - distance, pos[2] - distance, pos[3] - (distance / 2))
    local bound2 = Vector(pos[1] + distance, pos[2] + distance, pos[3] + 5)

    local col = COLHUD_DEFAULT:ToTable()
    for k, v in pairs( ents.FindByClass( "player" ) ) do
        if self:GetPos():Distance(v:GetPos()) < distance * 1.5 then
            col = COLHUD_BAD:ToTable()
            break
        end
    end
    local newcol = Color( col[1], col[2], col[3], 50 )
    render.SetColorMaterial()
    render.DrawBox( Vector( 0, 0, 0 ), Angle( 0, 0, 0 ), bound1, bound2, newcol )
end

hook.Add("PreDrawHalos", "AS_SpawnerOutlines", function()
    if not LocalPlayer():IsDeveloping() then return end

    local halos = {}
    local col = COLHUD_DEFAULT
    for k, v in pairs( ents.FindByClass("as_mobspawner") ) do
        local trace = util.TraceLine({
            start = LocalPlayer():GetShootPos(),
            endpos = LocalPlayer():GetShootPos() + (LocalPlayer():GetAimVector() * 10000),
            filter = LocalPlayer(),
        })

        for k, v in pairs( ents.FindByClass( "player" ) ) do
            if trace.Entity:GetPos():Distance(v:GetPos()) < trace.Entity:GetNWInt("Distance") * 1.5 then
                col = COLHUD_BAD
                break
            end
        end

        if trace.Entity != v then continue end
        halos[#halos + 1] = v
    end

    halo.Add( halos, col, 2, 2, 1, true, false )
end)