-- ███╗   ███╗███████╗██╗     ███████╗███████╗
-- ████╗ ████║██╔════╝██║     ██╔════╝██╔════╝
-- ██╔████╔██║█████╗  ██║     █████╗  █████╗
-- ██║╚██╔╝██║██╔══╝  ██║     ██╔══╝  ██╔══╝
-- ██║ ╚═╝ ██║███████╗███████╗███████╗███████╗
-- ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝╚══════╝

AS.AddBaseItem("wep_knife", {
    name = "Knife",
    desc = "A crappy old knife that has been sharpened to be usable again.",
    category = "weapon",
    model = "models/weapons/w_knife_ct.mdl",
    wep = "weapon_knife",
    value = 5,
    weight = 1,
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 10,
        ["misc_chemical"] = 5,
    },
})

AS.AddBaseItem("wep_crowbar", {
    name = "Crowbar",
    desc = "Once used as an old repair tool. Now, for ultimate destruction.",
    category = "weapon",
    model = "models/weapons/w_crowbar.mdl",
    wep = "weapon_crowbar",
    value = 5,
    weight = 2,
    class = "scavenger",
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 20,
    },
})

AS.AddBaseItem("wep_stun", {
    name = "Stunstick",
    desc = "A baton that's used to punish misbehaving citizens.",
    category = "weapon",
    model = "models/weapons/w_stunbaton.mdl",
    wep = "weapon_stunstick",
    value = 5,
    weight = 1.9,
    class = "scavenger",
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 20,
        ["misc_electronicparts"] = 1,
    },
})

AS.AddBaseItem("wep_katana", {
    name = "Katana",
    desc = "A very lengthy and well-balanced sword, useful for slashing right through your enemy.",
    category = "weapon",
    model = "models/items/weapons/katana.mdl",
    wep = "weapon_katana",
    value = 5,
    weight = 3.5,
    hidden = true,
    craft = {
        ["misc_scrap"] = 75,
        ["misc_smallparts"] = 50,
        ["misc_chemical"] = 60,
    },
})

-- ██████╗ ██╗███████╗████████╗ ██████╗ ██╗     ███████╗
-- ██╔══██╗██║██╔════╝╚══██╔══╝██╔═══██╗██║     ██╔════╝
-- ██████╔╝██║███████╗   ██║   ██║   ██║██║     ███████╗
-- ██╔═══╝ ██║╚════██║   ██║   ██║   ██║██║     ╚════██║
-- ██║     ██║███████║   ██║   ╚██████╔╝███████╗███████║
-- ╚═╝     ╚═╝╚══════╝   ╚═╝    ╚═════╝ ╚══════╝╚══════╝

AS.AddBaseItem("wep_pm", {
    name = "Makarov",
    desc = "Holds 8 rounds and uses 9x18mm ammo.",
    category = "weapon",
    model = "models/items/weapons/pm.mdl",
    wep = "weapon_pm",
    value = 25,
    weight = 2,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 40,
        ["misc_chemical"] = 35,
    },
})

AS.AddBaseItem("wep_p226", {
    name = "P226",
    desc = "Holds 13 rounds and uses 9x19mm ammo.",
    category = "weapon",
    model = "models/weapons/w_pist_p228.mdl",
    wep = "weapon_p226",
    value = 25,
    weight = 2,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 35,
        ["misc_smallparts"] = 45,
        ["misc_chemical"] = 40,
    },
})

AS.AddBaseItem("wep_glock17", {
    name = "Glock-17",
    desc = "Holds 15 rounds and uses 9x19mm ammo.",
    category = "weapon",
    model = "models/weapons/w_pist_glock18.mdl",
    wep = "weapon_glock",
    value = 25,
    weight = 2,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 40,
        ["misc_smallparts"] = 50,
        ["misc_chemical"] = 45,
    },
})

