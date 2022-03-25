-- ██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██████╗ ███████╗███╗   ██╗ ██████╗██╗  ██╗███████╗███████╗
-- ██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██╔══██╗██╔════╝████╗  ██║██╔════╝██║  ██║██╔════╝██╔════╝
-- ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██████╔╝█████╗  ██╔██╗ ██║██║     ███████║█████╗  ███████╗
-- ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██╔══██╗██╔══╝  ██║╚██╗██║██║     ██╔══██║██╔══╝  ╚════██║
-- ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██████╔╝███████╗██║ ╚████║╚██████╗██║  ██║███████╗███████║
--  ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝

AS.AddBaseItem("tool_armor", {
    name = "Armor Station",
    desc = "A station that allows mercenaries to craft armors.",
    category = "tool",
    model = "models/props_wasteland/controlroom_desk001b.mdl",
    value = 250,
    weight = 5,
    class = "mercenary",
    craft = {
        ["misc_scrap"] = 400,
        ["misc_smallparts"] = 350,
        ["misc_chemical"] = 300,
    },
})

AS.AddBaseItem("tool_stove", {
    name = "Stove",
    desc = "A handcrafted stove that will allow cultivators to cook food.",
    category = "tool",
    model = "models/props_c17/furnitureStove001a.mdl",
    value = 250,
    weight = 5,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 400,
        ["misc_smallparts"] = 300,
        ["misc_chemical"] = 450,
    },
})

AS.AddBaseItem("tool_workbench", {
    name = "Workbench",
    desc = "A handcrafted workbench that will allow engineers to craft firearms and better ammunition.",
    category = "tool",
    model = "models/props_canal/winch02.mdl",
    value = 250,
    weight = 5,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 325,
        ["misc_smallparts"] = 300,
        ["misc_chemical"] = 350,
        ["misc_saw"] = 1,
    },
})

AS.AddBaseItem("tool_pulse", {
    name = "Pulse Assembly Station",
    desc = "A station that allows scientists to assemble pulse weaponry.",
    category = "tool",
    model = "models/props_combine/combine_interface002.mdl",
    value = 300,
    weight = 5,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 450,
        ["misc_smallparts"] = 600,
        ["misc_chemical"] = 500,
    },
})

-- ██████╗ ██╗      █████╗ ███╗   ██╗████████╗███████╗
-- ██╔══██╗██║     ██╔══██╗████╗  ██║╚══██╔══╝██╔════╝
-- ██████╔╝██║     ███████║██╔██╗ ██║   ██║   ███████╗
-- ██╔═══╝ ██║     ██╔══██║██║╚██╗██║   ██║   ╚════██║
-- ██║     ███████╗██║  ██║██║ ╚████║   ██║   ███████║
-- ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝

AS.AddBaseItem("tool_plant_orange", {
    name = "Orange Plant",
    desc = "An orange plant. It produces oranges if taken care of over time.",
    category = "tool",
    model = "models/props/cs_office/plant01.mdl",
    value = 200,
    weight = 3,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 300,
        ["misc_smallparts"] = 400,
        ["misc_chemical"] = 550,
        ["misc_seed_orange"] = 1,
    },
})

AS.AddBaseItem("tool_plant_melon", {
    name = "Melon Plant",
    desc = "An melon plant. It produces melons if taken care of over time.",
    category = "tool",
    model = "models/props/de_inferno/flower_barrel.mdl",
    value = 250,
    weight = 4,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 400,
        ["misc_smallparts"] = 450,
        ["misc_chemical"] = 650,
        ["misc_seed_melon"] = 1,
    },
})

AS.AddBaseItem("tool_grub", {
    name = "Antlion Grub",
    desc = "An antlion grub, born and raised with the intention of making chemicals.",
    category = "tool",
    model = "models/antlion_grub.mdl",
    value = 250,
    weight = 4,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 300,
        ["misc_smallparts"] = 250,
        ["misc_chemical"] = 400,
        ["misc_egg"] = 1,
    },
})

AS.AddBaseItem("tool_miner", {
    name = "Automated Miner",
    desc = "This thing will pound the ground to dig out usable resources for you. Would be incredibly useful if you had an army of them.",
    category = "tool",
    model = "models/props_combine/combinethumper001a.mdl",
    value = 300,
    weight = 15,
    class = "scavenger",
    craft = {
        ["misc_scrap"] = 550,
        ["misc_smallparts"] = 650,
        ["misc_chemical"] = 500,
        ["misc_sensorpod"] = 1,
        ["misc_servo"] = 3,
    },
})