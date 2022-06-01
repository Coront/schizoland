function EntityMeta:CanLink()
    if self.AS_Conductor then return true end
    return false
end

-- Object Links

function EntityMeta:SetLinks( tbl )
    self.PowerLinks = tbl
end

function EntityMeta:GetLinks()
    return self.PowerLinks or {}
end

function EntityMeta:ClearLinks()
    self:SetLinks( nil )
end

-- Object Power

function EntityMeta:SetPower( int )
    self.Power = int
end

function EntityMeta:GetPower()
    return self.Power or 0
end

-- Object Generator

function EntityMeta:SetGenerator( obj )
    self.ParentGenerator = obj
end

function EntityMeta:GetGenerator()
    return self.ParentGenerator or nil
end

function EntityMeta:ClearGenerator()
    self:SetGenerator( nil )
end

function EntityMeta:HasGenerator()
    if self:GetGenerator() then return true end
    return false
end

function EntityMeta:IsGenerator()
    return self.AS_Generator or false
end

-- Generator Provider ( The entity that gave the generator )

function EntityMeta:SetGeneratorProvider( obj )
    self.ParentGeneratorProvider = obj
end

function EntityMeta:GetGeneratorProvider()
    return self.ParentGeneratorProvider or nil
end

function EntityMeta:HasGeneratorProvider()
    if self:GetGeneratorProvider() then return true end
    return false
end

function EntityMeta:ClearGeneratorProvider()
    self:SetGeneratorProvider( nil )
end

-- ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗███╗   ███╗███████╗███╗   ██╗████████╗
-- ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝████╗ ████║██╔════╝████╗  ██║╚══██╔══╝
-- ██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██╔████╔██║█████╗  ██╔██╗ ██║   ██║
-- ██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║
-- ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║ ╚═╝ ██║███████╗██║ ╚████║   ██║
-- ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝
--[[ 
    To anyone who plans on managing this, I tried to write out my thought process while doing this system because the way it functions can be incredibly hard to understand. Every object that is a conductor of power
    will have it's own table with links. The keys are the entity ID of other objects, while the value is a boolean (which does nothing). All of these objects will have a parent source, which is the power generator.
    The power generator bends the rules a bit by making direct links with objects that are not linked specifically to it, but another object that has it parented. These objects will all deduct power from that
    generator that has been parented. By default in PostnukeRP I believe eldar called it a powergrid, but it's basically where all of the power will come from. Think of it as invisible links.

    Also, this shit still has A LOT of issues.
]]