AS.AddBaseItem("wep_m1911", {
    name = "M1911",
    desc = "Holds 7 rounds and uses .45 ACP ammo.",
    category = "weapon",
    model = "models/items/weapons/m1911.mdl",
    wep = "weapon_m1911",
    value = 30,
    weight = 2.1,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 70,
        ["misc_smallparts"] = 80,
        ["misc_chemical"] = 75,
    },
})

AS.AddBaseItem("wep_ots", {
    name = "OTs-33 Pernach",
    desc = "Holds 21 rounds and uses 9x19mm ammo.",
    category = "weapon",
    model = "models/items/weapons/ots.mdl",
    wep = "weapon_ots33",
    value = 40,
    weight = 2.2,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 70,
        ["misc_smallparts"] = 90,
        ["misc_chemical"] = 70,
    },
})

AS.AddBaseItem("wep_deagle", {
    name = ".50 AE Desert Eagle",
    desc = "Holds 7 rounds and uses .50 Action Express ammo.",
    category = "weapon",
    model = "models/items/weapons/deagle.mdl",
    wep = "weapon_deagle",
    value = 50,
    weight = 3,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 120,
        ["misc_smallparts"] = 125,
        ["misc_chemical"] = 110,
        ["misc_weaponkit"] = 0,
    },
})

AS.AddBaseItem("wep_raging", {
    name = ".44 Raging Bull",
    desc = "Holds 5 rounds and uses .44 Magnum.",
    category = "weapon",
    model = "models/items/weapons/ragingbull.mdl",
    wep = "weapon_revolver",
    value = 55,
    weight = 2.9,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 115,
        ["misc_smallparts"] = 120,
        ["misc_chemical"] = 100,
        ["misc_weaponkit"] = 0,
    },
})

-- ███████╗███╗   ███╗ ██████╗ ███████╗
-- ██╔════╝████╗ ████║██╔════╝ ██╔════╝
-- ███████╗██╔████╔██║██║  ███╗███████╗
-- ╚════██║██║╚██╔╝██║██║   ██║╚════██║
-- ███████║██║ ╚═╝ ██║╚██████╔╝███████║
-- ╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝

AS.AddBaseItem("wep_mp5", {
    name = "MP5A5",
    desc = "Holds 30 rounds and uses 9x19mm ammo.",
    category = "weapon",
    model = "models/items/weapons/mp5.mdl",
    wep = "weapon_mp5",
    value = 100,
    weight = 3.3,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 75,
        ["misc_smallparts"] = 90,
        ["misc_chemical"] = 80,
    },
})

AS.AddBaseItem("wep_bizon", {
    name = "PP-19 Bizon",
    desc = "Holds 64 rounds and uses 9x19mm ammo.",
    category = "weapon",
    model = "models/items/weapons/bizon.mdl",
    wep = "weapon_bizon",
    value = 100,
    weight = 3.8,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 120,
        ["misc_smallparts"] = 100,
        ["misc_chemical"] = 115,
    },
})

AS.AddBaseItem("wep_mac11", {
    name = "Mac-11",
    desc = "Holds 32 rounds and uses .45 ACP ammo.",
    category = "weapon",
    model = "models/items/weapons/mac11.mdl",
    wep = "weapon_baiter",
    value = 100,
    weight = 3,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 70,
        ["misc_smallparts"] = 95,
        ["misc_chemical"] = 90,
    },
})

AS.AddBaseItem("wep_csmg", {
    name = "Model CMG",
    desc = "Holds 25 rounds and uses .45 ACP ammo.",
    category = "weapon",
    model = "models/items/weapons/csmg.mdl",
    wep = "weapon_cmg",
    value = 100,
    weight = 4.2,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 175,
        ["misc_smallparts"] = 190,
        ["misc_chemical"] = 150,
    },
})

-- ██████╗ ██╗███████╗██╗     ███████╗███████╗
-- ██╔══██╗██║██╔════╝██║     ██╔════╝██╔════╝
-- ██████╔╝██║█████╗  ██║     █████╗  ███████╗
-- ██╔══██╗██║██╔══╝  ██║     ██╔══╝  ╚════██║
-- ██║  ██║██║██║     ███████╗███████╗███████║
-- ╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝╚══════╝╚══════╝

