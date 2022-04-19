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
        if IsValid(self:GetClaimer()) and LocalPlayer() == self:GetClaimer() or not IsValid(self:GetClaimer()) then
            if not IsValid( frame_container ) then
                ContainerMenu( self )
            end
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

hook.Add("HUDPaint", "AS_Cases", function()
    for k, v in pairs( ents.FindByClass("as_case") ) do
        if LocalPlayer():GetPos():Distance(v:GetPos()) > 250 then continue end

        local trace = util.TraceLine({
            start = LocalPlayer():EyePos(),
            endpos = v:GetPos() + v:OBBCenter(),
            filter = LocalPlayer(),
        })
        if trace.HitWorld then continue end

        local pos = v:GetPos():ToScreen()
        local owner = v:GetNW2String("owner", nil)
        local claimer = v:GetNW2Entity("killer", nil)

        if owner and owner != "" then
            draw.SimpleTextOutlined( owner .. "'s Case", "TargetIDSmall", pos.x, pos.y, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
            if claimer and IsValid(claimer) then
                pos.y = pos.y + 15
                draw.SimpleTextOutlined( "Claimant: " .. claimer:Nickname(), "TargetIDSmall", pos.x, pos.y, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
                pos.y = pos.y + 15
                if LocalPlayer() != claimer then
                    draw.SimpleTextOutlined( "You may be attacked for approaching or looting.", "TargetIDSmall", pos.x, pos.y, COLHUD_BAD, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
                end
            end
        end
    end
end)