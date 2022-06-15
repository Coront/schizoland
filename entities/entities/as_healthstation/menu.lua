net.Receive("as_healthstation_open", function()
    local ent = net.ReadEntity()

    if IsValid(frame_healthstation) then frame_healthstation:Close() end

    frame_healthstation = vgui.Create("DFrame")
    frame_healthstation:SetSize(400, 200)
    frame_healthstation:Center()
    frame_healthstation:MakePopup()
    frame_healthstation:SetDraggable( false )
    frame_healthstation:SetTitle( "" )
    frame_healthstation:ShowCloseButton( false )
    function frame_healthstation:Paint( w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local cbuttonsize = 15
    local closebutton = CreateCloseButton( frame_healthstation, cbuttonsize, frame_healthstation:GetWide() - cbuttonsize - 5, 3 )

    local pickup = DefaultButton( "Pick Up", 5, 3, 80, 15, frame_healthstation, function()
        net.Start("as_tool_pickup")
            net.WriteEntity( ent )
        net.SendToServer()
        frame_healthstation:Close()
    end)
    pickup:SetEnabled( false )
    pickup:SetTooltip("You are not the owner of this object.")
    if ent:PlayerCanPickUp( LocalPlayer() ) then
        pickup:SetEnabled( true )
        pickup:SetTooltip("Pickup the entity and place it in your inventory.")
    end

    local panel = vgui.Create("DPanel", frame_healthstation)
    panel:SetPos( 5, 20 )
    panel:SetSize( frame_healthstation:GetWide() - 10, frame_healthstation:GetTall() - 25 )
    function panel:Paint( w, h ) 
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    if ent:GetObjectOwner() != LocalPlayer() then
        HealthStation_BuildUse( panel, ent )
    else
        HealthStation_BuildOwnerSettings( panel, ent )
    end
end)

function HealthStation_BuildOwnerSettings( parent, ent )
    local buildPanel = vgui.Create("DPanel", parent)
    buildPanel:SetSize( parent:GetWide(), parent:GetTall() )
    function buildPanel:Paint( w, h ) end

    local text = SimpleLabel( buildPanel, "Current Price: \n" .. ent:GetScrap() .. " Scrap\n" .. ent:GetSmallParts() .. " Small Parts\n" .. ent:GetChemicals() .. " Chemicals", 3, 0, "TargetID" )
    local width, height = 160, 20
    local update = DefaultButton( "Update Price", 5, 75, width, height, buildPanel, function()
        HealthStation_UpdatePrice( ent )
        frame_healthstation:Close()
    end)

    local charge = SimpleLabel( buildPanel, "Charge Left:", 5, 110, "TargetID" )
    local chargepanel = vgui.Create("DPanel", buildPanel)
    chargepanel:SetSize( 160, 20 )

    local charge = vgui.Create( "DLabel", chargepanel )
    charge:SetFont( "TargetID" )
    charge:SetText( ent:GetChargePercent() .. "%" )
    charge:SetContentAlignment( 6 )
    charge:SizeToContents()
    charge:SetPos( (chargepanel:GetWide() / 2) - (charge:GetWide() / 2), 0 )

    chargepanel:SetPos( 5, 130 )
    function chargepanel:Paint( w, h )
        surface.SetDrawColor( COLHUD_BAD )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_GOOD )
        surface.DrawRect( 0, 0, ( ent:GetChargePercent() / ent.MaxCharge ) * w, h )
    end

    local width, height = 160, 20
    local load = DefaultButton( "Load Medicinal Herbs", 5, chargepanel:GetY() + chargepanel:GetTall(), width, height, buildPanel, function()
        HealthStation_Load( ent )
        frame_healthstation:Close()
    end)

    local width, height = 160, 20
    local view = DefaultButton( "View Health Station", buildPanel:GetWide() - width - 5, buildPanel:GetTall() - height - 5, width, height, buildPanel, function()
        buildPanel:Remove()
        HealthStation_BuildUse( parent, ent )
    end)

    local resources = vgui.Create("DListView", buildPanel)
    resources:SetSize( 160, 70 )
    resources:SetPos( buildPanel:GetWide() - resources:GetWide() - 5, 5 )
    resources:SetMultiSelect( false )
    resources:AddColumn( "Item" )
    resources:AddColumn( "Amount" )

    for k, v in pairs( ent:GetInventory() ) do
        resources:AddLine( AS.Items[k].name, v )
    end

    local collect = DefaultButton( "Collect Resources", resources:GetX(), resources:GetY() + resources:GetTall(), resources:GetWide(), 20, buildPanel, function()
        net.Start("as_healthstation_takeres")
            net.WriteEntity( ent )
        net.SendToServer()
        frame_healthstation:Close()
    end)
end

function HealthStation_BuildUse( parent, ent )
    local buildPanel = vgui.Create("DPanel", parent)
    buildPanel:SetSize( parent:GetWide(), parent:GetTall() )
    function buildPanel:Paint( w, h ) end

    local text = SimpleLabel( buildPanel, "You can use this station for:\n" .. ent:GetScrap() .. " Scrap\n" .. ent:GetSmallParts() .. " Small Parts\n" .. ent:GetChemicals() .. " Chemicals\n\nCharge Left: " .. ent:GetChargePercent() .. "%", 0, 0, "TargetID" )
    text:SetPos( buildPanel:GetWide() / 2 - text:GetWide() / 2, 20 )

    local width, height = 200, 25
    local use = DefaultButton( "Use ( -" .. ent.ChargeUse .. "% )", buildPanel:GetWide() / 2 - width / 2, buildPanel:GetTall() - height - 10, width, height, buildPanel, function()
        net.Start("as_healthstation_use")
            net.WriteEntity( ent )
        net.SendToServer()
        frame_healthstation:Close()
    end)
    function use:Think()
        local inv = LocalPlayer():GetInventory()
        if ent:GetChargePercent() < ent.ChargeUse then
            self:SetEnabled( false )
            self:SetText("Not Enough Charge")
        end
        if ent:GetChargePercent() > 0 and (inv["misc_scrap"] or 0) < ent:GetScrap() or (inv["misc_smallparts"] or 0) < ent:GetSmallParts() or (inv["misc_chemical"] or 0) < ent:GetChemicals() then
            self:SetEnabled( false )
            self:SetText("Insufficient Resources")
        end
    end