AS.AddBaseItem("wep_g36", {
    name = "G36C",
    desc = "Holds 30 rounds and uses 5.56x45mm ammo.",
    category = "weapon",
    model = "models/items/weapons/g36.mdl",
    wep = "weapon_g36c",
    value = 100,
    weight = 4.5,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 115,
        ["misc_smallparts"] = 125,
        ["misc_chemical"] = 100,
    },
})

AS.AddBaseItem("wep_m4a1", {
    name = "M4A1",
    desc = "Holds 30 rounds and uses 5.56x45mm ammo.",
    category = "weapon",
    model = "models/items/weapons/m4a1.mdl",
    wep = "weapon_m4a1",
    value = 100,
    weight = 5,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 210,
        ["misc_smallparts"] = 195,
        ["misc_chemical"] = 180,
    },
})

AS.AddBaseItem("wep_sg550", {
    name = "SG 550",
    desc = "Holds 30 rounds and uses 5.56x45mm ammo.",
    category = "weapon",
    model = "models/items/weapons/sg550.mdl",
    wep = "weapon_sg550",
    value = 100,
    weight = 5.2,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 225,
        ["misc_smallparts"] = 205,
        ["misc_chemical"] = 200,
        ["misc_weaponkit"] = 0,
    },
})

AS.AddBaseItem("wep_ak47", {
    name = "AK-47",
    desc = "Holds 30 rounds and uses 7.62x39mm ammo.",
    category = "weapon",
    model = "models/items/weapons/ak47.mdl",
    wep = "weapon_ak47",
    value = 100,
    weight = 5,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 190,
        ["misc_smallparts"] = 200,
        ["misc_chemical"] = 175,
    },
})

AS.AddBaseItem("wep_sks", {
    name = "SKS",
    desc = "Holds 10 rounds and uses 7.62x39mm ammo.",
    category = "weapon",
    model = "models/items/weapons/sks.mdl",
    wep = "weapon_sks",
    value = 100,
    weight = 4.8,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 180,
        ["misc_smallparts"] = 210,
        ["misc_chemical"] = 180,
    },
})

AS.AddBaseItem("wep_sako", {
    name = "RK-95 Sako",
    desc = "Holds 30 rounds and uses 7.62x39mm ammo.",
    category = "weapon",
    model = "models/items/weapons/sako.mdl",
    wep = "weapon_sako",
    value = 100,
    weight = 6,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 215,
        ["misc_smallparts"] = 200,
        ["misc_chemical"] = 195,
        ["misc_weaponkit"] = 0,
    },
})

AS.AddBaseItem("wep_ak12", {
    name = "AK-12",
    desc = "Holds 30 rounds and uses 7.62x39mm ammo.",
    category = "weapon",
    model = "models/items/weapons/ak12.mdl",
    wep = "weapon_ak12",
    value = 100,
    weight = 6.1,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 235,
        ["misc_smallparts"] = 240,
        ["misc_chemical"] = 210,
        ["misc_weaponkit"] = 0,
    },
})

AS.AddBaseItem("wep_vss", {
    name = "VSS Vintorez",
    desc = "Holds 20 rounds and uses 9x39mm ammo.",
    category = "weapon",
    model = "models/items/weapons/vss.mdl",
    wep = "weapon_vss",
    color = Color( 120, 40, 40 ),
    value = 100,
    weight = 7.5,
    hidden = true,
    craft = {
        ["misc_scrap"] = 350,
        ["misc_smallparts"] = 325,
        ["misc_chemical"] = 300,
    },
})

