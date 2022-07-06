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

AS.AddMission( "dev", "kill_1", {
    name = "DevTest: Kill 1", --Name of the mission, used for display
    desc = "Kill the designated targets!", --Description of the mission, used for display
    type = "kill", --Type of mission. This effects the data we will feed it so it knows what a player's task is.
    minfo = {
        ["as_zombie"] = {amt = 3}, --Player must eliminate an NPC classed as 'as_zombie'.
        ["as_fastzombie"] = {amt = 3},
    },
} )