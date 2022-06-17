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

AS.AddBaseItem("food_beans", {
    name = "Can of Beans",
    desc = "A can of good old beans, a post-apocalyptic staple.",
    category = "food",
    model = "models/props_junk/garbage_metalcan001a.mdl",
    value = 2,
    weight = 0.2,
    use = {
        hunger = 10,
        soundcs = "npc/headcrab/headbite.wav",
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 2,
        ["misc_smallparts"] = 1,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("food_meat", {
    name = "Raw Meat",
    desc = "A small portion of raw meat that has been harvested from various species.",
    category = "food",
    model = "models/weapons/w_bugbait.mdl",
    value = 2,
    weight = 1,
    use = {
        hunger = 15,
        soundcs = "npc/headcrab/headbite.wav",
        stat = {
            [1] = {effect = "poison", length = 10, stack = true},
        },
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 2,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 1,
    }
})

AS.AddBaseItem("food_meat_antlion", {
    name = "Antlion Meat",
    desc = "Meat, harvested from a dead antlion. Probably not a good idea to consume in its current state.",
    category = "food",
    model = "models/gibs/antlion_gib_medium_2.mdl",
    value = 2,
    weight = 1.5,
    use = {
        hunger = 15,
        soundcs = "npc/headcrab/headbite.wav",
        stat = {
            [1] = {effect = "poison", length = 15, stack = true},
        },
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 2,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 3,
    }
})

AS.AddBaseItem("food_meat_guard", {
    name = "Antlion Guard Meat",
    desc = "A huge piece of meat that has been carefully harvested from a fallen Antlion Guard.",
    category = "food",
    model = "models/gibs/antlion_gib_large_3.mdl",
    value = 2,
    weight = 4,
    use = {
        hunger = 40,
        soundcs = "npc/headcrab/headbite.wav",
        stat = {
            [1] = {effect = "poison", length = 30, stack = true},
        },
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 1,
        ["misc_chemical"] = 4,
    }
})

AS.AddBaseItem("food_dirty_water", {
    name = "Bottle of Dirty Water",
    desc = "A bottle containing unsanitary water.",
    category = "food",
    model = "models/props_junk/garbage_plasticbottle003a.mdl",
    color = Color( 135, 80, 0 ),
    value = 3,
    weight = 1,
    use = {
        thirst = 20,
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
        ["misc_scrap"] = 1,
        ["misc_smallparts"] = 1,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("food_milk", {
    name = "Carton of Milk",
    desc = "A large carton of milk that seems way past its expiration date. Maybe you don't want to drink this.",
    category = "food",
    model = "models/props_junk/garbage_milkcarton002a.mdl",
    value = 3,
    weight = 0.9,
    use = {
        thirst = 15,
        soundcs = "npc/barnacle/barnacle_gulp1.wav",
        stat = {
            [1] = {effect = "poison", length = 4, stack = true},
        },
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 4,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 1,
    }
})

AS.AddBaseItem("food_soda", {
    name = "Soda Can",
    desc = "An aluminum can that contains soda, safe to drink too.",
    category = "food",
    model = "models/props_junk/PopCan01a.mdl",
    value = 2,
    weight = 0.2,
    use = {
        thirst = 15,
        soundcs = "npc/barnacle/barnacle_gulp1.wav",
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 1,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})

--  ██████╗ ██████╗  ██████╗ ██╗  ██╗███████╗██████╗
-- ██╔════╝██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝██╔══██╗
-- ██║     ██║   ██║██║   ██║█████╔╝ █████╗  ██║  ██║
-- ██║     ██║   ██║██║   ██║██╔═██╗ ██╔══╝  ██║  ██║
-- ╚██████╗╚██████╔╝╚██████╔╝██║  ██╗███████╗██████╔╝
--  ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝

AS.AddBaseItem("food_orange", {
    name = "Orange",
    desc = "An orange. Probably not that fulfilling.",
    category = "food",
    model = "models/props/cs_italy/orange.mdl",
    value = 2,
    weight = 0.15,
    use = {
        hunger = 3,
        thirst = 8,
        soundcs = "npc/headcrab/headbite.wav",
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 1,
    }
})

AS.AddBaseItem("food_melon", {
    name = "Melon Slice",
    desc = "A freshly cut melon that was grown recently.",
    category = "food",
    model = "models/props_junk/watermelon01_chunk01b.mdl",
    value = 3,
    weight = 0.2,
    use = {
        hunger = 6,
        thirst = 12,
        soundcs = "npc/headcrab/headbite.wav",
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 1,
    }
})

AS.AddBaseItem("food_cooked_beans", {
    name = "Cooked Can of Beans",
    desc = "A can of beans that has actually been cooked! Still unsure what the difference is though...",
    category = "food",
    model = "models/props_junk/garbage_metalcan001a.mdl",
    color = Color( 30, 100, 15 ),
    value = 2,
    weight = 0.2,
    use = {
        hunger = 20,
        soundcs = "npc/headcrab/headbite.wav",
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 1,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 6,
        ["food_beans"] = 1,
    }
})

AS.AddBaseItem("food_clean_water", {
    name = "Bottle of Clean Water",
    desc = "A bottle containing water that has been boiled to eliminate any harmful diseases.",
    category = "food",
    model = "models/props_junk/garbage_plasticbottle003a.mdl",
    color = Color( 0, 75, 135 ),
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
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 3,
        ["food_dirty_water"] = 1,
    },
})

AS.AddBaseItem("food_purified_water", {
    name = "Bottle of Purifed Water",
    desc = "A bottle containing water that has been properly purified to be completely safe and healthy to drink.",
    category = "food",
    model = "models/props_junk/garbage_plasticbottle003a.mdl",
    color = Color( 35, 105, 205),
    value = 5,
    weight = 1,
    use = {
        thirst = 25,
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
        ["misc_chemical"] = 1,
        ["food_dirty_water"] = 1,
    },
})

AS.AddBaseItem("food_cooked_meat", {
    name = "Cooked Meat",
    desc = "A large piece of cooked meat. Likely fufilling.",
    category = "food",
    model = "models/gibs/antlion_gib_small_2.mdl",
    color = Color( 30, 100, 15 ),
    value = 2,
    weight = 1,
    use = {
        hunger = 40,
        soundcs = "npc/headcrab/headbite.wav",
    },
    hidden = true,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 1,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 8,
        ["food_meat"] = 1,
    }
})

AS.AddBaseItem("food_cooked_antlion", {
    name = "Cooked Antlion Meat",
    desc = "Cooked meat that came from an antlion.",
    category = "food",
    model = "models/gibs/antlion_gib_medium_3a.mdl",
    color = Color( 30, 100, 15 ),
    value = 2,
    weight = 1.5,
    use = {
        hunger = 50,
        soundcs = "npc/headcrab/headbite.wav",
    },
    hidden = true,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 1,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 10,
        ["food_meat_antlion"] = 1,
    }
})

AS.AddBaseItem("food_cooked_guard", {
    name = "Cooked Antlion Guard Meat",
    desc = "Cooked and ready to be eaten! Unsure if one person alone could eat all of this.",
    category = "food",
    model = "models/props_junk/garbage_takeoutcarton001a.mdl",
    color = Color( 30, 100, 15 ),
    value = 2,
    weight = 3.5,
    use = {
        hunger = 70,
        soundcs = "npc/headcrab/headbite.wav",
    },
    hidden = true,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 1,
        ["misc_smallparts"] = 1,
        ["misc_chemical"] = 14,
        ["food_meat_guard"] = 1,
    }
})

AS.AddBaseItem("food_soup", {
    name = "Soup",
    desc = "A thermos of warm soup that's been cooked recently.",
    category = "food",
    model = "models/props_c17/pottery01a.mdl",
    color = Color( 30, 100, 15 ),
    value = 15,
    weight = 1,
    use = {
        hunger = 35,
        thirst = 25,
        soundcs = "npc/barnacle/barnacle_gulp1.wav",
    },
    hidden = true,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 15,
    },
})

AS.AddBaseItem("food_coffee", {
    name = "Coffee",
    desc = "A cup of warm coffee. Great for pulling all nighters, or postponing satiation.",
    category = "food",
    model = "models/props_junk/garbage_coffeemug001a.mdl",
    color = Color( 30, 100, 15 ),
    value = 10,
    weight = 0.6,
    use = {
        hunger = 20,
        thirst = 30,
        soundcs = "npc/barnacle/barnacle_gulp1.wav",
    },
    hidden = true,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 2,
        ["misc_chemical"] = 10,
    },
})