ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName		= "Ammo Box"
ENT.Author			= "Tampy"
ENT.Purpose			= "An ammo box. Will let players choose an ammo they they want to resupply on."
ENT.Category		= "Aftershock"
ENT.Spawnable		= false
ENT.AS_OwnableObject = true

ENT.TitleLimit = 100
ENT.CharacterLimit = 1000

function ENT:SetTitle( str )
    self.Title = str

    if ( SERVER ) then
        self:Resync()
    end
end

function ENT:GetTitle()
    local name = IsValid(self:GetObjectOwner()) and self:GetObjectOwner():Nickname() or "unknown"
    return self.Title or name .. "'s Paper"
end

function ENT:SetParagraph( str )
    self.Text = str

    if ( SERVER ) then
        self:Resync()
    end
end

function ENT:GetParagraph()
    return self.Text or ""
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

function ENT:Resync()
    if ( SERVER ) then
        local title = self:GetTitle()
        local para = self:GetParagraph()

        net.Start("as_paper_sync")
            net.WriteEntity( self )
            net.WriteString( title )
            net.WriteString( para )
        net.Broadcast()
    elseif ( CLIENT ) then
        net.Start("as_paper_requestsync")
            net.WriteEntity( self )
        net.SendToServer()
    end
end

if ( SERVER ) then

    util.AddNetworkString("as_paper_sync")
    util.AddNetworkString("as_paper_requestsync")

    net.Receive("as_paper_requestsync", function( _, ply )
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end

        local title = ent:GetTitle()
        local para = ent:GetParagraph()

        net.Start("as_paper_sync")
            net.WriteEntity( ent )
            net.WriteString( title )
            net.WriteString( para )
        net.Broadcast()
    end)

elseif ( CLIENT ) then

    net.Receive("as_paper_sync", function()
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        local title = net.ReadString()
        local str = net.ReadString()

        ent:SetTitle( title )
        ent:SetParagraph( str )
    end)

    function ENT:Think()
        if CurTime() > (self:GetCreationTime() + NWSetting.PostCreationDelay) and CurTime() > (self.NextResync or 0) then
            self:Resync()
            self.NextResync = CurTime() + NWSetting.EntUpdateLength
        end
    end

end