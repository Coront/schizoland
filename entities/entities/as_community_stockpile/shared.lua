ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Community Stockpile"
ENT.Author			= "Tampy"
ENT.Purpose			= "Store Resources"
ENT.Category		= "Aftershock"
ENT.Spawnable		= false

ENT.Sounds = {}
ENT.Sounds.Access = "physics/wood/wood_box_impact_hard4.wav"
ENT.Sounds.Manage = {
    "physics/body/body_medium_impact_soft1.wav",
    "physics/body/body_medium_impact_soft2.wav",
    "physics/body/body_medium_impact_soft3.wav",
    "physics/body/body_medium_impact_soft4.wav"
}
ENT.Sounds.BreakInto = "ambient/materials/wood_creak1.wav"
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

function ENT:SetResources( tbl )
    self.Resources = tbl
    if ( SERVER ) then
        self:ResyncResources()
        self:SaveResources()
    end
end

function ENT:GetResources()
    return self.Resources or {}
end

function ENT:GetResourceAmount( item )
    return self:GetResources()[item] or 0
end

function ENT:AddResource( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to add non-existant item to stockpile - " .. item) return end

    local tbl = self:GetResources()
    tbl[item] = (tbl[item] or 0) + amt
    self:SetResources( tbl )
end

function ENT:PlayerAddResource( ply, item, amt )
    ply:TakeItemFromInventory( item, amt )
    self:AddResource( item, amt )
end

function ENT:TakeResource( item, amt )
    if not AS.Items[item] then AS.LuaError("Attempt to take non-existant item from stockpile - " .. item) return end

    local tbl = self:GetResources()
    tbl[item] = (tbl[item] or 0) - amt
    if tbl[item] <= 0 then tbl[item] = nil end
    self:SetResources( tbl )
end

function ENT:PlayerTakeResource( ply, item, amt )
    self:TakeResource( item, amt )
    ply:AddItemToInventory( item, amt )
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝


if ( SERVER ) then

    util.AddNetworkString( "as_stockpile_synccommunity" )
    util.AddNetworkString( "as_stockpile_syncresources" )
    util.AddNetworkString( "as_stockpile_requestinfo" )

    function ENT:ResyncCommunity()
        net.Start("as_stockpile_synccommunity")
            net.WriteEntity( self )
            net.WriteUInt( self:GetCommunity(), NWSetting.CommunityAmtBits )
            net.WriteString( self:GetCommunityName() )
        net.Broadcast()
    end

    function ENT:ResyncResources()
        net.Start("as_stockpile_syncresources")
            net.WriteEntity( self )
            net.WriteInventory( self:GetResources() )
        net.Broadcast()
    end

    net.Receive("as_stockpile_requestinfo", function( _, ply )
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end

        if ent.GetCommunity then
            net.Start("as_stockpile_synccommunity")
                net.WriteEntity( ent )
                net.WriteUInt( ent:GetCommunity(), NWSetting.CommunityAmtBits )
                net.WriteString( ent:GetCommunityName() )
            net.Send( ply )
        end

        if ent.GetResources then
            net.Start("as_stockpile_syncresources")
                net.WriteEntity( ent )
                net.WriteInventory( ent:GetResources() )
            net.Send( ply )
        end
    end)

elseif ( CLIENT ) then

    net.Receive( "as_stockpile_synccommunity", function()
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        local cid = net.ReadUInt( NWSetting.CommunityAmtBits )
        local name = net.ReadString()

        ent:SetCommunity( cid, name )
    end)

    net.Receive( "as_stockpile_syncresources", function()
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end
        local res = net.ReadInventory()

        ent:SetResources( res )
    end)

    timer.Create( "as_autoresync_stockpile", 10, 0, function()
        for k, v in pairs( ents.FindByClass("as_community_stockpile") ) do
            if not IsValid(v) then continue end
            net.Start("as_stockpile_requestinfo") --Cases utilize the lootcontainer inventory system, so this isnt a concern.
                net.WriteEntity(v)
            net.SendToServer()
        end
    end)

end