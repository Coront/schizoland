--  ██████╗██╗  ██╗ █████╗ ██████╗  █████╗  ██████╗████████╗███████╗██████╗     ██╗███╗   ██╗███████╗ ██████╗
-- ██╔════╝██║  ██║██╔══██╗██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗    ██║████╗  ██║██╔════╝██╔═══██╗
-- ██║     ███████║███████║██████╔╝███████║██║        ██║   █████╗  ██████╔╝    ██║██╔██╗ ██║█████╗  ██║   ██║
-- ██║     ██╔══██║██╔══██║██╔══██╗██╔══██║██║        ██║   ██╔══╝  ██╔══██╗    ██║██║╚██╗██║██╔══╝  ██║   ██║
-- ╚██████╗██║  ██║██║  ██║██║  ██║██║  ██║╚██████╗   ██║   ███████╗██║  ██║    ██║██║ ╚████║██║     ╚██████╔╝
--  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝    ╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝
-- Every mission needs to be assigned a mission giver who holds these tasks.

AS.AddCharacter( "tutorial", {
    name = "Trainer",
    desc = "Here to teach you how to play the game.",
} )

-- ███╗   ███╗██╗███████╗███████╗██╗ ██████╗ ███╗   ██╗███████╗
-- ████╗ ████║██║██╔════╝██╔════╝██║██╔═══██╗████╗  ██║██╔════╝
-- ██╔████╔██║██║███████╗███████╗██║██║   ██║██╔██╗ ██║███████╗
-- ██║╚██╔╝██║██║╚════██║╚════██║██║██║   ██║██║╚██╗██║╚════██║
-- ██║ ╚═╝ ██║██║███████║███████║██║╚██████╔╝██║ ╚████║███████║
-- ╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
-- Here, we add our missions to the mission giver we created.

AS.AddMission( "tutorial", "tutorial_basics1", {
    name = "The Basics - 1",
    desc = "Look for cars to scavenge. Come back for a reward when you finish.",
    data = {
        {type = "scavenge", amt = 10},
    },
    reward = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 5,
    },
} )

AS.AddMission( "tutorial", "tutorial_basics2", {
    name = "The Basics - 2",
    desc = "Eat the Can of Beans that I gave to you.",
    initial = {
        ["food_beans"] = 2,
    },
    data = {
        {type = "useitem", item = "food_beans", amt = 1},
    },
    reward = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 5,
    },
} )

AS.AddMission( "tutorial", "tutorial_basics2", {
    name = "The Basics - 2",
    desc = "Eat the Can of Beans that I gave to you.",
    initial = {
        ["food_beans"] = 2,
    },
    data = {
        {type = "useitem", item = "food_beans", amt = 1},
    },
    reward = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 5,
    },
} )