function PlayerMeta:ToggleDevmode()
    self.Devmode = self.Devmode or false --This is to make sure that it exists.
    
    if self.Devmode then
        self:ChatPrint("Disabled Devmode.")
        self.Devmode = false
    else
        self:ChatPrint("Enabled Devmode.")
        self.Devmode = true 
    end

    net.Start( "as_admin_toggledevmode" )
        net.WriteEntity( self )
        net.WriteBool( self.Devmode )
    net.Broadcast()
end

function PlayerMeta:InDevmode()
    if self.Devmode then return true end
    return false
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if ( SERVER ) then

    util.AddNetworkString( "as_admin_toggledevmode" )

elseif ( CLIENT ) then

    net.Receive("as_admin_toggledevmode", function()
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end
        local state = net.ReadBool()

        ent.Devmode = state
    end)

end