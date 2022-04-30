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
    ent = "as_workbench_armor",
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
    ent = "as_workbench_stove",
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
    ent = "as_workbench_weapon",
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
    ent = "as_workbench_pulse",
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
    ent = "as_plant_orange",
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
    ent = "as_plant_melon",
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

AS.AddBaseItem("tool_plant_herb", {
    name = "Herb Box",
    desc = "A box that is filled with soil that is rich in nutrients. It produces herbs if taken care of over time.",
    category = "tool",
    model = "models/tools/dirtbox.mdl",
    ent = "as_plant_herb",
    value = 250,
    weight = 4,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 400,
        ["misc_smallparts"] = 450,
        ["misc_chemical"] = 650,
        ["misc_seed_herb"] = 1,
    },
})

--  ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ████████╗ ██████╗ ██████╗
-- ██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██╔═══██╗██╔══██╗
-- ██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║   ██║   ██║   ██║██████╔╝
-- ██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║   ██║   ██║   ██║██╔══██╗
-- ╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║   ██║   ╚██████╔╝██║  ██║
--  ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝

AS.AddBaseItem("tool_generator_solar", {
    name = "Solar Panel",
    desc = "Converts solar energy to electricity. Produces 25 electricity.",
    category = "tool",
    model = "models/hunter/plates/plate1x2.mdl",
    ent = "as_generator_solar",
    value = 250,
    weight = 4,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    },
})

AS.AddBaseItem("tool_generator_engine", {
    name = "Gas Generator",
    desc = "Uses gasoline to produce energy. Produces 75 electricity.",
    category = "tool",
    model = "models/props_vehicles/generatortrailer01.mdl",
    ent = "as_generator_engine",
    value = 250,
    weight = 4,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    },
})

AS.AddBaseItem("tool_generator_nuclear", {
    name = "Nuclear Generator",
    desc = "A large nuclear generator. Uses uranium to produce energy. Produces 150 electricity.",
    category = "tool",
    model = "models/props_canal/generator01.mdl",
    ent = "as_generator_nuclear",
    value = 250,
    weight = 4,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    },
})

AS.AddBaseItem("tool_generator_fusion", {
    name = "Fusion Generator",
    desc = "A fusion generator. Uses deuterium samples to produce energy. Produces 250 electricity.",
    category = "tool",
    model = "models/props_combine/combine_generator01.mdl",
    ent = "as_generator_fusion",
    value = 250,
    weight = 4,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    },
})

-- ██████╗ ██████╗  ██████╗ ██████╗ ██╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗
-- ██╔══██╗██╔══██╗██╔═══██╗██╔══██╗██║   ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║
-- ██████╔╝██████╔╝██║   ██║██║  ██║██║   ██║██║        ██║   ██║██║   ██║██╔██╗ ██║
-- ██╔═══╝ ██╔══██╗██║   ██║██║  ██║██║   ██║██║        ██║   ██║██║   ██║██║╚██╗██║
-- ██║     ██║  ██║╚██████╔╝██████╔╝╚██████╔╝╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║
-- ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝  ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

AS.AddBaseItem("tool_grub", {
    name = "Antlion Grub",
    desc = "An antlion grub, born and raised with the intention of making chemicals.",
    category = "tool",
    model = "models/antlion_grub.mdl",
    ent = "as_grub",
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
    ent = "as_miner",
    value = 300,
    weight = 15,
    class = "scavenger",
    craft = {
        ["misc_scrap"] = 550,
        ["misc_smallparts"] = 650,
        ["misc_chemical"] = 500,
        ["misc_sensorpod"] = 1,
        ["misc_electronicparts"] = 3,
        ["misc_servo"] = 3,
    },
})

-- ███╗   ███╗██╗███████╗ ██████╗███████╗██╗     ██╗      █████╗ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗███████╗
-- ████╗ ████║██║██╔════╝██╔════╝██╔════╝██║     ██║     ██╔══██╗████╗  ██║██╔════╝██╔═══██╗██║   ██║██╔════╝
-- ██╔████╔██║██║███████╗██║     █████╗  ██║     ██║     ███████║██╔██╗ ██║█████╗  ██║   ██║██║   ██║███████╗
-- ██║╚██╔╝██║██║╚════██║██║     ██╔══╝  ██║     ██║     ██╔══██║██║╚██╗██║██╔══╝  ██║   ██║██║   ██║╚════██║
-- ██║ ╚═╝ ██║██║███████║╚██████╗███████╗███████╗███████╗██║  ██║██║ ╚████║███████╗╚██████╔╝╚██████╔╝███████║
-- ╚═╝     ╚═╝╚═╝╚══════╝ ╚═════╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝ ╚═════╝  ╚═════╝ ╚══════╝

AS.AddBaseItem("tool_pylon", {
    name = "Power Pylon",
    desc = "A power pylon. Useful for conducting electricity. Can be used to simply store extra power, or as an extension for longer distances.",
    category = "tool",
    model = "models/props_c17/substation_transformer01d.mdl",
    ent = "as_pylon",
    value = 10,
    weight = 1,
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 15,
        ["misc_electronicparts"] = 1,
    },
})