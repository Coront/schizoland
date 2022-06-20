ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Resource Reward"
ENT.Author			= "Tampy"
ENT.Purpose			= "Give them resources"
ENT.Category		= "Aftershock - Event"
ENT.Spawnable		= true
ENT.Editable        = true

function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "Scrap", {
        KeyName = "Scrap Amount",
        Edit = {
            type = "Int",
            min = 1,
            max = 1000,
        }
    } )

    self:NetworkVar( "Int", 1, "SmallParts", {
        KeyName = "Small Parts Amount",
        Edit = {
            type = "Int",
            min = 1,
            max = 1000,
        }
    } )

    self:NetworkVar( "Int", 2, "Chemical", {
        KeyName = "Chemical Amount",
        Edit = {
            type = "Int",
            min = 1,
            max = 1000,
        }
    } )
end

function ENT:SetPlayers( tbl )
    self.Players = tbl
end

function ENT:GetPlayers()
    return self.Players or {}
end

function ENT:AddPlayer( steamid )
    local tbl = self:GetPlayers()
    tbl[steamid] = true
    self:SetPlayers( tbl )
end