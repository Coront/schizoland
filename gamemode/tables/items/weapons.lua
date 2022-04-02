-- ███╗   ███╗███████╗██╗     ███████╗███████╗
-- ████╗ ████║██╔════╝██║     ██╔════╝██╔════╝
-- ██╔████╔██║█████╗  ██║     █████╗  █████╗
-- ██║╚██╔╝██║██╔══╝  ██║     ██╔══╝  ██╔══╝
-- ██║ ╚═╝ ██║███████╗███████╗███████╗███████╗
-- ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝╚══════╝

AS.AddBaseItem("wep_knife", {
    name = "Knife",
    desc = "A small knife that has been sharpened recently. Useful for defending yourself against simple threats.",
    category = "weapon",
    model = "models/weapons/w_knife_t.mdl",
    wep = "weapon_knife",
    value = 5,
    weight = 0.3,
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 10,
        ["misc_chemical"] = 5,
    },
    salvage = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 3,
        ["misc_chemical"] = 2,
    },
})

AS.AddBaseItem("wep_crowbar", {
    name = "Crowbar",
    desc = "A lengthy piece of metal, once used as a repair tool. Now, for ultimate destruction.",
    category = "weapon",
    model = "models/weapons/w_crowbar.mdl",
    wep = "weapon_crowbar",
    value = 10,
    weight = 0.75,
    class = "scavenger",
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 15,
    },
    salvage = {
        ["misc_scrap"] = 8,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 5,
    },
})

-- ██████╗ ██╗███████╗████████╗ ██████╗ ██╗     ███████╗
-- ██╔══██╗██║██╔════╝╚══██╔══╝██╔═══██╗██║     ██╔════╝
-- ██████╔╝██║███████╗   ██║   ██║   ██║██║     ███████╗
-- ██╔═══╝ ██║╚════██║   ██║   ██║   ██║██║     ╚════██║
-- ██║     ██║███████║   ██║   ╚██████╔╝███████╗███████║
-- ╚═╝     ╚═╝╚══════╝   ╚═╝    ╚═════╝ ╚══════╝╚══════╝

AS.AddBaseItem("wep_peashooter", {
    name = "Peashooter",
    desc = "A small pistol that holds 18 rounds and can shoot an above moderate rate. Deals less than average damage. Uses pistol ammo.",
    category = "weapon",
    model = "models/weapons/w_pistol.mdl",
    wep = "weapon_peashooter",
    value = 25,
    weight = 0.8,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 35,
        ["misc_smallparts"] = 45,
        ["misc_chemical"] = 30,
    },
    salvage = {
        ["misc_scrap"] = 12,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 10,
    },
})

AS.AddBaseItem("wep_p228", {
    name = "P228",
    desc = "A small pistol that holds 13 rounds and shoots at a moderate rate. Deals average damage. Uses pistol ammo.",
    category = "weapon",
    model = "models/weapons/w_pist_p228.mdl",
    wep = "weapon_p228",
    value = 30,
    weight = 0.8,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 45,
        ["misc_smallparts"] = 60,
        ["misc_chemical"] = 30,
    },
    salvage = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 20,
        ["misc_chemical"] = 10,
    },
})

AS.AddBaseItem("wep_magnum", {
    name = "Magnum",
    desc = "A large magnum that holds 6 rounds and shoots at a slow rate. Deals above average damage. Uses pistol ammo.",
    category = "weapon",
    model = "models/weapons/w_357.mdl",
    wep = "weapon_revolver",
    value = 100,
    weight = 1.8,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 120,
        ["misc_smallparts"] = 150,
        ["misc_chemical"] = 60,
    },
    salvage = {
        ["misc_scrap"] = 40,
        ["misc_smallparts"] = 50,
        ["misc_chemical"] = 20,
    },
})

AS.AddBaseItem("wep_deagle", {
    name = ".50 AE Desert Eagle",
    desc = "A large and heavy handcannon that holds 7 rounds and shoots at a very slow rate. Deals a significant amount of damage. Uses pistol ammo.",
    category = "weapon",
    model = "models/weapons/w_pist_deagle.mdl",
    wep = "weapon_deagle",
    value = 120,
    weight = 2.1,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 150,
        ["misc_smallparts"] = 180,
        ["misc_chemical"] = 100,
    },
    salvage = {
        ["misc_scrap"] = 50,
        ["misc_smallparts"] = 60,
        ["misc_chemical"] = 33,
    },
})

