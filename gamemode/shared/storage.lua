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
    self:AddItemToInventory( item, amt )
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
        weight = weight + (AS.Items[k].weight or 1) 
    end
    return weight
end

function PlayerMeta:MaxBankWeight()
    return SET.BankWeight
end

function PlayerMeta:CanStoreItem( item, amt )
    if self:GetBankWeight() + (AS.Items[item].weight * amt) > self:MaxBankWeight() then return false end
    return true
end

function PlayerMeta:CanWithdrawItem( item, amt )
    if self:GetCarryWeight() + (AS.Items[item].weight * amt) > self:MaxCarryWeight() then return false end
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

    function BankSync()
        local bank = net.ReadTable()

        LocalPlayer():SetBank( bank )
    end
    net.Receive("as_syncbank", BankSync)

end