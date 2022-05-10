--This file might be a little confusing, but it's a system made specifically to counteract players who steal cases.

function PlayerMeta:SetRecentInv( tbl )
    self.RecentInv = tbl
end

function PlayerMeta:GetRecentInv()
    return self.RecentInv or {}
end

function PlayerMeta:AddRecentInvItem( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to give a non-existant item - " .. item) return end
    amt = amt and amt > 0 and math.Round(amt) or 1
    local inv = self:GetRecentInv()
    inv[item] = (inv[item] or 0) + amt
    self:SetRecentInv( inv )
end

function PlayerMeta:TakeRecentInvItem( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to take a non-existant item - " .. item) return end
    amt = amt and amt > 0 and math.Round(amt) or 1
    local inv = self:GetRecentInv()
    inv[item] = (inv[item] or 0) - amt
    if inv[item] <= 0 then inv[item] = nil end
    self:SetRecentInv( inv )
end

function PlayerMeta:ClearRecentInv()
    self:SetRecentInv({})
end

function PlayerMeta:SetRecentInvDelay( length )
    self.RecentInvDelay = length
end

function PlayerMeta:GetRecentInvDelay()
    return self.RecentInvDelay or 0
end

function PlayerMeta:HasRecentInventory()
    if table.Count(self:GetRecentInv()) > 0 then
        return true 
    else
        return false
    end
end

-- ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝

hook.Add( "Think", "AS_RecentInventory", function()
    for k, v in pairs( player.GetAll() ) do
        if not v:IsLoaded() then continue end
        if not v:Alive() then continue end
        if not v:HasRecentInventory() then continue end

        if CurTime() > v:GetRecentInvDelay() then
            v:ClearRecentInv()
        end
    end
end)