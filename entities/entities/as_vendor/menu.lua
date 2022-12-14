Vendor = Vendor or {}
local ent

function Vendor.Menu()
    ent = net.ReadEntity()
    if not IsValid(ent) then return end
    local profiles = net.ReadTable()

    if IsValid(frame_vendor) then frame_vendor:Close() end

    frame_vendor = vgui.Create("DFrame")
    frame_vendor:SetSize(750, 550)
    frame_vendor:Center()
    frame_vendor:MakePopup()
    frame_vendor:SetDraggable( false )
    frame_vendor:SetTitle( "" )
    frame_vendor:ShowCloseButton( false )
    function frame_vendor:Paint( w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetMaterial( Material("gui/aftershock/default.png") )
        surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
        surface.DrawTexturedRect( 0, 0, w, h )
    end

    local cbuttonsize = 17
    local closebutton = CreateCloseButton( frame_vendor, cbuttonsize, frame_vendor:GetWide() - cbuttonsize - 6, 3 )

    local pickup = vgui.Create("DButton", frame_vendor)
    pickup:SetSize( 80, 15 )
    pickup:SetPos( frame_vendor:GetWide() - (cbuttonsize + 15) - pickup:GetWide(), 3 )
    pickup:SetText("Pick Up")
    pickup:SetEnabled( false )
    pickup:SetTooltip("You are not the owner of this object.")
    if ent:PlayerCanPickUp( LocalPlayer() ) then
        pickup:SetEnabled( true )
        pickup:SetTooltip("Pickup the entity and place it in your inventory.")
    end
    function pickup:DoClick()
        net.Start("as_tool_pickup")
            net.WriteEntity( ent )
        net.SendToServer()
        frame_vendor:Close()
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

    local panel = vgui.Create("DPanel", frame_vendor)
    local x, y, space = 39, 23, 86
    panel:SetPos( x, y )
    panel:SetSize( frame_vendor:GetWide() - space, (frame_vendor:GetTall() - x) - 17 )
    function panel:Paint( w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    if ent:GetProfile() != 0 then
        if ent:GetObjectOwner() == LocalPlayer() then
            Vendor.BuildManagement( panel, ent:GetSales(), ent:GetResources() )
        else
            Vendor.BuildShop( panel, ent:GetSales() )
        end
    else
        if ent:GetObjectOwner() != LocalPlayer() then frame_vendor:Close() LocalPlayer():ChatPrint("This vendor does not have an assigned profiled.") end
        if #profiles <= 0 then
            frame_vendor:Close()
            Vendor.NewProfile( true )
        else
            Vendor.SelectProfile( panel, profiles )
        end
    end
end
net.Receive( "as_vendor_open", Vendor.Menu )

function Vendor.SelectProfile( parent, profiles )
    local title = SimpleLabel( parent, "Select a profile", 5, 5, "TargetID" )

    local profilescroll = SimpleScroll( parent, parent:GetWide() - 10, parent:GetTall() - 55, 5, 25, Color( 0, 0, 0, 0 ) )
    function profilescroll:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h )
    end

    local x, y = 5, 5
    for k, v in pairs( profiles ) do
        local panel = SimplePanel( profilescroll, profilescroll:GetWide() - 25, 80, x, y )
        function panel:Paint( w, h )
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawOutlinedRect( 0, 0, w, h, 1 )
        end
        local icon = SimpleSpawnIcon( panel, "models/props_c17/consolebox01a.mdl", panel:GetTall() - 6, 3, 3, "" )

        local name = SimpleLabel( panel, v.name, icon:GetWide() + 5, icon:GetY(), "TargetIDSmall" )

        local deleteprof = DefaultButton( "Delete Profile", 0, 0, 100, 20, panel, function()
            frame_vendor:Close()
            Verify( function()
                net.Start("as_vendor_deleteprofile")
                    net.WriteEntity( ent )
                    net.WriteUInt( v.vid, NWSetting.UIDAmtBits )
                net.SendToServer()
            end, true)
        end)
        deleteprof:SetPos( panel:GetWide() - (deleteprof:GetWide() + 5), panel:GetTall() - ( deleteprof:GetTall() + 5 ) )

        local selectprof = DefaultButton( "Load Profile", 0, 0, 100, 20, panel, function()
            frame_vendor:Close()
            net.Start("as_vendor_setprofile")
                net.WriteEntity( ent )
                net.WriteUInt( v.vid, NWSetting.UIDAmtBits )
            net.SendToServer()
        end)
        selectprof:SetPos( panel:GetWide() - (selectprof:GetWide() + 5), deleteprof:GetY() - ( selectprof:GetTall() ) )

        y = y + panel:GetTall() + 3
    end
    local newprof = DefaultButton( "Create a new Profile", 0, 0, 150, 20, parent, function()
        frame_vendor:Close()
        Vendor.NewProfile()
    end)
    newprof:SetPos( parent:GetWide() - (newprof:GetWide() + 5), parent:GetTall() - (newprof:GetTall() + 5) )
end

function Vendor.BuildManagement( parent, sales, res )
    ManagementPanel = SimplePanel( parent, parent:GetWide(), parent:GetTall(), 0, 0, Color( 0, 0, 0, 0 ) )
    local title = SimpleLabel( ManagementPanel, ent.name, 5, 5, "TargetID" )

    local saleslist = SimpleScroll( ManagementPanel, 250, ManagementPanel:GetTall() - 55, 5, 50, COLHUD_SECONDARY )
    function saleslist:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end
    local listed = SimpleLabel( ManagementPanel, "Listed Items", 10, 30, "TargetIDSmall" )
    local x, y = 5, 5
    for k, v in pairs( sales ) do
        local col = COLHUD_PRIMARY:ToTable()
        local panel = SimplePanel( saleslist, saleslist:GetWide() - 25, 80, x, y, Color( col[1], col[2], col[3], 100 ) )
        local icon = SimpleItemIcon( panel, k, panel:GetTall() - 6, 3, 3, "Click to manage.", function()
            local dmenu = DermaMenu()
            dmenu:AddOption("Modify Price", function()
                frame_vendor:Close()
                Vendor.ModifyListPrice( k )
            end)
            dmenu:AddOption("Create a Display", function()
                frame_vendor:Close()
                net.Start("as_vendor_item_createdisplay")
                    net.WriteEntity( ent )
                    net.WriteString( k )
                net.SendToServer()
            end)
            dmenu:AddOption("Withdraw", function()
                frame_vendor:Close()
                Vendor.TakeFromListedItem( k )
            end)
            dmenu:AddOption("Withdraw All", function()
                frame_vendor:Close()
                net.Start("as_vendor_item_unlist")
                    net.WriteEntity( ent )
                    net.WriteString( k )
                    net.WriteUInt( ent:GetSales()[k].amt, NWSetting.ItemAmtBits )
                net.SendToServer()
            end)
            dmenu:Open()
        end)

        local name = SimpleLabel( panel, AS.Items[k].name, icon:GetWide() + 5, icon:GetY(), "TargetIDSmall" )
        local amt = SimpleLabel( panel, "Amount: " .. v.amt, icon:GetWide() + 5, icon:GetY() + 15, "DermaDefault" )
        local scrap = SimpleLabel( panel, "Scrap: " .. v.scrap, icon:GetWide() + 5, icon:GetY() + 35, "DermaDefault" )
        local sp = SimpleLabel( panel, "Small Parts: " .. v.smallp, icon:GetWide() + 5, icon:GetY() + 50, "DermaDefault" )
        local chem = SimpleLabel( panel, "Chemicals: " .. v.chemical, icon:GetWide() + 5, icon:GetY() + 65, "DermaDefault" )

        y = y + panel:GetTall() + 3
    end

    local inv = SimpleScroll( ManagementPanel, 250, ManagementPanel:GetTall() - 55, saleslist:GetWide() + 10, 50, COLHUD_SECONDARY )
    function inv:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end
    local inventory = SimpleLabel( ManagementPanel, "Inventory", saleslist:GetWide() + 15, 30, "TargetIDSmall" )
    local x, y = 5, 5
    for k, v in pairs( LocalPlayer():GetInventory() ) do
        if AS.Items[k].novendor then continue end

        local col = COLHUD_PRIMARY:ToTable()
        local panel = SimplePanel( inv, inv:GetWide() - 25, 80, x, y, Color( col[1], col[2], col[3], 100 ) )
        local icon = SimpleItemIcon( panel, k, panel:GetTall() - 6, 3, 3, "Click to set up for sale.", function()
            frame_vendor:Close()
            if not ent:SaleExists( k ) then
                Vendor.ListItem( k )
            else
                Vendor.AddToListedItem( k )
            end
        end)

        local name = SimpleLabel( panel, AS.Items[k].name, icon:GetWide() + 5, icon:GetY(), "TargetIDSmall" )
        local amount = SimpleLabel( panel, "Amount: " .. v, icon:GetWide() + 5, icon:GetY() + 15, "DermaDefault" )

        y = y + panel:GetTall() + 3
    end

    local sidepanel = SimplePanel( ManagementPanel, 150, ManagementPanel:GetTall(), 0, 0, COLHUD_PRIMARY )
    sidepanel:SetPos( ManagementPanel:GetWide() - sidepanel:GetWide() - 5, inv:GetY() )

    local respanel = SimplePanel( sidepanel, sidepanel:GetWide() - 5, sidepanel:GetWide() - 10, 5, 0, COLHUD_SECONDARY )
    function respanel:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end
    local invres = SimpleLabel( respanel, "Scrap: " .. (res["misc_scrap"] or 0) .. " / " .. ent.ResCapacity .. "\nSmall Parts: " .. (res["misc_smallparts"] or 0) .. " / " .. ent.ResCapacity .. "\nChemicals: " .. (res["misc_chemical"] or 0) .. " / " .. ent.ResCapacity .. "\n\nWeight: " .. ent:CarryWeight() .. " / " .. ent.ProfileCapacity, 3, 3, "DermaDefault" )

    local withdraw = DefaultButton( "Withdraw Resources", 5, respanel:GetTall() + 5, sidepanel:GetWide() - 5, 20, sidepanel, function()
        frame_vendor:Close()
        net.Start("as_vendor_withdrawres")
            net.WriteEntity( ent )
        net.SendToServer()
    end)
    local changemodel = DefaultButton( "Change Model", 5, withdraw:GetY() + withdraw:GetTall() + 10, sidepanel:GetWide() - 5, 20, sidepanel, function()
        frame_vendor:Close()
        Vendor.Models()
    end)
    local changename = DefaultButton( "Change Profile Name", 5, changemodel:GetY() + changemodel:GetTall(), sidepanel:GetWide() - 5, 20, sidepanel, function()
        frame_vendor:Close()
        Vendor.Rename()
    end)
    local changeprofile = DefaultButton( "Unload Profile", 5, changename:GetY() + changename:GetTall(), sidepanel:GetWide() - 5, 20, sidepanel, function()
        frame_vendor:Close()
        net.Start("as_vendor_unloadprofile")
            net.WriteEntity( ent )
        net.SendToServer()
    end)
    local viewvendor = DefaultButton( "View Vendor", 5, changeprofile:GetY() + changeprofile:GetTall(), sidepanel:GetWide() - 5, 20, sidepanel, function()
        ManagementPanel:Remove()
        Vendor.BuildShop( parent, ent:GetSales() )
    end)
end

function Vendor.BuildShop( parent, sales )
    local title = SimpleLabel( parent, ent.name, 5, 5, "TargetID" )

    local saleslist = SimpleScroll( parent, parent:GetWide() - 10, parent:GetTall() - 35, 5, 30, COLHUD_SECONDARY )
    function saleslist:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end
    local x, y = 5, 5
    for k, v in pairs( sales ) do
        local panel = SimplePanel( saleslist, saleslist:GetWide() - 25, 100, x, y, COLHUD_PRIMARY )
        function panel:Paint( w, h )
            local col = COLHUD_PRIMARY:ToTable()
            surface.SetDrawColor( col[1], col[2], col[3], 100 )
            surface.DrawRect( 0, 0, w, h )
            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawOutlinedRect( 0, 0, w, h, 1 )
        end
        local icon = SimpleItemIcon( panel, k, panel:GetTall() - 10, 5, 5, AS.Items[k].name .. "\nWeight: " .. AS.Items[k].weight .. "\nAmount: " .. v.amt .. "\nScrap: " .. v.scrap .. "\nSmall Parts: " .. v.smallp .. "\nChemicals: " .. v.chemical)
        local name = SimpleLabel( panel, AS.Items[k].name, icon:GetWide() + 10, icon:GetY() + 5, "TargetIDSmall" )
        local scroll_desc = vgui.Create("DScrollPanel", panel)
        scroll_desc:SetSize( 400, 50 )
        scroll_desc:SetPos( icon:GetWide() + 20, icon:GetY() + 20 )
        function scroll_desc:Paint( w, h )
            surface.SetDrawColor( Color( 0,0,0,0 ) )
            surface.DrawRect( 0, 0, w, h )
        end
        local desc = vgui.Create("DLabel", scroll_desc )
        desc:SetPos( 0, 0 )
        desc:SetFont( "DermaDefault" )
        desc:SetText( AS.Items[k].desc )
        desc:SetSize( scroll_desc:GetWide() - 15, scroll_desc:GetTall() )
        desc:SetWrap( true )
        desc:SetAutoStretchVertical( true )

        local amt = SimpleLabel( panel, "Amount For Sale: " .. v.amt, 0, 0, "DermaDefault" )
        amt:SetPos( panel:GetWide() - (amt:GetWide() + 5), 5 )
        local scrap = SimpleLabel( panel, "Scrap: " .. v.scrap, 0, 0, "DermaDefault" )
        scrap:SetPos( panel:GetWide() - (scrap:GetWide() + 5), 20 )
        local sp = SimpleLabel( panel, "Small Parts: " .. v.smallp, 0, 0, "DermaDefault" )
        sp:SetPos( panel:GetWide() - (sp:GetWide() + 5), 35 )
        local chem = SimpleLabel( panel, "Chemicals: " .. v.chemical, 0, 0, "DermaDefault" )
        chem:SetPos( panel:GetWide() - (chem:GetWide() + 5), 50 )

        local tobuyamt = SimpleSlider( panel, "", 200, 20, panel:GetWide() - (185), panel:GetTall() - (40), 1, v.amt )
        local purchase = DefaultButton( "Purchase", panel:GetWide() - 105, panel:GetTall() - 20, 100, 15, panel, function()
            frame_vendor:Close()
            net.Start( "as_vendor_item_purchase" )
                net.WriteEntity( ent )
                net.WriteString( k )
                net.WriteUInt( tobuyamt:GetValue(), NWSetting.ItemAmtBits )
            net.SendToServer()
        end)

        y = y + panel:GetTall() + 3
    end
end

--  ????????????????????? ????????????????????????????????????  ??????????????????????????????????????????????????????     ????????????   ????????????????????????????????????????????????   ??????????????????   ?????????????????????????????????
-- ???????????????????????????????????????????????????????????????  ?????????????????????????????????????????????????????????    ??????????????? ??????????????????????????????????????????????????????  ??????????????????   ?????????????????????????????????
-- ?????????   ?????????   ?????????   ??????????????????????????????????????????  ????????????????????????    ???????????????????????????????????????????????????  ?????????????????? ??????????????????   ?????????????????????????????????
-- ?????????   ?????????   ?????????   ??????????????????????????????????????????  ????????????????????????    ???????????????????????????????????????????????????  ???????????????????????????????????????   ?????????????????????????????????
-- ???????????????????????????   ?????????   ?????????  ??????????????????????????????????????????  ?????????    ????????? ????????? ?????????????????????????????????????????? ?????????????????????????????????????????????????????????????????????
--  ?????????????????????    ?????????   ?????????  ??????????????????????????????????????????  ?????????    ?????????     ??????????????????????????????????????????  ??????????????? ????????????????????? ????????????????????????

function Vendor.NewProfile( first )
    local frame = vgui.Create("DFrame")
    frame:SetSize(700, 400)
    frame:Center()
    frame:MakePopup()
    frame:SetDraggable( false )
    frame:SetTitle( "" )
    frame:ShowCloseButton( false )
    function frame:Paint( w, h )
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

    local title = SimpleLabel( frame, "Create a new profile", 0, 0 )
    title:SetPos( (frame:GetWide() / 2) - (title:GetWide() / 2), 150 )

    if not first then
        local txt = "This will cost "
        for k, v in pairs( ent.ProfileCost ) do
            txt = txt .. v .. " " .. AS.Items[k].name .. ", " 
        end
        local warn = SimpleLabel( frame, txt, 0, 0 )
        warn:SetPos( (frame:GetWide() / 2) - (warn:GetWide() / 2), 170 )
    end

    local spawnicon = SimpleSpawnIcon( frame, "models/props_c17/consolebox01a.mdl", 64, 180, 180, "" )

    local name = SimpleTextEntry( frame, "Enter your profile's name", 250, 20, spawnicon:GetX() + spawnicon:GetWide() + 5, spawnicon:GetY() + ((spawnicon:GetTall() / 2) - 10) )

    local create = SimpleButton( frame, "Finish Profile", 100, 20, 0, 0, function()
        frame:Close()
        net.Start("as_vendor_createprofile")
            net.WriteEntity( ent )
            net.WriteString( name:GetText() )
        net.SendToServer()
    end)
    create:SetPos( (spawnicon:GetX() + spawnicon:GetWide() + 5 + name:GetWide()) / 2 + (create:GetWide() / 2), spawnicon:GetY() + spawnicon:GetTall() + 5 )
end

function Vendor.Rename()
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
        net.Start("as_vendor_renameprofile")
            net.WriteEntity( ent )
            net.WriteString( name:GetText() )
        net.SendToServer()
    end)
    submit:SetPos( (panel:GetWide() / 2) - (submit:GetWide() / 2), panel:GetTall() - (submit:GetTall() + 5) )