AS.AddBaseItem("wep_lr300", {
    name = "LR-300",
    desc = "Holds 30 rounds and uses 5.56x45mm ammo.",
    category = "weapon",
    model = "models/items/weapons/lr300.mdl",
    wep = "weapon_lr300",
    color = Color( 120, 40, 40 ),
    value = 100,
    weight = 8,
    hidden = true,
    craft = {
        ["misc_scrap"] = 350,
        ["misc_smallparts"] = 325,
        ["misc_chemical"] = 300,
    },
})

AS.AddBaseItem("wep_ash12", {
    name = "ASH-12",
    desc = "Holds 20 rounds and uses 7.62x51mm ammo.",
    category = "weapon",
    model = "models/items/weapons/ash12.mdl",
    wep = "weapon_ash12",
    color = Color( 120, 40, 40 ),
    value = 100,
    weight = 8,
    hidden = true,
    craft = {
        ["misc_scrap"] = 400,
        ["misc_smallparts"] = 350,
        ["misc_chemical"] = 275,
    },
})

AS.AddBaseItem("wep_pulserifle", {
    name = "Pulse Rifle",
    desc = "Holds 30 charges and uses Pulse Charges.",
    category = "weapon",
    model = "models/weapons/w_irifle.mdl",
    wep = "weapon_pulserifle",
    value = 100,
    weight = 8,
    hidden = true,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 300,
        ["misc_smallparts"] = 275,
        ["misc_chemical"] = 290,
        ["misc_pulsepod"] = 1,
    },
})

-- ███████╗██╗  ██╗ ██████╗ ████████╗ ██████╗ ██╗   ██╗███╗   ██╗███████╗
-- ██╔════╝██║  ██║██╔═══██╗╚══██╔══╝██╔════╝ ██║   ██║████╗  ██║██╔════╝
-- ███████╗███████║██║   ██║   ██║   ██║  ███╗██║   ██║██╔██╗ ██║███████╗
-- ╚════██║██╔══██║██║   ██║   ██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
-- ███████║██║  ██║╚██████╔╝   ██║   ╚██████╔╝╚██████╔╝██║ ╚████║███████║
-- ╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝

AS.AddBaseItem("wep_remington", {
    name = "Remington 870",
    desc = "Holds 8 shells and uses 12-Gauge Buckshot ammo.",
    category = "weapon",
    model = "models/items/weapons/rem870.mdl",
    wep = "weapon_remington",
    value = 100,
    weight = 6.5,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 150,
        ["misc_smallparts"] = 180,
        ["misc_chemical"] = 165,
    },
})

AS.AddBaseItem("wep_ks23", {
    name = "KS-23",
    desc = "Holds 4 shells and uses 12-Gauge Buckshot ammo.",
    category = "weapon",
    model = "models/items/weapons/ks23.mdl",
    wep = "weapon_ks23",
    value = 100,
    weight = 7,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 210,
        ["misc_smallparts"] = 235,
        ["misc_chemical"] = 225,
        ["misc_weaponkit"] = 0,
    },
})

-- ██╗  ██╗███████╗ █████╗ ██╗   ██╗██╗   ██╗
-- ██║  ██║██╔════╝██╔══██╗██║   ██║╚██╗ ██╔╝
-- ███████║█████╗  ███████║██║   ██║ ╚████╔╝
-- ██╔══██║██╔══╝  ██╔══██║╚██╗ ██╔╝  ╚██╔╝
-- ██║  ██║███████╗██║  ██║ ╚████╔╝    ██║
-- ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝  ╚═══╝     ╚═╝

AS.AddBaseItem("wep_rpk", {
    name = "RPK-47",
    desc = "Holds 45 rounds and uses 7.62x39mm ammo.",
    category = "weapon",
    model = "models/items/weapons/rpk.mdl",
    wep = "weapon_rpk",
    value = 100,
    weight = 10,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 280,
        ["misc_smallparts"] = 275,
        ["misc_chemical"] = 300,
        ["misc_weaponkit"] = 0,
    },
})

