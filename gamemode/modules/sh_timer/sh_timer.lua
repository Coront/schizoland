function PlayerMeta:SetEventTime( length )
    length = length or 1
    self.TimedEvent = length
end

function PlayerMeta:GetEventTime()
    return self.TimedEvent or 0
end

function PlayerMeta:SetEventCallback( callback )
    callback = callback or nil 
    if not callback then return end
    self.TimedEventCallback = callback
end

function PlayerMeta:GetEventCallback()
    return self.TimedEventCallback
end

function PlayerMeta:IsEventActive()
    if self:GetEventTime() > CurTime() then return true end
    return false
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if (SERVER) then

    util.AddNetworkString("as_timer_start")
    util.AddNetworkString("as_timer_end")

elseif (CLIENT) then

    net.Receive("as_timer_start", function()
        EventStartTime = CurTime()
        EventTimeLength = net.ReadFloat()
        LocalPlayer():SetEventTime( CurTime() + EventTimeLength )
    end)

    net.Receive("as_timer_end", function()
        LocalPlayer():SetEventTime( 0 )
    end)

end