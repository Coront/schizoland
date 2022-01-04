

-- ███████╗ ██████╗██████╗  █████╗ ██████╗     ██╗████████╗███████╗███╗   ███╗███████╗
-- ██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
-- ███████╗██║     ██████╔╝███████║██████╔╝    ██║   ██║   █████╗  ██╔████╔██║███████╗
-- ╚════██║██║     ██╔══██╗██╔══██║██╔═══╝     ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
-- ███████║╚██████╗██║  ██║██║  ██║██║         ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
-- ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝         ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- For items that are raw resources.

AS.AddBaseItem("misc_scrapmetal", {
    name = "Scrap Metal",
    desc = "Metal, salvaged from various objects. Useful for crafting.",
    model = "models/gibs/scanner_gib02.mdl",
    value = 1,
    weight = 0.1,
})

AS.AddBaseItem("misc_scrapwood", {
    name = "Scrap Wood",
    desc = "Wood, gathered from various objects. Useful for crafting.",
    model = "models/Gibs/wood_gib01c.mdl",
    value = 1,
    weight = 0.2,
})

AS.AddBaseItem("misc_scrapaluminum", {
    name = "Scrap Aluminum",
    desc = "Aluminum (Al), gathered from various objects. Useful for crafting.",
    model = "models/Gibs/wood_gib01c.mdl",
    value = 2,
    weight = 0.1,
})

AS.AddBaseItem("misc_scraptin", {
    name = "Scrap Tin",
    desc = "Tin (Sn), gathered from various objects. Useful for crafting.",
    model = "models/Gibs/wood_gib01c.mdl",
    value = 2,
    weight = 0.2,
})

AS.AddBaseItem("misc_copper", {
    name = "Copper Ingot",
    desc = "An ingot that contains the pure element Copper (Cu). Useful for crafting.",
    model = "models/Gibs/wood_gib01c.mdl",
    value = 5,
    weight = 1,
})

AS.AddBaseItem("misc_sulfur", {
    name = "Sulfur Chunk",
    desc = "A rough-chunky rock that contains the pure element Sulfur (S). Useful for crafting.",
    model = "models/Gibs/wood_gib01c.mdl",
    value = 4,
    weight = 1,
})

AS.AddBaseItem("misc_lead", {
    name = "Lead Ingot",
    desc = "An ingot that contains the pure element Lead (Pb). Useful for crafting.",
    model = "models/Gibs/wood_gib01c.mdl",
    value = 6,
    weight = 2,
})

AS.AddBaseItem("misc_iron", {
    name = "Iron Ingot",
    desc = "An ingot that contains the pure element Iron (Fe). Useful for crafting.",
    model = "models/Gibs/wood_gib01c.mdl",
    value = 12,
    weight = 2,
})

AS.AddBaseItem("misc_gold", {
    name = "Gold Ingot",
    desc = "An ingot that contains the pure element Gold (Au). Useful for crafting.",
    model = "models/Gibs/wood_gib01c.mdl",
    value = 20,
    weight = 3,
})

AS.AddBaseItem("misc_titanium", {
    name = "Titanium Ingot",
    desc = "An ingot that contains the pure element Titanium (Ti). Useful for crafting.",
    model = "models/props_junk/rock001a.mdl",
    value = 18,
    weight = 2,
})

--  ██████╗ ██████╗ ███████╗    ██╗████████╗███████╗███╗   ███╗███████╗
-- ██╔═══██╗██╔══██╗██╔════╝    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
-- ██║   ██║██████╔╝█████╗      ██║   ██║   █████╗  ██╔████╔██║███████╗
-- ██║   ██║██╔══██╗██╔══╝      ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
-- ╚██████╔╝██║  ██║███████╗    ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
--  ╚═════╝ ╚═╝  ╚═╝╚══════╝    ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- For items that are harvested from mining.

AS.AddBaseItem("misc_stone", {
    name = "Stone",
    desc = "Raw stone, doubt it has much value.",
    model = "models/props_junk/rock001a.mdl",
    value = 1,
    weight = 1,
})

AS.AddBaseItem("misc_copperore", {
    name = "Copper Ore",
    desc = "A ore that contains copper, can be smelted to obtain the raw element.",
    model = "models/props_junk/rock001a.mdl",
    value = 1,
    weight = 1,
})

AS.AddBaseItem("misc_sulfurore", {
    name = "Sulfur Ore",
    desc = "A ore that contains sulfur, can be smelted to obtain the raw element.",
    model = "models/props_junk/rock001a.mdl",
    value = 1,
    weight = 1,
})

AS.AddBaseItem("misc_leadore", {
    name = "Lead Ore",
    desc = "A ore that contains lead, can be smelted to obtain the raw element.",
    model = "models/props_junk/rock001a.mdl",
    value = 1,
    weight = 1,
})

AS.AddBaseItem("misc_ironore", {
    name = "Iron Ore",
    desc = "A ore that contains iron, can be smelted to obtain the raw element.",
    model = "models/props_junk/rock001a.mdl",
    value = 1,
    weight = 1,
})

AS.AddBaseItem("misc_goldore", {
    name = "Gold Ore",
    desc = "A ore that contains gold, can be smelted to obtain the raw element.",
    model = "models/props_junk/rock001a.mdl",
    value = 1,
    weight = 1,
})

AS.AddBaseItem("misc_titaniumore", {
    name = "Titanium Ore",
    desc = "A ore that contains titanium, can be smelted to obtain the raw element.",
    model = "models/props_junk/rock001a.mdl",
    value = 1,
    weight = 1,
})

-- ██████╗  █████╗ ██████╗ ████████╗    ██╗████████╗███████╗███╗   ███╗███████╗
-- ██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
-- ██████╔╝███████║██████╔╝   ██║       ██║   ██║   █████╗  ██╔████╔██║███████╗
-- ██╔═══╝ ██╔══██║██╔══██╗   ██║       ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
-- ██║     ██║  ██║██║  ██║   ██║       ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
-- ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝       ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- For items that are required for crafting.

AS.AddBaseItem("misc_mechanicalpart", {
    name = "Mechanical Part",
    desc = "A mechanical part salvaged from old technology.",
    model = "models/gibs/scanner_gib04.mdl",
    value = 1,
    weight = 0.2,
})

AS.AddBaseItem("misc_electronicparts", {
    name = "Electronic Part",
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

-- ████████╗ ██████╗  ██████╗ ██╗         ██╗████████╗███████╗███╗   ███╗███████╗
-- ╚══██╔══╝██╔═══██╗██╔═══██╗██║         ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
--    ██║   ██║   ██║██║   ██║██║         ██║   ██║   █████╗  ██╔████╔██║███████╗
--    ██║   ██║   ██║██║   ██║██║         ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
--    ██║   ╚██████╔╝╚██████╔╝███████╗    ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
--    ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝    ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- For items that are required for crafting but are not taken.

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
-- For items that are just junk. They can be salvaged for raw parts.

AS.AddBaseItem("misc_shoe", {
    name = "Shoe",
    desc = "A leather shoe. Can be salvaged for raw resources.",
    model = "models/props_junk/Shoe001a.mdl",
    value = 1,
    weight = 0.4,
})

AS.AddBaseItem("misc_can", {
    name = "Metal Can",
    desc = "A metal can. Can be salvaged for raw resources.",
    model = "models/props_junk/garbage_metalcan002a.mdl",
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