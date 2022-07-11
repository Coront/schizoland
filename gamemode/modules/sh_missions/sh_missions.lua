function PlayerMeta:SetMissions( tbl )
    self.Missions = tbl
    if ( SERVER ) then
        self:ResyncMissions()
    end
end

function PlayerMeta:SetFinishedMissions( tbl )
    self.FinishedMissions = tbl
    if ( SERVER ) then
        self:ResyncMissions()
    end
end

function PlayerMeta:GetMissions()
    return self.Missions or {}
end

function PlayerMeta:GetFinishedMissions()
    return self.FinishedMissions or {}
end

function FetchMissionInfo( id ) --This function will return the table of mission information that we are looking for.
    for k, v in pairs( AS.Missions ) do
        for k2, v2 in pairs( v.missions ) do
            if k2 == id then
                return AS.Missions[k].missions[k2]
            end
        end
    end
end

function PlayerMeta:HasCompletedMission( id )
    local missions = self:GetFinishedMissions()

    if missions[id] and missions[id] > 0 then return true end
    return false
end

function PlayerMeta:CanAcceptMission( id )
    local info = FetchMissionInfo( id )

    PrintTable( info )

    if self:GetMissions()[id] then return false end --Player already has the mission.
    if self:HasCompletedMission( id ) and not info.repeatable then return false end --Player has already completed the mission and it's not repeatable.

    if info.requirements then
        for k, v in pairs( info.requirements ) do --Player has to meet the mission requirements.
            if k == "missions" then
                for k2, v2 in pairs( v ) do
                    if not self:HasCompletedMission( k2 ) then
                        return false
                    end
                end
            end
        end
    end

    return true --We can take this mission.
end

function PlayerMeta:AddMission( id )
    local tbl = self:GetMissions()
    tbl[id] = {}
    self:SetMissions( tbl )
end

function PlayerMeta:ClearMission( id )
    local tbl = self:GetMissions()
    tbl[id] = nil
    self:SetMissions( tbl )
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

function PlayerMeta:ResyncMissions()
    if ( SERVER ) then
        local tbl = self:GetMissions()
        local tbl2 = self:GetFinishedMissions()

        net.Start("as_missions_sync")
            net.WriteTable( tbl )
            net.WriteTable( tbl2 )
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
        local tbl2 = net.ReadTable()

        LocalPlayer():SetMissions( tbl )
        LocalPlayer():SetFinishedMissions( tbl2 )
    end)

end