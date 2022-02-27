include( "shared.lua" )

function ENT:Draw()
    if LocalPlayer():GetPos():Distance(self:GetPos()) < GetConVar("as_entity_renderdist"):GetInt() then
        self:DrawModel()
        self:DrawShadow(true)
    else
        self:DrawShadow(false)
    end
end

function ENT:Think()
    local ply = LocalPlayer()

    if ply:GetEyeTrace().Entity == self and ply:GetPos():Distance(self:GetPos()) < 100 and not ply:IsDeveloping() then
        if not IsValid( frame_container ) then
            ContainerMenu( self )
        end
    else
        if (IsValid( frame_container ) and frame_container.ent == self) or IsValid( frame_container ) and not IsValid( frame_container.ent ) then
            frame_container:Close()
        end
    end
end

hook.Add( "PlayerButtonDown", "AS_LootContainer", function( ply, button )
    if IsFirstTimePredicted() then
        local button = GetKeyName( button )

        if button == input.LookupBinding( "+use" ) and IsValid(frame_container) and IsValid(frame_container.ent) and frame_container.selectedItem then --Take item from container
            local itemid = frame_container.selectedItem.ID
            local amt = frame_container.ent:GetInventory()[itemid]
            if not frame_container.ent:GetInventory()[itemid] then LocalPlayer():ChatPrint("This item was already taken.") frame_container.containeritemamtUpdate( itemid ) return end
            if frame_container.ent:PlayerCanTakeItem( LocalPlayer(), itemid, frame_container.ent:GetInventory()[itemid] ) then
                frame_container.ent:PlayerTakeItem( LocalPlayer(), itemid, frame_container.ent:GetInventory()[itemid] )
                surface.PlaySound( ITEMCUE.TAKE )
                frame_container.containeritemamtUpdate( itemid )

                net.Start("as_container_takeitem")
                    net.WriteEntity( frame_container.ent )
                    net.WriteString( itemid )
                    net.WriteInt( amt, 32 )
                net.SendToServer()
            end
        elseif button == input.LookupBinding( "+reload" ) and IsValid(frame_container) then
            frame_container:MakePopup()
            frame_container:SetKeyboardInputEnabled( false )
        end
    end
end )