include( "shared.lua" )

function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) < 2000 then
        self:DrawModel()
        self:DrawShadow(true)
    else
        self:DrawShadow(false)
    end
end