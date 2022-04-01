include( "shared.lua" )

function ENT:Draw()
    if IsValid(self:GetClaimer()) and LocalPlayer() != self:GetClaimer() and (not LocalPlayer():IsAdmin() or LocalPlayer():IsAdmin() and not LocalPlayer():IsDeveloping()) then return end

    if LocalPlayer():GetPos():Distance(self:GetPos()) < GetConVar("as_entity_renderdist"):GetInt() then
        self:DrawModel()
        self:DrawShadow(true)
    else
        self:DrawShadow(false)
    end
end

function ENT:Think()
    local ply = LocalPlayer()

    if ply:GetEyeTrace().Entity == self and ply:GetPos():Distance(self:GetPos()) < 100 and self:GetInventory() != nil and LocalPlayer():Alive() then
        if not IsValid( frame_container ) then
            ContainerMenu( self )
        end
    else
        if (IsValid( frame_container ) and frame_container.ent == self) or IsValid(frame_container) and not IsValid( frame_container.ent ) then
            frame_container:Close()
        end
    end
end

function ENT:OnRemove()
    if IsValid(frame_container) and frame_container.ent == self then
        frame_container:Close()
    end
end

hook.Add( "PreDrawHalos", "AS_Case_Indicator", function()
    if LocalPlayer():IsDeveloping() then return end

    local container = {}
    for k, v in pairs( ents.FindByClass("as_case") ) do
        if LocalPlayer():GetPos():Distance(v:GetPos()) > 250 then continue end
        if v and IsValid(v) and v.Inventory and table.Count(v.Inventory) > 0 then
            container[#container + 1] = v
        end
    end

    halo.Add( container, COLHUD_DEFAULT, 1, 1, 1, true, false )
end)