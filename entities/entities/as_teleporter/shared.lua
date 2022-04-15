ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Teleporter"
ENT.Author			= "Tampy"
ENT.Purpose			= "Allows a player to warp between two locations."
ENT.Category		= "Aftershock"
ENT.Spawnable		= true
ENT.Editable        = true

function ENT:SetupDataTables()
    self:NetworkVar( "String", 0, "Identifier", {
        KeyName = "Identifier",
        Edit = {
            type = "String",
        }
    } )
    self:NetworkVar( "String", 1, "LocationName", {
        KeyName = "Location Name",
        Edit = {
            type = "String",
        }
    } )
    self:NetworkVar( "String", 2, "WarpSound", {
        KeyName = "Warp Sound",
        Edit = {
            type = "String",
        }
    } )
end

function ENT:GetSpawnPos()
    local center = self:GetPos() + self:GetUp() * 40
    local upTr = util.TraceLine({
        start = center,
        endpos = center + Vector(0,0,64),
        mask = MASK_SOLID_BRUSHONLY
    })

    local hullStart = upTr.HitPos + Vector(0,0,-30)

    local mins, maxs = Vector( -20, -20, 0 ), Vector( 20, 20, 70 )
    maxs.z = 1
    local downTr = util.TraceHull({
        start = hullStart,
        endpos = center + Vector(0,0,-60),
        mins = mins,
        maxs = maxs,
        mask = MASK_SOLID_BRUSHONLY
    })

    return downTr.HitPos
end