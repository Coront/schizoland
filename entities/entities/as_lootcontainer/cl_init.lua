include( "shared.lua" )

function ENT:Draw()
    self:DrawModel()
end

function ENT:Think()
    local ply = LocalPlayer()

    if ply:GetEyeTrace().Entity == self and ply:GetPos():Distance(self:GetPos()) < 100 then
        if not IsValid( frame_container ) then
            ContainerMenu( self )
        end
    else
        if IsValid( frame_container ) and frame_container.ent == self then
            frame_container:Close()
        end
    end
end