AS.AddBaseItem("wep_m249", {
    name = "M249",
    desc = "Holds 100 rounds and uses 5.56x45mm ammo.",
    category = "weapon",
    model = "models/items/weapons/m249.mdl",
    wep = "weapon_m249",
    value = 100,
    weight = 12,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 300,
        ["misc_smallparts"] = 315,
        ["misc_chemical"] = 320,
        ["misc_weaponkit"] = 0,
    },
})

AS.AddBaseItem("wep_pulselmg", {
    name = "Pulse LMG",
    desc = "Holds 75 charges and uses Pulse Charges.",
    category = "weapon",
    model = "models/items/weapons/pulselmg.mdl",
    wep = "weapon_pulselmg",
    value = 100,
    weight = 13,
    hidden = true,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 300,
        ["misc_smallparts"] = 215,
        ["misc_chemical"] = 185,
        ["misc_pulsepod"] = 1,
    },
})

-- ███████╗███╗   ██╗██╗██████╗ ███████╗██████╗     ██╗██████╗ ███╗   ███╗██████╗
-- ██╔════╝████╗  ██║██║██╔══██╗██╔════╝██╔══██╗   ██╔╝██╔══██╗████╗ ████║██╔══██╗
-- ███████╗██╔██╗ ██║██║██████╔╝█████╗  ██████╔╝  ██╔╝ ██║  ██║██╔████╔██║██████╔╝
-- ╚════██║██║╚██╗██║██║██╔═══╝ ██╔══╝  ██╔══██╗ ██╔╝  ██║  ██║██║╚██╔╝██║██╔══██╗
-- ███████║██║ ╚████║██║██║     ███████╗██║  ██║██╔╝   ██████╔╝██║ ╚═╝ ██║██║  ██║
-- ╚══════╝╚═╝  ╚═══╝╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝

AS.AddBaseItem("wep_m24", {
    name = "M24",
    desc = "Holds 5 rounds and uses 7.62x51mm ammo.",
    category = "weapon",
    model = "models/items/weapons/m24.mdl",
    wep = "weapon_m24",
    value = 100,
    weight = 6.5,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 210,
        ["misc_smallparts"] = 180,
        ["misc_chemical"] = 200,
        ["misc_weaponkit"] = 0,
    },
})

AS.AddBaseItem("wep_m14", {
    name = "M14",
    desc = "Holds 20 rounds and uses 7.62x51mm ammo.",
    category = "weapon",
    model = "models/items/weapons/m14.mdl",
    wep = "weapon_m14",
    value = 100,
    weight = 6.6,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 220,
        ["misc_smallparts"] = 200,
        ["misc_chemical"] = 215,
        ["misc_weaponkit"] = 0,
    },
})

AS.AddBaseItem("wep_svd", {
    name = "SVD Dragunov",
    desc = "Holds 10 rounds and uses 7.62x51mm ammo.",
    category = "weapon",
    model = "models/items/weapons/svd.mdl",
    wep = "weapon_svd",
    value = 100,
    weight = 7.2,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 225,
        ["misc_smallparts"] = 240,
        ["misc_chemical"] = 250,
        ["misc_weaponkit"] = 0,
    },
})

AS.AddBaseItem("wep_sr25", {
    name = "SR-25",
    desc = "Holds 10 rounds and uses 7.62x51mm ammo.",
    category = "weapon",
    model = "models/items/weapons/sr25.mdl",
    wep = "weapon_sr25",
    value = 100,
    weight = 7.5,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 250,
        ["misc_smallparts"] = 275,
        ["misc_chemical"] = 265,
        ["misc_weaponkit"] = 0,
    },
})

AS.AddBaseItem("wep_pulsesniper", {
    name = "Pulse Sniper",
    desc = "Holds 10 charges and uses Pulse Charges. Consumes 2 charges per shot.",
    category = "weapon",
    model = "models/items/weapons/pulsesniper.mdl",
    wep = "weapon_pulsesniper",
    value = 100,
    weight = 10,
    hidden = true,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 330,
        ["misc_smallparts"] = 325,
        ["misc_chemical"] = 330,
        ["misc_pulsepod"] = 1,
    },
})

