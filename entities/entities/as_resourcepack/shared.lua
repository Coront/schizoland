ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Resource Pack"
ENT.Author			= "Tampy"
ENT.Purpose			= "Can hold multiple resources. Amazing!"
ENT.Category		= "Aftershock"
ENT.Spawnable		= false

function ENT:SetScrap( int )
    self.Scrap = int
end

function ENT:SetSmallParts( int )
    self.SmallParts = int
end

function ENT:SetChemicals( int )
    self.Chemical = int
end

function ENT:GetScrap()
    return self.Scrap or 0
end

function ENT:GetSmallParts()
    return self.SmallParts or 0
end

function ENT:GetChemicals()
    return self.Chemical or 0
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

function ENT:Resync()
    if ( SERVER ) then
        local s = self:GetScrap()
        local sp = self:GetSmallParts()
        local c = self:GetChemicals()

        net.Start("as_resourcepack_sync")
            net.WriteEntity( self )
            net.WriteUInt( s, NWSetting.ItemAmtBits )
            net.WriteUInt( sp, NWSetting.ItemAmtBits )
            net.WriteUInt( c, NWSetting.ItemAmtBits )
        net.Broadcast()
    elseif ( CLIENT ) then

    end
end

if ( SERVER ) then

    util.AddNetworkString("as_resourcepack_sync")
    util.AddNetworkString("as_resourcepack_requestsync")

    net.Receive("as_resourcepack_requestsync", function( _, ply )
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end

        local s = ent:GetScrap()
        local sp = ent:GetSmallParts()
        local c = ent:GetChemicals()

        net.Start("as_resourcepack_sync")
            net.WriteEntity( ent )
            net.WriteUInt( s, NWSetting.ItemAmtBits )
            net.WriteUInt( sp, NWSetting.ItemAmtBits )
            net.WriteUInt( c, NWSetting.ItemAmtBits )
        net.Send( ply )
    end)

elseif ( CLIENT ) then

    net.Receive("as_resourcepack_sync", function()
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end

        local scrap = net.ReadUInt( NWSetting.ItemAmtBits )
        local smallparts = net.ReadUInt( NWSetting.ItemAmtBits )
        local chemicals = net.ReadUInt( NWSetting.ItemAmtBits )

        if isfunction( ent.SetScrap ) then
            ent:SetScrap( scrap )
        end
        if isfunction( ent.SetSmallParts ) then
            ent:SetSmallParts( smallparts )
        end
        if isfunction( ent.SetChemicals ) then
            ent:SetChemicals( chemicals )
        end
    end)

    function ENT:Think()
        if CurTime() > (self:GetCreationTime() + NWSetting.PostCreationDelay) and CurTime() > (self.NextResync or 0) then
            self:Resync()
            self.NextResync = CurTime() + 10
        end
    end

end 