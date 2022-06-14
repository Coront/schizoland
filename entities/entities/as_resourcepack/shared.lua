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

if ( SERVER ) then

    util.AddNetworkString("as_resourcepack_resync")
    util.AddNetworkString("as_resourcepack_requestinventory")

    function ENT:ResyncResources()
        net.Start("as_resourcepack_resync")
            net.WriteEntity( self )
            net.WriteUInt( (self:GetScrap() or 0), NWSetting.ItemAmtBits )
            net.WriteUInt( (self:GetSmallParts() or 0), NWSetting.ItemAmtBits )
            net.WriteUInt( (self:GetChemicals() or 0), NWSetting.ItemAmtBits )
        net.Broadcast()
    end

    net.Receive("as_resourcepack_requestinventory", function( _, ply )
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end

        net.Start("as_resourcepack_resync")
            net.WriteEntity( ent )
            net.WriteUInt( ent:GetScrap(), NWSetting.ItemAmtBits )
            net.WriteUInt( ent:GetSmallParts(), NWSetting.ItemAmtBits )
            net.WriteUInt( ent:GetChemicals(), NWSetting.ItemAmtBits )
        net.Send( ply )
    end)

elseif ( CLIENT ) then

    net.Receive("as_resourcepack_resync", function()
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end
        local scrap = net.ReadUInt( NWSetting.ItemAmtBits )
        local smallparts = net.ReadUInt( NWSetting.ItemAmtBits )
        local chemicals = net.ReadUInt( NWSetting.ItemAmtBits )

        ent:SetScrap( scrap )
        ent:SetSmallParts( smallparts )
        ent:SetChemicals( chemicals )
    end)

    timer.Create( "as_autoresync_respack", 3, 0, function()
        for k, v in pairs( ents.FindByClass("as_resourcepack") ) do
            if not IsValid(v) then continue end
            net.Start("as_resourcepack_requestinventory") --Cases utilize the lootcontainer inventory system, so this isnt a concern.
                net.WriteEntity(v)
            net.SendToServer()
        end
    end)

end 