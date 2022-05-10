ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Community Locker"
ENT.Author			= "Tampy"
ENT.Purpose			= "Store Items"
ENT.Category		= "Aftershock"
ENT.Spawnable		= false

ENT.Sounds = {}
ENT.Sounds.Access = "physics/wood/wood_crate_impact_hard1.wav"
ENT.Sounds.Manage = {
    "physics/body/body_medium_impact_soft1.wav",
    "physics/body/body_medium_impact_soft2.wav",
    "physics/body/body_medium_impact_soft3.wav",
    "physics/body/body_medium_impact_soft4.wav"
}
ENT.Sounds.BreakInto = "ambient/materials/wood_creak2.wav"
ENT.Sounds.Broken = "physics/wood/wood_box_break1.wav"

function ENT:SetCommunity( int, name )
    name = name or ""

    self.CID = int
    self.name = name

    if ( SERVER ) then
        self:ResyncCommunity()
    end
end

function ENT:GetCommunity()
    return self.CID or 0
end

function ENT:GetCommunityName()
    return self.name or ""
end

function ENT:SetInventory( tbl )
    self.Inventory = tbl
    if ( SERVER ) then
        self:ResyncInventory()
        self:SaveInventory()
    end
end

function ENT:GetInventory()
    return self.Inventory or {}
end

function ENT:GetCarryWeight()
    local weight = 0
    for k, v in pairs( self:GetInventory() ) do
        weight = weight + (AS.Items[k].weight or 0)
    end
    return weight
end

function ENT:AddItemToInventory( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to add non-existant item to locker - " .. item) return end

    local tbl = self:GetInventory()
    tbl[item] = (tbl[item] or 0) + amt
    self:SetInventory( tbl )
end

function ENT:PlayerStoreItem( ply, item, amt )
    ply:TakeItemFromInventory( item, amt )
    self:AddItemToInventory( item, amt )

    if ( CLIENT ) then
        net.Start("as_cstorage_deposititem")
            net.WriteEntity( self )
            net.WriteString( item )
            net.WriteUInt( amt, NWSetting.ItemAmtBits )
        net.SendToServer()
    end
end

function ENT:TakeItemFromInventory( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to take non-existant item from locker - " .. item) return end

    local tbl = self:GetInventory()
    tbl[item] = (tbl[item] or 0) - amt
    if tbl[item] <= 0 then tbl[item] = nil end
    self:SetInventory( tbl )
end

function ENT:PlayerTakeItem( ply, item, amt )
    self:TakeItemFromInventory( item, amt )
    ply:AddItemToInventory( item, amt, true )

    if ( CLIENT ) then
        net.Start("as_cstorage_withdrawitem")
            net.WriteEntity( self )
            net.WriteString( item )
            net.WriteUInt( amt, NWSetting.ItemAmtBits )
        net.SendToServer()
    end
end

function ENT:GetItemCount( item )
    local amt = 0
    amt = amt + (self:GetInventory()[item] or 0)
    return amt
end

function ENT:HasItemInInventory( item, amt )
    amt = amt or 1
    if (self:GetInventory()[item] or 0) >= amt then return true end
    return false
end

function ENT:CanWithdrawItem( ply, item, amt )
    if not ply:Alive() then ply:ChatPrint("You are dead.") return false end
    if ply:GetCarryWeight() + (AS.Items[item].weight * amt) > ply:MaxCarryWeight() then ply:ChatPrint("You are too overweight to withdraw this.") return false end
    return true
end

function ENT:CanStoreItem( ply, item, amt )
    if not ply:Alive() then ply:ChatPrint("You are dead.") return false end
    if AS.Items[item].nostore then ply:ChatPrint("This item cannot be stored.") return false end
    return true
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if ( SERVER ) then

    util.AddNetworkString("as_cstorage_synccommunity")
    util.AddNetworkString("as_cstorage_syncinventory")

    function ENT:ResyncCommunity()
        net.Start("as_cstorage_synccommunity")
            net.WriteEntity(self)
            net.WriteUInt(self:GetCommunity(), NWSetting.CommunityAmtBits)
            net.WriteString(self:GetCommunityName())
        net.Broadcast()
    end

    function ENT:ResyncInventory()
        net.Start("as_cstorage_syncinventory")
            net.WriteEntity(self)
            net.WriteInventory(self:GetInventory())
        net.Broadcast()
    end

    function ENT:Think()
        if CurTime() > (self.NextResync or 0) then
            self.NextResync = CurTime() + 5

            self:ResyncCommunity()
            self:ResyncInventory()
        end
    end

elseif ( CLIENT ) then

    net.Receive("as_cstorage_synccommunity", function()
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end
        local cid = net.ReadUInt( NWSetting.CommunityAmtBits )
        local name = net.ReadString()

        ent:SetCommunity( cid, name )
    end)

    net.Receive("as_cstorage_syncinventory", function()
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end
        local inv = net.ReadInventory()

        ent:SetInventory( inv )
    end)

end