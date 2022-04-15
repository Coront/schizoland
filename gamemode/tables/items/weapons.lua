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
})

-- ██████╗ ██╗███████╗████████╗ ██████╗ ██╗     ███████╗
-- ██╔══██╗██║██╔════╝╚══██╔══╝██╔═══██╗██║     ██╔════╝
-- ██████╔╝██║███████╗   ██║   ██║   ██║██║     ███████╗
-- ██╔═══╝ ██║╚════██║   ██║   ██║   ██║██║     ╚════██║
-- ██║     ██║███████║   ██║   ╚██████╔╝███████╗███████║
-- ╚═╝     ╚═╝╚══════╝   ╚═╝    ╚═════╝ ╚══════╝╚══════╝

AS.AddBaseItem("wep_p226", {
    name = "P226",
    desc = "A pistol that holds 13 rounds. Uses 9x19mm ammunition.",
    category = "weapon",
    model = "models/weapons/w_pist_p228.mdl",
    wep = "weapon_p226",
    value = 25,
    weight = 0.8,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 35,
        ["misc_smallparts"] = 45,
        ["misc_chemical"] = 30,
    },
})

AS.AddBaseItem("wep_m1911", {
    name = "M1911",
    desc = "A pistol that holds 7 rounds. Uses .45 ACP ammunition.",
    category = "weapon",
    model = "models/items/weapons/m1911.mdl",
    wep = "weapon_m1911",
    value = 25,
    weight = 0.8,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 40,
        ["misc_smallparts"] = 60,
        ["misc_chemical"] = 35,
    },
})

AS.AddBaseItem("wep_ots", {
    name = "OTs-33 Pernach",
    desc = "An automatic pistol that holds 21 rounds. Uses 9x19mm ammunition.",
    category = "weapon",
    model = "models/items/weapons/ots.mdl",
    wep = "weapon_ots33",
    value = 25,
    weight = 0.8,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 40,
        ["misc_smallparts"] = 70,
        ["misc_chemical"] = 35,
    },
})

AS.AddBaseItem("wep_deagle", {
    name = ".50 AE Desert Eagle",
    desc = "A large hand-cannon that holds 7 rounds. Uses .50 Action Express.",
    category = "weapon",
    model = "models/items/weapons/deagle.mdl",
    wep = "weapon_deagle",
    value = 25,
    weight = 0.8,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 115,
        ["misc_smallparts"] = 90,
        ["misc_chemical"] = 85,
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
    desc = "A compact SMG that holds 30 rounds. Uses 9x19mm ammunition.",
    category = "weapon",
    model = "models/items/weapons/mp5.mdl",
    wep = "weapon_mp5",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 70,
        ["misc_smallparts"] = 85,
        ["misc_chemical"] = 80,
    },
})

AS.AddBaseItem("wep_csmg", {
    name = "Model CMG",
    desc = "A complex SMG that holds 25 rounds. Uses .45ACP ammunition.",
    category = "weapon",
    model = "models/items/weapons/csmg.mdl",
    wep = "weapon_cmg",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 175,
        ["misc_smallparts"] = 140,
        ["misc_chemical"] = 115,
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
    desc = "A small automatic rifle that holds 30 rounds. Uses 5.56x45mm ammunition.",
    category = "weapon",
    model = "models/items/weapons/g36.mdl",
    wep = "weapon_g36c",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 140,
        ["misc_smallparts"] = 125,
        ["misc_chemical"] = 105,
    },
})

AS.AddBaseItem("wep_ak12", {
    name = "AK-12",
    desc = "A tough rifle that holds 30 rounds. Uses 7.62x39mm ammunition.",
    category = "weapon",
    model = "models/items/weapons/ak12.mdl",
    wep = "weapon_ak12",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 175,
        ["misc_smallparts"] = 150,
        ["misc_chemical"] = 125,
    },
})

AS.AddBaseItem("wep_ak47", {
    name = "AK-47",
    desc = "A well-known rifle that holds 30 rounds. Uses 7.62x39mm ammunition.",
    category = "weapon",
    model = "models/items/weapons/ak47.mdl",
    wep = "weapon_ak47",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 160,
        ["misc_smallparts"] = 155,
        ["misc_chemical"] = 115,
    },
})

AS.AddBaseItem("wep_sg550", {
    name = "SG 550",
    desc = "A rifle that holds 30 rounds. Uses 5.56x45mm ammunition.",
    category = "weapon",
    model = "models/items/weapons/sg550.mdl",
    wep = "weapon_sg550",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 185,
        ["misc_smallparts"] = 140,
        ["misc_chemical"] = 125,
    },
})

AS.AddBaseItem("wep_sako", {
    name = "RK-95 Sako",
    desc = "A balanced rifle that holds 30 rounds. Uses 7.62x39mm ammunition.",
    category = "weapon",
    model = "models/items/weapons/sako.mdl",
    wep = "weapon_sako",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 175,
        ["misc_smallparts"] = 160,
        ["misc_chemical"] = 135,
    },
})

