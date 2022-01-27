AS.AddMission( "jackson", "jackson_protection", {
    name = "Protection",
    desc = "I need your help in scaring these damn crows off of the crops, otherwise we'll have barely any food to sustain us for long term. You'll need a weapon first. Take some of these parts and go to the workbench inside. See if you can make something out of them.",
    selfdesc = "Jackson wants me to handcraft a weapon of any sort so I can help him in scaring the crows away from his crops.",
    hint = "Jackson should have provided the materials you need to make a weapon. You can find a workbench inside the shack where you initially spawned.",
    data = {
        type, info = "craft", {
            selectiveitems = {
                ["weapon_knife"] = 1,
                ["weapon_branch"] = 1,
                ["weapon_peashooter"] = 1,
            },
        },
    },
    
} )

--[[
AS.AddMission( "CharacterID", "MissionID", {
    name = "My Mission!",
    desc = "Complete my job!",
    selfdesc = "I need to complete the job!",
    hint = "I should probably complete the job.",
    data = {
        type, info = "kill", {
            enemies = {
                ["npc_crow"] = 1,
            },
        },
    },
    settings = {
        onelife = false,
        timelimit = 0,
    },
    
} )
]]