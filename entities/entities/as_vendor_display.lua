AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Display Item"
ENT.Author			= "Tampy"
ENT.Purpose			= "A display item."
ENT.Category		= "Aftershock"
ENT.Spawnable		= false

function ENT:Initialize()
    if ( SERVER ) then
        self:SetModel( "models/props_junk/cardboard_box003b.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetUseType( SIMPLE_USE )
        self:SetSolid( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
    end
end

function ENT:Use( ply )
    if self:GetPackaged() == true then
        if self:GetObjectOwner() != ply then ply:ChatPrint("Only the owner can unpack this.") return end
        self:Unpack()
    else
        net.Start("as_vendor_display_purchaseitem")
            net.WriteEntity( self:GetParentVendor() )
            net.WriteString( self:GetDisplayItem() )
        net.Send( ply )
    end
end

function ENT:SetDisplayItem( item )
    self.DItem = item
    if ( SERVER ) then
        self:Resync()
    end
end

function ENT:GetDisplayItem()
    return self.DItem or ""
end

function ENT:SetPackaged( bool )
    self.Packed = bool
    if ( SERVER ) then
        self:Resync()
    end
end

function ENT:GetPackaged()
    return self.Packed or false
end

function ENT:SetParentVendor( ent )
    self.Vendor = ent
    if ( SERVER ) then
        self:Resync()
    end
end

function ENT:GetParentVendor()
    return self.Vendor or nil
end

function ENT:Unpack()
    self:SetPackaged( false )

    self:SetModel( AS.Items[self:GetDisplayItem()].model )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:GetPhysicsObject():Wake()

    self:Resync()
end

function ENT:Think()
    if ( SERVER ) then

        if not IsValid(self:GetParentVendor()) or (self:GetParentVendor() and not self:GetParentVendor():GetSales()[self:GetDisplayItem()]) then
            self:Remove()
        end

    elseif ( CLIENT ) then

        if CurTime() > (self:GetCreationTime() + NWSetting.PostCreationDelay) and CurTime() > (self.NextResync or 0) then
            self:Resync()
            self.NextResync = CurTime() + NWSetting.EntUpdateLength
        end

    end
end

if ( CLIENT ) then

    function ENT:Draw()
        self:DrawModel()
    end

    hook.Add( "HUDPaint", "AS_VendorDisplay", function()
        local trace = util.TraceLine({
            start = LocalPlayer():EyePos(),
            endpos = LocalPlayer():EyePos() + LocalPlayer():EyeAngles():Forward() * 100,
            filter = LocalPlayer(),
        })
        local ent = trace.Entity

        if IsValid(ent) and ent:GetClass() == "as_vendor_display" and ent:GetDisplayItem() then
            if not ent:GetPackaged() then
                local item = ent:GetDisplayItem()
                local vend = ent:GetParentVendor()
                if not IsValid(vend) then return end
                if not vend:GetSales()[item] then return end
                local scrap = vend:GetSales()[item].scrap
                local sp = vend:GetSales()[item].smallp
                local chem = vend:GetSales()[item].chemical

                local col = COLHUD_DEFAULT:ToTable()
                surface.SetDrawColor( COLHUD_DEFAULT )
                local w, h = 200, 75
                local x, y = (ScrW() / 2) - (w / 2), ScrH() * 0.53
                surface.DrawOutlinedRect( x, y, w, h, 1 )
                local col = COLHUD_DEFAULT:ToTable()
                surface.SetDrawColor( col[1], col[2], col[3], 10 )
                surface.DrawRect( x, y, w, h )
                draw.SimpleTextOutlined( AS.Items[item].name, "TargetIDSmall", (ScrW() / 2), (ScrH() * 0.53) + 10, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
                draw.SimpleTextOutlined( "Scrap: " .. scrap, "TargetIDSmall", (ScrW() / 2), (ScrH() * 0.53) + 30, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
                draw.SimpleTextOutlined( "Small Parts: " .. sp, "TargetIDSmall", (ScrW() / 2), (ScrH() * 0.53) + 45, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
                draw.SimpleTextOutlined( "Chemicals: " .. chem, "TargetIDSmall", (ScrW() / 2), (ScrH() * 0.53) + 60, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
            else
                local item = ent:GetDisplayItem()

                local col = COLHUD_DEFAULT:ToTable()
                surface.SetDrawColor( COLHUD_DEFAULT )
                local w, h = 200, 25
                local x, y = (ScrW() / 2) - (w / 2), ScrH() * 0.53
                surface.DrawOutlinedRect( x, y, w, h, 1 )
                local col = COLHUD_DEFAULT:ToTable()
                surface.SetDrawColor( col[1], col[2], col[3], 10 )
                surface.DrawRect( x, y, w, h )
                draw.SimpleTextOutlined( "Packed: " .. AS.Items[item].name, "TargetIDSmall", (ScrW() / 2), (ScrH() * 0.53) + 10, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
            end
        end
    end)

end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

function ENT:Resync()
    if ( SERVER ) then
        local item = self:GetDisplayItem()
        local packaged = self:GetPackaged()
        local parent = self:GetParentVendor()
        net.Start("as_vendor_display_sync")
            net.WriteEntity( self )
            net.WriteString( item )
            net.WriteBool( packaged )
            net.WriteEntity( parent )
        net.Broadcast()
    elseif ( CLIENT ) then
        net.Start("as_vendor_display_requestsync")
            net.WriteEntity( self )
        net.SendToServer()
    end
end

if ( SERVER ) then

    util.AddNetworkString( "as_vendor_display_purchaseitem" )
    util.AddNetworkString( "as_vendor_display_sync" )
    util.AddNetworkString( "as_vendor_display_requestsync" )

    net.Receive("as_vendor_display_requestsync", function( _, ply )
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end

        local item = ent:GetDisplayItem()
        local packaged = ent:GetPackaged()
        local parent = ent:GetParentVendor()

        net.Start( "as_vendor_display_sync" )
            net.WriteEntity( ent )
            net.WriteString( item )
            net.WriteBool( packaged )
            net.WriteEntity( parent )
        net.Send( ply )
    end)

elseif ( CLIENT ) then

    net.Receive("as_vendor_display_sync", function()
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end
        local item = net.ReadString()
        local packaged = net.ReadBool()
        local parent = net.ReadEntity()

        if isfunction( ent.SetDisplayItem ) then
            ent:SetDisplayItem( item )
        end
        if isfunction( ent.SetPackaged ) then
            ent:SetPackaged( packaged )
        end
        if isfunction( ent.SetParentVendor ) then
            ent:SetParentVendor( parent )
        end
    end)

end

-- ███╗   ███╗███████╗███╗   ██╗██╗   ██╗
-- ████╗ ████║██╔════╝████╗  ██║██║   ██║
-- ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
-- ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
-- ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
-- ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝

if ( CLIENT ) then

    net.Receive("as_vendor_display_purchaseitem", function()
        local vend = net.ReadEntity()
        local item = net.ReadString()

        local frame = vgui.Create("DFrame")
        frame:SetSize(300, 120)
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

        local label = SimpleLabel( panel, "Purchase " .. AS.Items[item].name .. "?", 0, 0, "TargetIDSmall" )
        label:SetPos( ( panel:GetWide() / 2 ) - ( label:GetWide() / 2 ), ( panel:GetTall() / 2 ) - ( label:GetTall() / 2 ) )

        local create = SimpleButton( panel, "Purchase", 200, 20, 0, 0, function()
            frame:Close()
            net.Start( "as_vendor_item_purchase" )
                net.WriteEntity( vend )
                net.WriteString( item )
                net.WriteUInt( 1, NWSetting.ItemAmtBits )
            net.SendToServer()
        end)
        create:SetPos( (panel:GetWide() / 2) - (create:GetWide() / 2), panel:GetTall() - (create:GetTall() + 5) )

    end)

end