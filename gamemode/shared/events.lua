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
    eventspot = true,
    outdoor = true,
    ent = "as_event_mound", --Replace this with the antlionnest entity when finished
    sound = "ambient/atmosphere/terrain_rumble1.wav", --This will play a sound to everyone as a notification
} )

AS.AddEvent( "zombie_horde", {
    name = "Zombie Horde",
    enable = true,
    mintime = 1800,
    maxtime = 7200,
    max = 1,
    eventspot = true,
    outdoor = true,
    ent = "npc_as_fastzombie", --Replace this with the antlionnest entity when finished
    entamt = {min = 20, max = 30},
    notify = {"A large horde of fast zombies have been spotted out in the wasteland."},
} )

AS.AddEvent( "raider_party", {
    name = "Raider Party",
    enable = true,
    mintime = 3600,
    maxtime = 6000,
    max = 1,
    eventspot = true,
    outdoor = true,
    ent = "npc_as_raider",
    entamt = {min = 4, max = 6}, --This tells us how much of the entity to spawn in the same location.
    notify = {"A group of heavily armed raiders have been spotted roaming the lands."}, --Will print text to everyone's chat
} )

AS.AddEvent( "combine_scout", {
    name = "Combine Scout",
    enable = true,
    mintime = 4200,
    maxtime = 8000,
    max = 1,
    eventspot = true,
    outdoor = true,
    ent = "as_event_canister",
    sound = "npc/env_headcrabcanister/launch.wav",
    notify = {"The distant sound of an explosion can be heard from the sky. Something bad is coming.", "The sound of a loud explosion from the sky shakes the land. Watch out from above.", "An explosion from above ruptures your eardrums. The government is on their way."},
} )