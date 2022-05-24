AS.AddBaseItem("ammo_9mm", {
    name = "9x19mm",
    desc = "A box with 40 rounds of 9x19mm ammunition.",
    category = "ammo",
    model = "models/items/ammo/9mmbox.mdl",
    value = 5,
    weight = 0.5,
    use = {
        ammotype = "pistol",
        ammoamt = 40,
    },
    class = "engineer",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 10,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 1,
    },
})

AS.AddBaseItem("ammo_45acp", {
    name = ".45 ACP",
    desc = "A box with 40 rounds of .45 ACP ammunition.",
    category = "ammo",
    model = "models/items/ammo/45acpbox.mdl",
    value = 10,
    weight = 0.6,
    use = {
        ammotype = "AlyxGun",
        ammoamt = 40,
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 15,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 1,
    },
})

AS.AddBaseItem("ammo_44mag", {
    name = ".44 Magnum",
    desc = "A box with 20 rounds of .44 Magnum.",
    category = "ammo",
    model = "models/items/ammo/44magbox.mdl",
    value = 15,
    weight = 0.75,
    use = {
        ammotype = "357",
        ammoamt = 20,
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 20,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 1,
    },
})

AS.AddBaseItem("ammo_50ae", {
    name = ".50 Action Express",
    desc = "A box with 20 rounds of .50 Action Express.",
    category = "ammo",
    model = "models/Items/357ammobox.mdl",
    value = 15,
    weight = 0.75,
    use = {
        ammotype = "CombineHeavyCannon",
        ammoamt = 20,
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 20,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 1,
    },
})

AS.AddBaseItem("ammo_buckshot", {
    name = "12-Gauge Buckshot",
    desc = "A box with 20 shells of 12-Gauge Buckshot.",
    category = "ammo",
    model = "models/Items/BoxBuckshot.mdl",
    value = 20,
    weight = 1,
    use = {
        ammotype = "buckshot",
        ammoamt = 20,
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 20,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 2,
    },
})

AS.AddBaseItem("ammo_762x39", {
    name = "7.62x39mm",
    desc = "A box with 60 rounds of 7.62x39mm ammunition.",
    category = "ammo",
    model = "models/items/ammo/762x39box.mdl",
    value = 15,
    weight = 1,
    use = {
        ammotype = "smg1",
        ammoamt = 60,
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 15,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 1,
    },
})

AS.AddBaseItem("ammo_556x45", {
    name = "5.56x45mm",
    desc = "A box with 75 rounds of 5.56x39mm ammunition.",
    category = "ammo",
    model = "models/Items/BoxMRounds.mdl",
    value = 15,
    weight = 1,
    use = {
        ammotype = "ar2",
        ammoamt = 75,
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 15,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 1,
    },
})

AS.AddBaseItem("ammo_pulse", {
    name = "Pulse Battery",
    desc = "A battery with 50 pulse charges.",
    category = "ammo",
    model = "models/Items/combine_rifle_cartridge01.mdl",
    value = 20,
    weight = 1.5,
    use = {
        ammotype = "striderminigun",
        ammoamt = 50,
    },
    hidden = true,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 20,
    },
})

AS.AddBaseItem("ammo_762x51", {
    name = "7.62x51mm",
    desc = "A box with 20 rounds of 7.62x51mm ammunition.",
    category = "ammo",
    model = "models/Items/BoxSRounds.mdl",
    value = 25,
    weight = 1.5,
    use = {
        ammotype = "sniperround",
        ammoamt = 20,
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 25,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 2,
    },
})

AS.AddBaseItem("ammo_50bmg", {
    name = ".50 BMG",
    desc = "A box with 20 rounds of .50 BMG.",
    category = "ammo",
    model = "models/items/ammo/50bmgbox.mdl",
    color = Color( 120, 40, 40 ),
    value = 40,
    weight = 2.5,
    use = {
        ammotype = "sniperpenetratedround",
        ammoamt = 20,
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 35,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 30,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 3,
    },
})

AS.AddBaseItem("ammo_gl", {
    name = "40mm HE",
    desc = "A single 40mm High Explosive, impact-action.",
    category = "ammo",
    model = "models/items/ar2_grenade.mdl",
    value = 25,
    weight = 1.5,
    use = {
        ammotype = "SMG1_Grenade",
        ammoamt = 1,
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 20,
        ["misc_gunpowder"] = 3,
    },
})