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

        if not v:Alive() then v:CancelTimedEvent() end --Cancel an event if the player is dead

        if v:GetEventTime() != 0 and CurTime() > v:GetEventTime() then --Basically after the first time think is called and the current time is more than event time
            v:SetEventTime( 0 ) --setting the timer to 0, because there is no event happening anymore
            local callback = v:GetEventCallback()
            callback() --Running the callback
            if v:GetMoveType() == MOVETYPE_NONE then v:SetMoveType( MOVETYPE_WALK ) end
        end
    end
end)