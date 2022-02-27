AS.AddBaseItem("ammo_pistol", {
    name = "Pistol Ammo",
    desc = "Ammunition that is constructed to work in any weapon labeled as a pistol.",
    category = "ammo",
    model = "models/Items/BoxSRounds.mdl",
    value = 5,
    weight = 1,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 15,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 1,
    },
})

AS.AddBaseItem("ammo_smg", {
    name = "SMG Ammo",
    desc = "Ammunition that is constructed to work in any weapon labeled as an SMG.",
    category = "ammo",
    model = "models/Items/BoxMRounds.mdl",
    value = 8,
    weight = 1.25,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 25,
        ["misc_munitionpress"] = 0,
        ["misc_gunpowder"] = 1,
    },
})

AS.AddBaseItem("ammo_rifle", {
    name = "Rifle Ammo",
    desc = "Ammunition that is constructed to work in any weapon labeled as a rifle.",
    category = "ammo",
    model = "models/Items/combine_rifle_cartridge01.mdl",
    value = 15,
    weight = 1.5,
})

AS.AddBaseItem("ammo_shotgun", {
    name = "Shotgun Ammo",
    desc = "Ammunition that is constructed to work in any weapon labeled as a shotgun.",
    category = "ammo",
    model = "models/Items/BoxBuckshot.mdl",
    value = 15,
    weight = 1.5,
})

AS.AddBaseItem("ammo_sniper", {
    name = "Sniper Ammo",
    desc = "Ammunition that is constructed to work in any weapon labeled as a sniper.",
    category = "ammo",
    model = "models/props_lab/box01a.mdl",
    value = 20,
    weight = 1.75,
})