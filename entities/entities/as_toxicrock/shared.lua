ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Toxic Rock"
ENT.Author			= "Tampy"
ENT.Purpose			= "idfk"
ENT.Category		= "Aftershock"
ENT.Spawnable		= true
ENT.Editable        = true

function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "ToxicDistance", {
        KeyName = "Distance",
        Edit = {
            type = "Int",
            min = 100,
            max = 5000
        }
    } )

    self:NetworkVar( "Int", 1, "ToxicAmt", {
        KeyName = "Amount",
        Edit = {
            type = "Int",
            min = 1,
            max = 100
        }
    } )
end