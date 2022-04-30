include( "shared.lua" )
include( "menu.lua" )

function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) < GetConVar("as_entity_renderdist"):GetInt() then
        self:DrawModel()
        self:DrawShadow(true)

        if self:GetObjectOwner() == LocalPlayer() and IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physgun" then
            local maxs = self:OBBMaxs():ToTable()
            render.DrawWireframeBox( self:GetPos(), self:GetAngles(), self:OBBMins(), Vector( maxs[1], maxs[2], 0 ), COLHUD_DEFAULT, true )
        end
    else
        self:DrawShadow(false)
    end
end