end

function Vendor.Models()
    local frame = vgui.Create("DFrame")
    frame:SetSize(415, 250)
    frame:Center()
    frame:MakePopup()
    frame:SetDraggable( false )
    frame:SetTitle( "Change Model" )
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

    local scroll = SimpleScroll( panel, panel:GetWide(), panel:GetTall(), 0, 0, Color( 0, 0, 0, 0 ) )
    local layout = SimpleIconLayout( scroll, scroll:GetWide(), scroll:GetTall(), 0, 0, Color( 0, 0, 0, 0 ) )

    for k, v in pairs( ent.Models ) do
        local spawnicon = layout:Add( "SpawnIcon" )
        spawnicon:SetModel( k )
        spawnicon:SetSize( 64, 64 )
        spawnicon:SetTooltip( k .. "\nClick to change model." )
        spawnicon.DoClick = function()
            frame:Close()
            surface.PlaySound("buttons/button15.wav")
            net.Start("as_vendor_changemodel")
                net.WriteEntity(ent)
                net.WriteString(k)
            net.SendToServer()
        end
    end
end

function Vendor.ListItem( k )
    local frame = vgui.Create("DFrame")
    frame:SetSize(400, 225)
    frame:Center()
    frame:MakePopup()
    frame:SetDraggable( false )
    frame:SetTitle( "" )
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

    local panel = SimplePanel( frame, frame:GetWide() - 6, frame:GetTall() - 28, 3, 25, COLHUD_SECONDARY )

    local icon = SimpleItemIcon( panel, k, 70, 0, 0, AS.Items[k].name )
    local label = SimpleLabel( panel, AS.Items[k].name, icon:GetWide() + 2, 0, "TargetID" )
    local craft = SimpleLabel( panel, "Default Crafting Price\nScrap: " .. (AS.Items[k].craft["misc_scrap"] or 0) .. "\nSmall Parts: " .. (AS.Items[k].craft["misc_smallparts"] or 0) .. "\nChemicals: " .. (AS.Items[k].craft["misc_chemical"] or 0), icon:GetWide() + 2, 18, "DermaDefault" )

    local width, height, x, y, space = panel:GetWide(), 20, 5, icon:GetTall() + 5, 20
    local amt = SimpleSlider( panel, "Amount for Sale", width, height, x, y, 1, LocalPlayer():GetInventory()[k] )
    y = y + space + 15
    local scrap = SimpleSlider( panel, "Scrap", width, height, x, y, 0, ent.MaxPrice )
    y = y + space
    local smallp = SimpleSlider( panel, "Small Parts", width, height, x, y, 0, ent.MaxPrice )
    y = y + space
    local chem = SimpleSlider( panel, "Chemicals", width, height, x, y, 0, ent.MaxPrice )

    local create = SimpleButton( panel, "Create Sale", 200, 20, 0, 0, function()
        frame:Close()
        net.Start("as_vendor_item_list")
            net.WriteEntity( ent )
            net.WriteString( k )
            net.WriteUInt( amt:GetValue(), NWSetting.ItemAmtBits )
            net.WriteUInt( scrap:GetValue(), NWSetting.VendorPriceBits ) --scrap
            net.WriteUInt( smallp:GetValue(), NWSetting.VendorPriceBits ) --smallparts
            net.WriteUInt( chem:GetValue(), NWSetting.VendorPriceBits ) --chemicals
        net.SendToServer()
    end)
    create:SetPos( (panel:GetWide() / 2) - (create:GetWide() / 2), panel:GetTall() - (create:GetTall() + 5) )
