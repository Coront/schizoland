function PlayerMeta:SetPlaytime( amt )
    amt = amt and math.Round(amt) or 0
    self.Playtime = amt
end

function PlayerMeta:GetPlaytime()
    return self.Playtime or 0
end

function PlayerMeta:GetPlaytimeMinutes() --Solely returns minutes
    return math.floor(self:GetPlaytime() / 60)
end

function PlayerMeta:GetPlaytimeHours() --Solely returns hours
    return math.floor(self:GetPlaytime() / 3600)
end

function PlayerMeta:GetPlaytimeHourMin() --Solely returns hours/minutes
    local hours = math.floor(self:GetPlaytimeMinutes() / 60)
    local minutes = self:GetPlaytimeMinutes() - (hours * 60)
    if hours < 10 then
        hours = 0 .. hours
    end
    if minutes < 10 then
        minutes = 0 .. minutes
    end
    return hours .. ":" .. minutes
end

hook.Add( "Think", "AS_PlaytimeUpdate", function()
    for k, v in pairs(player.GetAll()) do
        if not v:IsLoaded() then continue end
        if CLIENT and v != LocalPlayer() then continue end

        v.NextPlaytimeUpdate = v.NextPlaytimeUpdate or CurTime() + 1
        local nextupdate = v.NextPlaytimeUpdate

        if CurTime() > nextupdate then
            v:SetPlaytime( v:GetPlaytime() + 1 )
            v.NextPlaytimeUpdate = CurTime() + 1
        end
    end
end)

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if SERVER then

    util.AddNetworkString("as_syncplaytime")

    function PlayerMeta:ResyncPlaytime()
        net.Start("as_syncplaytime")
            net.WriteInt( self:GetPlaytime(), 32 )
        net.Send(self)
    end
    concommand.Add("as_resyncplaytime", function(ply) ply:ResyncPlaytime() end)

elseif CLIENT then

    function PlaytimeSync()
        LocalPlayer():SetPlaytime( net.ReadInt(32) )
    end
    net.Receive("as_resyncplaytime", PlaytimeSync)

end