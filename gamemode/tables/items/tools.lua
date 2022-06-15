-- ██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██████╗ ███████╗███╗   ██╗ ██████╗██╗  ██╗███████╗███████╗
-- ██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██╔══██╗██╔════╝████╗  ██║██╔════╝██║  ██║██╔════╝██╔════╝
-- ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██████╔╝█████╗  ██╔██╗ ██║██║     ███████║█████╗  ███████╗
-- ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██╔══██╗██╔══╝  ██║╚██╗██║██║     ██╔══██║██╔══╝  ╚════██║
-- ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██████╔╝███████╗██║ ╚████║╚██████╗██║  ██║███████╗███████║
--  ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝

AS.AddBaseItem("tool_armor", {
    name = "Armor Station",
    desc = "An armoring station that allows mercenaries to construct some of the toughest armors around.",
    category = "tool",
    model = "models/magnusson_teleporter_off.mdl",
    ent = "as_workbench_armor",
    value = 250,
    weight = 10,
    class = "mercenary",
    craft = {
        ["misc_scrap"] = 450,
        ["misc_smallparts"] = 500,
        ["misc_chemical"] = 400,
        ["misc_propane"] = 1,
        ["misc_servo"] = 2,
    },
})

AS.AddBaseItem("tool_stove", {
    name = "Stove",
    desc = "A stove that allows cultivators to cook food.",
    category = "tool",
    model = "models/props_c17/furnitureStove001a.mdl",
    ent = "as_workbench_stove",
    value = 250,
    weight = 10,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 250,
        ["misc_smallparts"] = 200,
        ["misc_chemical"] = 275,
        ["misc_propane"] = 1,
    },
})

AS.AddBaseItem("tool_workbench", {
    name = "Workbench",
    desc = "A weapon workbench at allows engineers to make effective firearms, and a couple other miscellaneous items.",
    category = "tool",
    model = "models/props_canal/winch02.mdl",
    ent = "as_workbench_weapon",
    value = 250,
    weight = 10,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 350,
        ["misc_smallparts"] = 400,
        ["misc_chemical"] = 300,
        ["misc_propane"] = 1,
        ["misc_saw"] = 1,
        ["misc_servo"] = 2,
    },
})

AS.AddBaseItem("tool_pulse", {
    name = "Science Station",
    desc = "A scientific workbench that allows scientists to make pulse weaponry and other useful items.",
    category = "tool",
    model = "models/props_combine/combine_interface002.mdl",
    ent = "as_workbench_pulse",
    value = 300,
    weight = 10,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 500,
        ["misc_smallparts"] = 450,
        ["misc_chemical"] = 450,
        ["misc_propane"] = 1,
        ["misc_electronicparts"] = 3,
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
    desc = "An orange plant. Will produce oranges if taken care of over time.",
    category = "tool",
    model = "models/props/cs_office/plant01.mdl",
    ent = "as_plant_orange",
    value = 200,
    weight = 6,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 300,
        ["misc_smallparts"] = 250,
        ["misc_chemical"] = 400,
        ["misc_seed_orange"] = 4,
    },
})

AS.AddBaseItem("tool_plant_melon", {
    name = "Melon Plant",
    desc = "A melon plant. Will produce melons if taken care of over time.",
    category = "tool",
    model = "models/props/de_inferno/flower_barrel.mdl",
    ent = "as_plant_melon",
    value = 250,
    weight = 8,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 450,
        ["misc_smallparts"] = 400,
        ["misc_chemical"] = 600,
        ["misc_seed_melon"] = 4,
    },
})

AS.AddBaseItem("tool_plant_herb", {
    name = "Herb Box",
    desc = "A herb box. Will produce medical herbs if taken care of over time.",
    category = "tool",
    model = "models/tools/dirtbox.mdl",
    ent = "as_plant_herb",
    value = 250,
    weight = 8,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 300,
        ["misc_smallparts"] = 300,
        ["misc_chemical"] = 350,
        ["misc_seed_herb"] = 3,
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
    desc = "A handmade solar panel. Absorbs the sun's energy to be converted to electricity. Produces 25 power.",
    category = "tool",
    model = "models/hunter/plates/plate1x2.mdl",
    ent = "as_generator_solar",
    value = 250,
    weight = 10,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 250,
        ["misc_smallparts"] = 300,
        ["misc_chemical"] = 200,
        ["misc_solarfilmroll"] = 1,
        ["misc_propane"] = 1,
        ["misc_electronicparts"] = 2,
        ["misc_servo"] = 2,
    },
})

AS.AddBaseItem("tool_generator_engine", {
    name = "Gas Generator",
    desc = "A gas generator that uses a motor to create electricity. Produces 75 power.",
    category = "tool",
    model = "models/props_vehicles/generatortrailer01.mdl",
    ent = "as_generator_engine",
    value = 250,
    weight = 15,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 350,
        ["misc_smallparts"] = 400,
        ["misc_chemical"] = 250,
        ["misc_engine"] = 1,
        ["misc_propane"] = 1,
        ["misc_electronicparts"] = 1,
    },
})

