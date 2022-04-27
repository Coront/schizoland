ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Power Pylon"
ENT.Author			= "Tampy"
ENT.Purpose			= "A power pylon. It conducts electricity."
ENT.Category		= "Aftershock"
ENT.Spawnable		= false
ENT.AS_OwnableObject = true
ENT.AS_Conductor = true

ENT.PL = {}
ENT.PL.Bank = true --We store electricity.

function ENT:Think()
    self:SetElectricityAmount( self:CalculateInletElectricity() )

    for k, v in pairs( self:GetInletTable() ) do
        if not IsValid(k) then self.PL.Inlet[k] = nil continue end
        k:SetElectricityAmount( 0 )
    end
end