end

function Vendor.AddToListedItem( k )
    local frame = vgui.Create("DFrame")
    frame:SetSize(400, 150)
    frame:Center()
    frame:MakePopup()
    frame:SetDraggable( false )
    frame:SetTitle( "" )
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

    local panel = SimplePanel( frame, frame:GetWide() - 6, frame:GetTall() - 28, 3, 25, COLHUD_SECONDARY )

    local icon = SimpleItemIcon( panel, k, 64, 0, 0, AS.Items[k].name )
    local label = SimpleLabel( panel, AS.Items[k].name, icon:GetWide() + 5, 5, "TargetID" )

    local width, height, x, y, space = panel:GetWide(), 20, 5, icon:GetTall() + 5, 20
    local amt = SimpleSlider( panel, "Amount to Add", width, height, x, y, 1, LocalPlayer():GetInventory()[k] )

    local create = SimpleButton( panel, "Add to Existing Sale", 200, 20, 0, 0, function()
        frame:Close()
        net.Start("as_vendor_item_list")
            net.WriteEntity( ent )
            net.WriteString( k )
            net.WriteUInt( amt:GetValue(), NWSetting.ItemAmtBits )
        net.SendToServer()
    end)
    create:SetPos( (panel:GetWide() / 2) - (create:GetWide() / 2), panel:GetTall() - (create:GetTall() + 5) )
