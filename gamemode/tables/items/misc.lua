

-- ███████╗ ██████╗██████╗  █████╗ ██████╗     ██╗████████╗███████╗███╗   ███╗███████╗
-- ██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
-- ███████╗██║     ██████╔╝███████║██████╔╝    ██║   ██║   █████╗  ██╔████╔██║███████╗
-- ╚════██║██║     ██╔══██╗██╔══██║██╔═══╝     ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
-- ███████║╚██████╗██║  ██║██║  ██║██║         ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
-- ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝         ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- Scrap items are raw resources.

AS.AddBaseItem("misc_scrapmetal", {
    name = "Scrap Metal",
    desc = "Metal, salvaged from various objects. Useful for crafting.",
    category = "misc",
    model = "models/gibs/scanner_gib02.mdl",
    value = 1,
    weight = 0.02,
})

AS.AddBaseItem("misc_smallparts", {
    name = "Small Parts",
    desc = "A bunch of small parts, gathered from various objects. Useful for crafting.",
    category = "misc",
    model = "models/props_wasteland/gear02.mdl",
    value = 1,
    weight = 0.02,
})

AS.AddBaseItem("misc_chemical", {
    name = "Chemical Nugget",
    desc = "A chemical nugget. Found from salvaging chemical objects. Useful for crafting.",
    category = "misc",
    model = "models/spitball_medium.mdl",
    value = 1,
    weight = 0.02,
})

-- ██████╗  █████╗ ██████╗ ████████╗    ██╗████████╗███████╗███╗   ███╗███████╗
-- ██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
-- ██████╔╝███████║██████╔╝   ██║       ██║   ██║   █████╗  ██╔████╔██║███████╗
-- ██╔═══╝ ██╔══██║██╔══██╗   ██║       ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
-- ██║     ██║  ██║██║  ██║   ██║       ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
-- ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝       ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- Part items are items that are generally required in crafting of other items, usually the player will have to scavenge these.

AS.AddBaseItem("misc_hide_antlion", {
    name = "Antlion Hide",
    desc = "A hide, harvested from an antlion. Useful in the creation of some items.",
    category = "misc",
    model = "models/gibs/antlion_gib_large_2.mdl",
    value = 1,
    weight = 0.2,
})

AS.AddBaseItem("misc_hide_guard", {
    name = "Antlion Guard Hide",
    desc = "A hide, harvested from a antlion guard. Useful in the creation of very protective armor.",
    category = "misc",
    model = "models/gibs/strider_gib2.mdl",
    value = 1,
    weight = 0.2,
})

AS.AddBaseItem("misc_gunpowder", {
    name = "Gunpowder",
    desc = "A black powder that pops when ignited. An important requirement for crafting ammunition.",
    category = "misc",
    model = "models/props_lab/jar01b.mdl",
    value = 1,
    weight = 0.2,
})

AS.AddBaseItem("misc_heavyplate", {
    name = "Heavy Armor Plate",
    desc = "A heavy plate that is incredibly durable against elements. Required in the creation of some very efficient armors.",
    category = "misc",
    model = "models/gibs/shield_scanner_gib2.mdl",
    value = 1,
    weight = 0.2,
})

AS.AddBaseItem("misc_mechanicalparts", {
    name = "Mechanical Parts",
    desc = "A mechanical part salvaged from old technology.",
    model = "models/gibs/scanner_gib04.mdl",
    value = 1,
    weight = 0.2,
})

AS.AddBaseItem("misc_electronicparts", {
    name = "Electronic Parts",
    desc = "A bunch of circuits, useful for constructing something that requires conduction of electricity.",
    category = "misc",
    model = "models/props/cs_office/computer_caseb_p2a.mdl",
    value = 1,
    weight = 0.2,
})

AS.AddBaseItem("misc_saw", {
    name = "Diamond-Edged Saw",
    desc = "A saw that has been tipped with diamond. Useful for cutting through metals.",
    category = "misc",
    model = "models/props/cs_militia/circularsaw01.mdl",
    value = 1,
    weight = 0.2,
})

