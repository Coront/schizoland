-- Banks

local PlayerMeta = FindMetaTable("Player")

function PlayerMeta:SetBank( tbl )
    tbl = tbl or {}
    self.Bank = tbl
end

function PlayerMeta:GetBank()
    return self.Bank
end

function PlayerMeta:AddItemToBank( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to give a non-existant item in bank - " .. item) return end
    amt = amt > 0 and math.Round(amt) or 1
    local bank = self:GetInventory()
    bank[item] = (bank[item] or 0) + amt
    self:SetBank( bank )
end

function PlayerMeta:TakeItemFromBank( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to take a non-existant item in bank - " .. item) return end
    amt = amt > 0 and math.Round(amt) or 1
    local bank = self:GetBank()
    bank[item] = (bank[item] or 0) + amt
    self:SetBank( bank )
end

function PlayerMeta:DepositItem( item, amt )
    
end

function PlayerMeta:WithdrawItem( item, amt )
    
end

function PlayerMeta:HasInBank( item, amt )
    local bank = self:GetBank()
    if bank[item] >= amt then return true end
    return false
end

function PlayerMeta:GetBankWeight()
    local weight = 0
    for k, v in pairs(self.Bank) do
        weight = weight + (AS.Items[k].weight or 1) 
    end
    return weight
end

function PlayerMeta:MaxBankWeight()
    return SET.BankWeight
end