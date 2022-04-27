function EntityMeta:SetInletTable( tbl )
    self.PL.Inlets = tbl
    if ( SERVER ) then self:ResyncPower() end
end

function EntityMeta:GetInletTable()
    return self.PL and self.PL.Inlets or {}
end

function EntityMeta:SetOutletTable( tbl )
    self.PL.Outlets = tbl
    if ( SERVER ) then self:ResyncPower() end
end

function EntityMeta:GetOutletTable()
    return self.PL and self.PL.Outlets or {}
end

function EntityMeta:SetElectricityAmount( int )
    self.PL.Electricity = int
end

function EntityMeta:GetElectricityAmount()
    return self.PL and self.PL.Electricity or 0
end

function EntityMeta:AddObjectToInlet( otherent )
    local tbl = self:GetInletTable()
    tbl[ otherent ] = true
    self:SetInletTable( tbl )
end

function EntityMeta:RemoveObjectFromInlet( otherent )
    local tbl = self:GetInletTable()
    tbl[ otherent ] = nil
    self:SetInletTable( tbl )
end

function EntityMeta:AddObjectToOutlet( otherent )
    local tbl = self:GetOutletTable()
    tbl[ otherent ] = true 
    self:SetOutletTable( tbl )
end

function EntityMeta:RemoveObjectFromOutlet( otherent )
    local tbl = self:GetOutletTable()
    tbl[ otherent ] = nil 
    self:SetOutletTable( tbl )
end

function EntityMeta:HasInlets()
    if table.Count(self:GetInletTable()) >= 1 then return true end
    return false
end

function EntityMeta:HasOutlets()
    if table.Count(self:GetOutletTable()) >= 1 then return true end
    return false
end

function EntityMeta:IsPowerBank()
    return self.PL and self.PL.Bank or false
end

function EntityMeta:GetPower()
    return self.PL and self.PL.Electricity or 0
end

function PlayerMeta:CanEstablishLink( ent ) --Can we establish a link with this entity?
    return true
end

function EntityMeta:EstablishLink( otherent ) --Establish a link from ourself to another entity
    self:AddObjectToOutlet( otherent )
    otherent:AddObjectToInlet( self )
end

function EntityMeta:DisconnectLink( otherent ) --Disconnect a link from ourself to another entity
    self:RemoveObjectFromOutlet( otherent )
    otherent:RemoveObjectFromInlet( self )
end

function EntityMeta:CalculateInletElectricity()
    local power = 0
    for k, v in pairs( self:GetInletTable() ) do
        if not IsValid(k) then self.PL.Inlets[k] = nil continue end
        if k:GetPower() <= 0 then continue end
        power = power + k:GetPower()
    end
    return power
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if ( SERVER ) then

    util.AddNetworkString("as_power_resyncobject")

    function EntityMeta:ResyncPower()
        net.Start("as_power_resyncobject")
            net.WriteEntity( self )
            net.WriteTable( self:GetInletTable() )
            net.WriteTable( self:GetOutletTable() )
        net.Broadcast()
    end

else

    net.Receive("as_power_resyncobject", function()
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end
        local inlets = net.ReadTable()
        local outlets = net.ReadTable()

        ent:SetInletTable( inlets )
        ent:SetOutletTable( outlets )
    end)

end