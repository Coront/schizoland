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
    if CurTime() > (self:GetCreationTime() + NWSetting.PostCreationDelay) and CurTime() > (self.NextResync or 0) then
        self:Resync()
        self.NextResync = CurTime() + NWSetting.EntUpdateLength
    end

    local ply = LocalPlayer()

    if ply:GetEyeTrace().Entity == self and ply:GetPos():Distance(self:GetPos()) < 100 and not ply:IsDeveloping() and table.Count(self:GetInventory()) > 0 then
        if not IsValid( frame_container ) then
            ContainerMenu( self )
        end
    else
        if (IsValid( frame_container ) and frame_container.ent == self) or IsValid( frame_container ) and not IsValid( frame_container.ent ) then
            frame_container:Close()
        end
    end
end

function ENT:OnRemove()
    if IsValid(frame_container) and frame_container.ent == self then
        frame_container:Close()
    end
end

hook.Add( "PlayerButtonDown", "AS_LootContainer", function( ply, button )
    if IsFirstTimePredicted() then
        if CurTime() < (ply.NextItemLootTime or 0) then return end
        local button = GetKeyName( button )

        if button == input.LookupBinding( "+use" ) and IsValid(frame_container) and IsValid(frame_container.ent) and frame_container.selectedItem then --Take item from container
            local itemid = frame_container.selectedItem.ID
            if not frame_container.selectedItem.ammo then
                local amt = frame_container.ent:GetInventory()[itemid]
                if not frame_container.ent:GetInventory()[itemid] then LocalPlayer():ChatPrint("This item isn't in the container.") frame_container.containeritemamtUpdate( itemid ) return end
                if frame_container.ent:PlayerCanTakeItem( LocalPlayer(), itemid, frame_container.ent:GetInventory()[itemid] ) then
                    frame_container.ent:PlayerTakeItem( LocalPlayer(), itemid, frame_container.ent:GetInventory()[itemid] )
                    if frame_container.ent:GetClass() != "as_case" then
                        surface.PlaySound( ITEMCUE.TAKE )
                    end
                    frame_container.containeritemamtUpdate( itemid )

                    net.Start("as_container_takeitem")
                        net.WriteEntity( frame_container.ent )
                        net.WriteString( itemid )
                        net.WriteUInt( amt, NWSetting.ItemAmtBits )
                    net.SendToServer()
                end
            else
                local amt = frame_container.ent:GetInventory().ammo[itemid]
                if not frame_container.ent:GetInventory().ammo[itemid] then LocalPlayer():ChatPrint("This item was already taken.") frame_container.containerammoamtUpdate( itemid ) return end
                if frame_container.ent:PlayerCanTakeAmmo( LocalPlayer() ) then
                    frame_container.ent:PlayerTakeAmmo( LocalPlayer(), itemid, frame_container.ent:GetInventory().ammo[itemid] )
                    surface.PlaySound( ITEMCUE.DROP )
                    frame_container.containerammoamtUpdate( itemid )

                    net.Start("as_case_takeammo")
                        net.WriteEntity( frame_container.ent )
                        net.WriteString( itemid )
                        net.WriteUInt( amt, 15 )
                    net.SendToServer()
                end
            end
            ply.NextItemLootTime = CurTime() + 0.15
        elseif button == input.LookupBinding( "+reload" ) and IsValid(frame_container) then
            frame_container:MakePopup()
            frame_container:SetKeyboardInputEnabled( false )
        end
    end
end )

hook.Add( "PreDrawHalos", "AS_Container_Indicator", function()
    if LocalPlayer():IsDeveloping() then return end

    local container = {}
    for k, v in pairs( ents.FindByClass("as_lootcontainer") ) do
        if LocalPlayer():GetPos():Distance(v:GetPos()) > 250 then continue end
        if v and IsValid(v) and v.Inventory and table.Count(v.Inventory) > 0 then
            container[#container + 1] = v
        end
    end

    halo.Add( container, COLHUD_DEFAULT, 1, 1, 1, true, false )
end)