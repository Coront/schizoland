Generator = Generator or {}
local ent

function Generator.Menu()
    ent = net.ReadEntity()
    if not IsValid(ent) then return end

    if IsValid(frame_generator) then frame_generator:Close() end

    frame_generator = vgui.Create("DFrame")
    frame_generator:SetSize(400, 150)
    frame_generator:Center()
    frame_generator:MakePopup()
    frame_generator:SetDraggable( false )
    frame_generator:SetTitle( "" )
    frame_generator:ShowCloseButton( false )
    frame_generator.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local closebutton = vgui.Create("DButton", frame_generator)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_generator:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_generator) then
            frame_generator:Close()
        end
    end

    local pickup = vgui.Create("DButton", frame_generator)
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
        frame_generator:Close()
    end

    local panel = vgui.Create("DPanel", frame_generator)
    panel:SetPos( 5, 25 )
    panel:SetSize( frame_generator:GetWide() - (panel:GetX() + 5), frame_generator:GetTall() - (panel:GetY() + 5))
    panel.Paint = function(_, w, h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local icon = vgui.Create( "SpawnIcon", panel )
    icon:SetSize( 64, 64 )
    icon:SetPos( 5, 5 )
    icon:SetModel( ent:GetModel() )
    icon:SetTooltip( "" )

    local name = vgui.Create( "DLabel", panel )
    name:SetFont( "TargetID" )
    name:SetText( ent.PrintName )
    name:SetContentAlignment( 4 )
    name:SizeToContents()
    name:SetPos( 75, 5 )

    local toggled = vgui.Create( "DLabel", panel )
    toggled:SetFont( "TargetID" )
    local str = ent:GetActiveState() and "True (" .. ent.PowerProduced .. " Electricity)" or "False ( 0 Electricity )"
    toggled:SetText( "Running: " .. str )
    local col = ent:GetActiveState() and COLHUD_GOOD or COLHUD_BAD
    toggled:SetColor( col )
    toggled:SetContentAlignment( 4 )
    toggled:SizeToContents()
    toggled:SetPos( 75, 25 )

    local togglebtn = vgui.Create("DButton", panel)
    togglebtn:SetSize( 90, 20 )
    togglebtn:SetPos( panel:GetWide() - (togglebtn:GetWide() + 5), 5 )
    togglebtn:SetText("Toggle Power")
    if ent:GetActiveState() and ent:GetObjectOwner() != LocalPlayer() then
        togglebtn:SetEnabled( false )
        togglebtn:SetTooltip( "You cannot turn this off unless you're the owner." )
    end
    if ent:GetFuelAmount() <= 0 and not ent.NoFuel then
        togglebtn:SetEnabled( false )
        togglebtn:SetTooltip( "There is no fuel." )
    end
    if ent:Health() <= 0 then
        togglebtn:SetEnabled( false )
        togglebtn:SetTooltip( "This generator is too damaged to function." )
    end
    togglebtn.DoClick = function()
        ent:TogglePower()
        net.Start("as_generator_togglepower")
            net.WriteEntity( ent )
        net.SendToServer()
        frame_generator:Close()
    end

    if not ent.NoFuel then
        local timeleft = vgui.Create( "DLabel", panel )
        timeleft:SetFont( "TargetID" )
        timeleft:SetText( "Current Length: " .. math.ceil(ent:GetFuelAmount() / 60) .. " minutes" )
        timeleft:SetContentAlignment( 4 )
        timeleft:SizeToContents()
        timeleft:SetPos( 75, 45 )

        local addwang = vgui.Create("DNumberWang", panel)
        local addfuel = vgui.Create("DButton", panel)
        addfuel:SetSize( 80, 20 )
        addfuel:SetPos( 5, panel:GetTall() - ( addfuel:GetTall() + 5 ) )
        addfuel:SetText("Add Fuel")
        addfuel:SetEnabled( false )
        addfuel.DoClick = function()
            ent:DepositFuel( LocalPlayer(), addwang:GetValue() )
            net.Start("as_generator_addfuel")
                net.WriteEntity( ent )
                net.WriteUInt( addwang:GetValue(), NWSetting.ItemAmtBits )
            net.SendToServer()
            frame_generator:Close()
        end

        addwang:SetSize( addfuel:GetWide(), 20 )
        addwang:SetPos( 5, panel:GetTall() - (addwang:GetTall() + addfuel:GetTall() + 5) )
        addwang:SetMax( LocalPlayer():GetInventory()[ent.Fuel] or 0 )

        addfuel.Think = function( self )
            if IsValid(addwang) then
                if addwang:GetValue() > 0 then
                    addfuel:SetEnabled( true )
                else
                    addfuel:SetEnabled( false )
                end

                if addwang:GetValue() > addwang:GetMax() then
                    addwang:SetValue( addwang:GetMax() )
                end
            end
        end

        local removewang = vgui.Create("DNumberWang", panel)
        local removefuel = vgui.Create("DButton", panel)
        removefuel:SetSize( 80, 20 )
        removefuel:SetPos( ( addfuel:GetPos() + addfuel:GetWide() ) + 5, panel:GetTall() - ( removefuel:GetTall() + 5 ) )
        removefuel:SetText("Take Fuel")
        removefuel:SetEnabled( false )
        if ent:GetObjectOwner() != LocalPlayer() then
            removefuel:SetTooltip("You cannot withdraw fuel from a generator that you do not own.")
        end
        removefuel.DoClick = function()
            ent:WithdrawFuel( LocalPlayer(), removewang:GetValue() )
            net.Start("as_generator_removefuel")
                net.WriteEntity( ent )
                net.WriteUInt( removewang:GetValue(), NWSetting.ItemAmtBits )
            net.SendToServer()
            frame_generator:Close()
        end

        removewang:SetSize( removefuel:GetWide(), 20 )
        removewang:SetPos( removefuel:GetX(), panel:GetTall() - (removewang:GetTall() + removefuel:GetTall() + 5) )
        removewang:SetMax( ent:CalcFuelInput() )

        removefuel.Think = function( self )
            if ent:GetObjectOwner() == LocalPlayer() and IsValid(removewang) then
                if removewang:GetValue() > 0 then
                    removefuel:SetEnabled( true )
                else
                    removefuel:SetEnabled( false )
                end

                if removewang:GetValue() > removewang:GetMax() then
                    removewang:SetValue( removewang:GetMax() )
                end
            end
        end
    end

    local repair = vgui.Create("DButton", panel)
    repair:SetSize( 160, 20 )
    repair:SetPos( panel:GetWide() - ( repair:GetWide() + 5 ), panel:GetTall() - ( repair:GetTall() + 5 ) )
    repair:SetText("Repair")
    repair.DoClick = function()
        net.Start("as_generator_repair")
            net.WriteEntity( ent )
        net.SendToServer()
        frame_generator:Close()
    end

    local hp = ent:Health()
    local maxhp = ent.MaxHealth

    local healthpanel = vgui.Create("DPanel", panel)
    healthpanel:SetSize( 160, 20 )

    local health = vgui.Create( "DLabel", healthpanel )
    health:SetFont( "TargetID" )
    health:SetText( hp .. " / " .. maxhp )
    health:SetContentAlignment( 6 )
    health:SizeToContents()
    health:SetPos( (healthpanel:GetWide() / 2) - (health:GetWide() / 2), 0 )
    health:Hide()

    healthpanel:SetPos( panel:GetWide() - ( healthpanel:GetWide() + 5 ), panel:GetTall() - ( healthpanel:GetTall() + repair:GetTall() + 5 ) )
    healthpanel.Paint = function(_, w, h)
        surface.SetDrawColor( COLHUD_BAD )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_GOOD )
        surface.DrawRect( 0, 0, ( hp / maxhp ) * w, h )
    end
    healthpanel.Think = function( self )
        if self:IsHovered() then
            health:Show()
        else
            health:Hide()
        end
    end

end
net.Receive( "as_generator_open", Generator.Menu )