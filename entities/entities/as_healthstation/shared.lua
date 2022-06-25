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
        self:Resync()
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
        self:Resync()
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

function ENT:Resync()
    if ( SERVER ) then
        local perc = self:GetChargePercent()
        local price = self:GetPrice()

        net.Start("as_healthstation_sync")
            net.WriteEntity( self )
            net.WriteFloat( perc )
            net.WriteInventory( price )
        net.Broadcast()
    elseif ( CLIENT ) then
        net.Start("as_healthstation_requestsync")
            net.WriteEntity( self )
        net.SendToServer()
    end
end

if ( SERVER ) then

    util.AddNetworkString( "as_healthstation_sync" )
    util.AddNetworkString( "as_healthstation_requestsync" )

    net.Receive("as_healthstation_requestsync", function( _, ply )
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end

        local perc = ent:GetChargePercent()
        local price = ent:GetPrice()

        net.Start("as_healthstation_sync")
            net.WriteEntity( ent )
            net.WriteFloat( perc )
            net.WriteInventory( price )
        net.Send( ply )
    end)

elseif ( CLIENT ) then

    net.Receive("as_healthstation_sync", function()
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end

        local perc = net.ReadFloat()
        local price = net.ReadInventory()

        if isfunction( ent.SetChargePercent ) then
            ent:SetChargePercent( perc )
        end
        if isfunction( ent.SetPrice ) then
            ent:SetPrice( price["misc_scrap"], price["misc_smallparts"], price["misc_chemical"] )
        end
    end)

    function ENT:Think()
        if CurTime() > (self:GetCreationTime() + NWSetting.PostCreationDelay) and CurTime() > (self.NextResync or 0) then
            self:Resync()
            self.NextResync = CurTime() + NWSetting.EntUpdateLength
        end
    end

end