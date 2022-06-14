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
        self:ResyncText()
    end
end

function ENT:GetTitle()
    local name = IsValid(self:GetObjectOwner()) and self:GetObjectOwner():Nickname() or "unknown"
    return self.Title or name .. "'s Paper"
end

function ENT:SetParagraph( str )
    self.Text = str

    if ( SERVER ) then
        self:ResyncText()
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

if ( SERVER ) then

    util.AddNetworkString("as_paper_sync")
    util.AddNetworkString("as_paper_requestinventory")

    function ENT:ResyncText()
        net.Start("as_paper_sync")
            net.WriteEntity( self )
            net.WriteString( self:GetTitle() )
            net.WriteString( self:GetParagraph() )
        net.Broadcast()
    end

    net.Receive("as_paper_requestinventory", function( _, ply )
        local ent = net.ReadEntity()

        net.Start("as_paper_sync")
            net.WriteEntity( ent )
            net.WriteString( ent:GetTitle() )
            net.WriteString( ent:GetParagraph() )
        net.Send( ply )
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

    timer.Create( "as_autoresync_papers", 3, 0, function()
        for k, v in pairs( ents.FindByClass("as_paper") ) do
            if not IsValid(v) then continue end
            net.Start("as_paper_requestinventory") --Cases utilize the lootcontainer inventory system, so this isnt a concern.
                net.WriteEntity(v)
            net.SendToServer()
        end
    end)

end