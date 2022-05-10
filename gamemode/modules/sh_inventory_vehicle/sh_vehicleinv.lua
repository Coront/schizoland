-- Banks

local PlayerMeta = FindMetaTable("Player")

function PlayerMeta:SetBank( tbl )
    tbl = tbl or {}
    self.Bank = tbl
end

function PlayerMeta:GetBank()
    return self.Bank or {}
end

function PlayerMeta:AddItemToBank( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to give a non-existant item in bank - " .. item) return end
    amt = amt > 0 and math.Round(amt) or 1
    local bank = self:GetBank()
    bank[item] = (bank[item] or 0) + amt
    self:SetBank( bank )
end

function PlayerMeta:TakeItemFromBank( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to take a non-existant item in bank - " .. item) return end
    amt = amt > 0 and math.Round(amt) or 1
    local bank = self:GetBank()
    bank[item] = (bank[item] or 0) - amt
    if bank[item] <= 0 then bank[item] = nil end
    self:SetBank( bank )
end

function PlayerMeta:DepositItem( item, amt )
    self:TakeItemFromInventory( item, amt )
    self:AddItemToBank( item, amt )
end

function PlayerMeta:WithdrawItem( item, amt )
    self:TakeItemFromBank( item, amt )
    self:AddItemToInventory( item, amt, true )
end

function PlayerMeta:HasInBank( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to request a non-existant item - " .. item) return end
    amt = amt and amt > 0 and math.Round(amt) or 1
    local bank = self:GetBank()
    if (bank[item] or 0) >= amt then return true end
    return false
end

function PlayerMeta:GetBankWeight()
    local weight = 0
    for k, v in pairs(self:GetBank()) do
        weight = weight + ((AS.Items[k].weight or 1) * v)
    end
    return weight
end

function PlayerMeta:MaxBankWeight( vehicleid )
    return AS.Items[vehicleid].weight
end

function PlayerMeta:CanStoreItem( ent, item, amt )
    if ent:GetObjectOwner() != self then return false end
    if self:GetPos():Distance(ent:GetPos()) > 200 then self:ChatPrint("You are too far to store anything.") return false end --Dont try storing stuff miles away wtf???
    if self:GetBankWeight() + (AS.Items[item].weight * amt) > self:MaxBankWeight( ent:GetNWString("ASID") ) then self:ChatPrint("Your storage is too full to hold this.") return false end
    if (AS.Items[item].nostore or false) then self:ChatPrint("You cannot deposit " .. AS.Items[item].name .. " in your storage.") return false end
    return true
end

function PlayerMeta:CanWithdrawItem( ent, item, amt )
    if ent:GetObjectOwner() != self then return false end
    if self:GetPos():Distance(ent:GetPos()) > 200 then self:ChatPrint("You are too far to withdraw anything.") return false end
    if self:GetCarryWeight() + (AS.Items[item].weight * amt) > self:MaxCarryWeight() then self:ChatPrint("You are too overweight to withdraw this.") return false end
    return true
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if SERVER then

    util.AddNetworkString("as_syncbank")

    --This function will resync a player's inventory if an error with information that was sent from the client was caught.
    function PlayerMeta:ResyncBank()
        net.Start("as_syncbank")
            net.WriteTable(self:GetBank())
        net.Send(self)
    end
    concommand.Add("as_resyncbank", function(ply) ply:ResyncBank() end)

elseif CLIENT then

    net.Receive("as_syncbank", function()
        local bank = net.ReadTable()
        LocalPlayer():SetBank( bank )
    end)

end