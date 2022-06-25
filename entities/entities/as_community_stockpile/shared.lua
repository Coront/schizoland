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
        self:Resync()
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
        self:Resync()
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

function ENT:Resync()
    if ( SERVER ) then
        local cid = self:GetCommunity()
        local cname = self:GetCommunityName()
        local res = self:GetResources()

        net.Start("as_stockpile_sync")
            net.WriteEntity( self )
            net.WriteUInt( cid, NWSetting.CommunityAmtBits )
            net.WriteString( cname )
            net.WriteInventory( res )
        net.Broadcast()
    elseif ( CLIENT ) then
        net.Start("as_stockpile_requestsync")
            net.WriteEntity( self )
        net.SendToServer()
    end
end

if ( SERVER ) then

    util.AddNetworkString( "as_stockpile_sync" )
    util.AddNetworkString( "as_stockpile_requestsync" )

    net.Receive("as_stockpile_requestsync", function( _, ply )
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end

        local cid = ent:GetCommunity()
        local cname = ent:GetCommunityName()
        local res = ent:GetResources()

        net.Start("as_stockpile_sync")
            net.WriteEntity( ent )
            net.WriteUInt( cid, NWSetting.CommunityAmtBits )
            net.WriteString( cname )
            net.WriteInventory( res )
        net.Send( ply )
    end)

elseif ( CLIENT ) then

    net.Receive( "as_stockpile_sync", function()
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        local cid = net.ReadUInt( NWSetting.CommunityAmtBits )
        local cname = net.ReadString()
        local res = net.ReadInventory()

        if isfunction( ent.SetCommunity ) then
            ent:SetCommunity( cid, cname )
        end
        if isfunction( ent.SetResources ) then
            ent:SetResources( res )
        end
    end)

    function ENT:Think()
        if CurTime() > (self:GetCreationTime() + NWSetting.PostCreationDelay) and CurTime() > (self.NextResync or 0) then
            self:Resync()
            self.NextResync = CurTime() + NWSetting.EntUpdateLength
        end
    end

end