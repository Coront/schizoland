ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Static Spawner Zone"
ENT.Author			= "Tampy"
ENT.Purpose			= "Will consider anything inside to be part of the static spawner zone."
ENT.Category		= "Aftershock"
ENT.Spawnable		= true
ENT.Editable        = true

function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "ZoneDistance", {
        KeyName = "Zone Distance",
        Edit = {
            type = "Int",
            min = 100,
            max = 10000
        }
    } )

    self:NetworkVarNotify( "ZoneDistance", self.OnDistChanged )
end

function ENT:OnNPCChanged( name, old, new )
    if old == "" then return end
end