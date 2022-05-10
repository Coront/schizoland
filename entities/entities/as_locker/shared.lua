ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= ""
ENT.Author			= "Tampy"
ENT.Purpose			= ""
ENT.Category		= "Aftershock"
ENT.Spawnable		= false
ENT.AS_OwnableObject = true
ENT.PickupDelay     = 60

ENT.ProfileCost = { --Cost of resources/items to make a profile
    ["misc_scrap"] = 100,
    ["misc_smallparts"] = 150,
    ["misc_chemical"] = 200,
}
ENT.ProfileCapacity = 300

ENT.Sounds = {}
ENT.Sounds.Access = "physics/metal/metal_grate_impact_soft3.wav"
ENT.Sounds.Manage = {
    "physics/body/body_medium_impact_soft1.wav",
    "physics/body/body_medium_impact_soft2.wav",
    "physics/body/body_medium_impact_soft3.wav",
    "physics/body/body_medium_impact_soft4.wav"
}
ENT.Sounds.BreakInto = "ambient/materials/wood_creak1.wav"
ENT.Sounds.Broken = "physics/wood/wood_box_break2.wav"

function ENT:SetProfile( id, name )
    self.lid = id
    self.name = name
    if ( SERVER ) then
        self:ResyncProfile()
    end
end

function ENT:GetProfile()
    return self.lid or 0
end

function ENT:GetProfileName()
    return self.name
end

function ENT:SetInventory( tbl )
    self.Inventory = tbl
    if ( SERVER ) then
        self:ResyncInventory()
    end
end

function ENT:GetInventory()
    return self.Inventory or {}
end

function ENT:AddItemToInventory( item, amt )
    amt = amt or 1
    if not AS.Items[item] then AS.LuaError("Attempt to add non-existant item to locker inventory - " .. item) return end
    local tbl = self:GetInventory()
    tbl[item] = (tbl[item] or 0) + amt
    self:SetInventory( tbl )

    if ( SERVER ) then
        self:SaveInventory()
    end
end

function ENT:TakeItemFromInventory( item, amt )
    amt = amt or 1
    if not AS.Items[item] then AS.LuaError("Attempt to take non-existant item from locker inventory - " .. item) return end
    local tbl = self:GetInventory()
    tbl[item] = (tbl[item] or 0) - amt
    if tbl[item] <= 0 then tbl[item] = nil end
    self:SetInventory( tbl )

    if ( SERVER ) then
        self:SaveInventory()
    end
end

function ENT:StoreItem( ply, item, amt )
    ply:TakeItemFromInventory( item, amt, true )
    self:AddItemToInventory( item, amt )

    if ( CLIENT ) then
        net.Start("as_locker_invtolocker")
            net.WriteEntity( self )
            net.WriteString( item )
            net.WriteInt( amt, 32 )
        net.SendToServer()
    end
end

function ENT:WithdrawItem( ply, item, amt )
    self:TakeItemFromInventory( item, amt )
    ply:AddItemToInventory( item, amt, true )

    if ( CLIENT ) then
        net.Start("as_locker_lockertoinv")
            net.WriteEntity( self )
            net.WriteString( item )
            net.WriteInt( amt, 32 )
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

function ENT:GetCarryWeight()
    local weight = 0
    for k, v in pairs( self:GetInventory() ) do
        weight = weight + (AS.Items[k].weight * v)
    end
    return weight
end

function ENT:CanWithdrawItem( ply, item, amt )
    if not ply:Alive() then return false end
    if ply:GetCarryWeight() + (AS.Items[item].weight * amt) > ply:MaxCarryWeight() then ply:ChatPrint("You are too overweight to withdraw this.") return false end
    return true
end

function ENT:CanStoreItem( ply, item, amt )
    if not ply:Alive() then return false end
    if AS.Items[item].nostore then ply:ChatPrint("This item cannot be stored.") return false end
    if self:GetCarryWeight() + (AS.Items[item].weight * amt) > self.ProfileCapacity then ply:ChatPrint("The profile is too full to store this.") return false end
    return true
end

if ( SERVER ) then

    function ENT:SaveInventory()
        sql.Query("UPDATE as_lockers SET items = " .. SQLStr( util.TableToJSON( self:GetInventory(), true ) ) .. " WHERE lid = " .. self:GetProfile())
    end

    function ENT:Think()
        if self:GetProfile() != 0 and CurTime() >= (self.NextResync or 0) then
            self.NextResync = CurTime() + 5
            self:ResyncProfile()
            self:ResyncInventory()
        end
    end

end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if ( SERVER ) then

    util.AddNetworkString("as_locker_syncprofile")
    util.AddNetworkString("as_locker_syncinventory")

    function ENT:ResyncProfile()
        net.Start("as_locker_syncprofile")
            net.WriteEntity( self )
            net.WriteInt( self:GetProfile(), 32 )
            net.WriteString( self.name )
        net.Broadcast()
    end

    function ENT:ResyncInventory()
        net.Start("as_locker_syncinventory")
            net.WriteEntity( self )
            net.WriteInventory( self:GetInventory() )
        net.Broadcast()
    end

elseif ( CLIENT ) then

    net.Receive( "as_locker_syncprofile", function()
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end
        local profile = net.ReadInt( 32 )
        local name = net.ReadString()

        ent:SetProfile( profile, name )
    end)

    net.Receive( "as_locker_syncinventory", function()
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end
        local inv = net.ReadInventory()

        ent:SetInventory( inv )
    end)

end