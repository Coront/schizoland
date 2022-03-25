AS.AddBaseItem("ammo_pistol", {
    name = "Pistol Ammo",
    desc = "Ammunition that is constructed to work in any weapon labeled as a pistol.",
    category = "ammo",
    model = "models/Items/BoxSRounds.mdl",
    value = 5,
    weight = 1,
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
    salvage = {
        ["misc_scrap"] = 2,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 3,
    },
})

AS.AddBaseItem("ammo_smg", {
    name = "SMG Ammo",
    desc = "Ammunition that is constructed to work in any weapon labeled as an SMG.",
    category = "ammo",
    model = "models/Items/BoxMRounds.mdl",
    value = 10,
    weight = 1,
    use = {
        ammotype = "smg1",
        ammoamt = 75,
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 20,
        ["misc_chemical"] = 15,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 1,
    },
    salvage = {
        ["misc_scrap"] = 3,
        ["misc_smallparts"] = 7,
        ["misc_chemical"] = 5,
    },
})

AS.AddBaseItem("ammo_rifle", {
    name = "Rifle Ammo",
    desc = "Ammunition that is constructed to work in any weapon labeled as a rifle.",
    category = "ammo",
    model = "models/Items/combine_rifle_cartridge01.mdl",
    value = 15,
    weight = 1.2,
    use = {
        ammotype = "ar2",
        ammoamt = 60,
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 20,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 1,
    },
    salvage = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 8,
        ["misc_chemical"] = 7,
    },
})

AS.AddBaseItem("ammo_shotgun", {
    name = "Shotgun Ammo",
    desc = "Ammunition that is constructed to work in any weapon labeled as a shotgun.",
    category = "ammo",
    model = "models/Items/BoxBuckshot.mdl",
    value = 20,
    weight = 1.5,
    use = {
        ammotype = "buckshot",
        ammoamt = 20,
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 20,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 2,
    },
    salvage = {
        ["misc_scrap"] = 7,
        ["misc_smallparts"] = 8,
        ["misc_chemical"] = 7,
    },
})

AS.AddBaseItem("ammo_sniper", {
    name = "Sniper Ammo",
    desc = "Ammunition that is constructed to work in any weapon labeled as a sniper.",
    category = "ammo",
    model = "models/props_lab/box01a.mdl",
    value = 20,
    weight = 1.5,
    use = {
        ammotype = "sniperround",
        ammoamt = 20,
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 25,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 2,
    },
    salvage = {
        ["misc_scrap"] = 7,
        ["misc_smallparts"] = 10,
        ["misc_chemical"] = 8,
    },
})