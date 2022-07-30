--  ██████╗██╗  ██╗ █████╗ ██████╗  █████╗  ██████╗████████╗███████╗██████╗     ██╗███╗   ██╗███████╗ ██████╗
-- ██╔════╝██║  ██║██╔══██╗██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗    ██║████╗  ██║██╔════╝██╔═══██╗
-- ██║     ███████║███████║██████╔╝███████║██║        ██║   █████╗  ██████╔╝    ██║██╔██╗ ██║█████╗  ██║   ██║
-- ██║     ██╔══██║██╔══██║██╔══██╗██╔══██║██║        ██║   ██╔══╝  ██╔══██╗    ██║██║╚██╗██║██╔══╝  ██║   ██║
-- ╚██████╗██║  ██║██║  ██║██║  ██║██║  ██║╚██████╗   ██║   ███████╗██║  ██║    ██║██║ ╚████║██║     ╚██████╔╝
--  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝    ╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝
-- Every mission needs to be assigned a mission giver who holds these tasks.

AS.AddCharacter( "dev", {
    name = "Dev Test",
    desc = "This character and its missions are for development purposes.",
} )

-- ███╗   ███╗██╗███████╗███████╗██╗ ██████╗ ███╗   ██╗███████╗
-- ████╗ ████║██║██╔════╝██╔════╝██║██╔═══██╗████╗  ██║██╔════╝
-- ██╔████╔██║██║███████╗███████╗██║██║   ██║██╔██╗ ██║███████╗
-- ██║╚██╔╝██║██║╚════██║╚════██║██║██║   ██║██║╚██╗██║╚════██║
-- ██║ ╚═╝ ██║██║███████║███████║██║╚██████╔╝██║ ╚████║███████║
-- ╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
-- Here, we add our missions to the mission giver we created.

AS.AddMission( "dev", "dev_kill_1", {
    name = "Kill 1", --Name of the mission, used for display
    desc = "Kill the designated targets!", --Description of the mission, used for display
    icon = "icon16/tag_red.png", --Small icon to display mission type. This is cosmetic.
    data = { --Data that will tell the mission how to function. This changes based off the mission 'type' that is plugged into each objective.
        {type = "kill", target = "npc_as_zombie", amt = 3, targetname = "Zombie"},
        {type = "kill", target = "npc_as_fastzombie", amt = 3, targetname = "Fast Zombie", wep = "weapon_knife"},
    },
    reward = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 5,
    },
} )

AS.AddMission( "dev", "dev_kill_2", {
    name = "Kill 2",
    desc = "Kill the designated targets!",
    icon = "icon16/tag_red.png",
    requirements = { --Requirements needs the player to have a certain level in their skill or a mission completed in order to start this mission.
        missions = {
            ["dev_kill_1"] = 1, --Key is the mission id, value is how many times it needs to be completed. Most missions are not repeatable so value should generally be 1.
        },
    },
    data = {
        {type = "kill", target = "npc_as_poisonzombie", amt = 4, targetname = "Poison Zombie"},
    },
    reward = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 10,
        ["misc_chemical"] = 10,
    },
} )

AS.AddMission( "dev", "dev_fetchitem_1", {
    name = "Fetch 1",
    desc = "Collect the items!",
    data = {
        {type = "fetch", target = "misc_towels", amt = 2},
    },
    reward = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 5,
    },
} )

AS.AddMission( "dev", "dev_scavenge_1", {
    name = "Scavenge 1",
    desc = "Scavenge Nodes!",
    data = {
        {type = "scavenge", amt = 10},
    },
    reward = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 5,
    },
} )

AS.AddMission( "dev", "dev_multi_1", {
    name = "Multitask 1",
    desc = "Perform all the tasks!",
    data = {
        {type = "kill", target = "npc_as_zombie", amt = 5, targetname = "Zombie"},
        {type = "kill", target = "npc_as_poisonzombie", amt = 3, targetname = "Poison Zombie", wep = "weapon_knife"},
        {type = "scavenge", amt = 10},
        {type = "fetch", target = "misc_towels", amt = 2},
    },
    reward = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 5,
    },
} )