AS.AddBaseItem("misc_electronicreceiver", {
    name = "Electronic Receiver",
    desc = "An outdated receiver, maybe it still works?",
    category = "misc",
    model = "models/props_lab/reciever01c.mdl",
    value = 1,
    weight = 0.2,
})

AS.AddBaseItem("misc_seed_orange", {
    name = "Orange Seeds",
    desc = "A packet that contains orange seeds. Can be used to grow an orange plant, to harvest oranges.",
    category = "misc",
    model = "models/props_lab/box01a.mdl",
    value = 1,
    weight = 0.2,
})

AS.AddBaseItem("misc_seed_melon", {
    name = "Melon Seeds",
    desc = "A packet that contains melon seeds. Can be used to grow a melon plant, to harvest melons.",
    category = "misc",
    model = "models/props_junk/cardboard_box004a.mdl",
    value = 1,
    weight = 0.2,
})

AS.AddBaseItem("misc_solarfilmroll", {
    name = "Thin Rollable Solar Film",
    desc = "A very thin roll that containers copper, indium, gallium, and selenide. Can absorb energy from the sun to be converted into electricity.",
    category = "misc",
    model = "models/props/de_nuke/wall_light.mdl",
    value = 1,
    weight = 0.2,
})

AS.AddBaseItem("misc_carbattery", {
    name = "Car Battery",
    desc = "A still functional battery salvaged from a vehicle. One of the many parts required to make a vehicle.",
    category = "misc",
    model = "models/items/car_battery01.mdl",
    value = 1,
    weight = 2,
})

AS.AddBaseItem("misc_wheel", {
    name = "Wheel",
    desc = "A wheel salvaged from a car. One of the many parts required to make a vehicle.",
    category = "misc",
    model = "models/props_vehicles/carparts_wheel01a.mdl",
    value = 1,
    weight = 5,
})

AS.AddBaseItem("misc_axel", {
    name = "Axel",
    desc = "An old axel that is still in good condition. One of the many parts required to make a vehicle.",
    category = "misc",
    model = "models/props_vehicles/carparts_axel01a.mdl",
    value = 1,
    weight = 2,
})

AS.AddBaseItem("misc_engine", {
    name = "Makeshift Engine",
    desc = "An engine made from found scraps. One of the many parts required to make a vehicle.",
    category = "misc",
    model = "models/props_c17/trappropeller_engine.mdl",
    value = 1,
    weight = 2,
})

AS.AddBaseItem("misc_propane", {
    name = "Propane",
    desc = "A canister that holds C3H8, or Propane Gas, useful when it comes to having a temporary source of fire for welding or burning.",
    category = "misc",
    model = "models/props_junk/PropaneCanister001a.mdl",
    value = 1,
    weight = 2,
})

AS.AddBaseItem("misc_gasoline", {
    name = "Gasoline",
    desc = "A jerry can that holds a homogeneous mixture of petroleum oil and many other substances, commonly referred to as gasoline. Used to power generators.",
    category = "misc",
    model = "models/props_junk/metalgascan.mdl",
    value = 1,
    weight = 4,
})

AS.AddBaseItem("misc_paintcan", {
    name = "Paint Can",
    desc = "A medium-sized tin can that holds paint inside of it. Useful if you want to, you know, paint something.",
    category = "misc",
    model = "models/props_junk/metal_paintcan001a.mdl",
    value = 1,
    weight = 2,
})

AS.AddBaseItem("misc_hydrogen", {
    name = "Bottle of Hydrogen Peroxide",
    desc = "A bottle that contains H2O2, or hydrogren peroxide, which is good for preventing minor cuts, scrapes, or burns from becoming infected.",
    category = "misc",
    model = "models/props_junk/glassjug01.mdl",
    value = 5,
    weight = 1,
})

