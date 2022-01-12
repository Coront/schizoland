AS.AddBaseItem("med_hydrogen", {
    name = "Bottle of Hydrogen Peroxide",
    desc = "A bottle that contains H2O2, or hydrogren peroxide, which is good for preventing minor cuts, scrapes, or burns from becoming infected.",
    model = "models/props_junk/glassjug01.mdl",
    value = 5,
    weight = 1,
    use = {
        health = 2,
        sound = "ambient/water/water_spray1.wav",
    },
})

AS.AddBaseItem("med_isopropyl", {
    name = "Bottle of Isopropyl Alcohol",
    desc = "A bottle that contains C3H8O, or Isopropyl Alcohol, which is good as a rubbing alcohol, and to stop minor cuts from becoming infected.",
    model = "models/props_junk/glassjug01.mdl",
    color = Color( 50, 100, 0 ),
    value = 5,
    weight = 1,
    use = {
        health = 2,
        sound = "ambient/water/water_spray1.wav",
    },
})

AS.AddBaseItem("med_vial", {
    name = "Health Vial",
    desc = "A vial that contains a strange green liquid that will heal some of your health back.",
    model = "models/healthvial.mdl",
    value = 15,
    weight = 1.5,
    use = {
        health = 5,
        sound = "items/medshot4.wav",
    },
})

AS.AddBaseItem("med_kit", {
    name = "Medical Kit",
    desc = "A kit that contains some of that strange green liquid and a bunch of other necessities to help recover from wounds.",
    model = "models/Items/HealthKit.mdl",
    color = Color( 50, 100, 0 ),
    value = 25,
    weight = 2.5,
    use = {
        health = 10,
        sound = "items/smallmedkit1.wav",
    }
})