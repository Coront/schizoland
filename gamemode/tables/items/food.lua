-- ██╗  ██╗██╗   ██╗███╗   ██╗ ██████╗ ███████╗██████╗     ██╗████████╗███████╗███╗   ███╗███████╗
-- ██║  ██║██║   ██║████╗  ██║██╔════╝ ██╔════╝██╔══██╗    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
-- ███████║██║   ██║██╔██╗ ██║██║  ███╗█████╗  ██████╔╝    ██║   ██║   █████╗  ██╔████╔██║███████╗
-- ██╔══██║██║   ██║██║╚██╗██║██║   ██║██╔══╝  ██╔══██╗    ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
-- ██║  ██║╚██████╔╝██║ ╚████║╚██████╔╝███████╗██║  ██║    ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
-- ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝    ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝

AS.AddBaseItem("food_beans", {
    name = "Can of Beans",
    desc = "An old aluminum can that contains perfectly good beans.",
    model = "models/props_junk/garbage_metalcan001a.mdl",
    value = 1,
    weight = 0.5,
    use = {
        hunger = 15,
        soundcs = "npc/headcrab/headbite.wav",
    },
})

AS.AddBaseItem("food_melon", {
    name = "Melon Slice",
    desc = "One of multiple slices from a melon. Manually grown and harvested.",
    model = "models/props_junk/watermelon01_chunk01b.mdl",
    value = 1,
    weight = 0.4,
    use = {
        hunger = 5,
        thirst = 15,
        soundcs = "npc/headcrab/headbite.wav",
    },
})

AS.AddBaseItem("food_orange", {
    name = "Orange",
    desc = "An orange, like the fruit orange. Manually grown and harvested.",
    model = "models/props/cs_italy/orange.mdl",
    value = 1,
    weight = 0.2,
    use = {
        hunger = 4,
        thirst = 10,
        soundcs = "npc/headcrab/headbite.wav",
    },
})

AS.AddBaseItem("food_takeout", {
    name = "Chinese Takeout",
    desc = "A small box that contains remains of food from a Chinese restaurant.",
    model = "models/props_junk/garbage_takeoutcarton001a.mdl",
    value = 1,
    weight = 1,
    use = {
        hunger = 25,
        soundcs = "npc/headcrab/headbite.wav",
    },
})

-- ████████╗██╗  ██╗██╗██████╗ ███████╗████████╗    ██╗████████╗███████╗███╗   ███╗███████╗
-- ╚══██╔══╝██║  ██║██║██╔══██╗██╔════╝╚══██╔══╝    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
--    ██║   ███████║██║██████╔╝███████╗   ██║       ██║   ██║   █████╗  ██╔████╔██║███████╗
--    ██║   ██╔══██║██║██╔══██╗╚════██║   ██║       ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
--    ██║   ██║  ██║██║██║  ██║███████║   ██║       ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
--    ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝       ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝

AS.AddBaseItem("food_dirty_water", {
    name = "Bottle of Dirty Water",
    desc = "An old bottle that contains unsanitary water.",
    model = "models/props_junk/garbage_plasticbottle003a.mdl",
    value = 1,
    weight = 1,
    use = {
        thirst = 15,
        soundcs = "npc/barnacle/barnacle_gulp1.wav",
    },
})

AS.AddBaseItem("food_clean_water", {
    name = "Bottle of Clean Water",
    desc = "An old bottle that contains sanitized water.",
    model = "models/props_junk/garbage_plasticbottle003a.mdl",
    value = 1,
    weight = 1,
    use = {
        thirst = 15,
        soundcs = "npc/barnacle/barnacle_gulp1.wav",
    },
})

AS.AddBaseItem("food_milk", {
    name = "A carton of Milk",
    desc = "An old carton that contains milk. Hopefully not expired.",
    model = "models/props_junk/garbage_milkcarton002a.mdl",
    value = 1,
    weight = 1,
    use = {
        thirst = 15,
        soundcs = "npc/barnacle/barnacle_gulp1.wav",
    },
})

AS.AddBaseItem("food_soda", {
    name = "Soda Can",
    desc = "An old aluminum can that contains soda. Apparently it still tastes good?",
    model = "models/props_junk/PopCan01a.mdl",
    value = 1,
    weight = 1,
    use = {
        thirst = 10,
        soundcs = "npc/barnacle/barnacle_gulp1.wav",
    },
})

AS.AddBaseItem("food_coffee", {
    name = "Coffee",
    desc = "A mug that contains coffee. Great for pulling all-nighters.",
    model = "models/props_junk/garbage_coffeemug001a.mdl",
    value = 1,
    weight = 0.8,
    use = {
        thirst = 15,
        soundcs = "npc/barnacle/barnacle_gulp1.wav",
    },
})