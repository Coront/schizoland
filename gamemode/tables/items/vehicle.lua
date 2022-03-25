AS.AddBaseItem("vehicle_jeep", {
    name = "Jeep",
    desc = "A simple jeep. Useful for lengthy travels while also being light. Can carry 200 pounds of items.",
    category = "vehicle",
    model = "models/buggy.mdl",
    value = 500,
    weight = 200, --With vehicles, weight is actually the max weight of the vehicle's inventory, not how much it will weight in the player's inventory. Vehicles have no inventory weight.
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