ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Vending Machine"
ENT.Author			= "Tampy"
ENT.Purpose			= "Sell your junk in it."
ENT.Category		= "Aftershock"
ENT.Spawnable		= false
ENT.AS_OwnableObject = true

ENT.ProfileCost = {
    ["misc_scrap"] = 200,
    ["misc_smallparts"] = 150,
    ["misc_chemical"] = 250,
}

function ENT:SetProfile()

end

function ENT:GetProfile()

end