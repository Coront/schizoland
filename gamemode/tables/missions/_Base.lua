AS.MissionGivers = {}
AS.MissionDataReference = {}

function AS.AddCharacter( id, data )
    AS.MissionGivers = AS.MissionGivers or {}

    AS.MissionGivers[id] = data
end

function AS.AddMission( charid, id, data )
    AS.MissionGivers = AS.MissionGivers or {}

    if not AS.MissionGivers[charid] then print("Cannot locate character id - '" .. charid .. "', returning.") return end --Character needs to be valid.

    AS.MissionGivers[charid].missions = AS.MissionGivers[charid].missions or {} --Create a new mission table if non exists to this character
    AS.MissionGivers[charid].missions[id] = data
end

function AS.AddMDataReference( id, info ) --This function is used to add data references so we can get the information we need for the mission 'types'.
    AS.MissionDataReference = AS.MissionDataReference or {}

    AS.MissionDataReference[id] = info
end

AS.AddMDataReference( "kill", {
    text = "Find and Kill",
    shorttext = "Killed",
    addition = "With",
} )

AS.AddMDataReference( "fetch", {
    text = "Gather",
    shorttext = "Obtained",
} )

AS.AddMDataReference( "scavenge", {
    text = "Scavenge",
    shorttext = "Scavenged",
} )

function TranslateTaskToText( type, target, amt ) --This is actual cringe
    local text = ""

    if type == "kill" then
        text = AS.MissionDataReference[type].text .. " " .. amt .. " " .. target .. "(s)"
    elseif type == "fetch" then
        text = AS.MissionDataReference[type].text .. " " .. amt .. " " .. AS.Items[target].name .. "(s)"
    elseif type == "scavenge" then
        text = AS.MissionDataReference[type].text .. " " .. amt .. " Node(s)"
    end

    return text
end

function TranslateTaskToShortText( type, target )
    local text = ""

    if type == "kill" then
        text = target .. "s " .. AS.MissionDataReference[type].shorttext
    elseif type == "fetch" then
        text = AS.Items[target].name .. " " .. AS.MissionDataReference[type].shorttext
    elseif type == "scavenge" then
        text = "Nodes " .. AS.MissionDataReference[type].shorttext
    end

    return text
end