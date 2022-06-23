ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Case"
ENT.Author			= "Tampy"
ENT.Purpose			= "/y claimed back off or die 10 seconds"
ENT.Category		= "Aftershock"
ENT.Spawnable		= false

function ENT:SetInventory( tbl )
    self.Inventory = tbl
end

function ENT:GetInventory()
    return self.Inventory or {}
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

function ENT:HasInAmmoInventory( itemid, amt )
    if not AS.Items[itemid] then AS.LuaError("Attempt to request a non-existant item in a container - " .. itemid) return end
    amt = amt and amt > 0 and math.Round(amt) or 1
    local inv = self:GetInventory().ammo or {}
    if (inv[itemid] or 0) >= amt then return true end
    return false
end

function ENT:PlayerCanTakeItem( ply, itemid, amt )
    if not ply:Alive() then return false end
    if IsValid(self:GetClaimer()) and ply != self:GetClaimer() then ply:ChatPrint("You are not the claimant of this case.") return false end
    if ply:GetPos():Distance( self:GetPos() ) > 200 then ply:ChatPrint("You are too far to take this item.") return false end
    if ply:GetCarryWeight() + (AS.Items[itemid].weight * amt) > ply:MaxCarryWeight() and not SET.RawResources[itemid] then ply:ChatPrint("You are too overweight to take this item.") return false end
    return true
end

function ENT:PlayerCanTakeAmmo( ply )
    if not ply:Alive() then return false end
    if ply:GetPos():Distance( self:GetPos() ) > 200 then ply:ChatPrint("You are too far to take this item.") return false end
    return true
end

function ENT:PlayerTakeItem( ply, itemid, amt )
    self:TakeItemFromInventory( itemid, amt )
    if (SERVER) and self:GetNWString("owner", "") != "" then
        ply:SetRecentInvDelay( CurTime() + SET.PlyCombatLength )
        ply:AddRecentInvItem( itemid, amt )
    end
    ply:AddItemToInventory( itemid, amt, true )
end

function ENT:PlayerTakeAmmo( ply, itemid, amt )
    local inv = self:GetInventory().ammo
    inv[itemid] = (inv[itemid] or 0) - amt
    if inv[itemid] <= 0 then inv[itemid] = nil end
    if table.Count(self:GetInventory().ammo) <= 0 then self:GetInventory().ammo = nil end

    if SERVER then
        ply:GiveAmmo( amt, translateAmmoNameID(itemid), true )
    end
end

function ENT:SetClaimer( ent )
    self:SetNWEntity("claimant", ent)
end

function ENT:GetClaimer()
    return self:GetNWEntity("claimant", nil)
end

function ENT:DeclaimOwner()
    self:SetNWEntity("claimant", nil)
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if ( SERVER ) then

    util.AddNetworkString("as_case_syncinventory")
    util.AddNetworkString("as_case_requestinventory")

    function ENT:ResyncInventory()
        net.Start("as_case_syncinventory")
            net.WriteEntity( self )
            net.WriteTable( self:GetInventory() )
        net.Broadcast() --Everyone needs it
    end

    function ResyncAllCaseInventories( ply )
        for k, v in pairs( ents.FindByClass("as_case") ) do
            net.Start("as_case_syncinventory")
                net.WriteEntity(v)
                net.WriteTable( v:GetInventory() )
            net.Send( ply )
        end
    end
    concommand.Add("as_resynccases", ResyncAllCaseInventories)

    net.Receive("as_case_requestinventory", function( _, ply )
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        if ent:GetClass() != "as_case" then return end
        net.Start("as_case_syncinventory")
            net.WriteEntity( ent )
            net.WriteTable( ent:GetInventory() )
        net.Send( ply )
    end)

else

    net.Receive("as_case_syncinventory", function()
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end 
        local inv = net.ReadTable()
        if not ent.SetInventory then return end
        ent:SetInventory( inv )
    end)

    timer.Create( "as_autoresync_cases", 10, 0, function()
        for k, v in pairs( ents.FindByClass("as_case") ) do
            if not IsValid(v) then continue end
            net.Start("as_case_requestinventory") --Cases utilize the lootcontainer inventory system, so this isnt a concern.
                net.WriteEntity(v)
            net.SendToServer()
        end
    end)

end