-- ███████╗███╗   ███╗ ██████╗ ███████╗
-- ██╔════╝████╗ ████║██╔════╝ ██╔════╝
-- ███████╗██╔████╔██║██║  ███╗███████╗
-- ╚════██║██║╚██╔╝██║██║   ██║╚════██║
-- ███████║██║ ╚═╝ ██║╚██████╔╝███████║
-- ╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝

AS.AddBaseItem("wep_mp7", {
    name = "MP7",
    desc = "A medium sized SMG that holds 30 rounds and shoots fast. Deals below average damage. Uses SMG ammo.",
    category = "weapon",
    model = "models/weapons/w_smg1.mdl",
    wep = "weapon_mp7",
    value = 50,
    weight = 2,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 90,
        ["misc_smallparts"] = 130,
        ["misc_chemical"] = 125,
    },
    salvage = {
        ["misc_scrap"] = 30,
        ["misc_smallparts"] = 43,
        ["misc_chemical"] = 42,
    },
})

AS.AddBaseItem("wep_mp5", {
    name = "MP5",
    desc = "A medium sized SMG that holds 30 rounds and shoots fast. Deals average damage. Uses SMG ammo.",
    category = "weapon",
    model = "models/weapons/w_smg_mp5.mdl",
    wep = "weapon_mp5",
    value = 50,
    weight = 2.3,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 120,
        ["misc_smallparts"] = 130,
        ["misc_chemical"] = 125,
    },
    salvage = {
        ["misc_scrap"] = 40,
        ["misc_smallparts"] = 43,
        ["misc_chemical"] = 42,
    },
})

AS.AddBaseItem("wep_mac", {
    name = "Mac-10",
    desc = "A compact SMG that holds 30 rounds and shoots extremely fast. Deals less than average damage. Uses SMG ammo.",
    category = "weapon",
    model = "models/weapons/w_smg_mac10.mdl",
    wep = "weapon_mac10",
    value = 65,
    weight = 1.9,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 120,
        ["misc_smallparts"] = 210,
        ["misc_chemical"] = 130,
    },
    salvage = {
        ["misc_scrap"] = 40,
        ["misc_smallparts"] = 70,
        ["misc_chemical"] = 43,
    },
})

-- ██████╗ ██╗███████╗██╗     ███████╗███████╗
-- ██╔══██╗██║██╔════╝██║     ██╔════╝██╔════╝
-- ██████╔╝██║█████╗  ██║     █████╗  ███████╗
-- ██╔══██╗██║██╔══╝  ██║     ██╔══╝  ╚════██║
-- ██║  ██║██║██║     ███████╗███████╗███████║
-- ╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝╚══════╝╚══════╝

AS.AddBaseItem("wep_m4a1", {
    name = "M4A1",
    desc = "An average sized rifle that holds 30 rounds and shoots at an above moderate rate. Deals slightly above average damage. Uses rifle ammo.",
    category = "weapon",
    model = "models/weapons/w_rif_m4a1.mdl",
    wep = "weapon_m4a1",
    value = 80,
    weight = 2.6,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 160,
        ["misc_smallparts"] = 210,
        ["misc_chemical"] = 150,
    },
    salvage = {
        ["misc_scrap"] = 53,
        ["misc_smallparts"] = 70,
        ["misc_chemical"] = 50,
    },
})

AS.AddBaseItem("wep_ak47", {
    name = "AK-47",
    desc = "An average sized rifle that holds 30 rounds and shoots at a moderate rate. Deals above average damage. Uses rifle ammo.",
    category = "weapon",
    model = "models/weapons/w_rif_ak47.mdl",
    value = 80,
    weight = 2.7,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 180,
        ["misc_smallparts"] = 190,
        ["misc_chemical"] = 140,
    },
    salvage = {
        ["misc_scrap"] = 60,
        ["misc_smallparts"] = 63,
        ["misc_chemical"] = 47,
    },
})
AS.AddBaseItem("wep_sg552", {
    name = "SG-552",
    desc = "An average sized rifle that holds 30 rounds and shoots at a moderate rate. Deals slightly above average damage. Has an attached scope for sighting. Uses rifle ammo.",
    category = "weapon",
    model = "models/weapons/w_rif_sg552.mdl",
    wep = "weapon_sg552",
    value = 100,
    weight = 2.5,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 210,
        ["misc_smallparts"] = 250,
        ["misc_chemical"] = 150,
    },
    salvage = {
        ["misc_scrap"] = 70,
        ["misc_smallparts"] = 83,
        ["misc_chemical"] = 50,
    },
})

