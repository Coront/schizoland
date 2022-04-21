AS.AddBaseItem("vehicle_firecrackerred", {
    name = "Red Fire Cracker",
    desc = "A basic vehicle for fast transportation and to haul your items. Seats 4 people and can carry 200 pounds of items.",
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