AS.AddBaseItem("wep_m4a1", {
    name = "M4A1",
    desc = "A balanced rifle that holds 30 rounds. Uses 5.56x45mm ammunition.",
    category = "weapon",
    model = "models/items/weapons/m4a1.mdl",
    wep = "weapon_m4a1",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 180,
        ["misc_smallparts"] = 165,
        ["misc_chemical"] = 140,
    },
})

AS.AddBaseItem("wep_sks", {
    name = "SKS",
    desc = "A long-ranged soviet rifle that holds 10 rounds. Uses 7.62x39mm ammunition.",
    category = "weapon",
    model = "models/items/weapons/sks.mdl",
    wep = "weapon_sks",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 160,
        ["misc_smallparts"] = 150,
        ["misc_chemical"] = 120,
    },
})

AS.AddBaseItem("wep_pulserifle", {
    name = "Pulse Rifle",
    desc = "An advanced pulse rifle that holds 30 pulse charges. Uses Pulse Batteries.",
    category = "weapon",
    model = "models/weapons/w_irifle.mdl",
    wep = "weapon_pulserifle",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 285,
        ["misc_smallparts"] = 200,
        ["misc_chemical"] = 225,
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
    desc = "A quick-pump action shotgun that holds 8 shells. Uses 12-Gauge Buckshot.",
    category = "weapon",
    model = "models/items/weapons/rem870.mdl",
    wep = "weapon_remington",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 180,
        ["misc_smallparts"] = 150,
        ["misc_chemical"] = 105,
    },
})

-- ██╗  ██╗███████╗ █████╗ ██╗   ██╗██╗   ██╗
-- ██║  ██║██╔════╝██╔══██╗██║   ██║╚██╗ ██╔╝
-- ███████║█████╗  ███████║██║   ██║ ╚████╔╝
-- ██╔══██║██╔══╝  ██╔══██║╚██╗ ██╔╝  ╚██╔╝
-- ██║  ██║███████╗██║  ██║ ╚████╔╝    ██║
-- ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝  ╚═══╝     ╚═╝

AS.AddBaseItem("wep_m249", {
    name = "M249",
    desc = "A heavy lmg that holds 100 rounds. Uses 5.56x45mm ammunition.",
    category = "weapon",
    model = "models/items/weapons/m249.mdl",
    wep = "weapon_m249",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 225,
        ["misc_smallparts"] = 185,
        ["misc_chemical"] = 160,
    },
})

AS.AddBaseItem("wep_pulselmg", {
    name = "Pulse LMG",
    desc = "An advanced pulse lmg that holds 75 charges. Uses Pulse Batteries.",
    category = "weapon",
    model = "models/items/weapons/pulselmg.mdl",
    wep = "weapon_pulselmg",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 300,
        ["misc_smallparts"] = 215,
        ["misc_chemical"] = 185,
        ["misc_pulsepod"] = 1,
    },
})

AS.AddBaseItem("wep_m60", {
    name = "M60",
    desc = "An incredibly heavy lmg that holds 100 rounds. Uses 7.62x51mm ammunition.",
    category = "weapon",
    model = "models/items/weapons/m60.mdl",
    wep = "weapon_m60",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 325,
        ["misc_smallparts"] = 300,
        ["misc_chemical"] = 275,
    },
})

-- ███████╗███╗   ██╗██╗██████╗ ███████╗██████╗
-- ██╔════╝████╗  ██║██║██╔══██╗██╔════╝██╔══██╗
-- ███████╗██╔██╗ ██║██║██████╔╝█████╗  ██████╔╝
-- ╚════██║██║╚██╗██║██║██╔═══╝ ██╔══╝  ██╔══██╗
-- ███████║██║ ╚████║██║██║     ███████╗██║  ██║
-- ╚══════╝╚═╝  ╚═══╝╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝

AS.AddBaseItem("wep_sr25", {
    name = "SR-25",
    desc = "A long-ranged DMR that holds 10 rounds. Uses 7.52x51mm ammunition.",
    category = "weapon",
    model = "models/items/weapons/sr25.mdl",
    wep = "weapon_sr25",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 215,
        ["misc_smallparts"] = 185,
        ["misc_chemical"] = 190,
    },
})

AS.AddBaseItem("wep_pulsesniper", {
    name = "Pulse Sniper",
    desc = "An advanced pulse sniper that holds 10 charges. Uses Pulse Batteries.",
    category = "weapon",
    model = "models/items/weapons/pulsesniper.mdl",
    wep = "weapon_pulsesniper",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 285,
        ["misc_smallparts"] = 295,
        ["misc_chemical"] = 280,
        ["misc_pulsepod"] = 1,
    },
})

AS.AddBaseItem("wep_m82", {
    name = "M82 Barret",
    desc = "A large caliber sniper that holds 10 rounds. Uses .50 BMG. Hearing someone fire this in the center of town means you should run.",
    category = "weapon",
    model = "models/items/weapons/m82.mdl",
    wep = "weapon_m82",
    value = 100,
    weight = 1.4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 350,
        ["misc_smallparts"] = 290,
        ["misc_chemical"] = 250,
    },
})