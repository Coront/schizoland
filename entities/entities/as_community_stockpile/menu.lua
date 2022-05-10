Stockpile = Stockpile or {}
local ent

function Stockpile.Open()
    ent = net.ReadEntity()
    if not IsValid(ent) then return end

    if IsValid(frame_stockpile) then frame_stockpile:Close() end

    frame_stockpile = vgui.Create("DFrame")
    frame_stockpile:SetSize(520, 220)
    frame_stockpile:Center()
    frame_stockpile:MakePopup()
    frame_stockpile:SetDraggable( false )
    frame_stockpile:SetTitle( "" )
    frame_stockpile:ShowCloseButton( false )
    frame_stockpile.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local closebutton = vgui.Create("DButton", frame_stockpile)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_stockpile:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_stockpile) then
            frame_stockpile:Close()
        end
    end

    local pickup = vgui.Create("DButton", frame_stockpile)
    pickup:SetSize( 80, 20 )
    pickup:SetPos( 3, 3 )
    pickup:SetText("Hide")
    pickup:SetEnabled( false )
    pickup:SetTooltip("You cannot hide the stockpile")
    if ent:GetCommunity() == LocalPlayer():GetCommunity() then
        pickup:SetEnabled( true )
        pickup:SetTooltip("Hide the community stockpile.")
    end
    pickup.DoClick = function()
        frame_stockpile:Close()
        net.Start("as_stockpile_hide")
            net.WriteEntity( ent )
        net.SendToServer()
    end

    local panel = vgui.Create("DPanel", frame_stockpile)
    panel:SetPos( 3, 27 )
    panel:SetSize( frame_stockpile:GetWide() - (panel:GetX() + 3), frame_stockpile:GetTall() - (panel:GetY() + 3))
    panel.Paint = function(_, w, h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local scrap = (ent:GetResources()["misc_scrap"] or 0)
    local smallparts = (ent:GetResources()["misc_smallparts"] or 0)
    local chemical = (ent:GetResources()["misc_chemical"] or 0)

    local icon = SimpleSpawnIcon( panel, "models/props/cs_office/Crates_indoor.mdl", 64, 0, 0, "" )
    local name = SimpleLabel( panel, ent:GetCommunityName() .. " Community Stockpile", icon:GetWide() + 3, 3, "TargetID" )
    local scrapheld = SimpleLabel( panel, "Scrap: " .. scrap, icon:GetWide() + 3, 20, "DermaDefault" )
    local smallpheld = SimpleLabel( panel, "Small Parts: " .. smallparts, icon:GetWide() + 3, 35, "DermaDefault" )
    local chemheld = SimpleLabel( panel, "Chemicals: " .. chemical, icon:GetWide() + 3, 50, "DermaDefault" )

    local width, height = 250, 20
    local x, y = 5, 90

    --Store
    local storelabel = SimpleLabel( panel, "Store", 5, 70, "TargetIDSmall" )
    local storescrap = SimpleSlider( panel, "Scrap", width, height, x, y, 0, LocalPlayer():GetItemCount( "misc_scrap" ) )
    y = y + height + 5
    local storesmallp = SimpleSlider( panel, "Small Parts", width, height, x, y, 0, LocalPlayer():GetItemCount( "misc_smallparts" ) )
    y = y + height + 5
    local storechem = SimpleSlider( panel, "Chemicals", width, height, x, y, 0, LocalPlayer():GetItemCount( "misc_chemical" ) )
    y = y + height + 5
    local store = SimpleButton( panel, "Store", width, height, x, y, function()
        frame_stockpile:Close()
        net.Start("as_stockpile_addresource")
            net.WriteEntity( ent )
            net.WriteUInt( storescrap:GetValue(), NWSetting.ItemAmtBits )
            net.WriteUInt( storesmallp:GetValue(), NWSetting.ItemAmtBits )
            net.WriteUInt( storechem:GetValue(), NWSetting.ItemAmtBits )
        net.SendToServer()
    end)
    
    --Withdraw
    x, y = 260, 90
    local storelabel = SimpleLabel( panel, "Withdraw", x, 70, "TargetIDSmall" )
    local withdrawscrap = SimpleSlider( panel, "Scrap", width, height, x, y, 0, scrap )
    y = y + height + 5
    local withdrawsmallp = SimpleSlider( panel, "Small Parts", width, height, x, y, 0, smallparts )
    y = y + height + 5
    local withdrawchem = SimpleSlider( panel, "Chemicals", width, height, x, y, 0, chemical )
    y = y + height + 5
    local withdraw = SimpleButton( panel, "Withdraw", width, height, x, y, function() 
        frame_stockpile:Close()
        net.Start("as_stockpile_takeresource")
            net.WriteEntity( ent )
            net.WriteUInt( withdrawscrap:GetValue(), NWSetting.ItemAmtBits )
            net.WriteUInt( withdrawsmallp:GetValue(), NWSetting.ItemAmtBits )
            net.WriteUInt( withdrawchem:GetValue(), NWSetting.ItemAmtBits )
        net.SendToServer()
    end)
end
net.Receive("as_stockpile_open", Stockpile.Open)