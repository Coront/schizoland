ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Loot Container"
ENT.Author			= "Tampy"
ENT.Purpose			= "A container. It holds items."
ENT.Category		= "Aftershock"
ENT.Spawnable		= true
ENT.Editable        = true

local loottables = {}
for k, v in SortedPairs( AS.Loot ) do
    loottables[v.name] = k
end

function ENT:SetupDataTables()
    self:NetworkVar( "String", 0, "Container", {
        KeyName = "Loot Table",
        Edit = {
            type = "Combo",
            text = "Test",
            values = loottables,
        }
    } )

    if SERVER then
        self:NetworkVarNotify( "Container", self.OnLootTableChanged )
    end
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

function ENT:HasInInventory( itemid, amt )
    if not AS.Items[itemid] then AS.LuaError("Attempt to request a non-existant item in a container - " .. itemid) return end
    amt = amt and amt > 0 and math.Round(amt) or 1
    local inv = self:GetInventory()
    if (inv[itemid] or 0) >= amt then return true end
    return false
end

function ENT:PlayerCanTakeItem( ply, itemid, amt )
    if not ply:Alive() then return end
    if ply:GetPos():Distance( self:GetPos() ) > 200 then ply:ChatPrint("You are too far to take this item.") return false end
    if ply:GetCarryWeight() + (AS.Items[itemid].weight * amt) > ply:MaxCarryWeight() then ply:ChatPrint("You are too overweight to take this item.") return false end
    return true
end

function ENT:PlayerTakeItem( ply, itemid, amt )
    self:TakeItemFromInventory( itemid, amt )
    ply:AddItemToInventory( itemid, amt, true )
end

function ENT:SetNextGeneration( time )
    self.NextGeneration = time
end

function ENT:GetNextGeneration()
    return self.NextGeneration or 0
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

function ENT:Resync()
    if ( SERVER ) then
        local inv = self:GetInventory()
        net.Start("as_lootcontainer_sync")
            net.WriteEntity( self )
            net.WriteInventory( inv )
        net.Broadcast()
    elseif ( CLIENT ) then
        net.Start("as_lootcontainer_requestsync")
            net.WriteEntity( self )
        net.SendToServer()
    end
end

if ( SERVER ) then

    util.AddNetworkString("as_lootcontainer_sync")
    util.AddNetworkString("as_lootcontainer_requestsync")

    net.Receive("as_lootcontainer_requestsync", function( _, ply )
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end

        local inv = ent:GetInventory()

        net.Start("as_lootcontainer_sync")
            net.WriteEntity( ent )
            net.WriteInventory( inv )
        net.Send( ply )
    end)

    concommand.Add("as_resynccontainers", function( ply )
        for k, v in pairs( ents.FindByClass("as_lootcontainer") ) do
            net.Start("as_lootcontainer_sync")
                net.WriteEntity(v)
                net.WriteInventory( v:GetInventory() )
            net.Send( ply )
        end
    end)

elseif ( CLIENT ) then

    net.Receive( "as_lootcontainer_sync", function()
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        local inv = net.ReadInventory()

        if isfunction( ent.SetInventory ) then
            ent:SetInventory( inv )
        end
    end)

end