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
            ["misc_scrap"] = {tickets = 115, min = 1, max = 3}, --key is itemid, tickets is drawing chance, min is minimal stack, max is maximum stack
            ["misc_smallparts"] = {tickets = 95, min = 1, max = 2},
            ["misc_chemical"] = {tickets = 90, min = 1, max = 2},
            --Items
            ["food_beans"] = {tickets = 60, min = 1, max = 1},
            ["misc_towels"] = {tickets = 60, min = 1, max = 1},
            ["misc_emptysodacan"] = {tickets = 50, min = 1, max = 1},
            ["misc_metalcan"] = {tickets = 50, min = 1, max = 1},
            ["misc_shoe"] = {tickets = 45, min = 1, max = 1},
            ["misc_servo"] = {tickets = 30, min = 1, max = 1},
            ["misc_emptybottle"] = {tickets = 40, min = 1, max = 1},
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
            ["misc_scrap"] = {tickets = 115, min = 1, max = 3},
            ["misc_smallparts"] = {tickets = 95, min = 1, max = 2},
            ["misc_chemical"] = {tickets = 90, min = 1, max = 1},
            --Items
            ["food_beans"] = {tickets = 60, min = 1, max = 1},
            ["misc_towels"] = {tickets = 60, min = 1, max = 1},
            ["misc_emptysodacan"] = {tickets = 50, min = 1, max = 1},
            ["misc_metalcan"] = {tickets = 50, min = 1, max = 1},
            ["misc_shoe"] = {tickets = 45, min = 1, max = 1},
            ["misc_emptybottle"] = {tickets = 35, min = 1, max = 1},
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
            ["misc_scrap"] = {tickets = 115, min = 1, max = 4},
            ["misc_smallparts"] = {tickets = 95, min = 1, max = 2},
            ["misc_chemical"] = {tickets = 90, min = 1, max = 1},
            --Items
            ["food_beans"] = {tickets = 60, min = 1, max = 1},
            ["misc_metalcan"] = {tickets = 60, min = 1, max = 1},
            ["misc_phonereceiver"] = {tickets = 55, min = 1, max = 1},
            ["misc_wrench"] = {tickets = 50, min = 1, max = 1},
            ["misc_damagedtransceiver"] = {tickets = 50, min = 1, max = 1},
            ["misc_emptysodacan"] = {tickets = 60, min = 1, max = 1},
            ["misc_electronicparts"] = {tickets = 25, min = 1, max = 1},
            ["misc_seed_orange"] = {tickets = 25, min = 1, max = 1},
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
            ["misc_scrap"] = {tickets = 115, min = 1, max = 4},
            ["misc_smallparts"] = {tickets = 95, min = 1, max = 2},
            ["misc_chemical"] = {tickets = 90, min = 1, max = 1},
            --Items
            ["food_beans"] = {tickets = 60, min = 1, max = 1},
            ["misc_metalcan"] = {tickets = 60, min = 1, max = 1},
            ["misc_phonereceiver"] = {tickets = 55, min = 1, max = 1},
            ["misc_wrench"] = {tickets = 50, min = 1, max = 1},
            ["misc_damagedtransceiver"] = {tickets = 50, min = 1, max = 1},
            ["misc_emptysodacan"] = {tickets = 60, min = 1, max = 1},
            ["misc_seed_melon"] = {tickets = 25, min = 1, max = 1},
            ["misc_servo"] = {tickets = 25, min = 1, max = 1},
            ["misc_emptybottle"] = {tickets = 35, min = 1, max = 1},
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
            ["misc_scrap"] = {tickets = 115, min = 1, max = 4},
            ["misc_smallparts"] = {tickets = 95, min = 1, max = 2},
            ["misc_chemical"] = {tickets = 90, min = 1, max = 1},
            --Items
            ["food_beans"] = {tickets = 60, min = 1, max = 1},
            ["misc_towels"] = {tickets = 50, min = 1, max = 1},
            ["misc_metalcan"] = {tickets = 50, min = 1, max = 1},
            ["misc_shoe"] = {tickets = 45, min = 1, max = 1},
            ["misc_lamp"] = {tickets = 35, min = 1, max = 1},
            ["misc_pulley"] = {tickets = 25, min = 1, max = 1},
            ["misc_gunpowder"] = {tickets = 25, min = 1, max = 1},
            ["misc_emptybottle"] = {tickets = 25, min = 1, max = 1},
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
            ["misc_scrap"] = {tickets = 95, min = 1, max = 2},
            ["misc_smallparts"] = {tickets = 115, min = 1, max = 4},
            ["misc_chemical"] = {tickets = 90, min = 1, max = 1},
            --Items
            ["misc_damagedtransceiver"] = {tickets = 30, min = 1, max = 1},
            ["misc_wrench"] = {tickets = 30, min = 1, max = 1},
            ["misc_emptysodacan"] = {tickets = 40, min = 1, max = 2},
            ["misc_electronicparts"] = {tickets = 30, min = 1, max = 1},
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
            ["misc_scrap"] = {tickets = 115, min = 1, max = 4},
            ["misc_smallparts"] = {tickets = 95, min = 1, max = 2},
            ["misc_chemical"] = {tickets = 90, min = 1, max = 1},
            --Items
            ["misc_emptysodacan"] = {tickets = 55, min = 1, max = 1},
            ["misc_metalcan"] = {tickets = 50, min = 1, max = 2},
            ["misc_leadpipe"] = {tickets = 35, min = 1, max = 1},
            ["food_orange"] = {tickets = 40, min = 1, max = 3},
            ["misc_fullmelon"] = {tickets = 20, min = 1, max = 1},
            ["misc_emptybottle"] = {tickets = 40, min = 1, max = 1},
            ["food_beans"] = {tickets = 40, min = 1, max = 1},
            ["food_meat"] = {tickets = 20, min = 1, max = 1},
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
            ["misc_scrap"] = {tickets = 115, min = 1, max = 4},
            ["misc_smallparts"] = {tickets = 95, min = 1, max = 2},
            ["misc_chemical"] = {tickets = 90, min = 1, max = 1},
            --Items
            ["misc_emptysodacan"] = {tickets = 55, min = 1, max = 2},
            ["food_soda"] = {tickets = 50, min = 1, max = 2},
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
            ["misc_scrap"] = {tickets = 110, min = 1, max = 2},
            ["misc_smallparts"] = {tickets = 95, min = 1, max = 1},
            ["misc_chemical"] = {tickets = 90, min = 1, max = 1},
            --Items
            ["food_beans"] = {tickets = 60, min = 1, max = 1},
            ["misc_emptysodacan"] = {tickets = 60, min = 1, max = 1},
            ["misc_metalcan"] = {tickets = 60, min = 1, max = 1},
            ["misc_shoe"] = {tickets = 55, min = 1, max = 1},
            ["misc_leadpipe"] = {tickets = 40, min = 1, max = 1},
            ["misc_wrench"] = {tickets = 45, min = 1, max = 1},
            ["misc_phonereceiver"] = {tickets = 50, min = 1, max = 1},
            ["misc_pulley"] = {tickets = 25, min = 1, max = 1},
            ["misc_damagedtransceiver"] = {tickets = 25, min = 1, max = 1},
            ["misc_bustedcomputer"] = {tickets = 20, min = 1, max = 1},
            ["misc_acid"] = {tickets = 25, min = 1, max = 1},
            ["misc_bleach"] = {tickets = 25, min = 1, max = 1},
            ["misc_cleaner"] = {tickets = 30, min = 1, max = 1},
            ["misc_fireextinguisher"] = {tickets = 15, min = 1, max = 1},
            ["misc_chemicalbucket"] = {tickets = 10, min = 1, max = 1},
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
            ["misc_scrap"] = {tickets = 110, min = 1, max = 5},
            ["misc_smallparts"] = {tickets = 95, min = 1, max = 3},
            ["misc_chemical"] = {tickets = 95, min = 1, max = 2},
            --Items
            ["food_beans"] = {tickets = 60, min = 1, max = 1},
            ["misc_leadpipe"] = {tickets = 40, min = 1, max = 1},
            ["misc_wrench"] = {tickets = 45, min = 1, max = 1},
            ["misc_pulley"] = {tickets = 35, min = 1, max = 1},
            ["misc_lamp"] = {tickets = 40, min = 1, max = 1},
            ["misc_bustedcomputer"] = {tickets = 35, min = 1, max = 1},
            ["misc_acid"] = {tickets = 35, min = 1, max = 1},
            ["misc_bleach"] = {tickets = 35, min = 1, max = 1},
            ["misc_fireextinguisher"] = {tickets = 25, min = 1, max = 1},
            ["misc_chemicalbucket"] = {tickets = 25, min = 1, max = 1},
            ["misc_servo"] = {tickets = 20, min = 1, max = 1},
            ["misc_sensorpod"] = {tickets = 15, min = 1, max = 1},
            ["misc_axel"] = {tickets = 5, min = 1, max = 1},
            ["misc_propane"] = {tickets = 5, min = 1, max = 1},
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
            ["misc_scrap"] = {tickets = 110, min = 1, max = 4},
            ["misc_smallparts"] = {tickets = 95, min = 1, max = 2},
            ["misc_chemical"] = {tickets = 95, min = 1, max = 2},
            --Items
            ["food_beans"] = {tickets = 60, min = 1, max = 1},
            ["misc_emptysodacan"] = {tickets = 60, min = 1, max = 2},
            ["misc_metalcan"] = {tickets = 60, min = 1, max = 2},
            ["misc_shoe"] = {tickets = 55, min = 1, max = 1},
            ["misc_wrench"] = {tickets = 50, min = 1, max = 1},
            ["misc_leadpipe"] = {tickets = 50, min = 1, max = 1},
            ["misc_phonereceiver"] = {tickets = 60, min = 1, max = 1},
            ["misc_damagedtransceiver"] = {tickets = 50, min = 1, max = 1},
            ["misc_bustedcomputer"] = {tickets = 35, min = 1, max = 1},
            ["misc_cleaner"] = {tickets = 60, min = 1, max = 1},
            ["misc_fireextinguisher"] = {tickets = 35, min = 1, max = 1},
            ["misc_emptybottle"] = {tickets = 45, min = 1, max = 1},
            ["misc_axel"] = {tickets = 15, min = 1, max = 1},
            ["misc_wheel"] = {tickets = 2, min = 1, max = 1},
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
            ["misc_scrap"] = {tickets = 110, min = 1, max = 2},
            ["misc_smallparts"] = {tickets = 95, min = 1, max = 1},
            ["misc_chemical"] = {tickets = 95, min = 1, max = 1},
            --Items
            ["misc_towels"] = {tickets = 60, min = 1, max = 1},
            ["misc_metalcan"] = {tickets = 55, min = 1, max = 1},
            ["misc_damagedtransceiver"] = {tickets = 40, min = 1, max = 1},
            ["misc_fireextinguisher"] = {tickets = 30, min = 1, max = 1},
            ["misc_seed_orange"] = {tickets = 20, min = 1, max = 1},
            ["misc_emptybottle"] = {tickets = 25, min = 1, max = 1},
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
            --Res
            ["misc_scrap"] = {tickets = 100, min = 1, max = 3},
            ["misc_smallparts"] = {tickets = 100, min = 1, max = 2},
            ["misc_chemical"] = {tickets = 100, min = 1, max = 1},
            --Items
            ["misc_towels"] = {tickets = 60, min = 1, max = 1},
            ["misc_metalcan"] = {tickets = 55, min = 1, max = 1},
            ["misc_shoe"] = {tickets = 50, min = 1, max = 1},
            ["misc_wrench"] = {tickets = 50, min = 1, max = 1},
            ["misc_cleaner"] = {tickets = 55, min = 1, max = 1},
            ["misc_acid"] = {tickets = 45, min = 1, max = 1},
            ["misc_bleach"] = {tickets = 45, min = 1, max = 1},
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
            --Res
            ["misc_scrap"] = {tickets = 100, min = 1, max = 5},
            ["misc_smallparts"] = {tickets = 100, min = 1, max = 4},
            ["misc_chemical"] = {tickets = 100, min = 1, max = 2},
            --Items
            ["misc_wrench"] = {tickets = 50, min = 1, max = 1},
            ["misc_leadpipe"] = {tickets = 40, min = 1, max = 1},
            ["misc_pulley"] = {tickets = 30, min = 1, max = 1},
            ["misc_cleaner"] = {tickets = 50, min = 1, max = 1},
            ["misc_acid"] = {tickets = 40, min = 1, max = 1},
            ["misc_bleach"] = {tickets = 35, min = 1, max = 1},
            ["misc_chemicalbucket"] = {tickets = 25, min = 1, max = 1},
            ["misc_seed_melon"] = {tickets = 15, min = 1, max = 1},
            ["misc_solarfilmroll"] = {tickets = 3, min = 1, max = 1},
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
            --Res
            ["misc_scrap"] = {tickets = 110, min = 1, max = 3},
            ["misc_smallparts"] = {tickets = 95, min = 1, max = 3},
            ["misc_chemical"] = {tickets = 95, min = 1, max = 2},
            --Items
            ["misc_shoe"] = {tickets = 50, min = 1, max = 1},
            ["misc_metalcan"] = {tickets = 50, min = 1, max = 1},
            ["misc_leadpipe"] = {tickets = 35, min = 1, max = 1},
            ["misc_phonereceiver"] = {tickets = 45, min = 1, max = 1},
            ["misc_damagedtransceiver"] = {tickets = 35, min = 1, max = 1},
            ["misc_acid"] = {tickets = 40, min = 1, max = 1},
            ["misc_fireextinguisher"] = {tickets = 25, min = 1, max = 1},
            ["misc_servo"] = {tickets = 20, min = 1, max = 1},
            ["misc_emptybottle"] = {tickets = 30, min = 1, max = 1},
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
            --Res
            ["misc_scrap"] = {tickets = 100, min = 1, max = 3},
            ["misc_smallparts"] = {tickets = 100, min = 1, max = 2},
            ["misc_chemical"] = {tickets = 100, min = 1, max = 1},
            --Items
            ["misc_metalcan"] = {tickets = 50, min = 1, max = 1},
            ["misc_towels"] = {tickets = 50, min = 1, max = 1},
            ["misc_wrench"] = {tickets = 30, min = 1, max = 1},
            ["ammo_9mm"] = {tickets = 15, min = 1, max = 1},
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
            --Res
            ["misc_scrap"] = {tickets = 110, min = 1, max = 8},
            ["misc_smallparts"] = {tickets = 95, min = 1, max = 7},
            ["misc_chemical"] = {tickets = 95, min = 1, max = 7},
            --Items
            ["misc_acid"] = {tickets = 40, min = 1, max = 1},
            ["misc_wrench"] = {tickets = 45, min = 1, max = 1},
            ["misc_phonereceiver"] = {tickets = 50, min = 1, max = 1},
        },
    },
} )

AS.AddLootTable( "gunbox", {
    name = "(Occupation) Gun Box",
    model = "models/items/ammocrate_smg2.mdl",
    opensound = "items/ammocrate_open.wav",
    closesound = "items/ammocrate_close.wav",
    generation = {
        time = 4800,
        chance = 100,
        minitem = 1,
        maxitem = 1,
        items = {
            ["wep_mp5"] = {tickets = 100, min = 1, max = 1},
            ["wep_bizon"] = {tickets = 100, min = 1, max = 1},
            ["wep_g36"] = {tickets = 80, min = 1, max = 1},
            ["wep_m4a1"] = {tickets = 70, min = 1, max = 1},
            ["wep_sg550"] = {tickets = 60, min = 1, max = 1},
            ["wep_ak47"] = {tickets = 60, min = 1, max = 1},
            ["wep_sako"] = {tickets = 50, min = 1, max = 1},
            ["wep_rpk"] = {tickets = 40, min = 1, max = 1},
            ["wep_svd"] = {tickets = 30, min = 1, max = 1},
        },
    },
} )