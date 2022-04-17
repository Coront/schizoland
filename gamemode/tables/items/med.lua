AS.AddBaseItem("med_painkiller", {
    name = "Bottle of Painkillers",
    desc = "A bottle that contains a couple tablets of painkiller. Will reduce incoming damage by 10% for 2 minutes.",
    category = "med",
    model = "models/props_junk/PopCan01a.mdl",
    skin = 1,
    value = 15,
    weight = 0.1,
    use = {
        sound = "items/medshot4.wav",
        stat = {
            effect = "painkillers",
            length = 120,
        },
    },
    hidden = true,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 10,
        ["misc_chemical"] = 40,
    }
})

AS.AddBaseItem("med_adrenaline", {
    name = "Adrenaline Shot",
    desc = "A syringe that carries adrenaline. Will increase your movement speed by 15% for 1 minute.",
    category = "med",
    model = "models/props_junk/PopCan01a.mdl",
    skin = 1,
    value = 15,
    weight = 0.1,
    use = {
        sound = "items/medshot4.wav",
        stat = {
            effect = "adrenaline",
            length = 60,
        },
    },
    hidden = true,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 10,
        ["misc_chemical"] = 40,
    }
})

AS.AddBaseItem("med_bag", {
    name = "Bag of Medical Supplies",
    desc = "An old garbage bag that contains some bandages, a potential tourniquet, and maybe a few other things to help with your personal health. Heals 15 HP, 3 second cooldown.",
    category = "med",
    model = "models/props_junk/garbage_bag001a.mdl",
    value = 20,
    weight = 0.2,
    use = {
        health = 15,
        sound = "physics/body/body_medium_impact_soft4.wav",
        stat = {
            effect = "healingsickness",
            length = 3,
        },
    },
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 35,
    },
})

AS.AddBaseItem("med_vial", {
    name = "Health Vial",
    desc = "A vial that contains a strange green liquid that apparently lets your body regenerate lost blood faster. Heals 20 HP, 4 second cooldown.",
    category = "med",
    model = "models/healthvial.mdl",
    color = Color( 0, 115, 70 ),
    value = 20,
    weight = 0.75,
    use = {
        health = 20,
        sound = "items/medshot4.wav",
        stat = {
            effect = "healingsickness",
            length = 4,
        },
    },
    class = "scientist",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 10,
        ["misc_chemical"] = 20,
    },
})

AS.AddBaseItem("med_kit", {
    name = "Medical Kit",
    desc = "A kit that contains some of that strange green liquid and a bunch of other necessities to help recover from wounds. Heals 35 HP, 7 second cooldown.",
    category = "med",
    model = "models/Items/HealthKit.mdl",
    color = Color( 0, 115, 70 ),
    value = 40,
    weight = 1,
    use = {
        health = 35,
        sound = "items/smallmedkit1.wav",
        stat = {
            effect = "healingsickness",
            length = 7,
        },
    },
    class = "scientist",
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 20,
        ["misc_chemical"] = 35,
    },
})

AS.AddBaseItem("med_bloodbag", {
    name = "Bloodbag",
    desc = "A bag that contains a majority of the different bloodtypes, including yours, and a couple of other things to help recover from recent damage. Heals 70 HP, 20 second cooldown.",
    category = "med",
    model = "models/weapons/w_package.mdl",
    color = Color( 0, 115, 70 ),
    value = 80,
    weight = 1.5,
    use = {
        health = 70,
        sound = "physics/flesh/flesh_bloody_impact_hard1.wav",
        stat = {
            effect = "healingsickness",
            length = 20,
        },
    },
    hidden = true,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 40,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 50,
    },
})

AS.AddBaseItem("med_surgery", {
    name = "Surgery Kit",
    desc = "A large bag that contains a bunch of materials to perform surgery on yourself, or to simply recover your health. Heals 150 HP, 40 second cooldown.",
    category = "med",
    model = "models/props_c17/BriefCase001a.mdl",
    color = Color( 120, 40, 40 ),
    value = 175,
    weight = 2.5,
    use = {
        health = 150,
        sound = "physics/body/body_medium_impact_soft6.wav",
        stat = {
            effect = "healingsickness",
            length = 40,
        },
    },
    hidden = true,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 75,
        ["misc_smallparts"] = 50,
        ["misc_chemical"] = 80,
    },
})