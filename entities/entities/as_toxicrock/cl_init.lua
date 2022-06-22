include( "shared.lua" )

function ENT:Draw()
    self:DrawModel()

    if LocalPlayer():IsDeveloping() then
    local col = COLHUD_BAD or Color( 255, 255, 255 )
        render.SetColorMaterial()
        render.DrawWireframeSphere( self:GetPos(), self:GetToxicDistance(), 15, 15, col, true )
    end
end