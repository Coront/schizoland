ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= ""
ENT.Author			= "Tampy"
ENT.Purpose			= ""
ENT.Category		= "Aftershock"
ENT.Spawnable		= false

function ENT:SetAmmoType( id )
    self.AmmoType = id
end

function ENT:GetAmmoType()
    return self.AmmoType
end

function ENT:SetAmmoAmount( amt )
    self.AmmoAmount = amt 
end

function ENT:GetAmmoAmount()
    return self.AmmoAmount
end