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

function PlayerMeta:HasMission( id )
    if self:GetMissions()[id] then return true end
    return false
end

function FetchMissionInfo( id ) --This function will return the table of mission information that we are looking for.
    for k, v in pairs( AS.MissionGivers ) do
        if v.missions[id] then
            return AS.MissionGivers[k].missions[id]
        end
    end

    AS.LuaError( "Failed to find mission by id - " .. id )
end

function FindCharacterByMission( id ) --This function will return the character that owns it by use of a mission id.
    for k, v in pairs( AS.MissionGivers ) do
        if v.missions[id] then
            return k
        end
    end

    AS.LuaError( "No giver found for mission - " .. id )
end

function PlayerMeta:GetMissionsByGiver( giver ) --This gives a table of missions from a supplied giver id
    local tbl = {}

    for k, v in pairs( self:GetMissions() ) do
        local char = FindCharacterByMission( k )
        if char == giver then
            tbl[#tbl + 1] = k
        end
    end

    return tbl
end

function PlayerMeta:HasCompletedMission( id )
    local missions = self:GetFinishedMissions()

    if missions[id] and missions[id] > 0 then return true end
    return false
end

function PlayerMeta:CanAcceptMission( id )
    local info = FetchMissionInfo( id )

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

function PlayerMeta:CanTurnMissionIn( id )
    local missions = self:GetMissions()
    if not missions[id] then return false end --Doesnt even have the mission

    local curprog = missions[id]
    local info = FetchMissionInfo( id )

    for k, v in pairs( info.data ) do
        if (curprog[k] or 0) < v.amt then return false end --Player has not reach sufficient amount for this objective
    end

    return true
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

function PlayerMeta:SetObjScore( mid, objid, amt )
    local missions = self:GetMissions()

    if not missions[mid] then AS.LuaError("Attempt to set score on mission that player doesn't have - " .. mid ) return end

    missions[mid][objid] = amt 

    self:SetMissions( missions )
end

function PlayerMeta:GetObjScore( mid, objid )
    local missions = self:GetMissions()
    if not missions[mid] then AS.LuaError("Attempt to get score on mission that player doesn't have - " .. mid ) return end

    return missions[mid][objid] or 0
end

function PlayerMeta:IncreaseObjScore( mid, objid, amt )
    local missions = self:GetMissions()
    local curamt = self:GetObjScore( mid, objid )
    local newamt = curamt + amt

    self:SetObjScore( mid, objid, newamt )
end

function PlayerMeta:DecreaseObjScore( mid, objid, amt )
    local missions = self:GetMissions()
    local curamt = self:GetObjScore( mid, objid )
    local newamt = curamt - amt

    self:SetObjScore( mid, objid, newamt )
end

function PlayerMeta:FinishMission( id )

end

-- ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝

-- Kill Task
hook.Add( "OnNPCKilled", "as_mission_kill", function( ent, attacker, inflictor )
    if not attacker:IsPlayer() then return end --not a player
    if table.Count( attacker:GetMissions() ) < 1 then return end --no missions

    for k, v in pairs( attacker:GetMissions() ) do --Go through all the player's missions
        local info = FetchMissionInfo( k ).data --Data for the mission
        local npc = ent:GetClass()

        for k2, v2 in pairs( info ) do --Go through all of the objectives
            if v2.type != "kill" then continue end --skip all the objs that are not a kill.
            if attacker:GetObjScore( k, k2 ) >= v2.amt then continue end --already reached required amount
            if v2.target != npc then continue end --skip this obj because it wasnt the kill we needed.
            if v2.wep and inflictor:GetClass() != v2.wep then continue end --incorrect weapon required

            attacker:IncreaseObjScore( k, k2, 1 )
        end
    end
end)

-- Scavenge Task
hook.Add( "OnNodeScavenged", "as_mission_scavenge", function( ply ) 
    if not ply:IsPlayer() then return end
    if table.Count( ply:GetMissions() ) < 1 then return end

    for k, v in pairs( ply:GetMissions() ) do --Go through all the player's missions
        local info = FetchMissionInfo( k ).data --Data for the mission

        for k2, v2 in pairs( info ) do --Go through all of the objectives
            if v2.type != "scavenge" then continue end --skip all the objs that are not a kill.
            if ply:GetObjScore( k, k2 ) >= v2.amt then continue end --already reached required amount

            ply:IncreaseObjScore( k, k2, 1 )
        end
    end
end)

hook.Add( "OnContainerLooted", "as_mission_scavenge", function( ply ) 

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