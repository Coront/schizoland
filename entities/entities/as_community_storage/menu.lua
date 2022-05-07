CLocker = CLocker or {}
local ent

function CLocker.Menu()
    ent = net.ReadEntity()
    if not IsValid(ent) then return end

    if IsValid(frame_clocker) then frame_clocker:Close() end

    frame_clocker = vgui.Create("DFrame")
    frame_clocker:SetSize(750, 500)
    frame_clocker:Center()
    frame_clocker:MakePopup()
    frame_clocker:SetDraggable( false )
    frame_clocker:SetTitle( "" )
    frame_clocker:ShowCloseButton( false )
    frame_clocker.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local closebutton = vgui.Create("DButton", frame_clocker)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_clocker:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_clocker) then
            frame_clocker:Close()
        end
    end

    local pickup = vgui.Create("DButton", frame_clocker)
    pickup:SetSize( 80, 20 )
    pickup:SetPos( 3, 3 )
    pickup:SetText("Hide")
    pickup:SetEnabled( false )
    pickup:SetTooltip("You cannot hide the locker")
    if ent:GetCommunity() == LocalPlayer():GetCommunity() then
        pickup:SetEnabled( true )
        pickup:SetTooltip("Hide the community locker.")
    end
    pickup.DoClick = function()
        frame_clocker:Close()
        net.Start("as_cstorage_hide")
            net.WriteEntity( ent )
        net.SendToServer()
    end

    local panel = vgui.Create("DPanel", frame_clocker)
    local x, y, space = 3, 25, 6
    panel:SetPos( x, y )
    panel:SetSize( frame_clocker:GetWide() - space, (frame_clocker:GetTall() - x) - y )
    panel.Paint = function( self, w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    CLocker.Displays( panel, ent:GetInventory(), LocalPlayer():GetInventory() )
end
net.Receive("as_cstorage_open", CLocker.Menu)

function CLocker.Displays( parent, lockerinv, plyinv )
    local title = SimpleLabel( parent, ent:GetCommunityName() .. " Community Locker", 5, 5, "TargetID" )

    LockerStorageSearch = SimpleTextEntry( parent, "Search Item...", 265, 20, 5, 50, function( txt )
        if IsValid(Lockerstorelistlayout) then
            Lockerstorelistlayout:Remove()
            CLocker.DisplaysBuildStorage( Lockerstorelist, lockerinv, txt )
        end
    end)
    local storage = SimpleLabel( parent, "Storage", 10, 30, "TargetIDSmall" )
    Lockerstorelist = SimpleScroll( parent, 265, parent:GetTall() - 75, 5, 70, Color( 0, 0, 0, 0 ) )
    CLocker.DisplaysBuildStorage( Lockerstorelist, lockerinv )

    LockerInventorySearch = SimpleTextEntry( parent, "Search Item...", 265, 20, 275, 50, function( txt )
        if IsValid(Lockerinvlistlayout) then
            Lockerinvlistlayout:Remove()
            CLocker.DisplaysBuildInv( Lockerinvlist, plyinv, txt )
        end
    end)
    Lockerinvlist = SimpleScroll( parent, 265, parent:GetTall() - 75, 275, 70, Color( 0, 0, 0, 0 ) )
    local inventory = SimpleLabel( parent, "Inventory", 280, 30, "TargetIDSmall" )
    CLocker.DisplaysBuildInv( Lockerinvlist, plyinv )

    local sidepanel = SimplePanel( parent, 200, parent:GetTall(), 0, 0, COLHUD_PRIMARY )
    sidepanel:SetPos( parent:GetWide() - sidepanel:GetWide(), 0 )

    LockerCarryWeight = SimpleLabel( sidepanel, "Inventory Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight(), 5, 0, "TargetIDSmall" )
    LockerStorageWeight = SimpleLabel( sidepanel, "Locker Weight: " .. ent:GetCarryWeight(), 5, 15, "TargetIDSmall" )
end

function CLocker.DisplaysBuildInv( parent, plyinv, txt )
    txt = txt and string.lower(txt) or ""

    Lockerinvlistlayout = SimpleIconLayout( parent, parent:GetWide(), parent:GetTall(), 0, 0, Color( 0, 0, 0, 0 ) )

    for k, v in SortedPairs( plyinv ) do
        if (AS.Items[k].nostore or false) then continue end
        if not string.find( string.lower(k), txt ) and not string.find( string.lower(AS.Items[k].name), txt ) then continue end

        local panel = SimpleLayoutPanel( Lockerinvlistlayout, 80, 120, 0, 0, COLHUD_PRIMARY )
        local name = SimpleLabel( panel, AS.Items[k].name, 5, 5, "TargetIDSmall" )
        local tooltip = AS.Items[k].name .. "\nAmount: " .. v .. "\n\nClick to transfer."
        local amt = SimpleWang( panel, panel:GetWide() - 40, 20, 5, (panel:GetTall() - 25), 1, v )
        local val = SimpleLabel( panel, v .. "x", panel:GetWide() - 30, panel:GetTall() - 23, "TargetIDSmall" )
        local icon = SimpleItemIcon( panel, k, panel:GetWide() - 10, 5, 20, tooltip, function()
            if not ent:CanStoreItem( LocalPlayer(), k, amt:GetValue() ) then return end

            ent:PlayerStoreItem( LocalPlayer(), k, amt:GetValue() )

            if IsValid(Lockerinvlistlayout) then 
                Lockerinvlistlayout:Remove() 
                CLocker.DisplaysBuildInv( parent, LocalPlayer():GetInventory(), LockerInventorySearch:GetValue() )
            end
            if IsValid(Lockerstorelistlayout) then 
                Lockerstorelistlayout:Remove() 
                CLocker.DisplaysBuildStorage( Lockerstorelist, ent:GetInventory(), LockerStorageSearch:GetValue() )
            end

            LockerCarryWeight:SetText( "Inventory Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
            LockerCarryWeight:SizeToContents()
            LockerStorageWeight:SetText( "Locker Weight: " .. ent:GetCarryWeight() )
            LockerStorageWeight:SizeToContents()
        end)
    end
end

function CLocker.DisplaysBuildStorage( parent, lockerinv, txt )
    txt = txt or ""

    Lockerstorelistlayout = SimpleIconLayout( parent, parent:GetWide(), parent:GetTall(), 0, 0, Color( 0, 0, 0, 0 ) )

    for k, v in SortedPairs( lockerinv ) do
        if not string.find( string.lower(k), txt ) and not string.find( string.lower(AS.Items[k].name), txt ) then continue end

        local panel = SimpleLayoutPanel( Lockerstorelistlayout, 80, 120, 0, 0, COLHUD_PRIMARY )
        local name = SimpleLabel( panel, AS.Items[k].name, 5, 5, "TargetIDSmall" )
        local tooltip = AS.Items[k].name .. "\nAmount: " .. v .. "\n\nClick to transfer."
        local amt = SimpleWang( panel, panel:GetWide() - 40, 20, 5, (panel:GetTall() - 25), 1, v )
        local val = SimpleLabel( panel, v .. "x", panel:GetWide() - 30, panel:GetTall() - 23, "TargetIDSmall" )
        local icon = SimpleItemIcon( panel, k, panel:GetWide() - 10, 5, 20, tooltip, function()
            if not ent:CanWithdrawItem( LocalPlayer(), k, amt:GetValue() ) then return end

            ent:PlayerTakeItem( LocalPlayer(), k, amt:GetValue() )

            if IsValid(Lockerinvlistlayout) then 
                Lockerinvlistlayout:Remove()
                CLocker.DisplaysBuildInv( Lockerinvlist, LocalPlayer():GetInventory(), LockerInventorySearch:GetValue() )
            end
            if IsValid(Lockerstorelistlayout) then 
                Lockerstorelistlayout:Remove() 
                CLocker.DisplaysBuildStorage( parent, ent:GetInventory(), LockerStorageSearch:GetValue() )
            end

            LockerCarryWeight:SetText( "Inventory Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
            LockerCarryWeight:SizeToContents()
            LockerStorageWeight:SetText( "Locker Weight: " .. ent:GetCarryWeight() )
            LockerStorageWeight:SizeToContents()
        end)
    end
end