function EstablishLink( ent1, ent2 )
    if not ent1:CanLink() then return end
    if not ent2:CanLink() then return end

    --First, we need to establish to both entities that they are now linked to each other.

    local links = ent1:GetLinks()
    links[ ent2 ] = true
    ent1:SetLinks( links )

    local links2 = ent2:GetLinks()
    links2[ ent1 ] = true 
    ent2:SetLinks( links2 )

    --Next, we need to set up the generator parent. The entity needs something to reference to know where its power is coming from.

    if not ent1:IsGenerator() and not ent2:IsGenerator() then --Both objects are not generators. We'll see if one of them has a main generator.
        local mainGenerator, newEnt
        if ent1:HasGenerator() and not ent2:HasGenerator() then --The first entity has a generator, but the second doesn't. We will tell the second that it now is part of the first entity's generator.
            ent2:SetGeneratorProvider( ent1 )
            mainGenerator, newEnt = ent1:GetGenerator(), ent2
        elseif ent2:HasGenerator() and not ent1:HasGenerator() then --Same as above, vice-versa.
            ent1:SetGeneratorProvider( ent2 )
            mainGenerator, newEnt = ent2:GetGenerator(), ent1
        end

        if newEnt then
            newEnt:SetGenerator( mainGenerator )
        end
        if mainGenerator then --We gotta tell the generator that there is a new link!
            local generatorLinks = mainGenerator:GetLinks()
            generatorLinks[ newEnt ] = true
            mainGenerator:SetLinks( generatorLinks )
            mainGenerator:UpdatePower() --We need to update the power too!
        end
    elseif ent1:IsGenerator() and not ent2:IsGenerator() then --The first entity is a generator! We'll do the same thing, but without checks because we have direct references.
        if ent1:HasGenerator() then
            local mainGenerator = ent1:GetGenerator()
            local generatorLinks = mainGenerator:GetLinks()
            generatorLinks[ ent2 ] = true
            mainGenerator:SetLinks( generatorLinks )
            mainGenerator:UpdatePower()
            ent2:SetGenerator( ent1:GetGenerator() )
        else
            ent2:SetGenerator( ent1 )
        end
    elseif ent2:IsGenerator() and not ent1:IsGenerator() then --Same as above, vice-versa.
        if ent2:HasGenerator() then
            local mainGenerator = ent2:GetGenerator()
            local generatorLinks = mainGenerator:GetLinks()
            generatorLinks[ ent1 ] = true
            mainGenerator:SetLinks( generatorLinks )
            mainGenerator:UpdatePower()
            ent2:SetGenerator( ent1:GetGenerator() )
            ent1:SetGenerator( ent2:GetGenerator() )
        else
            ent1:SetGenerator( ent2 )
        end
    elseif ent1:IsGenerator() and ent2:IsGenerator() then --This is specifically for linking generators.
        local mainGenerator, newEnt
        if ent1:HasGenerator() and not ent2:HasGenerator() then --If the first generator has a generator linked to it, but not the second one (second is being introduced)
            ent2:SetGeneratorProvider( ent1 )
            mainGenerator, newEnt = ent1:GetGenerator(), ent2
        elseif ent2:HasGenerator() and not ent1:HasGenerator() then --first is being introduced
            ent1:SetGeneratorProvider( ent2 )
            mainGenerator, newEnt = ent2:GetGenerator(), ent1
        elseif not ent1:HasGenerator() and not ent2:HasGenerator() then --Since they're both generators, the first generator linked will always take priority.
            ent2:SetGenerator( ent1 )
            mainGenerator, newEnt = ent1, ent2
        end

        if newEnt then
            newEnt:SetGenerator( mainGenerator )
        end
        if mainGenerator then
            local generatorLinks = mainGenerator:GetLinks()
            generatorLinks[ newEnt ] = true
            mainGenerator:SetLinks( generatorLinks )
            mainGenerator:UpdatePower()
        end
    end

    --Finally, with the new links established, we'll tell the entities to update their power calculation.

    ent1:UpdatePower()
    ent2:UpdatePower()
end

function DestroyLink( ent1, ent2 )
    local links = ent1:GetLinks()
    links[ ent2 ] = nil 
    ent1:SetLinks( links )

    local links2 = ent2:GetLinks()
    links2[ ent1 ] = nil 
    ent2:SetLinks( links2 )

    --We need to detach ourselves from the parent generator too, but we also have to make sure that the object who provided the generator isn't being the one detached.

    if ent2:HasGenerator() and ent2:HasGeneratorProvider() and ent2:GetGeneratorProvider() == ent1 then --The second entity has a provider and the provider is the first entity.
        local generator = ent2:GetGenerator() --We need to tell the generator that we are no longer linked to this entity.
        local generatorLinks = generator:GetLinks()
        generatorLinks[ ent2 ] = nil
        generator:SetLinks( generatorLinks )
        generator:UpdatePower()
        ent2:ClearGenerator() --And then we clear our parent generator and the provider.
        ent2:ClearGeneratorProvider()
    elseif ent1:HasGenerator() and ent1:HasGeneratorProvider() and ent1:GetGeneratorProvider() == ent2 then --Same as above, vice-versa.
        local generator = ent1:GetGenerator()
        local generatorLinks = generator:GetLinks()
        generatorLinks[ ent1 ] = nil 
        generator:SetLinks( generatorLinks )
        generator:UpdatePower()
        ent1:ClearGenerator()
        ent1:ClearGeneratorProvider()
    end

    --If we reach this point and the previous functions arent ran, it means that either the first entity or the second entity ARE the provider, a.k.a. the generator.
    if ent1:HasGenerator() then --Second entity is the generator
        local generator = ent1:GetGenerator() --We need to tell the generator that we are no longer linked to this entity.
        local generatorLinks = generator:GetLinks()
        generatorLinks[ ent1 ] = nil
        generator:SetLinks( generatorLinks )
        ent1:ClearGenerator()
        ent1:UpdatePower()
    elseif ent2:HasGenerator() then --First entity is the generator
        local generator = ent2:GetGenerator()
        local generatorLinks = generator:GetLinks()
        generatorLinks[ ent2 ] = nil
        generator:SetLinks( generatorLinks )
        ent2:ClearGenerator()
        ent2:UpdatePower()
    end
