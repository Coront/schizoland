AS_ClientConVar( "as_container_sounds", "1", true, false )

function ContainerMenu( ent )
    if IsValid(frame_container) then frame_container:Close() end
    local isContainer = ent:GetClass() == "as_lootcontainer" and true or false
    if tobool(GetConVar("as_container_sounds"):GetInt()) and isContainer and AS.Loot[ent:GetContainer()] and AS.Loot[ent:GetContainer()].opensound then
        ent:EmitSound(AS.Loot[ent:GetContainer()].opensound)
    end

    frame_container = vgui.Create("DFrame")
    frame_container:SetPos( ScrW() * 0.51, ScrH() * 0.515 )
    frame_container:SetSize(350, 250)
    frame_container:SetDraggable( false )
    frame_container:SetTitle( "" )
    frame_container:ShowCloseButton( false )
    frame_container.ent = ent
    function frame_container:Paint( w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetMaterial( Material("gui/aftershock/default.png") )
        surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
        surface.DrawTexturedRect( 0, 0, w, h )
    end
    function frame_container:OnClose()
        if tobool(GetConVar("as_container_sounds"):GetInt()) and isContainer and IsValid( frame_container.ent ) and AS.Loot[ent:GetContainer()] and AS.Loot[ent:GetContainer()].closesound then
            ent:EmitSound(AS.Loot[ent:GetContainer()].closesound)
        end
    end
    frame_container.selectedItem = nil

    local scroll_items = vgui.Create("DScrollPanel", frame_container)
    scroll_items:SetPos( 18, 10 )
    scroll_items:SetSize( frame_container:GetWide() - (scroll_items:GetX() * 2) - 3, frame_container:GetTall() - (scroll_items:GetY() + 15) )
    scroll_items.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)
    end

    local itemlist = vgui.Create("DIconLayout", scroll_items)
    itemlist:SetPos( 0, 0 )
    itemlist:SetSize( scroll_items:GetWide(), scroll_items:GetTall())
    itemlist:SetSpaceY( 2 )
    itemlist:SetSpaceX( 5 )

    local buttonshelp = vgui.Create("DLabel", frame_container)
    buttonshelp:SetFont("TargetID")
    buttonshelp:SetText( "[" .. string.upper(KEYBIND_USE) .. "] Quick Take Item    [" .. string.upper( input.LookupBinding( "+reload" ) ) .. "] Mouse" )
    buttonshelp:SetContentAlignment( 3 )
    buttonshelp:SizeToContents()
    buttonshelp:SetPos( frame_container:GetWide() / 2 - (buttonshelp:GetWide() / 2), frame_container:GetTall() - buttonshelp:GetTall() - 17 )

    panel = {}
    for k, v in SortedPairs( ent:GetInventory() ) do
        if k == "ammo" then continue end
        local info = AS.Items[k]
        if not info then AS.LuaError("Attempt to index an invalid item in container inventory - " .. k) continue end
        if not frame_container.selectedItem then frame_container.selectedItem = {ID = k, amt = v} end

        panel[k] = itemlist:Add("DPanel")
        panel[k]:SetSize( itemlist:GetWide() - 16, 60 )
        local pan = panel[k]
        function pan:Paint( w, h )
            if frame_container.selectedItem.ID == k then
                surface.SetDrawColor( COLHUD_DEFAULT )
            else
                local col = COLHUD_PRIMARY:ToTable()
                surface.SetDrawColor( col[1], col[2], col[3], 70 )
            end
            surface.DrawRect( 0, 0, w, h )

            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawOutlinedRect( 0, 0, w, h, 1 )
        end

        local iconpanel = vgui.Create("DPanel", panel[k])
        iconpanel:SetSize( panel[k]:GetTall() - 2, panel[k]:GetTall() - 2 )
        iconpanel:SetPos( 1, 1 )
        function iconpanel:Paint( w, h )
            local col = info.color and info.color:ToTable() or COLHUD_PRIMARY:ToTable()
            surface.SetDrawColor( col[1], col[2], col[3], 50 )
            surface.DrawRect( 0, 0, w, h )

            if info.color then
                surface.SetDrawColor( info.color )
            else
                surface.SetDrawColor( COLHUD_PRIMARY )
            end
            surface.DrawOutlinedRect( 0, 0, w, h, 1 )
        end

        local icon = vgui.Create("SpawnIcon", iconpanel)
        icon:SetSize( iconpanel:GetWide(), iconpanel:GetTall() )

        local name = vgui.Create("DLabel", panel[k])
        name:SetFont("TargetID")
        name:SetText( info.name .. " (" .. v .. ")" )
        name:SetContentAlignment( 3 )
        name:SizeToContents()
        name:SetPos( icon:GetWide() + 5, 3 )
        function frame_container.containeritemamtUpdate( key )
            if frame_container.ent:GetInventory()[key] and IsValid(frame_container.ent:GetInventory()[key]) and frame_container.ent:GetInventory()[key] > 1 then
                if IsValid( name ) then
                    name:SetText( info.name .. " (" .. frame_container.ent:GetInventory()[k] .. ")" )
                    name:SizeToContents()
                end
            else
                if IsValid( panel[key] ) then
                    panel[key]:Remove()
                end
                noitem = true
                for k, v in SortedPairs( frame_container.ent:GetInventory() ) do
                    if k == "ammo" then continue end
                    noitem = false
                    frame_container.selectedItem = {ID = k, amt = v}
                    break
                end
                if noitem then
                    if ent:GetInventory().ammo then
                        for k, v in SortedPairs( ent:GetInventory().ammo ) do
                            frame_container.selectedItem = {ID = k, amt = v, ammo = true}
                            break
                        end
                    else
                        frame_container.selectedItem = nil
                    end
                end
            end
        end

        icon:SetModel( AS.Items[k].model, AS.Items[k].skin or 0 )
        icon:SetTooltip( "Left Click to take all.\nRight Click to take amount." )
        icon.DoClick = function( self )
            if frame_container.ent:PlayerCanTakeItem( LocalPlayer(), k, frame_container.ent:GetInventory()[k] ) then
                local amt = frame_container.ent:GetInventory()[k]
                frame_container.ent:PlayerTakeItem( LocalPlayer(), k, frame_container.ent:GetInventory()[k] )
                surface.PlaySound( ITEMCUE.TAKE )
                frame_container.containeritemamtUpdate( k )

                net.Start("as_container_takeitem")
                    net.WriteEntity( frame_container.ent )
                    net.WriteString( k )
                    net.WriteUInt( amt, NWSetting.ItemAmtBits )
                net.SendToServer()
            end
        end
    end
    if ent:GetInventory().ammo then
        for k, v in SortedPairs( ent:GetInventory().ammo ) do
            local info = AS.Items[k]
            if not info then AS.LuaError("Attempt to index an invalid item in container inventory - " .. k) continue end
            if not frame_container.selectedItem then frame_container.selectedItem = {ID = k, amt = v, ammo = true} end

            panel[k] = itemlist:Add("DPanel")
            panel[k]:SetSize( itemlist:GetWide() - 16, 60 )
            panel[k].Paint = function(self,w,h)
                if frame_container.selectedItem.ID == k then
                    surface.SetDrawColor( COLHUD_DEFAULT )
                else
                    local col = COLHUD_PRIMARY:ToTable()
                    surface.SetDrawColor( col[1], col[2], col[3], 70 )
                end
                surface.DrawRect( 0, 0, w, h )

                surface.SetDrawColor( COLHUD_DEFAULT )
                surface.DrawOutlinedRect( 0, 0, w, h, 1 )
            end

            local iconpanel = vgui.Create("DPanel", panel[k])
            iconpanel:SetSize( panel[k]:GetTall() - 2, panel[k]:GetTall() - 2 )
            iconpanel:SetPos( 1, 1 )
            function iconpanel:Paint( w, h )
                local col = info.color and info.color:ToTable() or COLHUD_PRIMARY:ToTable()
                surface.SetDrawColor( col[1], col[2], col[3], 50 )
                surface.DrawRect( 0, 0, w, h )

                if info.color then
                    surface.SetDrawColor( info.color )
                else
                    surface.SetDrawColor( COLHUD_PRIMARY )
                end
                surface.DrawOutlinedRect( 0, 0, w, h, 1 )
            end

            local icon = vgui.Create("SpawnIcon", iconpanel)
            icon:SetSize( iconpanel:GetTall(), iconpanel:GetTall() )

            local name = vgui.Create("DLabel", panel[k])
            name:SetFont("TargetID")
            name:SetText( info.name .. " (" .. v .. ")" )
            name:SetContentAlignment( 3 )
            name:SizeToContents()
            name:SetPos( icon:GetWide() + 5, 3 )
            function frame_container.containerammoamtUpdate( key )
                if frame_container.ent:GetInventory().ammo and frame_container.ent:GetInventory().ammo[key] then
                    if IsValid( name ) then
                        name:SetText( info.name .. " (" .. frame_container.ent:GetInventory().ammo[k] .. ")" )
                        name:SizeToContents()
                    end
                else
                    if IsValid( panel[key] ) then
                        panel[key]:Remove()
                        noitem = true
                        for k, v in SortedPairs( frame_container.ent:GetInventory() ) do
                            if k == "ammo" then continue end
                            frame_container.selectedItem = {ID = k, amt = v}
                            noitem = false
                            break
                        end
                        if noitem then
                            if ent:GetInventory().ammo then
                                for k, v in SortedPairs( ent:GetInventory().ammo ) do
                                    frame_container.selectedItem = {ID = k, amt = v, ammo = true}
                                    break
                                end
                            else
                                frame_container.selectedItem = nil
                            end
                        end
                    end
                end
            end

            icon:SetModel( AS.Items[k].model, AS.Items[k].skin or 0 )
            icon:SetTooltip( "Left Click to take all.\nRight Click to take amount." )
            icon.DoClick = function( self )
                if frame_container.ent:PlayerCanTakeAmmo( LocalPlayer() ) then
                    local amt = frame_container.ent:GetInventory().ammo[k]
                    frame_container.ent:PlayerTakeAmmo( LocalPlayer(), k, amt )
                    surface.PlaySound( ITEMCUE.DROP )
                    frame_container.containerammoamtUpdate( k )

                    net.Start("as_case_takeammo")
                        net.WriteEntity( frame_container.ent )
                        net.WriteString( k )
                        net.WriteUInt( amt, 15 )
                    net.SendToServer()
                end
            end
        end
    end
end