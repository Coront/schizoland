include( "shared.lua" )

function ENT:Draw()
    if LocalPlayer():IsDeveloping() then
        self:DrawModel()
        self:DrawShadow(true)

        local col = COLHUD_DEFAULT or Color( 255, 255, 255 )
        render.SetColorMaterial()
        render.DrawWireframeBox( self:GetSpawnPos(), Angle( 0, 0, 0 ), Vector( -15, -15, 0 ), Vector( 15, 15, 70 ), col, true )
        render.DrawLine( Vector( self:GetSpawnPos() ), self:GetSpawnAngVisual(), col, true )
    else
        self:DrawShadow(false)
    end
end