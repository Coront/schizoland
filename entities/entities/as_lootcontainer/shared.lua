ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Base Container"
ENT.Author			= "Tampy"
ENT.Purpose			= "A container. It holds items."

function ENT:Initialize()
    self:SetContainer( "drawer" )

    self:SetModel( AS.Loot[self:GetContainer()].model ) 
    self:SetSolid( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    if SERVER then
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetUseType( SIMPLE_USE )
    end
end

function ENT:SetContainer( id )
    self.ContainerID = id
end

function ENT:GetContainer( id )
    return self.ContainerID
end

function ENT:SetInventory( tbl )
    self.Inventory = tbl
end

function ENT:GetInventory()
    return self.Inventory or {}
end

function ENT:AddItemToInventory( itemid, amt )
    local inv = self:GetInventory()
    inv[itemid] = (inv[itemid] or 0) + amt
end

function ENT:TakeItemFromInventory( itemid, amt )
    local inv = self:GetInventory()
    inv[itemid] = (inv[itemid] or 0) - amt
    if inv[itemid] <= 0 then inv[itemid] = nil end
end

function ENT:SetNextGeneration( time )
    self.NextGeneration = time
end

function ENT:GetNextGeneration()
    return self.NextGeneration or 0
end

if SERVER then

    util.AddNetworkString("as_lootcontainer_syncinventory")

    function ENT:ResyncInventory()
        net.Start("as_lootcontainer_syncinventory")
            net.WriteEntity( self )
            net.WriteTable( self:GetInventory() )
        net.Broadcast() --Broadcasting, because everyone needs this info.
    end

elseif CLIENT then

    function ContainerInventorySync()
        local self = net.ReadEntity()
        self:SetInventory( net.ReadTable() )
    end
    net.Receive( "as_lootcontainer_syncinventory", ContainerInventorySync )

end