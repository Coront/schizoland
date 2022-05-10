Locker = Locker or {}
local ent

function Locker.Menu()
    ent = net.ReadEntity()
    if not IsValid(ent) then return end
    local profiles = net.ReadTable()

    if IsValid(frame_locker) then frame_locker:Close() end

    frame_locker = vgui.Create("DFrame")
    frame_locker:SetSize(750, 500)
    frame_locker:Center()
    frame_locker:MakePopup()
    frame_locker:SetDraggable( false )
    frame_locker:SetTitle( "" )
    frame_locker:ShowCloseButton( false )
    frame_locker.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local closebutton = vgui.Create("DButton", frame_locker)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_locker:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_locker) then
            frame_locker:Close()
        end
    end

    local pickup = vgui.Create("DButton", frame_locker)
    pickup:SetSize( 80, 20 )
    pickup:SetPos( 5, 3 )
    pickup:SetText("Pick Up")
    pickup:SetEnabled( false )
    pickup:SetTooltip("You are not the owner of this object.")
    if ent:PlayerCanPickUp( LocalPlayer() ) then
        pickup:SetEnabled( true )
        pickup:SetTooltip("Pickup the entity and place it in your inventory.")
    end
    pickup.DoClick = function()
        net.Start("as_tool_pickup")
            net.WriteEntity( ent )
        net.SendToServer()
        frame_locker:Close()
    end

    local panel = vgui.Create("DPanel", frame_locker)
    local x, y, space = 3, 25, 6
    panel:SetPos( x, y )
    panel:SetSize( frame_locker:GetWide() - space, (frame_locker:GetTall() - x) - y )
    panel.Paint = function( self, w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    if ent:GetProfile() != 0 then
        Locker.Displays( panel, ent:GetInventory(), LocalPlayer():GetInventory() )
    else
        if #profiles <= 0 then
            Locker.NewProfile( panel, true )
        else
            Locker.SelectProfile( panel, profiles )
        end
    end
end
net.Receive("as_locker_open", Locker.Menu)

function Locker.NewProfile( parent, first )
    local title = SimpleLabel( parent, "Create a new profile", 0, 0 )
    title:SetPos( (parent:GetWide() / 2) - (title:GetWide() / 2), 150 )

    if not first then
        local txt = "This will cost "
        for k, v in pairs( ent.ProfileCost ) do
            txt = txt .. v .. " " .. AS.Items[k].name .. ", " 
        end
        local warn = SimpleLabel( parent, txt, 0, 0 )
        warn:SetPos( (parent:GetWide() / 2) - (warn:GetWide() / 2), 165 )
    end

    local spawnicon = SimpleSpawnIcon( parent, "models/props_c17/Lockers001a.mdl", 64, 200, 180, "" )

    local name = SimpleTextEntry( parent, "Enter your profile's name", 250, 20, spawnicon:GetX() + spawnicon:GetWide() + 5, spawnicon:GetY() + ((spawnicon:GetTall() / 2) - 10) )

    local create = SimpleButton( parent, "Finish Profile", 100, 20, 0, 0, function()
        frame_locker:Close()
        net.Start("as_locker_createprofile")
            net.WriteEntity( ent )
            net.WriteString( name:GetText() )
        net.SendToServer()
    end)
    create:SetPos( parent:GetWide() / 2 - create:GetWide() / 2, spawnicon:GetY() + spawnicon:GetTall() + 5 )
end

function Locker.SelectProfile( parent, profiles )
    local title = SimpleLabel( parent, "Select a profile", 5, 5, "TargetID" )

    local profilescroll = SimpleScroll( parent, parent:GetWide() - 10, parent:GetTall() - 55, 5, 25, Color( 0, 0, 0, 0 ) )

    local x, y = 0, 0
    for k, v in pairs( profiles ) do
        local panel = SimplePanel( profilescroll, profilescroll:GetWide() - 20, 80, x, y, COLHUD_PRIMARY )
        local icon = SimpleSpawnIcon( panel, "models/props_c17/Lockers001a.mdl", panel:GetTall() - 6, 3, 3, "" )

        local name = SimpleLabel( panel, v.name, icon:GetWide() + 5, icon:GetY(), "TargetIDSmall" )

        local deleteprof = SimpleButton( panel, "Delete Profile", 100, 20, 0, 0, function()
            frame_locker:Close()
            Verify( function()
                net.Start("as_locker_deleteprofile")
                    net.WriteEntity( ent )
                    net.WriteUInt( v.lid, NWSetting.LockerAmtBits )
                net.SendToServer()
            end, true)
        end)
        deleteprof:SetPos( panel:GetWide() - (deleteprof:GetWide() + 5), panel:GetTall() - ( deleteprof:GetTall() + 5 ) )

        local selectprof = SimpleButton( panel, "Load Profile", 100, 20, 0, 0, function()
            frame_locker:Close()
            net.Start("as_locker_setprofile")
                net.WriteEntity( ent )
                net.WriteUInt( v.lid, NWSetting.LockerAmtBits )
            net.SendToServer()
        end)
        selectprof:SetPos( panel:GetWide() - (selectprof:GetWide() + 5), deleteprof:GetY() - ( selectprof:GetTall() ) )

        y = y + panel:GetTall() + 3
    end

    local newprof = SimpleButton( parent, "Create a new profile", 150, 20, 0, 0, function()
        title:Remove()
        profilescroll:Remove()
        Locker.NewProfile( parent )
    end)
    newprof:SetPos( parent:GetWide() - (newprof:GetWide() + 5), parent:GetTall() - (newprof:GetTall() + 5) )
end

function Locker.Displays( parent, lockerinv, plyinv )
    local title = SimpleLabel( parent, ent:GetProfileName(), 5, 5, "TargetID" )

    LockerStorageSearch = SimpleTextEntry( parent, "Search Item...", 265, 20, 5, 50, function( txt )
        if IsValid(Lockerstorelistlayout) then
            Lockerstorelistlayout:Remove()
            Locker.DisplaysBuildStorage( Lockerstorelist, lockerinv, txt )
        end
    end)
    local storage = SimpleLabel( parent, "Storage", 10, 30, "TargetIDSmall" )
    Lockerstorelist = SimpleScroll( parent, 265, parent:GetTall() - 75, 5, 70, Color( 0, 0, 0, 0 ) )
    Locker.DisplaysBuildStorage( Lockerstorelist, lockerinv )

    LockerInventorySearch = SimpleTextEntry( parent, "Search Item...", 265, 20, 275, 50, function( txt )
        if IsValid(Lockerinvlistlayout) then
            Lockerinvlistlayout:Remove()
            Locker.DisplaysBuildInv( Lockerinvlist, plyinv, txt )
        end
    end)
    Lockerinvlist = SimpleScroll( parent, 265, parent:GetTall() - 75, 275, 70, Color( 0, 0, 0, 0 ) )
    local inventory = SimpleLabel( parent, "Inventory", 280, 30, "TargetIDSmall" )
    Locker.DisplaysBuildInv( Lockerinvlist, plyinv )

    local sidepanel = SimplePanel( parent, 200, parent:GetTall(), 0, 0, COLHUD_PRIMARY )
    sidepanel:SetPos( parent:GetWide() - sidepanel:GetWide(), 0 )

    LockerCarryWeight = SimpleLabel( sidepanel, "Inventory Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight(), 5, 0, "TargetIDSmall" )
    LockerStorageWeight = SimpleLabel( sidepanel, "Profile Weight: " .. ent:GetCarryWeight() .. " / " .. ent.ProfileCapacity, 5, 15, "TargetIDSmall" )

    local renameprof = SimpleButton( sidepanel, "Rename Locker", sidepanel:GetWide() - 10, 20, 5, 35, function()
        frame_locker:Close()
        Locker.Rename()
    end)
end

function Locker.DisplaysBuildInv( parent, plyinv, txt )
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

            ent:StoreItem( LocalPlayer(), k, amt:GetValue() )

            if IsValid(Lockerinvlistlayout) then 
                Lockerinvlistlayout:Remove() 
                Locker.DisplaysBuildInv( parent, LocalPlayer():GetInventory(), LockerInventorySearch:GetValue() )
            end
            if IsValid(Lockerstorelistlayout) then 
                Lockerstorelistlayout:Remove() 
                Locker.DisplaysBuildStorage( Lockerstorelist, ent:GetInventory(), LockerStorageSearch:GetValue() )
            end

            LockerCarryWeight:SetText( "Inventory Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
            LockerCarryWeight:SizeToContents()
            LockerStorageWeight:SetText( "Profile Weight: " .. ent:GetCarryWeight() .. " / " .. ent.ProfileCapacity )
            LockerStorageWeight:SizeToContents()
        end)
    end
end

function Locker.DisplaysBuildStorage( parent, lockerinv, txt )
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

            ent:WithdrawItem( LocalPlayer(), k, amt:GetValue() )

            if IsValid(Lockerinvlistlayout) then 
                Lockerinvlistlayout:Remove()
                Locker.DisplaysBuildInv( Lockerinvlist, LocalPlayer():GetInventory(), LockerInventorySearch:GetValue() )
            end
            if IsValid(Lockerstorelistlayout) then 
                Lockerstorelistlayout:Remove() 
                Locker.DisplaysBuildStorage( parent, ent:GetInventory(), LockerStorageSearch:GetValue() )
            end

            LockerCarryWeight:SetText( "Inventory Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
            LockerCarryWeight:SizeToContents()
            LockerStorageWeight:SetText( "Profile Weight: " .. ent:GetCarryWeight() .. " / " .. ent.ProfileCapacity )
            LockerStorageWeight:SizeToContents()
        end)
    end
end

function Locker.Rename()
    local frame = vgui.Create("DFrame")
    frame:SetSize(300, 110)
    frame:Center()
    frame:MakePopup()
    frame:SetDraggable( false )
    frame:SetTitle( "Change Profile Name" )
    frame:ShowCloseButton( false )
    frame.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local closebutton = vgui.Create("DButton", frame)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame) then
            frame:Close()
        end
    end

    local panel = vgui.Create("DPanel", frame)
    local x, y, space = 3, 25, 6
    panel:SetPos( x, y )
    panel:SetSize( frame:GetWide() - space, (frame:GetTall() - x) - y )
    panel.Paint = function( self, w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local name = SimpleTextEntry( panel, ent.name, 250, 20, 0, 0 )
    name:SetPos( (panel:GetWide() / 2) - (name:GetWide() / 2), (panel:GetTall() / 2) - (name:GetTall() / 2) )

    local submit = SimpleButton( panel, "Submit New Name", 200, 20, 0, 0, function()
        frame:Close()
        net.Start("as_locker_renameprofile")
            net.WriteEntity( ent )
            net.WriteString( name:GetText() )
        net.SendToServer()
    end)
    submit:SetPos( (panel:GetWide() / 2) - (submit:GetWide() / 2), panel:GetTall() - (submit:GetTall() + 5) )
end