end

function EntityMeta:UpdatePower() --This function will update the power calculations of an object. Please be mindful that you update every object that is linked, and you should avoid looping this function inside itself.
    local power = 0 --Obviously, there will never be any power to begin with.

    --First, we have to find out how much power we as the object will start off with. We will either be a power generator or a power consumer/conductor.

    if self:IsGenerator() and not self:HasGenerator() then --We are a generator. Generally this means that we have power initially.
        if self:GetActiveState() then --If we are turned on...
            power = self.PowerProduced --Set our power.
        end

        for k, v in pairs( self:GetLinks() ) do --We need to go through all of our current links to see if we have any generators connected to us.
            if not k:IsGenerator() then continue end --Skip anything not a generator
            if not k:GetActiveState() then continue end --Skip a generator if it's off.
            power = power + k.PowerProduced
        end
    else --We are NOT a generator. This means that we are a power consumer or conductor.
        if self.PowerNeeded then
            power = -self.PowerNeeded
        end
    end

    --Next, this is specifically for the generators, we have to find out how much power we should have with the objects that are linked consuming it.

    if self:IsGenerator() and not self:HasGenerator() then
        for k, v in pairs( self:GetLinks() ) do
            if k:IsGenerator() or (k.PowerNeeded and k.PowerNeeded == 0) then continue end --Ignore anything that is a generator or needs 0 power.

            if k.PowerNeeded then --The object is something that needs power.
                power = power - k.PowerNeeded --We lost power, because we provided it to the object.
            end
        end
    end

    --This part is also specifically for the generators, we have to tell the objects that the linked to it how much power they should have. Think of it as a parent commanding the children.

    if self:IsGenerator() and not self:HasGenerator() then
        for k, v in pairs( self:GetLinks() ) do
            k:SetPower( power )
            if ( SERVER ) then
                k:ResyncPower()
            end
        end
    end

    --We will then update the power for the object. We don't this with objects that have a generator because the generator is telling them directly how much power they have supposed to have.

    if self:IsGenerator() and self:HasGenerator() then
        self:GetGenerator():UpdatePower()
    end

    if self:IsGenerator() and not self:HasGenerator() or not self:IsGenerator() and not self:HasGenerator() then
        self:SetPower( power ) --Set the new power amount
    end
    if ( SERVER ) then
        self:ResyncPower() --This will resync clientside.
    end
end

-- ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝

hook.Add("EntityRemoved", "AS_PowerLinkUpdate", function( ent ) --This hook exists because there are cases where a player will pick up a linked object and it will break everything. This shoul fix it.
    if (SERVER) and ent:CanLink() then --Is a linking object, no reason for this to be ran on anything else.
        for k, v in pairs( ent:GetLinks() ) do
            DestroyLink( ent, k )
        end
        if ent:HasGenerator() then
            for k, v in pairs( ents.GetAll() ) do --I know this is inefficient, but I'm not sure how else to tell all the objects that use this entity as a parent for the power source that they no longer are connected.
                if not v:CanLink() then continue end --Skip everything that isnt a link.
                if not v:HasGeneratorProvider() then continue end --Skip everything without a provider
                if not v:GetGeneratorProvider() == ent then continue end --Skip everything that isn't linked the entity specifically
                --Everything that remains should be an object that used the entity that was just removed as a reference to the main generator. These objects need to be removed as links to the generator.
                local generator = v:GetGenerator()
                local generatorLinks = generator:GetLinks()
                generatorLinks[ v ] = nil
                generator:SetLinks( generatorLinks ) --Tell the generator that they are no longer linked to this object
                v:ClearGeneratorProvider() --Tell the object that they dont have a provider
                v:ClearGenerator() --They do not have a generator either.

                generator:UpdatePower()
                v:UpdatePower()
            end
        end
        ent:ClearLinks()
        ent:UpdatePower()

        constraint.RemoveConstraints( ent, "Rope" )
    end
end)

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
            net.WriteEntity( self:GetGenerator() )
            net.WriteInt( self:GetPower(), 16 )
        net.Broadcast()
    end

elseif ( CLIENT ) then

    net.Receive( "as_powerlinker_syncpower", function()
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end
        local parent = net.ReadEntity()
        local power = net.ReadInt( 16 )
        ent:SetGenerator( parent )
        ent:SetPower( power )
    end)

end
