ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Vending Machine"
ENT.Author			= "Tampy"
ENT.Purpose			= "Sell your junk in it."
ENT.Category		= "Aftershock"
ENT.Spawnable		= false
ENT.AS_OwnableObject = true
ENT.AS_Conductor = true

ENT.PowerNeeded = 25

function ENT:Initialize()
    if ( SERVER ) then
        self:SetModel( "models/props_interiors/vendingmachinesoda01a.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetUseType( SIMPLE_USE )
        self:SetSolid( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
    end

	self:SetPower( -self.PowerNeeded )
end

ENT.ProfileCost = { --Cost of resources/items to make a profile
    ["misc_scrap"] = 200,
    ["misc_smallparts"] = 150,
    ["misc_chemical"] = 250,
}
ENT.ProfileCapacity = 250 --Maximum weight a profile can carry
ENT.ResCapacity = 2000 --Maximum resources a profile can carry
ENT.MaxPrice = 500 --Maximum price that items can be listed for
ENT.DisplayLimit = 30 --Maximum displays a player can have.
ENT.Models = { --Models that player can swap the vendor to
    ["models/props_interiors/VendingMachineSoda01a.mdl"] = 1,
    ["models/props_interiors/VendingMachineSoda01a_door.mdl"] = 2,
    ["models/props/cs_office/Vending_machine.mdl"] = 3,
    ["models/props_junk/TrashDumpster01a.mdl"] = 4,
    ["models/props/CS_militia/bar01.mdl"] = 5,
    ["models/props_combine/health_charger001.mdl"] = 6,
    ["models/props_combine/suit_charger001.mdl"] = 7,
    ["models/props_c17/cashregister01a.mdl"] = 8,
}

function ENT:SetProfile( id, name )
    self.vid = id
    self.name = name
    if ( SERVER ) then
        self:Resync()
    end
end

function ENT:GetProfile()
    return self.vid or 0
end

function ENT:GetProfileName()
    return self.name or ""
end

function ENT:SetSales( tbl )
    self.Sales = tbl
    if ( SERVER ) then
        self:Resync()
    end
end

function ENT:GetSales()
    return self.Sales or {}
end

function ENT:SaleExists( id )
    local tbl = self:GetSales()
    if tbl[id] then return true end
    return false
end

function ENT:GetSaleAmount( id )
    local tbl = self:GetSales()
    if tbl[id] then return tbl[id].amt end
    return 0
end

function ENT:AddSale( id, data )
    local tbl = self:GetSales()
    tbl[id] = data
    self:SetSales( tbl )
end

function ENT:RemoveSale( id, amt )
    local tbl = self:GetSales()
    tbl[id] = nil
    self:SetSales( tbl )
end

function ENT:AddToExistingSale( id, amount )
    local tbl = self:GetSales()
    tbl[id].amt = (tbl[id].amt or 0) + amount
    self:SetSales(tbl)
end

function ENT:TakeFromExistingSale( id, amount )
    local tbl = self:GetSales()
    tbl[id].amt = (tbl[id].amt or 0) - amount
    if tbl[id].amt <= 0 then tbl[id] = nil end
    self:SetSales(tbl)
end

function ENT:SetSalePrice( id, s, sp, chem )
    local tbl = self:GetSales()
    tbl[id].scrap = s
    tbl[id].smallp = sp
    tbl[id].chemical = chem
    self:SetSales( tbl )
end

function ENT:SetResources( tbl )
    self.Resources = tbl
    if ( SERVER ) then
        self:Resync()
    end
end

function ENT:GetResources()
    return self.Resources or {}
end

function ENT:AddResource( id, amt )
    local tbl = self:GetResources()
    tbl[id] = (tbl[id] or 0) + amt
    self:SetResources( tbl )
end

function ENT:RemoveResource( id, amt )
    local tbl = self:GetResources()
    tbl[id] = (tbl[id] or 0 ) - amt
    if amt <= 0 then tbl[id] = nil end
    self:SetResources( tbl )
end

function ENT:CarryWeight()
    local weight = 0
    for k, v in pairs( self:GetSales() ) do
        weight = weight + (AS.Items[k].weight * v.amt)
    end
    return weight
end

if ( SERVER ) then

    function ENT:SaveSales()
        sql.Query("UPDATE as_vendors SET sale = " .. SQLStr( util.TableToJSON( self:GetSales(), true ) ) .. " WHERE vid = " .. self:GetProfile())
    end

    function ENT:SaveResources()
        sql.Query("UPDATE as_vendors SET res = " .. SQLStr( util.TableToJSON( self:GetResources(), true ) ) .. " WHERE vid = " .. self:GetProfile())
    end

    function ENT:SaveAll()
        self:SaveSales()
        self:SaveResources()
    end

end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

function ENT:Resync()
    if ( SERVER ) then
        local id = self:GetProfile()
        local name = self:GetProfileName()
        local sales = self:GetSales()
        local res = self:GetResources()

        net.Start("as_vendor_sync")
            net.WriteEntity( self )
            net.WriteUInt( id, NWSetting.UIDAmtBits )
            net.WriteString( name )
            net.WriteTable( sales )
            net.WriteInventory( res )
        net.Broadcast()
    elseif ( CLIENT ) then
        net.Start("as_vendor_requestsync")
            net.WriteEntity( self )
        net.SendToServer()
    end
end

if ( SERVER ) then

    util.AddNetworkString("as_vendor_sync")
    util.AddNetworkString("as_vendor_requestsync")

    net.Receive("as_vendor_requestsync", function( _, ply )
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end

        local id = ent:GetProfile()
        local name = ent:GetProfileName()
        local sales = ent:GetSales()
        local res = ent:GetResources()

        net.Start("as_vendor_sync")
            net.WriteEntity( ent )
            net.WriteUInt( id, NWSetting.UIDAmtBits )
            net.WriteString( name )
            net.WriteTable( sales )
            net.WriteInventory( res )
        net.Send( ply )
    end)

elseif ( CLIENT ) then

    net.Receive( "as_vendor_sync", function()
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end

        local prof = net.ReadUInt( NWSetting.UIDAmtBits )
        local name = net.ReadString()
        local sales = net.ReadTable()
        local res = net.ReadInventory()

        if isfunction( ent.SetProfile ) then
            ent:SetProfile( prof, name )
        end
        if isfunction( ent.SetSales ) then
            ent:SetSales( sales )
        end
        if isfunction( ent.SetResources ) then
            ent:SetResources( res )
        end
    end)

    function ENT:Think()
        if CurTime() > (self:GetCreationTime() + NWSetting.PostCreationDelay) and CurTime() > (self.NextResync or 0) then
            self:Resync()
            self.NextResync = CurTime() + NWSetting.EntUpdateLength
        end
    end

end