end

function HealthStation_UpdatePrice( ent )
    if IsValid(frame_healthstation_updateprice) then frame_healthstation_updateprice:Close() end

    frame_healthstation_updateprice = vgui.Create("DFrame")
    frame_healthstation_updateprice:SetSize(300, 200)
    frame_healthstation_updateprice:Center()
    frame_healthstation_updateprice:MakePopup()
    frame_healthstation_updateprice:SetDraggable( false )
    frame_healthstation_updateprice:SetTitle( "" )
    frame_healthstation_updateprice:ShowCloseButton( true )
    function frame_healthstation_updateprice:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    local infotext = vgui.Create("DLabel", frame_healthstation_updateprice)
    infotext:SetText("Set the health station price.")
    infotext:SizeToContents()
    infotext:SetContentAlignment(5)
    infotext:SetPos( frame_healthstation_updateprice:GetWide() / 2 - infotext:GetWide() / 2, 40)

    local scrap = vgui.Create("DNumSlider", frame_healthstation_updateprice)
    scrap:SetSize( 250, 20 )
    scrap:SetPos( frame_healthstation_updateprice:GetWide() / 2 - (scrap:GetWide() / 2), 75 )
    scrap:SetText( "Scrap" )
    scrap:SetValue( 0 )
    scrap:SetMin( 0 )
    scrap:SetMax( ent.MaxPrice )
    scrap:SetDecimals( 0 )
    scrap:SetDark( false )

    local sp = vgui.Create("DNumSlider", frame_healthstation_updateprice)
    sp:SetSize( 250, 20 )
    sp:SetPos( frame_healthstation_updateprice:GetWide() / 2 - (sp:GetWide() / 2), 100 )
    sp:SetText( "Small Parts" )
    sp:SetValue( 0 )
    sp:SetMin( 0 )
    sp:SetMax( ent.MaxPrice )
    sp:SetDecimals( 0 )
    sp:SetDark( false )

    local chem = vgui.Create("DNumSlider", frame_healthstation_updateprice)
    chem:SetSize( 250, 20 )
    chem:SetPos( frame_healthstation_updateprice:GetWide() / 2 - (chem:GetWide() / 2), 125 )
    chem:SetText( "Chemicals" )
    chem:SetValue( 0 )
    chem:SetMin( 0 )
    chem:SetMax( ent.MaxPrice )
    chem:SetDecimals( 0 )
    chem:SetDark( false )

    local width, height = 150, 20
    DefaultButton( "Set Price", frame_healthstation_updateprice:GetWide() / 2 - (width / 2), frame_healthstation_updateprice:GetTall() - height - 15, width, height, frame_healthstation_updateprice, function()
        net.Start("as_healthstation_updateprice")
            net.WriteEntity( ent )
            net.WriteFloat( scrap:GetValue() )
            net.WriteFloat( sp:GetValue() )
            net.WriteFloat( chem:GetValue() )
        net.SendToServer()
        frame_healthstation_updateprice:Close()
    end)
end

function HealthStation_Load( ent )
    if IsValid(frame_healthstation_load) then frame_healthstation_load:Close() end

    frame_healthstation_load = vgui.Create("DFrame")
    frame_healthstation_load:SetSize(300, 150)
    frame_healthstation_load:Center()
    frame_healthstation_load:MakePopup()
    frame_healthstation_load:SetDraggable( false )
    frame_healthstation_load:SetTitle( "" )
    frame_healthstation_load:ShowCloseButton( true )
    function frame_healthstation_load:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    local infotext = vgui.Create("DLabel", frame_healthstation_load)
    infotext:SetText("Select amount of herbs to load.")
    infotext:SizeToContents()
    infotext:SetContentAlignment(5)
    infotext:SetPos( frame_healthstation_load:GetWide() / 2 - infotext:GetWide() / 2, 40)

    local amt = vgui.Create("DNumSlider", frame_healthstation_load)
    amt:SetSize( 250, 20 )
    amt:SetPos( frame_healthstation_load:GetWide() / 2 - (amt:GetWide() / 2), 75 )
    amt:SetText( "Amount" )
    amt:SetValue( 1 )
    amt:SetMin( 1 )
    local maxAmt = math.Clamp( LocalPlayer():GetItemCount( ent.ChargeItem ), 0, 5 )
    amt:SetMax( maxAmt )
    amt:SetDecimals( 0 )
    amt:SetDark( false )

    local width, height = 150, 20
    DefaultButton( "Load Herbs", frame_healthstation_load:GetWide() / 2 - (width / 2), frame_healthstation_load:GetTall() - height - 15, width, height, frame_healthstation_load, function()
        net.Start("as_healthstation_load")
            net.WriteEntity( ent )
            net.WriteFloat( amt:GetValue() )
        net.SendToServer()
        frame_healthstation_load:Close()
    end)
end