end

function Vendor.TakeFromListedItem( k )
    local frame = vgui.Create("DFrame")
    frame:SetSize(400, 150)
    frame:Center()
    frame:MakePopup()
    frame:SetDraggable( false )
    frame:SetTitle( "" )
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

    local panel = SimplePanel( frame, frame:GetWide() - 6, frame:GetTall() - 28, 3, 25, COLHUD_SECONDARY )

    local icon = SimpleItemIcon( panel, k, 64, 0, 0, AS.Items[k].name )
    local label = SimpleLabel( panel, AS.Items[k].name, icon:GetWide() + 5, 5, "TargetID" )

    local width, height, x, y, space = panel:GetWide(), 20, 5, icon:GetTall() + 5, 20
    local amt = SimpleSlider( panel, "Amount to Take", width, height, x, y, 1, ent:GetSales()[k].amt )

    local create = SimpleButton( panel, "Take From Sale", 200, 20, 0, 0, function()
        frame:Close()
        net.Start("as_vendor_item_unlist")
            net.WriteEntity( ent )
            net.WriteString( k )
            net.WriteUInt( amt:GetValue(), NWSetting.ItemAmtBits )
        net.SendToServer()
    end)
    create:SetPos( (panel:GetWide() / 2) - (create:GetWide() / 2), panel:GetTall() - (create:GetTall() + 5) )