AS.AddBaseItem("wep_m82", {
    name = "M82 Barret",
    desc = "Holds 10 rounds and uses .50 BMG ammo. Hearing this gun in town means you should probably run.",
    category = "weapon",
    model = "models/items/weapons/m82.mdl",
    wep = "weapon_m82",
    color = Color( 160, 130, 0 ),
    value = 100,
    weight = 12,
    hidden = true,
    craft = {
        ["misc_scrap"] = 420,
        ["misc_smallparts"] = 380,
        ["misc_chemical"] = 400,
    },
})

-- ███╗   ███╗██╗███████╗ ██████╗███████╗██╗     ██╗      █████╗ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗███████╗
-- ████╗ ████║██║██╔════╝██╔════╝██╔════╝██║     ██║     ██╔══██╗████╗  ██║██╔════╝██╔═══██╗██║   ██║██╔════╝
-- ██╔████╔██║██║███████╗██║     █████╗  ██║     ██║     ███████║██╔██╗ ██║█████╗  ██║   ██║██║   ██║███████╗
-- ██║╚██╔╝██║██║╚════██║██║     ██╔══╝  ██║     ██║     ██╔══██║██║╚██╗██║██╔══╝  ██║   ██║██║   ██║╚════██║
-- ██║ ╚═╝ ██║██║███████║╚██████╗███████╗███████╗███████╗██║  ██║██║ ╚████║███████╗╚██████╔╝╚██████╔╝███████║
-- ╚═╝     ╚═╝╚═╝╚══════╝ ╚═════╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝ ╚═════╝  ╚═════╝ ╚══════╝

AS.AddBaseItem("wep_gl", {
    name = "M79 Grenade Launcher",
    desc = "A useful break-action grenade launcher. Uses .40MM HE Grenades.",
    category = "weapon",
    model = "models/items/weapons/m79.mdl",
    wep = "weapon_grenadelauncher",
    value = 80,
    weight = 4.5,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 190,
        ["misc_smallparts"] = 185,
        ["misc_chemical"] = 170,
    },
})

AS.AddBaseItem("wep_keypadcracker", {
    name = "Keypad Cracker",
    desc = "A tool that allows you to hack keypads in order to bypass their security features.",
    category = "weapon",
    model = "models/weapons/w_c4.mdl",
    wep = "weapon_keypadcracker",
    value = 80,
    weight = 2,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 40,
        ["misc_smallparts"] = 50,
        ["misc_chemical"] = 25,
        ["misc_electronicparts"] = 1,
    },
})

AS.AddBaseItem("wep_lockpick", {
    name = "Lockpick",
    desc = "A tool that allows you to force open doors that are locked.",
    category = "weapon",
    model = "models/props_c17/TrapPropeller_Lever.mdl",
    wep = "weapon_lockpick",
    value = 80,
    weight = 1.5,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 50,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 20,
        ["misc_multitool"] = 0,
    },
})

AS.AddBaseItem("wep_breach", {
    name = "Breaching Charge",
    desc = "A charge that allows you to blast a door off its hinges.",
    category = "weapon",
    model = "models/weapons/w_slam.mdl",
    wep = "weapon_breach",
    value = 80,
    weight = 2,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 80,
        ["misc_smallparts"] = 40,
        ["misc_chemical"] = 60,
        ["misc_gunpowder"] = 2,
    },
})

AS.AddBaseItem("wep_defib", {
    name = "Defibrillator",
    desc = "A defibrillation kit. Useful for reviving dead allies.",
    category = "weapon",
    model = "models/weapons/w_defuser.mdl",
    wep = "weapon_defib",
    value = 80,
    weight = 2,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 150,
        ["misc_smallparts"] = 80,
        ["misc_chemical"] = 120,
        ["misc_electronicparts"] = 2,
    },
})