AS.AddBaseItem("tool_generator_nuclear", {
    name = "Nuclear Generator",
    desc = "A nuclear generator that utilizes uranium as a source to generate electricity. Produces 150 power.",
    category = "tool",
    model = "models/props_canal/generator01.mdl",
    ent = "as_generator_nuclear",
    value = 250,
    weight = 25,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 500,
        ["misc_smallparts"] = 550,
        ["misc_chemical"] = 600,
        ["misc_nukecore"] = 1,
        ["misc_propane"] = 2,
        ["misc_servo"] = 4,
        ["misc_electronicparts"] = 3,
    },
})

AS.AddBaseItem("tool_generator_fusion", {
    name = "Fusion Generator",
    desc = "A fusion generator that is powered by deuterium fuel. Produces 250 power.",
    category = "tool",
    model = "models/props_combine/combine_generator01.mdl",
    ent = "as_generator_fusion",
    value = 250,
    weight = 40,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 1000,
        ["misc_smallparts"] = 900,
        ["misc_chemical"] = 850,
        ["misc_fusioncore"] = 1,
        ["misc_propane"] = 3,
        ["misc_servo"] = 5,
        ["misc_electronicparts"] = 5,
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
    desc = "A small antlion grub, can produce chemicals over time.",
    category = "tool",
    model = "models/antlion_grub.mdl",
    ent = "as_grub",
    value = 250,
    weight = 4,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 250,
        ["misc_smallparts"] = 300,
        ["misc_chemical"] = 550,
        ["misc_egg"] = 1,
    },
})

AS.AddBaseItem("tool_miner", {
    name = "Automated Miner",
    desc = "This thing will pound the ground to dig out usable resources for you. Would be incredibly useful if you had an army of them. Requires 75 Electricity.",
    category = "tool",
    model = "models/props_combine/combinethumper001a.mdl",
    ent = "as_miner",
    value = 300,
    weight = 15,
    class = "scavenger",
    craft = {
        ["misc_scrap"] = 650,
        ["misc_smallparts"] = 800,
        ["misc_chemical"] = 350,
        ["misc_sensorpod"] = 1,
        ["misc_electronicparts"] = 3,
        ["misc_servo"] = 4,
    },
})

-- ███╗   ███╗██╗███████╗ ██████╗███████╗██╗     ██╗      █████╗ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗███████╗
-- ████╗ ████║██║██╔════╝██╔════╝██╔════╝██║     ██║     ██╔══██╗████╗  ██║██╔════╝██╔═══██╗██║   ██║██╔════╝
-- ██╔████╔██║██║███████╗██║     █████╗  ██║     ██║     ███████║██╔██╗ ██║█████╗  ██║   ██║██║   ██║███████╗
-- ██║╚██╔╝██║██║╚════██║██║     ██╔══╝  ██║     ██║     ██╔══██║██║╚██╗██║██╔══╝  ██║   ██║██║   ██║╚════██║
-- ██║ ╚═╝ ██║██║███████║╚██████╗███████╗███████╗███████╗██║  ██║██║ ╚████║███████╗╚██████╔╝╚██████╔╝███████║
-- ╚═╝     ╚═╝╚═╝╚══════╝ ╚═════╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝ ╚═════╝  ╚═════╝ ╚══════╝

AS.AddBaseItem("tool_vendor", {
    name = "Vending Machine",
    desc = "A vending machine. You can put junk in here that other players can buy. Requires 25 Electricity.",
    category = "tool",
    model = "models/props_interiors/vendingmachinesoda01a.mdl",
    ent = "as_vendor",
    value = 10,
    weight = 10,
    novendor = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 1000,
        ["misc_smallparts"] = 1200,
        ["misc_chemical"] = 950,
        ["misc_servo"] = 2,
        ["misc_electronicparts"] = 2,
    },
})

AS.AddBaseItem("tool_locker", {
    name = "Personal Locker",
    desc = "It's a personal storage locker. You can place belongings in here that you don't want to carry everywhere else.",
    category = "tool",
    model = "models/props_c17/Lockers001a.mdl",
    ent = "as_locker",
    value = 10,
    weight = 4,
    novendor = true,
    craft = {
        ["misc_scrap"] = 350,
        ["misc_smallparts"] = 200,
        ["misc_chemical"] = 250,
    },
})

AS.AddBaseItem("tool_healthstation", {
    name = "Health Station",
    desc = "A station that allows you to load it with medicinal herbs, in which players can use to heal themself at a charged price.",
    category = "tool",
    model = "models/props_combine/health_charger001.mdl",
    ent = "as_healthstation",
    value = 10,
    weight = 3,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 150,
        ["misc_smallparts"] = 400,
        ["misc_chemical"] = 300,
        ["misc_servo"] = 2,
        ["misc_emptybottle"] = 1,
    },
})

AS.AddBaseItem("tool_pylon", {
    name = "Power Pylon",
    desc = "A small pylon, useful to transfer large amounts of electricity over far distances.",
    category = "tool",
    model = "models/props_c17/substation_transformer01d.mdl",
    ent = "as_pylon",
    value = 10,
    weight = 3,
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 20,
    },
})

AS.AddBaseItem("tool_paper", {
    name = "Paper",
    desc = "A piece of paper that you can write anything on. Other people can read it.",
    category = "tool",
    model = "models/props_c17/paper01.mdl",
    ent = "as_paper",
    value = 10,
    weight = 0.1,
    craft = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 1,
        ["misc_chemical"] = 0,
    },
})