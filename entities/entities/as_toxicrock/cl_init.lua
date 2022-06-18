include( "shared.lua" )

function ENT:Draw()
    if LocalPlayer():IsDeveloping() then
        self:DrawModel()
        self:DrawShadow(true)

        local col = COLHUD_BAD or Color( 255, 255, 255 )
        render.SetColorMaterial()
        render.DrawWireframeSphere( self:GetPos(), self:GetToxicDistance(), 15, 15, col, true )
    else
        self:DrawShadow(false)
    end
end