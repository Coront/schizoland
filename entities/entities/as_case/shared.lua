ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Case"
ENT.Author			= "Tampy"
ENT.Purpose			= "/y claimed back off or die 10 seconds"
ENT.Category		= "Aftershock"
ENT.Spawnable		= false

function ENT:SetInventory( tbl )
    self.Inventory = tbl
    if ( SERVER ) then
        self:Resync()
    end
end

function ENT:GetInventory()
    return self.Inventory or {}
end

function ENT:SetLockedTimer( len )
    self.LockedLength = len
    if ( SERVER ) then
        self:Resync()
    end
end

function ENT:GetLockedTimer()
    return self.LockedLength or 0
end

function ENT:IsLocked()
    if CurTime() < self:GetLockedTimer() then return true end
    return false
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
    if self:IsLocked() then ply:ChatPrint("This case is still locked.") return false end
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
    if (SERVER) then
        ply:EmitSound( ITEMCUE.TAKE )
        if self:GetNWString("owner", "") != "" then
            ply:SetRecentInvDelay( CurTime() + SET.PlyCombatLength )
            ply:AddRecentInvItem( itemid, amt )
        end
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

function ENT:Resync()
    if ( SERVER ) then
        local inv = self:GetInventory()
        local lock = self:GetLockedTimer()
        net.Start("as_case_sync")
            net.WriteEntity( self )
            net.WriteTable( inv )
            net.WriteFloat( lock )
        net.Broadcast()
    elseif ( CLIENT ) then
        net.Start("as_case_requestsync")
            net.WriteEntity( self )
        net.SendToServer()
    end
end

if ( SERVER ) then

    util.AddNetworkString("as_case_sync")
    util.AddNetworkString("as_case_requestsync")

    net.Receive("as_case_requestsync", function( _, ply ) --This is for when a player requests information because their client needs to update the entity.
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end

        local inv = ent:GetInventory()
        local lock = ent:GetLockedTimer()

        net.Start( "as_case_sync" )
            net.WriteEntity( ent )
            net.WriteTable( inv )
            net.WriteFloat( lock )
        net.Send( ply )
    end)

    concommand.Add( "as_resynccases", function( ply )
        for k, v in pairs( ents.FindByClass("as_case") ) do
            local inv = v:GetInventory()
            local lock = v:GetLockedTimer()

            net.Start( "as_case_sync" )
                net.WriteEntity( v )
                net.WriteTable( inv )
                net.WriteFloat( lock )
            net.Send( ply )
        end
    end)

elseif ( CLIENT ) then

    net.Receive("as_case_sync", function()
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end
        local inv = net.ReadTable()
        local lock = net.ReadFloat()

        if isfunction(ent.SetInventory) then
            ent:SetInventory( inv )
        end
        if isfunction(ent.SetLockedTimer) then
            ent:SetLockedTimer( lock )
        end
    end)

end