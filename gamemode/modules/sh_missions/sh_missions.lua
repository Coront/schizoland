function PlayerMeta:SetMissions( tbl )
    self.Missions = tbl
    if ( SERVER ) then
        self:ResyncMissions()
    end
end

function PlayerMeta:GetMissions()
    return self.Missions or {}
end

function FetchMissionInfo( id ) --This function will return the table of mission information that we are looking for.

end

function PlayerMeta:AddMission( id )
    local tbl = self:GetMissions()
    tbl[id] = 0
    self:SetMissions( tbl )
end

function PlayerMeta:ClearMission( id )
    local tbl = self:GetMissions()
    tbl[id] = nil
    self:SetMissions( tbl )
end

-- ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝

hook.Add( "OnNPCKilled", "AS_Mission_Kill", function( ent, attacker, inflictor )

end)

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

function PlayerMeta:ResyncMissions()
    if ( SERVER ) then
        local tbl = self:GetMissions()

        net.Start("as_missions_sync")
            net.WriteTable( tbl )
        net.Send( self )
    elseif ( CLIENT ) then
        net.Start("as_missions_requestsync")
        net.SendToServer()
    end
end

if ( SERVER ) then

    util.AddNetworkString( "as_missions_sync" )
    util.AddNetworkString( "as_missions_requestsync" )

    net.Receive( "as_missions_requestsync", function( _, ply )
        ply:ResyncMissions()
    end)

elseif ( CLIENT ) then

    net.Receive( "as_missions_sync", function()
        local tbl = net.ReadTable()
        LocalPlayer():SetMissions( tbl )
    end)

end