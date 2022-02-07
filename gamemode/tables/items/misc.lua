

-- ███████╗ ██████╗██████╗  █████╗ ██████╗     ██╗████████╗███████╗███╗   ███╗███████╗
-- ██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
-- ███████╗██║     ██████╔╝███████║██████╔╝    ██║   ██║   █████╗  ██╔████╔██║███████╗
-- ╚════██║██║     ██╔══██╗██╔══██║██╔═══╝     ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
-- ███████║╚██████╗██║  ██║██║  ██║██║         ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
-- ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝         ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- Scrap items are raw resources, basically as base of a resource you can get.

AS.AddBaseItem("misc_scrapmetal", {
    name = "Scrap Metal",
    desc = "Metal, salvaged from various objects. Useful for crafting.",
    model = "models/gibs/scanner_gib02.mdl",
    value = 1,
    weight = 0.01,
})

AS.AddBaseItem("misc_smallparts", {
    name = "Small Parts",
    desc = "A bunch of small parts, gathered from various objects. Useful for crafting.",
    model = "models/props_wasteland/gear02.mdl",
    value = 1,
    weight = 0.01,
})

AS.AddBaseItem("misc_chemical", {
    name = "Chemical Nugget",
    desc = "A chemical nugget. Found from salvaging chemical objects. Useful for crafting.",
    model = "models/spitball_medium.mdl",
    value = 1,
    weight = 0.01,
})

-- ██████╗  █████╗ ██████╗ ████████╗    ██╗████████╗███████╗███╗   ███╗███████╗
-- ██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
-- ██████╔╝███████║██████╔╝   ██║       ██║   ██║   █████╗  ██╔████╔██║███████╗
-- ██╔═══╝ ██╔══██║██╔══██╗   ██║       ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
-- ██║     ██║  ██║██║  ██║   ██║       ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
-- ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝       ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- Part items are items that are generally required in crafting of other items, usually the player will have to scavenge these.

AS.AddBaseItem("misc_mechanicalparts", {
    name = "Mechanical Parts",
    desc = "A mechanical part salvaged from old technology.",
    model = "models/gibs/scanner_gib04.mdl",
    value = 1,
    weight = 0.2,
})

AS.AddBaseItem("misc_electronicparts", {
    name = "Electronic Parts",
    desc = "Parts of electronics salvaged from old technology.",
    model = "models/props_lab/reciever01c.mdl",
    value = 1,
    weight = 0.2,
})

AS.AddBaseItem("misc_carbattery", {
    name = "Car Battery",
    desc = "A battery salvaged from a vehicle.",
    model = "models/items/car_battery01.mdl",
    value = 1,
    weight = 2,
})

AS.AddBaseItem("misc_wheel", {
    name = "Wheel",
    desc = "A wheel salvaged from a car.",
    model = "models/props_vehicles/carparts_wheel01a.mdl",
    value = 1,
    weight = 5,
})

AS.AddBaseItem("misc_propane", {
    name = "Propane",
    desc = "A canister that holds C3H8, or Propane Gas, useful when it comes to having a temporary source of fire for welding or burning.",
    model = "models/props_junk/PropaneCanister001a.mdl",
    value = 1,
    weight = 2,
})

AS.AddBaseItem("misc_gasoline", {
    name = "Gasoline",
    desc = "A jerry can that holds a homogeneous mixture of petroleum oil and many other substances, commonly referred to as gasoline.",
    model = "models/props_junk/metalgascan.mdl",
    value = 1,
    weight = 4,
})

AS.AddBaseItem("misc_paintcan", {
    name = "Paint Can",
    desc = "A medium-sized tin can that holds paint inside of it. Useful if you want to, you know, paint something.",
    model = "models/props_junk/metal_paintcan001a.mdl",
    value = 1,
    weight = 2,
})

AS.AddBaseItem("misc_hydrogen", {
    name = "Bottle of Hydrogen Peroxide",
    desc = "A bottle that contains H2O2, or hydrogren peroxide, which is good for preventing minor cuts, scrapes, or burns from becoming infected.",
    model = "models/props_junk/glassjug01.mdl",
    value = 5,
    weight = 1,
})

AS.AddBaseItem("misc_isopropyl", {
    name = "Bottle of Isopropyl Alcohol",
    desc = "A bottle that contains C3H8O, or Isopropyl Alcohol, which is good as a rubbing alcohol, and to stop minor cuts from becoming infected.",
    model = "models/props_junk/glassjug01.mdl",
    color = Color( 50, 100, 0 ),
    value = 5,
    weight = 1,
})

-- ████████╗ ██████╗  ██████╗ ██╗         ██╗████████╗███████╗███╗   ███╗███████╗
-- ╚══██╔══╝██╔═══██╗██╔═══██╗██║         ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
--    ██║   ██║   ██║██║   ██║██║         ██║   ██║   █████╗  ██╔████╔██║███████╗
--    ██║   ██║   ██║██║   ██║██║         ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
--    ██║   ╚██████╔╝╚██████╔╝███████╗    ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
--    ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝    ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- Tool items are items that are required in crafting but are never actually consumed, meaning it's constantly reusable.

AS.AddBaseItem("misc_tools", {
    name = "Set of Tools",
    desc = "A bag that contains a bunch of tools that would be required for assembling anything advanced.",
    model = "models/props_c17/BriefCase001a.mdl",
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
    model = "models/props_junk/Shoe001a.mdl",
    value = 1,
    weight = 0.4,
})

AS.AddBaseItem("misc_emptybottle", {
    name = "Empty Bottle",
    desc = "An empty bottle. Can be filled with water or salvaged for resources.",
    model = "models/props_junk/garbage_plasticbottle003a.mdl",
    value = 1,
    weight = 0.4,
})