end

function Vendor.ModifyListPrice( k )
    local frame = vgui.Create("DFrame")
    frame:SetSize(400, 200)
    frame:Center()
    frame:MakePopup()
    frame:SetDraggable( false )
    frame:SetTitle( "" )
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

    local panel = SimplePanel( frame, frame:GetWide() - 6, frame:GetTall() - 28, 3, 25, COLHUD_SECONDARY )

    local icon = SimpleItemIcon( panel, k, 64, 0, 0, AS.Items[k].name )
    local label = SimpleLabel( panel, AS.Items[k].name, icon:GetWide() + 5, 5, "TargetID" )

    local width, height, x, y, space = panel:GetWide(), 20, 5, icon:GetTall() + 5, 20
    local scrap = SimpleSlider( panel, "Scrap", width, height, x, y, 0, ent.MaxPrice )
    y = y + space
    local smallp = SimpleSlider( panel, "Small Parts", width, height, x, y, 0, ent.MaxPrice )
    y = y + space
    local chem = SimpleSlider( panel, "Chemicals", width, height, x, y, 0, ent.MaxPrice )

    local create = SimpleButton( panel, "Add to Existing Sale", 200, 20, 0, 0, function()
        frame:Close()
        net.Start("as_vendor_item_modifyprice")
            net.WriteEntity( ent )
            net.WriteString( k )
            net.WriteUInt( scrap:GetValue(), NWSetting.VendorPriceBits ) --scrap
            net.WriteUInt( smallp:GetValue(), NWSetting.VendorPriceBits ) --smallparts
            net.WriteUInt( chem:GetValue(), NWSetting.VendorPriceBits ) --chemicals
        net.SendToServer()
    end)
    create:SetPos( (panel:GetWide() / 2) - (create:GetWide() / 2), panel:GetTall() - (create:GetTall() + 5) )
end