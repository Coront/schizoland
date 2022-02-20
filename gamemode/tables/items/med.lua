AS.AddBaseItem("med_vial", {
    name = "Health Vial",
    desc = "A vial that contains a strange green liquid that will heal some of your health back.",
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
    model = "models/Items/HealthKit.mdl",
    color = Color( 50, 100, 0 ),
    value = 25,
    weight = 2.5,
    use = {
        health = 25,
        sound = "items/smallmedkit1.wav",
    }
})