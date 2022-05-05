ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Community Stockpile"
ENT.Author			= "Tampy"
ENT.Purpose			= "Store Resources"
ENT.Category		= "Aftershock"
ENT.Spawnable		= false

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
    return self.name
end

function ENT:SetResources( tbl )
    self.Resources = tbl
    if ( SERVER ) then
        self:ResyncResources()
    end
end

function ENT:GetResources()
    return self.Resources or {}
end

function ENT:AddResource( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to add non-existant item to stockpile - " .. item) return end

    local tbl = self:GetResources()
    tbl[item] = (tbl[item] or 0) + amt
    self:SetResources( tbl )
end

function ENT:TakeResource( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to take non-existant item from stockpile - " .. item) return end

    local tbl = self:GetResources()
    tbl[item] = (tbl[item] or 0) - amt
    if tbl[item] <= 0 then tbl[item] = nil end
    self:SetResources( tbl )
end

-- Networking

if ( SERVER ) then

    util.AddNetworkString( "as_stockpile_synccommunity" )
    util.AddNetworkString( "as_stockpile_syncresources" )
    
    function ENT:ResyncCommunity()
        net.Start("as_stockpile_synccommunity")
            net.WriteEntity( self )
            net.WriteInt( self:GetCommunity(), 32 )
            net.WriteString( self:GetCommunityName() )
        net.Broadcast()
    end

    function ENT:ResyncResources()
        net.Start("as_stockpile_syncresources")
            net.WriteEntity( self )
            net.WriteTable( self:GetResources() )
        net.Broadcast()
    end
    
    function ENT:Think()
        if CurTime() > (self.NextResync or 0) then
            self.NextResync = CurTime() + 5

            self:ResyncCommunity()
            self:ResyncResources()
        end
    end

elseif ( CLIENT ) then

    net.Receive( "as_stockpile_synccommunity", function()
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        local cid = net.ReadInt( 32 )
        local name = net.ReadString()
        
        ent:SetCommunity( cid, name )
    end)

    net.Receive( "as_stockpile_syncresources", function()
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end
        local res = net.ReadTable()
        
        ent:SetResources( res )
    end)

end