AS.AddBaseItem("wep_aug", {
    name = "Steyr AUG",
    desc = "An average sized rifle that holds 30 rounds and shoots at a moderate rate. Deals slightly above average damage. Has an attached scope for sighting. Uses rifle ammo.",
    category = "weapon",
    model = "models/weapons/w_rif_aug.mdl",
    wep = "weapon_aug",
    value = 100,
    weight = 2.7,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 200,
        ["misc_smallparts"] = 260,
        ["misc_chemical"] = 170,
    },
    salvage = {
        ["misc_scrap"] = 67,
        ["misc_smallparts"] = 87,
        ["misc_chemical"] = 57,
    },
})

AS.AddBaseItem("wep_pulserifle", {
    name = "Pulse Rifle",
    desc = "A large rifle that holds 30 shots per charge and shoots at an above moderate rate. Deals above average damage. Uses pulse charges.",
    category = "weapon",
    model = "models/weapons/w_irifle.mdl",
    wep = "weapon_pulserifle",
    value = 250,
    weight = 3,
    hidden = true,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 300,
        ["misc_smallparts"] = 200,
        ["misc_chemical"] = 280,
        ["misc_pulsepod"] = 1,
    },
    salvage = {
        ["misc_scrap"] = 100,
        ["misc_smallparts"] = 67,
        ["misc_chemical"] = 93,
    },
})

-- ███████╗██╗  ██╗ ██████╗ ████████╗ ██████╗ ██╗   ██╗███╗   ██╗███████╗
-- ██╔════╝██║  ██║██╔═══██╗╚══██╔══╝██╔════╝ ██║   ██║████╗  ██║██╔════╝
-- ███████╗███████║██║   ██║   ██║   ██║  ███╗██║   ██║██╔██╗ ██║███████╗
-- ╚════██║██╔══██║██║   ██║   ██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
-- ███████║██║  ██║╚██████╔╝   ██║   ╚██████╔╝╚██████╔╝██║ ╚████║███████║
-- ╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝

AS.AddBaseItem("wep_m3super", {
    name = "M3 Super 90",
    desc = "A large shotgun that holds 8 rounds and shoots at a pump-action rate. Deals significant amounts of damage. Uses shotgun ammo.",
    category = "weapon",
    model = "models/weapons/w_shot_m3super90.mdl",
    wep = "weapon_m3super",
    value = 80,
    weight = 2.9,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 230,
        ["misc_smallparts"] = 180,
        ["misc_chemical"] = 280,
    },
    salvage = {
        ["misc_scrap"] = 77,
        ["misc_smallparts"] = 60,
        ["misc_chemical"] = 93,
    },
})

AS.AddBaseItem("wep_xm1014", {
    name = "XM1014",
    desc = "A large shotgun that holds 8 rounds and shoots at a moderate rate. Deals significant amounts of damage. Uses shotgun ammo.",
    category = "weapon",
    model = "models/weapons/w_shot_xm1014.mdl",
    wep = "weapon_xm",
    value = 100,
    weight = 2.9,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 250,
        ["misc_smallparts"] = 200,
        ["misc_chemical"] = 300,
    },
    salvage = {
        ["misc_scrap"] = 83,
        ["misc_smallparts"] = 67,
        ["misc_chemical"] = 100,
    },
})

AS.AddBaseItem("wep_spas", {
    name = "SPAS-12",
    desc = "A large shotgun that holds 8 rounds and shoots very fast. Deals large amounts of damage. Uses shotgun ammo.",
    category = "weapon",
    model = "models/weapons/w_shotgun.mdl",
    color = Color( 120, 40, 40 ),
    wep = "weapon_spas",
    value = 150,
    weight = 2.8,
    salvage = {
        ["misc_scrap"] = 90,
        ["misc_smallparts"] = 100,
        ["misc_chemical"] = 120,
    },
})

-- ██╗     ███╗   ███╗ ██████╗ ███████╗
-- ██║     ████╗ ████║██╔════╝ ██╔════╝
-- ██║     ██╔████╔██║██║  ███╗███████╗
-- ██║     ██║╚██╔╝██║██║   ██║╚════██║
-- ███████╗██║ ╚═╝ ██║╚██████╔╝███████║
-- ╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝

AS.AddBaseItem("wep_m249", {
    name = "M249",
    desc = "A light machine gun that holds 100 rounds and shoots very fast. Deals average damage. Uses rifle ammo.",
    category = "weapon",
    model = "models/weapons/w_mach_m249para.mdl",
    wep = "weapon_m249",
    value = 200,
    weight = 4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 350,
        ["misc_smallparts"] = 300,
        ["misc_chemical"] = 285,
    },
    salvage = {
        ["misc_scrap"] = 117,
        ["misc_smallparts"] = 100,
        ["misc_chemical"] = 95,
    },
})

