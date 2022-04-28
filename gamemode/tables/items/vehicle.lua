AS.AddBaseItem("vehicle_firecrackerred", {
    name = "Red Fire Cracker",
    desc = "Fast speed but terrible steering. Seats 4 people and can carry 200 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/car001a_hatchback_skin0.mdl",
    ent = "car001a_skin0",
    value = 500,
    weight = 200, --With vehicles, weight is actually the max weight of the vehicle's inventory, not how much it will weight in the player's inventory. Vehicles have no inventory weight.
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["misc_engine"] = 1,
        ["misc_carbattery"] = 1,
        ["misc_axel"] = 2,
        ["misc_wheel"] = 4,
    },
})

AS.AddBaseItem("vehicle_firecrackeryellow", {
    name = "Yellow Fire Cracker",
    desc = "Fast speed but terrible steering. Seats 4 people and can carry 200 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/car001a_hatchback_skin1.mdl",
    ent = "car001a_skin1",
    value = 500,
    weight = 200,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["misc_engine"] = 1,
        ["misc_carbattery"] = 1,
        ["misc_axel"] = 2,
        ["misc_wheel"] = 4,
    },
})

AS.AddBaseItem("vehicle_markswagon", {
    name = "Mark-S Wagon",
    desc = "Average speed and controllable steering. Seats 2 people and can carry 300 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/car002a.mdl",
    ent = "car004a",
    value = 500,
    weight = 300,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["misc_engine"] = 1,
        ["misc_carbattery"] = 1,
        ["misc_axel"] = 2,
        ["misc_wheel"] = 4,
    },
})

AS.AddBaseItem("vehicle_tuscan", {
    name = "Tuscan-350",
    desc = "Average speed and controllable steering. Seats 4 people and can carry 250 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/car005a.mdl",
    ent = "car005a",
    value = 500,
    weight = 250,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["misc_engine"] = 1,
        ["misc_carbattery"] = 1,
        ["misc_axel"] = 2,
        ["misc_wheel"] = 4,
    },
})

AS.AddBaseItem("vehicle_roadrunner", {
    name = "Roadrunner",
    desc = "Average speed and controllable steering. Seats 4 people and can carry 250 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/car003a.mdl",
    ent = "car003a",
    value = 500,
    weight = 250,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["misc_engine"] = 1,
        ["misc_carbattery"] = 1,
        ["misc_axel"] = 2,
        ["misc_wheel"] = 4,
    },
})

AS.AddBaseItem("vehicle_gaz", {
    name = "GAZ-27",
    desc = "Above average speed and controllable steering. Seats 5 people and can carry 225 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/car004a.mdl",
    ent = "car004a",
    value = 500,
    weight = 225,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["misc_engine"] = 1,
        ["misc_carbattery"] = 1,
        ["misc_axel"] = 2,
        ["misc_wheel"] = 4,
    },
})

AS.AddBaseItem("vehicle_van", {
    name = "Fourcha Van",
    desc = "Slow speed and controllable steering. Seats 4 people and can carry 400 pounds of items. Comes with the faint smell of candy.",
    category = "vehicle",
    model = "models/source_vehicles/van001a_01_nodoor.mdl",
    ent = "van001a_01_nodoor",
    value = 500,
    weight = 400,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["misc_engine"] = 1,
        ["misc_carbattery"] = 1,
        ["misc_axel"] = 2,
        ["misc_wheel"] = 4,
    },
})

AS.AddBaseItem("vehicle_hardram", {
    name = "Hard RAM",
    desc = "Designed to RAM, climb, and raid. Seats 2 people and can carry 100 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/truck002a_cab.mdl",
    ent = "truck002a_cab",
    value = 500,
    weight = 100,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["misc_engine"] = 1,
        ["misc_carbattery"] = 1,
        ["misc_axel"] = 2,
        ["misc_wheel"] = 4,
    },
})

AS.AddBaseItem("vehicle_towtruck", {
    name = "Tow Truck",
    desc = "Can hold smaller cars in the back of it. Seats 2 people and can carry 100 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/truck003a_01.mdl",
    ent = "truck003a_01",
    value = 500,
    weight = 100,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["misc_engine"] = 1,
        ["misc_carbattery"] = 1,
        ["misc_axel"] = 2,
        ["misc_wheel"] = 4,
    },
})

AS.AddBaseItem("vehicle_truckblue", {
    name = "Blue Cargo Truck",
    desc = "A powerful truck, useful for hauling significant amounts of items. Seats 2 people and can carry 1000 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/truck001c_01.mdl",
    ent = "truck001c_01",
    value = 500,
    weight = 1000,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["misc_engine"] = 1,
        ["misc_carbattery"] = 1,
        ["misc_axel"] = 2,
        ["misc_wheel"] = 4,
    },
})

