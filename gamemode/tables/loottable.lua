AS.Loot = {}
function AS.AddLootTable( id, data )
    AS.Loot = AS.Loot or {}

    AS.Loot[id] = data
end

-- ██╗      ██████╗  ██████╗ ████████╗    ████████╗ █████╗ ██████╗ ██╗     ███████╗███████╗
-- ██║     ██╔═══██╗██╔═══██╗╚══██╔══╝    ╚══██╔══╝██╔══██╗██╔══██╗██║     ██╔════╝██╔════╝
-- ██║     ██║   ██║██║   ██║   ██║          ██║   ███████║██████╔╝██║     █████╗  ███████╗
-- ██║     ██║   ██║██║   ██║   ██║          ██║   ██╔══██║██╔══██╗██║     ██╔══╝  ╚════██║
-- ███████╗╚██████╔╝╚██████╔╝   ██║          ██║   ██║  ██║██████╔╝███████╗███████╗███████║
-- ╚══════╝ ╚═════╝  ╚═════╝    ╚═╝          ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝

AS.AddLootTable( "drawer", {
    name = "Drawers", --Name of container (This won't be displayed to players)
    model = "models/props_c17/FurnitureDrawer001a.mdl", --Model of container
    opensound = "physics/wood/wood_plank_impact_soft1.wav", --Sound played when player opens the container
    closesound = "physics/wood/wood_plank_impact_soft3.wav", --Sound played when the player closes the container
    generation = {
        time = 300, --Time to regenerate
        chance = 80, --Chance to regenerate on timer call
        minitem = 1, --Minimal items that will spawn on regenerate call
        maxitem = 4, --Maximum items that will spawn on regenerate call (item stacks not included)
        items = {
            --Res
            ["misc_scrap"] = {tickets = 350, min = 1, max = 6}, --key is itemid, tickets is drawing chance, min is minimal stack, max is maximum stack
            ["misc_smallparts"] = {tickets = 340, min = 1, max = 4},
            ["misc_chemical"] = {tickets = 310, min = 1, max = 2},
            --Items
            ["misc_metalcan"] = {tickets = 40, min = 1, max = 1},
            ["misc_shoe"] = {tickets = 40, min = 1, max = 1},
            ["misc_towels"] = {tickets = 40, min = 1, max = 1},
            ["food_beans"] = {tickets = 40, min = 1, max = 1},
            ["misc_emptybottle"] = {tickets = 38, min = 1, max = 2},
            ["misc_servo"] = {tickets = 35, min = 1, max = 1},
            ["misc_gunpowder"] = {tickets = 35, min = 1, max = 1},
            ["misc_electronicparts"] = {tickets = 25, min = 1, max = 1},
            ["misc_electronicreceiver"] = {tickets = 10, min = 1, max = 1},
            ["wep_peashooter"] = {tickets = 3, min = 1, max = 1},
        },
    },
} )

AS.AddLootTable( "drawer2", {
    name = "Drawers 2",
    model = "models/props_c17/FurnitureDrawer002a.mdl",
    opensound = "physics/wood/wood_plank_impact_soft1.wav",
    closesound = "physics/wood/wood_plank_impact_soft3.wav",
    generation = {
        time = 240,
        chance = 85,
        minitem = 1,
        maxitem = 2,
        items = {
            --Res
            ["misc_scrap"] = {tickets = 300, min = 1, max = 4},
            ["misc_smallparts"] = {tickets = 290, min = 1, max = 3},
            ["misc_chemical"] = {tickets = 270, min = 1, max = 1},
            --Items
            ["misc_metalcan"] = {tickets = 40, min = 1, max = 1},
            ["food_beans"] = {tickets = 40, min = 1, max = 1},
            ["misc_emptybottle"] = {tickets = 38, min = 1, max = 1},
            ["misc_sensorpod"] = {tickets = 20, min = 1, max = 1},
            ["misc_electronicparts"] = {tickets = 20, min = 1, max = 1},
        },
    },
} )

AS.AddLootTable( "desk", {
    name = "Desk",
    model = "models/props_interiors/Furniture_Desk01a.mdl",
    opensound = "physics/wood/wood_plank_impact_soft1.wav",
    closesound = "physics/wood/wood_plank_impact_soft3.wav",
    generation = {
        time = 300,
        chance = 80,
        minitem = 1,
        maxitem = 3,
        items = {
            --Res
            ["misc_scrap"] = {tickets = 350, min = 1, max = 6},
            ["misc_smallparts"] = {tickets = 340, min = 1, max = 5},
            ["misc_chemical"] = {tickets = 310, min = 1, max = 2},
            --Items
            ["misc_metalcan"] = {tickets = 40, min = 1, max = 2},
            ["food_beans"] = {tickets = 40, min = 1, max = 1},
            ["misc_emptybottle"] = {tickets = 40, min = 1, max = 1},
            ["misc_gunpowder"] = {tickets = 30, min = 1, max = 1},
            ["food_dirty_water"] = {tickets = 25, min = 1, max = 1},
            ["misc_servo"] = {tickets = 25, min = 1, max = 1},
            ["misc_electronicparts"] = {tickets = 20, min = 1, max = 1},
            ["misc_sensorpod"] = {tickets = 20, min = 1, max = 1},
            ["ammo_pistol"] = {tickets = 5, min = 1, max = 1},
        },
    },
} )

AS.AddLootTable( "desk2", {
    name = "Desk 2",
    model = "models/props_interiors/Furniture_Vanity01a.mdl",
    opensound = "physics/wood/wood_plank_impact_soft1.wav",
    closesound = "physics/wood/wood_plank_impact_soft3.wav",
    generation = {
        time = 240,
        chance = 85,
        minitem = 1,
        maxitem = 2,
        items = {
            --Res
            ["misc_scrap"] = {tickets = 350, min = 1, max = 4},
            ["misc_smallparts"] = {tickets = 340, min = 1, max = 4},
            ["misc_chemical"] = {tickets = 310, min = 1, max = 1},
            --Items
            ["misc_metalcan"] = {tickets = 40, min = 1, max = 1},
            ["food_beans"] = {tickets = 40, min = 1, max = 1},
            ["misc_emptybottle"] = {tickets = 40, min = 1, max = 1},
            ["misc_gunpowder"] = {tickets = 30, min = 1, max = 1},
            ["food_dirty_water"] = {tickets = 25, min = 1, max = 1},
            ["misc_servo"] = {tickets = 25, min = 1, max = 1},
            ["misc_electronicparts"] = {tickets = 20, min = 1, max = 1},
            ["misc_sensorpod"] = {tickets = 20, min = 1, max = 1},
            ["ammo_pistol"] = {tickets = 5, min = 1, max = 1},
        },
    },
} )

AS.AddLootTable( "dresser", {
    name = "Dresser",
    model = "models/props_c17/FurnitureDresser001a.mdl",
    opensound = "physics/wood/wood_plank_impact_soft1.wav",
    closesound = "physics/wood/wood_plank_impact_soft3.wav",
    generation = {
        time = 300,
        chance = 80,
        minitem = 1,
        maxitem = 5,
        items = {
            --Res
            ["misc_scrap"] = {tickets = 350, min = 1, max = 7},
            ["misc_smallparts"] = {tickets = 300, min = 1, max = 4},
            ["misc_chemical"] = {tickets = 300, min = 1, max = 6},
            --Items
            ["misc_metalcan"] = {tickets = 50, min = 1, max = 3},
            ["misc_gunpowder"] = {tickets = 50, min = 1, max = 2},
            ["misc_paintcan"] = {tickets = 40, min = 1, max = 1},
            ["currency_dollar"] = {tickets = 35, min = 5, max = 30},
            ["misc_sensorpod"] = {tickets = 30, min = 1, max = 1},
            ["misc_servo"] = {tickets = 30, min = 1, max = 1},
            ["misc_chemicalbucket"] = {tickets = 20, min = 1, max = 1},
            ["misc_solarfilmroll"] = {tickets = 15, min = 1, max = 1},
            ["armor_makeshift"] = {tickets = 5, min = 1, max = 1},
        },
    },
} )

AS.AddLootTable( "computer", {
    name = "Computer",
    model = "models/props/cs_office/computer_caseB.mdl",
    opensound = "physics/metal/metal_computer_impact_soft2.wav",
    closesound = "physics/metal/metal_computer_impact_soft3.wav",
    generation = {
        time = 240,
        chance = 85,
        minitem = 1,
        maxitem = 2,
        items = {
            --Res
            ["misc_scrap"] = {tickets = 200, min = 1, max = 2},
            ["misc_smallparts"] = {tickets = 350, min = 1, max = 7},
            ["misc_chemical"] = {tickets = 290, min = 1, max = 5},
            --Items
            ["misc_electronicparts"] = {tickets = 80, min = 1, max = 2},
            ["misc_servo"] = {tickets = 55, min = 1, max = 1},
            ["misc_electronicreceiver"] = {tickets = 35, min = 1, max = 1},
        },
    },
} )

AS.AddLootTable( "fridge", {
    name = "Fridge",
    model = "models/props_c17/FurnitureFridge001a.mdl",
    opensound = "physics/plastic/plastic_barrel_impact_soft4.wav",
    closesound = "physics/plastic/plastic_barrel_impact_soft5.wav",
    generation = {
        time = 300,
        chance = 80,
        minitem = 1,
        maxitem = 4,
        items = {
            --Res
            ["misc_scrap"] = {tickets = 150, min = 1, max = 4},
            ["misc_smallparts"] = {tickets = 250, min = 1, max = 5},
            ["misc_chemical"] = {tickets = 180, min = 1, max = 4},
            --Items
            ["misc_emptysodacan"] = {tickets = 70, min = 1, max = 2},
            ["food_beans"] = {tickets = 60, min = 1, max = 2},
            ["food_dirty_water"] = {tickets = 60, min = 1, max = 2},
            ["food_soda"] = {tickets = 50, min = 1, max = 2},
            ["food_milk"] = {tickets = 45, min = 1, max = 1},
            ["food_clean_water"] = {tickets = 40, min = 1, max = 1},
            ["food_takeout"] = {tickets = 25, min = 1, max = 1},
            ["food_soup"] = {tickets = 20, min = 1, max = 1},
        },
    },
} )

AS.AddLootTable( "vending", {
    name = "Vending Machine",
    model = "models/props_interiors/VendingMachineSoda01a.mdl",
    opensound = "physics/plastic/plastic_barrel_impact_soft4.wav",
    closesound = "physics/plastic/plastic_barrel_impact_soft5.wav",
    generation = {
        time = 300,
        chance = 80,
        minitem = 1,
        maxitem = 5,
        items = {
            --Res
            ["misc_scrap"] = {tickets = 200, min = 1, max = 6},
            ["misc_smallparts"] = {tickets = 170, min = 1, max = 5},
            ["misc_chemical"] = {tickets = 140, min = 1, max = 3},
            --Items
            ["misc_emptysodacan"] = {tickets = 70, min = 1, max = 3},
            ["food_soda"] = {tickets = 70, min = 1, max = 3},
            ["food_clean_water"] = {tickets = 40, min = 1, max = 2},
        },
    },
} )

AS.AddLootTable( "box", {
    name = "Cardboard Box",
    model = "models/props_junk/cardboard_box001a.mdl",
    opensound = "physics/cardboard/cardboard_box_impact_soft1.wav",
    closesound = "physics/cardboard/cardboard_box_impact_soft2.wav",
    generation = {
        time = 200,
        chance = 100,
        minitem = 1,
        maxitem = 3,
        items = {
            --Res
            ["misc_scrap"] = {tickets = 100, min = 1, max = 6},
            ["misc_smallparts"] = {tickets = 95, min = 1, max = 5},
            ["misc_chemical"] = {tickets = 90, min = 1, max = 4},
            --Items
            ["misc_metalcan"] = {tickets = 40, min = 1, max = 1},
            ["misc_emptysodacan"] = {tickets = 40, min = 1, max = 1},
        },
    },
} )

AS.AddLootTable( "crate", {
    name = "Crate",
    model = "models/props_junk/wood_crate002a.mdl",
    opensound = "physics/wood/wood_plank_impact_soft1.wav",
    closesound = "physics/wood/wood_plank_impact_soft3.wav",
    generation = {
        time = 300,
        chance = 80,
        minitem = 1,
        maxitem = 5,
        items = {
            --Res
            ["misc_scrap"] = {tickets = 200, min = 1, max = 7},
            ["misc_smallparts"] = {tickets = 170, min = 1, max = 6},
            ["misc_chemical"] = {tickets = 100, min = 1, max = 4},
            --Items
            ["misc_paintcan"] = {tickets = 50, min = 1, max = 1},
            ["misc_servo"] = {tickets = 40, min = 1, max = 2},
            ["misc_seed_orange"] = {tickets = 40, min = 1, max = 1},
            ["misc_seed_melon"] = {tickets = 40, min = 1, max = 1},
            ["misc_gunpowder"] = {tickets = 40, min = 1, max = 2},
            ["misc_saw"] = {tickets = 30, min = 1, max = 1},
            ["misc_propane"] = {tickets = 30, min = 1, max = 1},
            ["misc_sensorpod"] = {tickets = 30, min = 1, max = 2},
            ["misc_chemicalbucket"] = {tickets = 25, min = 1, max = 1},
        },
    },
} )

AS.AddLootTable( "dumpster", {
    name = "Dumpster",
    model = "models/props_junk/TrashDumpster01a.mdl",
    opensound = "physics/plastic/plastic_barrel_impact_soft4.wav",
    closesound = "physics/plastic/plastic_barrel_impact_soft5.wav",
    generation = {
        time = 420,
        chance = 85,
        minitem = 1,
        maxitem = 6,
        items = {
            --Res
            ["misc_scrap"] = {tickets = 300, min = 1, max = 8},
            ["misc_smallparts"] = {tickets = 100, min = 1, max = 3},
            ["misc_chemical"] = {tickets = 120, min = 1, max = 4},
            --Items
            ["misc_metalcan"] = {tickets = 70, min = 1, max = 3},
            ["misc_emptysodacan"] = {tickets = 70, min = 1, max = 3},
            ["misc_shoe"] = {tickets = 60, min = 1, max = 2},
            ["misc_paintcan"] = {tickets = 60, min = 1, max = 1},
            ["misc_servo"] = {tickets = 50, min = 1, max = 2},
            ["misc_leadpipe"] = {tickets = 40, min = 1, max = 1},
            ["misc_axel"] = {tickets = 30, min = 1, max = 1},
            ["misc_wheel"] = {tickets = 30, min = 1, max = 1},
            ["misc_electronicreceiver"] = {tickets = 20, min = 1, max = 1},
        },
    },
} )

AS.AddLootTable( "file", {
    name = "Filing Cabinet",
    model = "models/props_wasteland/controlroom_filecabinet002a.mdl",
    opensound = "physics/metal/metal_grate_impact_soft3.wav",
    closesound = "physics/metal/metal_grate_impact_soft2.wav",
    generation = {
        time = 300,
        chance = 80,
        minitem = 1,
        maxitem = 4,
        items = {
            --Res
            ["misc_scrap"] = {tickets = 150, min = 1, max = 4},
            ["misc_smallparts"] = {tickets = 110, min = 1, max = 4},
            ["misc_chemical"] = {tickets = 100, min = 1, max = 4},
            --Items
            ["currency_dollar"] = {tickets = 60, min = 5, max = 25},
            ["misc_wrench"] = {tickets = 60, min = 1, max = 1},
            ["misc_seed_melon"] = {tickets = 50, min = 1, max = 1},
            ["misc_seed_orange"] = {tickets = 50, min = 1, max = 1},
            ["misc_electronicparts"] = {tickets = 40, min = 1, max = 1},
            ["ammo_pistol"] = {tickets = 5, min = 1, max = 1},
        },
    },
} )

AS.AddLootTable( "lockers", {
    name = "Lockers",
    model = "models/props_c17/Lockers001a.mdl",
    opensound = "physics/metal/metal_grate_impact_soft3.wav",
    closesound = "physics/metal/metal_grate_impact_soft2.wav",
    generation = {
        time = 300,
        chance = 80,
        minitem = 1,
        maxitem = 5,
        items = {
            ["misc_scrap"] = {tickets = 100, min = 1, max = 6},
            ["misc_smallparts"] = {tickets = 100, min = 1, max = 6},
            ["misc_chemical"] = {tickets = 100, min = 1, max = 6},
        },
    },
} )

AS.AddLootTable( "storagelocker", {
    name = "Storage Locker",
    model = "models/props_wasteland/controlroom_storagecloset001a.mdl",
    opensound = "physics/wood/wood_plank_impact_soft1.wav",
    closesound = "physics/wood/wood_plank_impact_soft3.wav",
    generation = {
        time = 300,
        chance = 80,
        minitem = 1,
        maxitem = 5,
        items = {
            ["misc_scrap"] = {tickets = 100, min = 1, max = 6},
            ["misc_smallparts"] = {tickets = 100, min = 1, max = 6},
            ["misc_chemical"] = {tickets = 100, min = 1, max = 6},
        },
    },
} )

AS.AddLootTable( "footlocker", {
    name = "Foot Locker",
    model = "models/props/CS_militia/footlocker01_closed.mdl",
    opensound = "physics/wood/wood_plank_impact_soft1.wav",
    closesound = "physics/wood/wood_plank_impact_soft3.wav",
    generation = {
        time = 300,
        chance = 80,
        minitem = 1,
        maxitem = 5,
        items = {
            ["misc_scrap"] = {tickets = 100, min = 1, max = 6},
            ["misc_smallparts"] = {tickets = 100, min = 1, max = 6},
            ["misc_chemical"] = {tickets = 100, min = 1, max = 6},
        },
    },
} )

AS.AddLootTable( "guncabinet", {
    name = "Gun Cabinet",
    model = "models/props/CS_militia/gun_cabinet.mdl",
    opensound = "physics/wood/wood_plank_impact_soft1.wav",
    closesound = "physics/wood/wood_plank_impact_soft3.wav",
    generation = {
        time = 300,
        chance = 80,
        minitem = 1,
        maxitem = 5,
        items = {
            ["misc_scrap"] = {tickets = 100, min = 1, max = 6},
            ["misc_smallparts"] = {tickets = 100, min = 1, max = 6},
            ["misc_chemical"] = {tickets = 100, min = 1, max = 6},
        },
    },
} )

AS.AddLootTable( "stash", {
    name = "Barrel Stash",
    model = "models/props_borealis/bluebarrel001.mdl",
    opensound = "physics/wood/wood_plank_impact_soft1.wav",
    closesound = "physics/wood/wood_plank_impact_soft3.wav",
    generation = {
        time = 300,
        chance = 80,
        minitem = 1,
        maxitem = 5,
        items = {
            ["misc_scrap"] = {tickets = 100, min = 1, max = 6},
            ["misc_smallparts"] = {tickets = 100, min = 1, max = 6},
            ["misc_chemical"] = {tickets = 100, min = 1, max = 6},
        },
    },
} )