AS.AddBaseItem("misc_isopropyl", {
    name = "Bottle of Isopropyl Alcohol",
    desc = "A bottle that contains C3H8O, or Isopropyl Alcohol, which is good as a rubbing alcohol, and to stop minor cuts from becoming infected.",
    category = "misc",
    model = "models/props_junk/glassjug01.mdl",
    color = Color( 50, 100, 0 ),
    value = 5,
    weight = 1,
})

AS.AddBaseItem("misc_emptybottle", {
    name = "Empty Bottle",
    desc = "An empty bottle. Can be filled with water or salvaged for resources.",
    category = "misc",
    model = "models/props_junk/garbage_plasticbottle003a.mdl",
    value = 1,
    weight = 0.4,
})

-- ████████╗ ██████╗  ██████╗ ██╗         ██╗████████╗███████╗███╗   ███╗███████╗
-- ╚══██╔══╝██╔═══██╗██╔═══██╗██║         ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
--    ██║   ██║   ██║██║   ██║██║         ██║   ██║   █████╗  ██╔████╔██║███████╗
--    ██║   ██║   ██║██║   ██║██║         ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
--    ██║   ╚██████╔╝╚██████╔╝███████╗    ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
--    ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝    ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- Tool items are items that are required in crafting but are never actually consumed, meaning it's reusable.

AS.AddBaseItem("misc_tools", {
    name = "Set of Tools",
    desc = "A bag that contains a bunch of tools that would be required for assembling anything advanced.",
    category = "misc",
    model = "models/props_c17/BriefCase001a.mdl",
    value = 1,
    weight = 2,
})

AS.AddBaseItem("misc_munitionpress", {
    name = "Munition Press",
    desc = "A press that allows you to handcraft some basic ammunition wherever you are!",
    category = "misc",
    model = "models/props/cs_militia/reloadingpress01.mdl",
    value = 1,
    weight = 2,
})

-- ███████╗ █████╗ ██╗    ██╗   ██╗ █████╗  ██████╗ ███████╗    ██╗████████╗███████╗███╗   ███╗███████╗
-- ██╔════╝██╔══██╗██║    ██║   ██║██╔══██╗██╔════╝ ██╔════╝    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
-- ███████╗███████║██║    ██║   ██║███████║██║  ███╗█████╗      ██║   ██║   █████╗  ██╔████╔██║███████╗
-- ╚════██║██╔══██║██║    ╚██╗ ██╔╝██╔══██║██║   ██║██╔══╝      ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
-- ███████║██║  ██║███████╗╚████╔╝ ██║  ██║╚██████╔╝███████╗    ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
-- ╚══════╝╚═╝  ╚═╝╚══════╝ ╚═══╝  ╚═╝  ╚═╝ ╚═════╝ ╚══════╝    ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- Salvage items are just junk items. They don't do anything and cannot be used for crafting, but can be salvaged for raw resources.

AS.AddBaseItem("misc_shoe", {
    name = "Shoe",
    desc = "A leather shoe. Can be salvaged for raw resources.",
    category = "misc",
    model = "models/props_junk/Shoe001a.mdl",
    value = 1,
    weight = 0.4,
})

AS.AddBaseItem("misc_emptysodacan", {
    name = "Empty Soda Can",
    desc = "An empty soda can. Can be salvaged for raw resources.",
    category = "misc",
    model = "models/props_junk/PopCan01a.mdl",
    skin = 2,
    value = 1,
    weight = 0.1,
})

AS.AddBaseItem("misc_metalcan", {
    name = "Metal Can",
    desc = "A empty aluminum can. Not sure what this could be used for.",
    category = "misc",
    model = "models/props_junk/garbage_metalcan002a.mdl",
    value = 1,
    weight = 0.125,
})

AS.AddBaseItem("misc_checmicalbucket", {
    name = "Chemical Bucket",
    desc = "A bucket that has some random chemicals inside of it. Probably not really useful for much.",
    category = "misc",
    model = "models/props_junk/plasticbucket001a.mdl",
    value = 1,
    weight = 1,
})