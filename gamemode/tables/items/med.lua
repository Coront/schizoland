AS.AddBaseItem("med_bag", {
    name = "Bag of Medical Supplies",
    desc = "An old garbage bag that contains some bandages, a potential tourniquet, and maybe a few other things to help with your personal health.",
    category = "med",
    model = "models/props_junk/garbage_bag001a.mdl",
    value = 1,
    weight = 0.4,
    use = {
        health = 15,
        sound = "physics/body/body_medium_impact_soft4.wav",
    },
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 35,
    },
})

AS.AddBaseItem("med_vial", {
    name = "Health Vial",
    desc = "A vial that contains a strange green liquid that will heal some of your health back.",
    category = "med",
    model = "models/healthvial.mdl",
    value = 15,
    weight = 1.5,
    use = {
        health = 15,
        sound = "items/medshot4.wav",
    },
})

AS.AddBaseItem("med_kit", {
    name = "Medical Kit",
    desc = "A kit that contains some of that strange green liquid and a bunch of other necessities to help recover from wounds.",
    category = "med",
    model = "models/Items/HealthKit.mdl",
    color = Color( 50, 100, 0 ),
    value = 25,
    weight = 2.5,
    use = {
        health = 25,
        sound = "items/smallmedkit1.wav",
    }
})