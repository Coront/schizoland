ENT.Type            = "ai"
ENT.Base            = "base_ai" 
ENT.PrintName		= "Large Antlion Grub"
ENT.Author			= "Tampy"
ENT.Purpose			= "A grub."
ENT.Category		= "Aftershock"
ENT.Spawnable		= false
ENT.AS_OwnableObject = true

ENT.MaxHealth = 1000 --Object Health
ENT.Items = { --items that we will potentially produce over time.
    [1] = "misc_chemical",
}
ENT.ProduceLength = 60 --Time it takes for us to randomly produce an item.
ENT.Capacity = 100 --Maximum chemicals that it can hold.

function ENT:Initialize()
    if ( SERVER ) then
        self:SetModel( "models/antlion_grub.mdl" )
        self:SetHullType( HULL_TINY )
        self:SetSolid( SOLID_BBOX )
        self:SetUseType( SIMPLE_USE )
        self:CapabilitiesAdd( CAP_MOVE_GROUND )
        self:SetMoveType( MOVETYPE_STEP )
        self:SetHealth( self.MaxHealth )
        self:SetMaxHealth( self.MaxHealth )
        self:SetModelScale( 1.7 )
    end

    self:SetNextProduce( CurTime() + self.ProduceLength )
end

function ENT:SetInventory( tbl )
    self.Inventory = tbl
end

function ENT:GetInventory()
    return self.Inventory or {}
end

function ENT:AddItemToInventory( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to produce a non-existant item at grub - " .. item) return end
    amt = amt and amt > 0 and math.Round(amt) or 1
    local inv = self:GetInventory()
    inv[item] = (inv[item] or 0) + amt
    self:SetInventory( inv )
end

function ENT:TakeItemFromInventory( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to take a non-existant item at grub - " .. item) return end
    amt = amt and amt > 0 and math.Round(amt) or 1
    local inv = self:GetInventory()
    inv[item] = (inv[item] or 0) - amt
    if inv[item] <= 0 then inv[item] = nil end
    self:SetInventory( inv )
end

function ENT:HasItemInInventory( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to request a non-existant item with grub - " .. item) return end
    amt = amt and amt > 0 and math.Round(amt) or 1
    local inv = self:GetInventory()
    if (inv[item] or 0) >= amt then return true end
    return false
end

function ENT:PlayerTakeItem( ply, item, amt )
    self:TakeItemFromInventory( item, amt )
    ply:AddItemToInventory( item, amt, true )
end

function ENT:SetNextProduce( time )
    self.NextProduce = time
end

function ENT:GetNextProduce()
    return self.NextProduce or 0
end

function ENT:CanProduce()
    for k, v in pairs( ents.FindByClass("as_grub") ) do
        if v == self then continue end
        if v:GetPos():Distance(self:GetPos()) <= 15 and v:GetObjectOwner() == self:GetObjectOwner() then
            self:GetObjectOwner():ChatPrint("One of your grubs is too close to another in order to produce its own chemicals.")
            return false
        end
    end
    if (self:GetInventory()["misc_chemical"] or 0) >= self.Capacity then
        if CurTime() <= (self:GetObjectOwner().NextGrubWarning or 0) then
            self:GetObjectOwner().NextGrubWarning = CurTime() + 1500
            self:GetObjectOwner():ChatPrint("One of your grubs has reached max chemical capacity.")
        end
        return false
    end
    return true
end

function ENT:PlayGrubSound()
    local sounds = {
        [1] = "npc/antlion_grub/agrub_alert1.wav",
        [2] = "npc/antlion_grub/agrub_alert2.wav",
        [3] = "npc/antlion_grub/agrub_alert3.wav",
        [4] = "npc/antlion_grub/agrub_idle1.wav",
        [5] = "npc/antlion_grub/agrub_idle3.wav",
        [6] = "npc/antlion_grub/agrub_idle6.wav",
        [7] = "npc/antlion_grub/agrub_idle8.wav",
        [8] = "npc/antlion_grub/agrub_stimulated1.wav",
        [9] = "npc/antlion_grub/agrub_stimulated2.wav",
        [10] = "npc/antlion_grub/agrub_stimulated3.wav",
    }

    local snd = table.Random(sounds)

    self:EmitSound( snd )
end

function ENT:Think()
    local nextproduce = self.ProduceLength

    if CurTime() >= self:GetNextProduce() then
        self:SetNextProduce( CurTime() + nextproduce)
        if not self:CanProduce() then return end

        local item = table.Random( self.Items )
        self:AddItemToInventory( item, 10 )
    end

    if ( SERVER ) then
        if CurTime() > (self.NextResync or 0) then
            self.NextResync = CurTime() + 5
            self:ResyncInventory()
        end

        if CurTime() > (self.NextSound or 0) then
            self.NextSound = CurTime() + math.random( 10, 20 )
            self:PlayGrubSound()
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

    util.AddNetworkString( "as_grub_syncinventory" )

    function ENT:ResyncInventory()
        net.Start("as_grub_syncinventory")
            net.WriteEntity( self )
            net.WriteInventory( self:GetInventory() )
        net.Broadcast()
    end

else

    net.Receive( "as_grub_syncinventory", function()
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        local inv = net.ReadInventory()

        ent:SetInventory( inv )
    end)

end