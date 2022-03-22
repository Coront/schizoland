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

if (SERVER) then

    function PlayerMeta:StartTimedEvent( length, freeze, callback )
        length = length or 1 --Time length for the event to finish.
        freeze = freeze or true
        if not callback then AS.LuaError("Cannot perform a timed event with no call back.") return end

        if freeze then self:SetMoveType( MOVETYPE_NONE ) end

        net.Start("as_timer_start")
            net.WriteFloat( length )
        net.Send(self)
        self:SetEventTime( CurTime() + length )
        self:SetEventCallback( callback )
    end

    function PlayerMeta:CancelTimedEvent()
        net.Start("as_timer_end")
        net.Send(self)
        self:SetEventTime( 0 )
        if self:GetMoveType() == MOVETYPE_NONE then self:SetMoveType( MOVETYPE_WALK ) end
    end


    hook.Add( "Think", "AS_TimedEvents", function()
        for k, v in pairs( player.GetAll() ) do
            if v:GetEventTime() == 0 then continue end --Player doesn't have an event.

            if v:GetEventTime() != 0 and CurTime() > v:GetEventTime() then --Basically after the first time think is called and the current time is more than event time
                v:SetEventTime( 0 ) --setting the timer to 0, because there is no event happening anymore
                local callback = v:GetEventCallback()
                callback() --Running the callback
                if v:GetMoveType() == MOVETYPE_NONE then v:SetMoveType( MOVETYPE_WALK ) end
            end
        end
    end)

end

-- ██╗  ██╗██╗   ██╗██████╗
-- ██║  ██║██║   ██║██╔══██╗
-- ███████║██║   ██║██║  ██║
-- ██╔══██║██║   ██║██║  ██║
-- ██║  ██║╚██████╔╝██████╔╝
-- ╚═╝  ╚═╝ ╚═════╝ ╚═════╝

if (CLIENT) then

    hook.Add( "HUDPaint", "AS_TimedEvents", function()

        if LocalPlayer():GetEventTime() <= 0 or CurTime() >= LocalPlayer():GetEventTime() then return end
        surface.SetDrawColor( COLHUD_DEFAULT )
        local width, height, ply = 100, 20, LocalPlayer()
        surface.DrawOutlinedRect( (ScrW() / 2) - (width / 2), ((ScrH() / 2) + height) * 1.02, width, height )
        local percent = (CurTime() - (EventStartTime or 0)) / EventTimeLength
        surface.DrawRect( (ScrW() / 2) - (width / 2), ((ScrH() / 2) + height) * 1.02, math.Clamp(percent * 100, 0, 100), height )
        draw.SimpleTextOutlined( math.Round(percent * 100) .. "%", "TargetID", (ScrW() / 2), ((ScrH() / 2) + height) * 1.02, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0 ) )

    end)

end

-- ███████╗██╗   ██╗███╗   ██╗ ██████╗██╗███╗   ██╗ ██████╗
-- ██╔════╝╚██╗ ██╔╝████╗  ██║██╔════╝██║████╗  ██║██╔════╝
-- ███████╗ ╚████╔╝ ██╔██╗ ██║██║     ██║██╔██╗ ██║██║  ███╗
-- ╚════██║  ╚██╔╝  ██║╚██╗██║██║     ██║██║╚██╗██║██║   ██║
-- ███████║   ██║   ██║ ╚████║╚██████╗██║██║ ╚████║╚██████╔╝
-- ╚══════╝   ╚═╝   ╚═╝  ╚═══╝ ╚═════╝╚═╝╚═╝  ╚═══╝ ╚═════╝

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