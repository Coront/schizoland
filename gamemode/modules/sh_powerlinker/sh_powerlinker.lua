function EntityMeta:SetLinks( tbl )
    self.PowerLinks = tbl
end

function EntityMeta:GetLinks()
    return self.PowerLinks or {}
end

function EntityMeta:SetPower( int )
    self.Power = int
end

function EntityMeta:GetPower()
    return self.Power or 0
end

function EntityMeta:SetPowerUsage( int )
    self.PowerUsage = int
end

function EntityMeta:GetPowerUsage()
    return self.PowerUsage or 0
end

function EntityMeta:SetGenerator( obj )
    self.ParentGenerator = obj
end

function EntityMeta:GetGenerator()
    return self.ParentGenerator or nil
end

function EntityMeta:HasGenerator()
    if self:GetGenerator() then return true end
    return false
end

function EntityMeta:IsGenerator()
    return self.AS_Generator or false
end

function EntityMeta:EstablishLink( otherEnt )
    if not self.AS_Conductor or not otherEnt.AS_Conductor then return end

    --First Entity
    local links = self:GetLinks()
    links[ otherEnt ] = true
    self:SetLinks( links )

    --Second Entity
    local links = otherEnt:GetLinks()
    links[ self ] = true
    otherEnt:SetLinks( links )

    --[[ All of these entities are going to have a generator parent, this is where the all of the power is coming from.
    It will be what the entity references to deduct power from. ]]
    if self:IsGenerator() then
        otherEnt:SetGenerator( self )
    elseif otherEnt:IsGenerator() then
        self:SetGenerator( otherEnt )
    end
end

function EntityMeta:DestroyLink( otherEnt )
    --First Entity
    local links = self:GetLinks()
    links[ otherEnt ] = nil
    self:SetLinks( links )

    --Second Entity
    local links = otherEnt:GetLinks()
    links[ self ] = nil
    otherEnt:SetLinks( links )
end

function EntityMeta:UpdatePower()
    local power = self:IsGenerator()
    if self:HasGenerator() then
        power = self:GetGenerator():GetPower()
    end

    self:SetPower( power )
    if ( SERVER ) then
        self:ResyncPower()
    end
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if ( SERVER ) then

    util.AddNetworkString("as_powerlinker_syncpower")

    function EntityMeta:ResyncPower()
        net.Start("as_powerlinker_syncpower")
            net.WriteEntity( self )
            net.WriteUInt( self:GetPower(), 16 )
        net.Broadcast()
    end

elseif ( CLIENT ) then

    net.Receive( "as_powerlinker_syncpower", function()
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end
        local power = net.ReadUInt( 16 )
        ent:SetPower( power )
    end)

end