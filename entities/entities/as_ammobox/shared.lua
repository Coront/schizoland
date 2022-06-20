ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Ammo Box"
ENT.Author			= "Tampy"
ENT.Purpose			= "Here dr freeman, gotta reload"
ENT.Category		= "Aftershock - Event"
ENT.Spawnable		= true
ENT.Editable        = true

function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "Amount", {
        KeyName = "Ammo Box Amount",
        Edit = {
            type = "Int",
            min = 1,
            max = 20,
        }
    } )
end

ENT.Items = { --Ammo type players can select (can be regular items too for whatever reason.)
    --Key is itemid, value is order (greatest to least)
    ["ammo_9mm"] = 1,
    ["ammo_45acp"] = 2,
    ["ammo_44mag"] = 3,
    ["ammo_50ae"] = 4,
    ["ammo_556x45"] = 5,
    ["ammo_762x39"] = 6,
    ["ammo_buckshot"] = 7,
    ["ammo_pulse"] = 8,
    ["ammo_762x51"] = 9,
}

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