AS.AddBaseItem("vehicle_truckgreen", {
    name = "Green Cargo Truck",
    desc = "A powerful truck, useful for hauling significant amounts of items. Seats 2 people and can carry 1000 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/truck001c_02.mdl",
    ent = "truck001c_02",
    value = 500,
    weight = 1000,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["misc_engine"] = 1,
        ["misc_carbattery"] = 1,
        ["misc_axel"] = 2,
        ["misc_wheel"] = 4,
    },
})

AS.AddBaseItem("vehicle_apc", {
    name = "Military APC",
    desc = "An old military APC. Slow, but is useful for tanking damage. Seats 8 people and can carry 400 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/apc.mdl",
    ent = "apc",
    value = 500,
    weight = 400,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["misc_engine"] = 1,
        ["misc_carbattery"] = 1,
        ["misc_axel"] = 2,
        ["misc_wheel"] = 4,
    },
})

-- ██╗   ██╗██████╗  ██████╗ ██████╗  █████╗ ██████╗ ███████╗███████╗
-- ██║   ██║██╔══██╗██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝
-- ██║   ██║██████╔╝██║  ███╗██████╔╝███████║██║  ██║█████╗  ███████╗
-- ██║   ██║██╔═══╝ ██║   ██║██╔══██╗██╔══██║██║  ██║██╔══╝  ╚════██║
-- ╚██████╔╝██║     ╚██████╔╝██║  ██║██║  ██║██████╔╝███████╗███████║
--  ╚═════╝ ╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝

AS.AddBaseItem("vehicle_m80yellow", {
    name = "Yellow Firecracker M-80",
    desc = "An upgraded version of the Firecracker. Most parts have been stripped to increase carry weight. Seats 4 people and can carry 250 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/car001b_hatchback/vehicle.mdl",
    ent = "car001b_skin0",
    value = 500,
    weight = 250,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["vehicle_firecrackeryellow"] = 1
    },
})

AS.AddBaseItem("vehicle_m80red", {
    name = "Red Firecracker M-80",
    desc = "An upgraded version of the Firecracker. Most parts have been stripped to increase carry weight. Seats 4 people and can carry 250 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/car001b_hatchback/vehicle_skin1.mdl",
    ent = "car001b_skin1",
    value = 500,
    weight = 250,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["vehicle_firecrackerred"] = 1
    },
})

AS.AddBaseItem("vehicle_marksinternational", {
    name = "Mark-S International",
    desc = "An upgraded version of the Mark-S Wagon. Seats 2 people and can carry 400 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/car002b/vehicle.mdl",
    ent = "car002b",
    value = 500,
    weight = 400,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["vehicle_markswagon"] = 1,
    },
})

AS.AddBaseItem("vehicle_tuscanlegacy", {
    name = "Tuscan Legacy",
    desc = "An upgraded version of the Tuscan-350. Seats 4 people and can carry 325 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/car005b/vehicle.mdl",
    ent = "car005b",
    value = 500,
    weight = 325,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["vehicle_tuscan"] = 1,
    },
})

AS.AddBaseItem("vehicle_tuscanforce", {
    name = "Tuscan Force",
    desc = "An upgraded version of the Tuscan-350. Seats 4 people and can carry 300 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/car005b/vehicle.mdl",
    ent = "car005b_armored",
    value = 500,
    weight = 325,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["vehicle_tuscan"] = 1,
    },
})

AS.AddBaseItem("vehicle_roadrunnercaddy", {
    name = "Roadrunner Caddy",
    desc = "An upgraded version of the Roadrunner. Seats 4 people and can carry 325 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/car003b/vehicle.mdl",
    ent = "car003b",
    value = 500,
    weight = 325,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["vehicle_roadrunner"] = 1,
    },
})

AS.AddBaseItem("vehicle_gaztt", {
    name = "GAZ-27 TT",
    desc = "An upgraded version of the GAZ-27. Seats 5 people and can carry 300 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/car004b/vehicle.mdl",
    ent = "car004b",
    value = 500,
    weight = 300,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["vehicle_gaz"] = 1,
    },
})

AS.AddBaseItem("vehicle_rebelvan", {
    name = "Rebel Fourcha Van",
    desc = "An upgraded version of the Fourcha Van. Seats 4 people and can carry 500 pounds of items.",
    category = "vehicle",
    model = "models/source_vehicles/vehicle_van.mdl",
    ent = "car004b",
    value = 500,
    weight = 500,
    nostore = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 750,
        ["misc_smallparts"] = 850,
        ["misc_chemical"] = 600,
        ["vehicle_van"] = 1,
    },
})