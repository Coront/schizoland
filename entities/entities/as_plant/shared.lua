ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Plant"
ENT.Author			= "Tampy"
ENT.Purpose			= "A plant. For growing food."
ENT.Category		= "Aftershock"
ENT.Spawnable		= false
ENT.AS_OwnableObject = true

function ENT:SetSlots( tbl )
    self.CurSlots = tbl
end

function ENT:GetSlots()
    return self.CurSlots or {}
end

function ENT:FindOpenSlot()
    for i = 1, #self.Slots do
        if not IsValid(self:GetSlots()[i]) then
            return i
        end
    end

    return false --Cannot find a slot.
end

function ENT:AddEntityToSlot( ent, slot )
    local slots = self:GetSlots()
    slots[slot] = ent
    self:SetSlots( slots )
end

function ENT:SetPruneAmount( amt )
    self.PruneAmount = amt
end

function ENT:GetPruneAmount()
    return self.PruneAmount or 0
end

function ENT:SetNextProduce( time )
    self.NextProduce = time
end

function ENT:GetNextProduce()
    return self.NextProduce or 0
end

function ENT:CanPrune( ply )
    if ply:GetASClass() != "cultivator" then return false end
    if self:GetPruneAmount() >= self.PruneMax then return false end
    return true
end

function ENT:Initialize()
    if ( SERVER ) then
        self:SetModel( self.Model )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetUseType( SIMPLE_USE )
        self:SetSolid( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
    end

    self:SetPruneAmount( 20 )
    self:SetNextProduce( CurTime() + self.GrowthLength )
end

function ENT:Think()
    if self:GetPruneAmount() >= self.PruneLoss and CurTime() > self:GetNextProduce() then
        local produceTime = self.GrowthLength
        if self:HasObjectOwner() then
            produceTime = produceTime * (1 - ( self:GetObjectOwner():GetSkillLevel("farming") * SKL.Farming.decproducetime ))
        end

        self:SetPruneAmount( self:GetPruneAmount() - self.PruneLoss )
        self:SetNextProduce( CurTime() + produceTime )
        if self:HasObjectOwner() and self:GetObjectOwner():GetASClass() == "cultivator" then
            self:GetObjectOwner():IncreaseSkillExperience( "farming", SKL.Farming.incamt )
        end

        if ( SERVER ) then
            local slot = self:FindOpenSlot()
            if not slot then return end

            local pos = self:LocalToWorld( Vector( self.Slots[slot] ) )

            local item = self.Food
            local ent = ents.Create("as_baseitem")
            self:AddEntityToSlot( ent, slot )
            ent:SetItem( item )
            ent:SetAmount( 1 )
            ent:SetSkin( AS.Items[item].skin or 0 )
            ent:SetPos( pos )
            ent:Spawn()
            constraint.Weld( ent, self, 0, 0, 0, true, false )
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

    util.AddNetworkString( "as_plant_syncprune" )

    function ENT:ResyncPrune()
        net.Start("as_plant_syncprune")
            net.WriteEntity( self )
            net.WriteInt( self:GetPruneAmount(), 32 )
        net.Broadcast()
    end

else

    net.Receive( "as_plant_syncprune", function()
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        local amt = net.ReadInt( 32 )

        ent:SetPruneAmount( amt )
    end)

end