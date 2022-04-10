AS.AddBaseItem("ammo_9mm", {
    name = "9x19mm",
    desc = "40 rounds of 9x19mm ammunition. Used mainly in pistols and a couple SMGs.",
    category = "ammo",
    model = "models/items/ammo/9mmbox.mdl",
    value = 5,
    weight = 0.4,
    use = {
        ammotype = "pistol",
        ammoamt = 40,
    },
    class = "engineer",
    craft = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 10,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 1,
    },
})

AS.AddBaseItem("ammo_45acp", {
    name = ".45 ACP",
    desc = "40 rounds of .45 ACP ammunition. Used in the M1911 and Mac11.",
    category = "ammo",
    model = "models/items/ammo/45acpbox.mdl",
    value = 10,
    weight = 0.4,
    use = {
        ammotype = "AlyxGun",
        ammoamt = 40,
    },
    class = "engineer",
    craft = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 20,
        ["misc_chemical"] = 10,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 1,
    },
})

AS.AddBaseItem("ammo_44", {
    name = ".44 Magnum",
    desc = "20 rounds of .44 Magnum, a powerful cartridge. Used in the Raging Bull.",
    category = "ammo",
    model = "models/items/ammo/44magbox.mdl",
    value = 15,
    weight = 0.6,
    use = {
        ammotype = "357",
        ammoamt = 20,
    },
    class = "engineer",
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 20,
        ["misc_chemical"] = 15,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 1,
    },
})

AS.AddBaseItem("ammo_50ae", {
    name = ".50 Action Express",
    desc = "20 rounds of .50 AE, a very strong bullet. Used in the Desert Eagle.",
    category = "ammo",
    model = "models/Items/357ammobox.mdl",
    value = 15,
    weight = 0.6,
    use = {
        ammotype = "CombineHeavyCannon",
        ammoamt = 20,
    },
    class = "engineer",
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 20,
        ["misc_chemical"] = 20,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 1,
    },
})

AS.AddBaseItem("ammo_buckshot", {
    name = "12-Gauge Buckshot",
    desc = "20 shells of 12-Gauge Buckshot. Blast your enemies away. Used in Shotguns.",
    category = "ammo",
    model = "models/Items/BoxBuckshot.mdl",
    value = 20,
    weight = 1,
    use = {
        ammotype = "buckshot",
        ammoamt = 20,
    },
    class = "engineer",
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 20,
        ["misc_chemical"] = 20,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 2,
    },
})

AS.AddBaseItem("ammo_762x39", {
    name = "7.62x39mm",
    desc = "60 rounds of 7.62x39mm. Commonly used in rifles.",
    category = "ammo",
    model = "models/items/ammo/762x39box.mdl",
    value = 15,
    weight = 0.8,
    use = {
        ammotype = "smg1",
        ammoamt = 60,
    },
    class = "engineer",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 20,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 1,
    },
})

AS.AddBaseItem("ammo_556x45", {
    name = "5.56x45mm",
    desc = "75 rounds of 5.56x45mm. Commonly used in rifles.",
    category = "ammo",
    model = "models/Items/BoxMRounds.mdl",
    value = 15,
    weight = 1,
    use = {
        ammotype = "ar2",
        ammoamt = 75,
    },
    class = "engineer",
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 20,
        ["misc_chemical"] = 15,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 1,
    },
})

AS.AddBaseItem("ammo_762x51", {
    name = "7.62x51mm",
    desc = "20 rounds of 7.62x51mm. Commonly used in snipers and other heavy weaponry.",
    category = "ammo",
    model = "models/Items/BoxSRounds.mdl",
    value = 25,
    weight = 1,
    use = {
        ammotype = "sniperround",
        ammoamt = 20,
    },
    class = "engineer",
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 25,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 2,
    },
})

AS.AddBaseItem("ammo_50bmg", {
    name = ".50 BMG",
    desc = "20 rounds of .50 BMG. A round of this size and potential power doesn't even need to hit someone to kill them. Used in the M82 Barret.",
    category = "ammo",
    model = "models/items/ammo/50bmgbox.mdl",
    color = Color( 120, 40, 40 ),
    value = 40,
    weight = 1,
    use = {
        ammotype = "sniperpenetratedround",
        ammoamt = 20,
    },
    class = "engineer",
    craft = {
        ["misc_scrap"] = 30,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 40,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 3,
    },
})

AS.AddBaseItem("ammo_gl", {
    name = "40mm HE",
    desc = "A single shell of a 40mm High Explosive. Use it wisely.",
    category = "ammo",
    model = "models/items/ar2_grenade.mdl",
    value = 25,
    weight = 1,
    use = {
        ammotype = "SMG1_Grenade",
        ammoamt = 1,
    },
    class = "engineer",
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 20,
        ["misc_chemical"] = 30,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 2,
    },
})