-- ███████╗███╗   ██╗██╗██████╗ ███████╗██████╗ ███████╗
-- ██╔════╝████╗  ██║██║██╔══██╗██╔════╝██╔══██╗██╔════╝
-- ███████╗██╔██╗ ██║██║██████╔╝█████╗  ██████╔╝███████╗
-- ╚════██║██║╚██╗██║██║██╔═══╝ ██╔══╝  ██╔══██╗╚════██║
-- ███████║██║ ╚████║██║██║     ███████╗██║  ██║███████║
-- ╚══════╝╚═╝  ╚═══╝╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝

AS.AddBaseItem("wep_scout", {
    name = "Scout",
    desc = "A very light sniper rifle that holds 10 rounds and shoots at a bolt-action rate. Deals above average damage. Has an attached scope for sighting. Uses sniper ammo.",
    category = "weapon",
    model = "models/weapons/w_snip_scout.mdl",
    wep = "weapon_scout",
    value = 125,
    weight = 2.6,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 220,
        ["misc_smallparts"] = 240,
        ["misc_chemical"] = 175,
    },
    salvage = {
        ["misc_scrap"] = 73,
        ["misc_smallparts"] = 80,
        ["misc_chemical"] = 58,
    },
})

AS.AddBaseItem("wep_g3sg1", {
    name = "G3SG1",
    desc = "A heavy sniper rifle that holds 10 rounds and shoots at a slow rate. Deals above average damage. Has an attached scope for sighting. Uses sniper ammo.",
    category = "weapon",
    model = "models/weapons/w_snip_g3sg1.mdl",
    color = Color( 120, 40, 40 ),
    value = 180,
    weight = 3.1,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 250,
        ["misc_smallparts"] = 275,
        ["misc_chemical"] = 200,
    },
    salvage = {
        ["misc_scrap"] = 83,
        ["misc_smallparts"] = 92,
        ["misc_chemical"] = 67,
    },
})

AS.AddBaseItem("wep_sg550", {
    name = "SG-550",
    desc = "A heavy sniper rifle that holds 20 rounds and shoots at a medium rate. Deals average damage. Has an attached scope for sighting. Uses sniper ammo.",
    category = "weapon",
    model = "models/weapons/w_snip_sg550.mdl",
    color = Color( 120, 40, 40 ),
    value = 180,
    weight = 3,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 280,
        ["misc_smallparts"] = 245,
        ["misc_chemical"] = 210,
    },
    salvage = {
        ["misc_scrap"] = 93,
        ["misc_smallparts"] = 82,
        ["misc_chemical"] = 70,
    },
})

AS.AddBaseItem("wep_awp", {
    name = "AWP",
    desc = "A very rare and heavy sniper rifle that holds 10 rounds and shoots at very slow bolt-action rate. Deals significant amounts of damage. Uses sniper ammo.",
    category = "weapon",
    model = "models/weapons/w_snip_awp.mdl",
    color = Color( 150, 120, 60 ),
    wep = "weapon_awp",
    value = 500,
    weight = 3.9,
    salvage = {
        ["misc_scrap"] = 200,
        ["misc_smallparts"] = 250,
        ["misc_chemical"] = 225,
    },
})

-- ███╗   ███╗██╗███████╗ ██████╗
-- ████╗ ████║██║██╔════╝██╔════╝
-- ██╔████╔██║██║███████╗██║
-- ██║╚██╔╝██║██║╚════██║██║
-- ██║ ╚═╝ ██║██║███████║╚██████╗
-- ╚═╝     ╚═╝╚═╝╚══════╝ ╚═════╝

AS.AddBaseItem("wep_grenade", {
    name = "Grenade",
    desc = "A high-explosive grenade that has a fuse of around 3 seconds after being thrown.",
    category = "weapon",
    model = "models/weapons/w_grenade.mdl",
    wep = "weapon_grenade",
    value = 15,
    weight = 1,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 50,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 40,
        ["misc_gunpowder"] = 1,
    },
})

AS.AddBaseItem("wep_breach", {
    name = "Breaching Charge",
    desc = "A charge that contains explosives, strong enough to bust through doors. Useful to place on Antlion nests if you prefer to save time.",
    category = "weapon",
    model = "models/weapons/w_slam.mdl",
    value = 15,
    weight = 1,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 85,
        ["misc_smallparts"] = 50,
        ["misc_chemical"] = 60,
        ["misc_gunpowder"] = 2,
    },
})