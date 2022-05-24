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
    return self.Title or self:GetObjectOwner():Nickname() .. "'s Paper"
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

    function ENT:ResyncText()
        net.Start("as_paper_sync")
            net.WriteEntity( self )
            net.WriteString( self:GetTitle() )
            net.WriteString( self:GetParagraph() )
        net.Broadcast()
    end
    
elseif ( CLIENT ) then

    net.Receive("as_paper_sync", function()
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        local title = net.ReadString()
        local str = net.ReadString()

        ent:SetTitle( title )
        ent:SetParagraph( str )
    end)

end