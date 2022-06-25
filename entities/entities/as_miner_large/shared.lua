ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName		= "Large Miner"
ENT.Author			= "Tampy"
ENT.Purpose			= "A miner. Pounds the ground for scrap and small parts."
ENT.Category		= "Aftershock"
ENT.Spawnable		= false
ENT.AutomaticFrameAdvance = true
ENT.AS_OwnableObject = true
ENT.AS_Conductor = true

ENT.MaxHealth = 3500 --Object Health
ENT.Items = { --items that we will potentially produce over time.
    [1] = "misc_scrap",
    [2] = "misc_smallparts",
}
ENT.ProduceLength = 30 --Time it takes for us to randomly produce an item.

ENT.PowerNeeded = 750

function ENT:Initialize()
    if ( SERVER ) then
        self:SetModel( "models/props_combine/combinethumper001a.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetUseType( SIMPLE_USE )
        self:SetSolid( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )

        self:SetHealth( self.MaxHealth )
        self:SetMaxHealth( self.MaxHealth )
    end

    self:SetPower( -self.PowerNeeded )
end

function ENT:SetInventory( tbl )
    self.Inventory = tbl
end

function ENT:GetInventory()
    return self.Inventory or {}
end

function ENT:AddItemToInventory( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to produce a non-existant item at miner - " .. item) return end
    amt = amt and amt > 0 and math.Round(amt) or 1
    local inv = self:GetInventory()
    inv[item] = (inv[item] or 0) + amt
    self:SetInventory( inv )
end

function ENT:TakeItemFromInventory( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to take a non-existant item at miner - " .. item) return end
    amt = amt and amt > 0 and math.Round(amt) or 1
    local inv = self:GetInventory()
    inv[item] = (inv[item] or 0) - amt
    if inv[item] <= 0 then inv[item] = nil end
    self:SetInventory( inv )
end

function ENT:HasItemInInventory( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to request a non-existant item with miner - " .. item) return end
    amt = amt and amt > 0 and math.Round(amt) or 1
    local inv = self:GetInventory()
    if (inv[item] or 0) >= amt then return true end
    return false
end

function ENT:PlayerTakeItem( ply, item, amt )
    self:TakeItemFromInventory( item, amt )
    ply:AddItemToInventory( item, amt, true )
end

function ENT:SetActiveState( bool )
    self.Running = bool
end

function ENT:GetActiveState()
    return self.Running or false
end

function ENT:TogglePower()
    if self:GetActiveState() then
        self:SetActiveState( false )
    else
        self:SetActiveState( true )
    end
end

function ENT:SetNextHarvest( time )
    self.NextHarvest = time
end

function ENT:GetNextHarvest()
    return self.NextHarvest or 0
end

function ENT:CanMine()
    local tr = util.TraceLine({
        start = self:GetPos(),
        endpos = self:GetPos() + Vector( 0, 0, -500 ),
        filter = {self},
    })
    if not tr.HitWorld then return false end

    local tr2 = util.TraceLine({
        start = self:GetPos(),
        endpos = self:GetPos() + Vector( 0, 0, 99999 ),
        filter = {self},
        mask = MASK_SOLID_BRUSHONLY,
    })
    if not tr2.HitSky then return false end

    if self:GetPower() < 0 then return false end
    return true
end

function ENT:Think()
    local nextharvest = self.ProduceLength
    if self:HasObjectOwner() then
        nextharvest = nextharvest * (1 - (self:GetObjectOwner():GetSkillLevel("mining") * SKL.Mining.decharvesttime))
    end

    if self:GetActiveState() then --Is turned on
        if CurTime() >= self:GetNextHarvest() then
            self:SetNextHarvest( CurTime() + nextharvest )

            local item = table.Random( self.Items )
            self:AddItemToInventory( item, 10 )
            if self:GetObjectOwner():GetASClass() == "scavenger" then
                self:GetObjectOwner():IncreaseSkillExperience("mining", (SKL.Mining.incamt * 10))
            end
        end

        if not self:CanMine() then
            self:TogglePower()
            if SERVER then
                self:DisableOperation()
            end
        end
    else
        self:SetNextHarvest( CurTime() + nextharvest )
    end

    if ( CLIENT ) then
        if CurTime() > (self:GetCreationTime() + NWSetting.PostCreationDelay) and CurTime() > (self.NextResync or 0) then
            self:Resync()
            self.NextResync = CurTime() + NWSetting.EntUpdateLength
        end
    end

    self:NextThink( CurTime() + 0.1 )
    return true
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

function ENT:Resync()
    if ( SERVER ) then
        local state = self:GetActiveState()
        local inv = self:GetInventory()

        net.Start("as_miner_sync")
            net.WriteEntity( self )
            net.WriteBool( state )
            net.WriteInventory( inv )
        net.Broadcast()
    elseif ( CLIENT ) then
        net.Start("as_miner_requestsync")
            net.WriteEntity( self )
        net.SendToServer()
    end
end