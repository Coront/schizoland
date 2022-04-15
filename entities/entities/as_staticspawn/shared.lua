ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Static Spawner"
ENT.Author			= "Tampy"
ENT.Purpose			= "Will spawn an NPC to guard."
ENT.Category		= "Aftershock"
ENT.Spawnable		= true
ENT.Editable        = true

ENT.PlyDisableDist = 3000 --Distance from players in which we will just disable.

function ENT:SetupDataTables()
    self:NetworkVar( "String", 0, "NPC", {
        KeyName = "NPC",
        Edit = {
            type = "String",
        }
    } )

    self:NetworkVarNotify( "NPC", self.OnNPCChanged )
end

function ENT:OnNPCChanged( name, old, new )
    if old == "" then return end
end

function ENT:GetSpawnPos()
    local center = self:GetPos() + self:GetUp() * 20
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
        endpos = center + Vector(0,0,0),
        mins = mins,
        maxs = maxs,
        mask = MASK_SOLID_BRUSHONLY
    })

    return downTr.HitPos
end

function ENT:GetSpawnAng()
    local ang = self:GetAngles():ToTable()
    return Angle( 0, ang[2], 0 )
end

function ENT:GetSpawnAngVisual()
    local ang = self:GetAngles():ToTable()
    local toAng = Angle( 0, ang[2], 0 ):Forward()
    return self:GetSpawnPos() + toAng * 50
end