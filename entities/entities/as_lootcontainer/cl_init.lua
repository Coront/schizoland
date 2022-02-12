include( "shared.lua" )

function ENT:Draw()
    self:DrawModel()
end

function ENT:Think()
    local ply = LocalPlayer()

    if ply:GetEyeTrace().Entity == self and ply:GetPos():Distance(self:GetPos()) < 150 then
        if not IsValid( ContainerMenu ) then
            ContainerMenu()
        end
    end
end