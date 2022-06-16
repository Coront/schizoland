ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Health Station"
ENT.Author			= "Tampy"
ENT.Purpose			= "Can be loaded with medicinal herbs, and then charge players to be used."
ENT.Category		= "Aftershock"
ENT.Spawnable		= false
ENT.AS_OwnableObject = true

ENT.MaxCharge = 100
ENT.MaxPrice = 150
ENT.MaxResHold = 500
ENT.ChargeItem = "misc_herb"
ENT.ChargePerItem = 20
ENT.ChargeUse = 10
ENT.WaitLength = 600

function ENT:SetChargePercent( int )
    self.Charge = int

    if ( SERVER ) then
        self:ResyncCharge()
    end
end

function ENT:GetChargePercent()
    return self.Charge or 0
end

function ENT:SetPrice( scrap, smallparts, chemicals )
    self.Price = {}
    self.Price["misc_scrap"] = scrap
    self.Price["misc_smallparts"] = smallparts
    self.Price["misc_chemical"] = chemicals

    if ( SERVER ) then
        self:ResyncCharge()
    end
end

function ENT:GetPrice()
    return self.Price or {}
end

function ENT:GetScrap()
    return self.Price and self.Price["misc_scrap"] or 0
end

function ENT:GetSmallParts()
    return self.Price and self.Price["misc_smallparts"] or 0
end

function ENT:GetChemicals()
    return self.Price and self.Price["misc_chemical"] or 0
end

function ENT:SetInventory( tbl )
    self.Inventory = tbl
end

function ENT:GetInventory()
    return self.Inventory or {}
end

function ENT:AddItemToInventory( item, amt )
    local inv = self:GetInventory()
    inv[ item ] = (inv[item] or 0) + amt
    self:SetInventory( inv )
end

function ENT:TakeItemFromInventory( item, amt )
    local inv = self:GetInventory()
    inv[item] = (inv[item] or 0) - amt
    if inv[item] <= 0 then inv[item] = nil end
    self:SetInventory( inv )
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if ( SERVER ) then

    util.AddNetworkString( "as_healthstation_resync" )
    util.AddNetworkString( "as_healthstation_resyncinv" )
    util.AddNetworkString( "as_healthstation_requestcharge" )
    util.AddNetworkString( "as_healthstation_requestinv" )

    function ENT:ResyncCharge()
        net.Start("as_healthstation_resync")
            net.WriteEntity( self )
            net.WriteFloat( self:GetChargePercent() )
            net.WriteInventory( self:GetPrice() )
        net.Broadcast()
    end

    function ENT:ResyncInventory()
        if not IsValid( self:GetObjectOwner() ) then return end

        net.Start("as_healthstation_resyncinv")
            net.WriteEntity( self )
            net.WriteInventory( self:GetInventory() )
        net.Send( self:GetObjectOwner() )
    end

    net.Receive( "as_healthstation_requestcharge", function( _, ply )
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end

        net.Start("as_healthstation_resync")
            net.WriteEntity( ent )
            net.WriteFloat( ent:GetChargePercent() )
            net.WriteInventory( ent:GetPrice() )
        net.Send( ply )
    end)

    net.Receive( "as_healthstation_requestinv", function( _, ply ) 
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end

        ent:ResyncInventory()
    end)

elseif ( CLIENT ) then

    net.Receive( "as_healthstation_resync", function()
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        local charge = net.ReadFloat()
        local price = net.ReadInventory()

        ent:SetChargePercent( charge )
        ent:SetPrice( price["misc_scrap"], price["misc_smallparts"], price["misc_chemical"] )
    end)

    net.Receive( "as_healthstation_resyncinv", function()
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        local inv = net.ReadInventory()

        ent:SetInventory( inv )
    end)

    timer.Create( "as_autoresync_healthstations", 10, 0, function()
        for k, v in pairs( ents.FindByClass("as_healthstation") ) do
            if not IsValid(v) then continue end
            net.Start("as_healthstation_requestcharge")
                net.WriteEntity(v)
            net.SendToServer()
        end
    end)

    timer.Create( "as_autoresync_healthstationsinv", 10, 0, function()
        for k, v in pairs( ents.FindByClass("as_healthstation") ) do
            if not IsValid(v) then continue end
            if not v:GetObjectOwner() == LocalPlayer() then continue end
            net.Start("as_healthstation_requestinv")
                net.WriteEntity(v)
            net.SendToServer()
        end
    end)

end