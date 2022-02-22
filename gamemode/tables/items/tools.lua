-- ██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██████╗ ███████╗███╗   ██╗ ██████╗██╗  ██╗███████╗███████╗
-- ██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██╔══██╗██╔════╝████╗  ██║██╔════╝██║  ██║██╔════╝██╔════╝
-- ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██████╔╝█████╗  ██╔██╗ ██║██║     ███████║█████╗  ███████╗
-- ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██╔══██╗██╔══╝  ██║╚██╗██║██║     ██╔══██║██╔══╝  ╚════██║
-- ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██████╔╝███████╗██║ ╚████║╚██████╗██║  ██║███████╗███████║
--  ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝

AS.AddBaseItem("tool_armor", {
    name = "Armor Station",
    desc = "A station that allows wastelanders to craft armors.",
    model = "models/props_wasteland/controlroom_desk001b.mdl",
    value = 1,
    weight = 0.4,
})

AS.AddBaseItem("tool_stove", {
    name = "Stove",
    desc = "A handcrafted stove that will allow cultivators to cook food.",
    model = "models/props_c17/furnitureStove001a.mdl",
    value = 1,
    weight = 0.4,
})

AS.AddBaseItem("tool_workbench", {
    name = "Workbench",
    desc = "A handcrafted workbench that will allow engineers to craft firearms and better ammunition.",
    model = "models/props_canal/winch02.mdl",
    value = 1,
    weight = 0.4,
})

AS.AddBaseItem("tool_pulse", {
    name = "Pulse Assembly Station",
    desc = "A station that allows scientists to assemble pulse weaponry.",
    model = "models/props_combine/combine_interface002.mdl",
    value = 1,
    weight = 0.4,
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
    model = "models/props/cs_office/plant01.mdl",
    value = 1,
    weight = 0.4,
})

AS.AddBaseItem("tool_plant_melon", {
    name = "Melon Plant",
    desc = "An melon plant. It produces melons if taken care of over time.",
    model = "models/props/de_inferno/flower_barrel.mdl",
    value = 1,
    weight = 0.4,
})

AS.AddBaseItem("tool_plant_potato", {
    name = "Potato Plant",
    desc = "An potato plant. It produces potatoes if taken care of over time.",
    model = "models/props/de_inferno/potted_plant3.mdl",
    value = 1,
    weight = 0.4,
})

AS.AddBaseItem("tool_grub", {
    name = "Antlion Grub",
    desc = "An antlion grub, born and raised with the intention of making chemicals.",
    model = "models/antlion_grub.mdl",
    value = 1,
    weight = 0.4,
})

AS.AddBaseItem("tool_miner", {
    name = "Automated Miner",
    desc = "This thing will pound the ground to dig out usable resources for you. Useful if you had an army of them.",
    model = "models/props_combine/combinethumper001a.mdl",
    value = 1,
    weight = 0.4,
})