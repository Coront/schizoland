AS.Missions = {}

function AS.AddCharacter( id, data )
    AS.Missions = AS.Missions or {}

    AS.Missions[id] = data
end

function AS.AddMission( charid, id, data )
    AS.Missions = AS.Missions or {}

    if not AS.Missions[charid] then print("Cannot locate character id - '" .. charid .. "', returning.") return end --Character needs to be valid.

    AS.Missions[charid].missions = AS.Missions[charid].missions or {} --Create a new mission table if non exists to this character
    AS.Missions[charid].missions[id] = data
end