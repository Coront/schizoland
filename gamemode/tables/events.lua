function AS.AddEvent( id, data )
    AS.Events = AS.Events or {}
    AS.Events[id] = data
end

AS.AddEvent( "antlion_guard", {
    name = "Antlion Guard",
    enable = true, --Should we actually be spawning?
    mintime = 600, --Minimal time before we spawn in seconds
    maxtime = 1200, --Maximum time before we spawn
    max = 2, --Maximum amount of this event that can spawn at once
    minplayers = 1, --Minimal players required on the server for this event to occur
    eventspot = false, --Should we only spawn in event spots?
    outdoor = true, --Spawn outdoor
    ent = "npc_as_antlionguard", --Entity to spawn
} )

AS.AddEvent( "antlion_nest", {
    name = "Antlion Nest",
    enable = true,
    mintime = 600,
    maxtime = 1800,
    max = 1,
    minplayers = 1,
    eventspot = true,
    outdoor = true,
    ent = "as_event_mound",
    sound = "ambient/atmosphere/terrain_rumble1.wav", --This will play a sound to everyone as a notification
} )

AS.AddEvent( "zombie_horde", {
    name = "Zombie Horde",
    enable = true,
    mintime = 1800,
    maxtime = 7200,
    max = 1,
    minplayers = 3,
    eventspot = true,
    outdoor = true,
    ent = "npc_as_fastzombie",
    entamt = {min = 10, max = 15},
    notify = {"A large horde of fast zombies have been spotted out in the wasteland."},
} )

AS.AddEvent( "tachala", {
    name = "Tachala",
    enable = true,
    mintime = 3600,
    maxtime = 4800,
    max = 1,
    minplayers = 5,
    eventspot = true,
    outdoor = true,
    ent = "npc_as_tachala",
} )

AS.AddEvent( "raider_party", {
    name = "Raider Party",
    enable = true,
    mintime = 3600,
    maxtime = 6000,
    max = 1,
    minplayers = 1,
    eventspot = true,
    outdoor = true,
    ent = "npc_as_raider",
    entamt = {min = 4, max = 6}, --This tells us how much of the entity to spawn in the same location.
    notify = {"A group of heavily armed raiders have been spotted roaming the lands."}, --Will print text to everyone's chat
} )

AS.AddEvent( "combine_scout", {
    name = "Coalition Scout",
    enable = true,
    mintime = 7200,
    maxtime = 10800,
    max = 1,
    minplayers = 10,
    eventspot = true,
    outdoor = true,
    ent = "as_event_canister",
    sound = "npc/env_headcrabcanister/launch.wav",
    notify = {"The distant sound of an explosion can be heard from the sky. Something bad is coming.", "The sound of a loud explosion from the sky shakes the land. Watch out from above.", "An explosion from above ruptures your eardrums. The government is on their way."},
} )