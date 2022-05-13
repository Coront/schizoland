AS.AddBaseItem("food_unsatiate", {
    name = "Starver",
    desc = "[Dev Item] Will starve your character.",
    category = "food",
    model = "models/hunter/blocks/cube025x025x025.mdl",
    value = 0,
    weight = 0,
    use = {
        hunger = -50,
        thirst = -50,
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})

-- ██████╗  █████╗ ██╗    ██╗
-- ██╔══██╗██╔══██╗██║    ██║
-- ██████╔╝███████║██║ █╗ ██║
-- ██╔══██╗██╔══██║██║███╗██║
-- ██║  ██║██║  ██║╚███╔███╔╝
-- ╚═╝  ╚═╝╚═╝  ╚═╝ ╚══╝╚══╝

--  ██████╗ ██████╗  ██████╗ ██╗  ██╗███████╗██████╗
-- ██╔════╝██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝██╔══██╗
-- ██║     ██║   ██║██║   ██║█████╔╝ █████╗  ██║  ██║
-- ██║     ██║   ██║██║   ██║██╔═██╗ ██╔══╝  ██║  ██║
-- ╚██████╗╚██████╔╝╚██████╔╝██║  ██╗███████╗██████╔╝
--  ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝


AS.AddBaseItem("food_beans", {
    name = "Can of Beans",
    desc = "An old aluminum can that contains perfectly good beans.",
    category = "food",
    model = "models/props_junk/garbage_metalcan001a.mdl",
    value = 2,
    weight = 0.15,
    use = {
        hunger = 15,
        soundcs = "npc/headcrab/headbite.wav",
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 1,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("food_meat_antlion", {
    name = "Antlion Meat",
    desc = "A large chuck of meat that has been harvested from an antlion. With cooking, it could probably be edible.",
    category = "food",
    model = "models/gibs/antlion_gib_large_1.mdl",
    value = 2,
    weight = 0.15,
    use = {
        hunger = 15,
        soundcs = "npc/headcrab/headbite.wav",
        stat = {
            [1] = {effect = "poison", length = 10, stack = true},
        },
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 3,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("food_cooked_antlion", {
    name = "Cooked Antlion Meat",
    desc = "Antlion meat that has been properly cooked to be edible.",
    category = "food",
    model = "models/gibs/antlion_gib_medium_2.mdl",
    value = 2,
    weight = 0.15,
    use = {
        hunger = 40,
        soundcs = "npc/headcrab/headbite.wav",
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 15,
    }
})

AS.AddBaseItem("food_melon", {
    name = "Melon Slice",
    desc = "One of multiple slices from a melon. Manually grown and harvested.",
    category = "food",
    model = "models/props_junk/watermelon01_chunk01b.mdl",
    value = 3,
    weight = 0.2,
    use = {
        hunger = 5,
        thirst = 10,
        soundcs = "npc/headcrab/headbite.wav",
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("food_orange", {
    name = "Orange",
    desc = "An orange, like the fruit orange. Manually grown and harvested.",
    category = "food",
    model = "models/props/cs_italy/orange.mdl",
    value = 2,
    weight = 0.2,
    use = {
        hunger = 4,
        thirst = 12,
        soundcs = "npc/headcrab/headbite.wav",
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("food_takeout", {
    name = "Chinese Takeout",
    desc = "A small box that contains remains of food from a Chinese restaurant.",
    category = "food",
    model = "models/props_junk/garbage_takeoutcarton001a.mdl",
    value = 10,
    weight = 1,
    use = {
        hunger = 25,
        soundcs = "npc/headcrab/headbite.wav",
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 3,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("food_soup", {
    name = "Soup",
    desc = "A thermos that still contains some warm soup. Everybody's favorite.",
    category = "food",
    model = "models/props_c17/pottery01a.mdl",
    value = 15,
    weight = 1.25,
    use = {
        hunger = 25,
        thirst = 30,
        soundcs = "npc/barnacle/barnacle_gulp1.wav",
    },
    hidden = true,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 25,
    },
})

AS.AddBaseItem("food_dirty_water", {
    name = "Bottle of Dirty Water",
    desc = "An old bottle that contains unsanitary water.",
    category = "food",
    model = "models/props_junk/garbage_plasticbottle003a.mdl",
    color = Color( 135, 80, 0 ),
    value = 3,
    weight = 1,
    use = {
        thirst = 15,
        soundcs = "npc/barnacle/barnacle_gulp1.wav",
        items = {
            ["misc_emptybottle"] = 1,
        },
        stat = {
            [1] = {effect = "poison", length = 5, stack = true},
        },
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 2,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("food_clean_water", {
    name = "Bottle of Clean Water",
    desc = "An old bottle that contains sanitized water.",
    category = "food",
    model = "models/props_junk/garbage_plasticbottle003a.mdl",
    color = Color( 0, 75, 135),
    value = 5,
    weight = 1,
    use = {
        thirst = 20,
        soundcs = "npc/barnacle/barnacle_gulp1.wav",
        items = {
            ["misc_emptybottle"] = 1,
        },
    },
    hidden = true,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 3,
        ["food_dirty_water"] = 1,
    },
})

AS.AddBaseItem("food_milk", {
    name = "A carton of Milk",
    desc = "An old carton that contains milk. Hopefully not expired.",
    category = "food",
    model = "models/props_junk/garbage_milkcarton002a.mdl",
    value = 3,
    weight = 0.8,
    use = {
        thirst = 15,
        soundcs = "npc/barnacle/barnacle_gulp1.wav",
        stat = {
            [1] = {effect = "poison", length = 3, stack = true},
        },
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 2,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("food_soda", {
    name = "Soda Can",
    desc = "An old aluminum can that contains soda. Apparently it still tastes good?",
    category = "food",
    model = "models/props_junk/PopCan01a.mdl",
    value = 2,
    weight = 0.15,
    use = {
        thirst = 10,
        soundcs = "npc/barnacle/barnacle_gulp1.wav",
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 2,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("food_coffee", {
    name = "Coffee",
    desc = "A mug that contains coffee. Great for pulling all-nighters.",
    category = "food",
    model = "models/props_junk/garbage_coffeemug001a.mdl",
    value = 10,
    weight = 0.3,
    use = {
        hunger = 15,
        thirst = 25,
        soundcs = "npc/barnacle/barnacle_gulp1.wav",
    },
    hidden = true,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 20,
    },
})