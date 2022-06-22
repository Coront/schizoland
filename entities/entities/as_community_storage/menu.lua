CLocker = CLocker or {}
local ent

function CLocker.Menu()
    ent = net.ReadEntity()
    if not IsValid(ent) then return end

    if IsValid(frame_clocker) then frame_clocker:Close() end

    frame_clocker = vgui.Create("DFrame")
    frame_clocker:SetSize(850, 600)
    frame_clocker:Center()
    frame_clocker:MakePopup()
    frame_clocker:SetDraggable( false )
    frame_clocker:SetTitle( "" )
    frame_clocker:ShowCloseButton( false )
    function frame_clocker:Paint( w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetMaterial( Material("gui/aftershock/default.png") )
        surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
        surface.DrawTexturedRect( 0, 0, w, h )
    end

    local cbuttonsize = 18
    local closebutton = CreateCloseButton( frame_clocker, cbuttonsize, frame_clocker:GetWide() - cbuttonsize - 6, 3 )

    local pickup = vgui.Create("DButton", frame_clocker)
    pickup:SetSize( 80, 16 )
    pickup:SetPos( frame_clocker:GetWide() - pickup:GetWide() - 35, 3 )
    pickup:SetText("Hide")
    pickup:SetEnabled( false )
    pickup:SetTooltip("You cannot hide the locker")
    if ent:GetCommunity() == LocalPlayer():GetCommunity() then
        pickup:SetEnabled( true )
        pickup:SetTooltip("Hide the community locker.")
    end
    function pickup:DoClick()
        frame_clocker:Close()
        net.Start("as_cstorage_hide")
            net.WriteEntity( ent )
        net.SendToServer()
    end
    function pickup:Paint( w, h )
        if self:IsHovered() then
            surface.SetDrawColor( COLHUD_DEFAULT )
            self:SetColor( COLHUD_SECONDARY )
        else
            surface.SetDrawColor( COLHUD_SECONDARY )
            self:SetColor( COLHUD_DEFAULT )
        end
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    local panel = vgui.Create("DPanel", frame_clocker)
    local x, y, space = 44, 25, 96
    panel:SetPos( x, y )
    panel:SetSize( frame_clocker:GetWide() - space, (frame_clocker:GetTall() - 36) - y )
    function panel:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    CLocker.Displays( panel, ent:GetInventory(), LocalPlayer():GetInventory() )
end
net.Receive("as_cstorage_open", CLocker.Menu)

function CLocker.Displays( parent, lockerinv, plyinv )
    local title = SimpleLabel( parent, ent:GetCommunityName() .. " Community Locker", 5, 5, "TargetID" )

    local invweightpan = vgui.Create("DPanel", parent)
    invweightpan:SetPos( 5, 30 )
    invweightpan:SetSize( parent:GetWide() - 10, 20 )
    function invweightpan:Paint( w, h )
        local col = COLHUD_DEFAULT:ToTable()
        surface.SetDrawColor( col[1], col[2], col[3], 255 )
        surface.DrawOutlinedRect( 0, 0, w, h )

        surface.SetDrawColor( col[1], col[2], col[3], 100 )
        surface.DrawRect( 0, 0, (LocalPlayer():GetCarryWeight() / LocalPlayer():MaxCarryWeight()) * w, h )
    end
    LockerCarryWeight = SimpleLabel( invweightpan, "Inventory Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight(), 0, 0, "TargetIDSmall" )
    LockerCarryWeight:SetPos( invweightpan:GetWide() / 2 - LockerCarryWeight:GetWide() / 2, 2 )
    LockerStorageWeight = SimpleLabel( parent, "Locker Weight: " .. ent:GetCarryWeight(), 0, 0, "TargetIDSmall" )
    LockerStorageWeight:SetPos( parent:GetWide() / 2 - LockerStorageWeight:GetWide() / 2, 55 )

    local width = (parent:GetWide() / 2) - 10
    LockerInventorySearch = SimpleTextEntry( parent, "Search Item...", width, 20, 5, 90, function( txt )
        if IsValid(Lockerinvlistlayout) then
            Lockerinvlistlayout:Remove()
            CLocker.DisplaysBuildInv( Lockerinvlist, plyinv, txt )
        end
    end)
    Lockerinvlist = SimpleScroll( parent, width, parent:GetTall() - 120, 5, 115, Color( 0, 0, 0, 0 ) )
    local inventory = SimpleLabel( parent, "Inventory", 5, 73, "TargetIDSmall" )
    CLocker.DisplaysBuildInv( Lockerinvlist, plyinv )

    LockerStorageSearch = SimpleTextEntry( parent, "Search Item...", width, 20, width + 15, 90, function( txt )
        if IsValid(Lockerstorelistlayout) then
            Lockerstorelistlayout:Remove()
            CLocker.DisplaysBuildStorage( Lockerstorelist, lockerinv, txt )
        end
    end)
    local storage = SimpleLabel( parent, "Storage", width + 15, 73, "TargetIDSmall" )
    Lockerstorelist = SimpleScroll( parent, width, parent:GetTall() - 120, width + 15, 115, Color( 0, 0, 0, 0 ) )
    CLocker.DisplaysBuildStorage( Lockerstorelist, lockerinv )
end

function CLocker.DisplaysBuildInv( parent, plyinv, txt )
    txt = txt and string.lower(txt) or ""

    Lockerinvlistlayout = SimpleIconLayout( parent, parent:GetWide(), parent:GetTall(), 0, 0, Color( 0, 0, 0, 0 ) )

    for k, v in SortedPairs( plyinv ) do
        if (AS.Items[k].nostore or false) then continue end
        if not string.find( string.lower(k), txt ) and not string.find( string.lower(AS.Items[k].name), txt ) then continue end

        local panel = SimpleLayoutPanel( Lockerinvlistlayout, 84, 115, 0, 0, COLHUD_PRIMARY )
        function panel:Paint( w, h )
            local col = COLHUD_PRIMARY:ToTable()
            surface.SetDrawColor( col[1], col[2], col[3], 50 )
            surface.DrawRect( 0, 0, w, h )
            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawOutlinedRect( 0, 0, w, h )
        end
        local name = SimpleLabel( panel, AS.Items[k].name, 5, 3, "DermaDefault" )
        local tooltip = AS.Items[k].name .. "\nAmount: " .. v .. "\n\nClick to transfer."
        local amt = SimpleWang( panel, panel:GetWide() - 45, 15, 5, (panel:GetTall() - 18), 1, v )
        local val = SimpleLabel( panel, v .. "x", panel:GetWide() - 38, panel:GetTall() - 18, "DermaDefault" )
        local iconpanel = SimplePanel( panel, panel:GetWide() - 10, panel:GetWide() - 10, 5, 20, Color( 0, 0, 0, 0 ) )
        local icon = SimpleItemIcon( iconpanel, k, iconpanel:GetWide(), 0, 0, tooltip, function()
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
        function iconpanel:Paint( w, h )
            local info = AS.Items[k]
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
    end
end

function CLocker.DisplaysBuildStorage( parent, lockerinv, txt )
    txt = txt or ""

    Lockerstorelistlayout = SimpleIconLayout( parent, parent:GetWide(), parent:GetTall(), 0, 0, Color( 0, 0, 0, 0 ) )

    for k, v in SortedPairs( lockerinv ) do
        if not string.find( string.lower(k), txt ) and not string.find( string.lower(AS.Items[k].name), txt ) then continue end

        local panel = SimpleLayoutPanel( Lockerstorelistlayout, 84, 115, 0, 0, COLHUD_PRIMARY )
        function panel:Paint( w, h )
            local col = COLHUD_PRIMARY:ToTable()
            surface.SetDrawColor( col[1], col[2], col[3], 50 )
            surface.DrawRect( 0, 0, w, h )
            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawOutlinedRect( 0, 0, w, h )
        end
        local name = SimpleLabel( panel, AS.Items[k].name, 5, 3, "DermaDefault" )
        local tooltip = AS.Items[k].name .. "\nAmount: " .. v .. "\n\nClick to transfer."
        local amt = SimpleWang( panel, panel:GetWide() - 45, 15, 5, (panel:GetTall() - 18), 1, v )
        local val = SimpleLabel( panel, v .. "x", panel:GetWide() - 38, panel:GetTall() - 18, "DermaDefault" )
        local iconpanel = SimplePanel( panel, panel:GetWide() - 10, panel:GetWide() - 10, 5, 20, Color( 0, 0, 0, 0 ) )
        local icon = SimpleItemIcon( iconpanel, k, iconpanel:GetWide(), 0, 0, tooltip, function()
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
        function iconpanel:Paint( w, h )
            local info = AS.Items[k]
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
    end
end