AS.AddBaseItem("armor_makeshift", {
    name = "Makeshift Armor",
    desc = "Some old clothes that have been sewed together. Hopefully it helps protect you.",
    category = "armor",
    model = "models/items/armor/rebel.mdl",
    wep = "armor_makeshift",
    value = 35,
    weight = 2,
    armor = {
        ["movemult"] = 1, --Movespeed Mult
        [DMG_BULLET] = 10, --Bullets
        [DMG_SLASH] = 12, --Melee
        [DMG_BURN] = 9, --Fire
        [DMG_ENERGYBEAM] = 5, --Pulse
        [DMG_BLAST] = 3, --Explosive
    },
    class = "scavenger",
    craft = {
        ["misc_scrap"] = 50,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 40,
        ["misc_hide_antlion"] = 1,
    },
})

AS.AddBaseItem("armor_bandit", {
    name = "Bandit Armor",
    desc = "A ragged coat with a gasmask attached to it. Simple, but could be useful at a time like this.",
    category = "armor",
    model = "models/items/armor/banditarmor.mdl",
    wep = "armor_bandit",
    value = 35,
    weight = 2,
    armor = {
        ["movemult"] = 0.95, --Movespeed Mult
        [DMG_BULLET] = 15, --Bullets
        [DMG_SLASH] = 14, --Melee
        [DMG_BURN] = 11, --Fire
        [DMG_ENERGYBEAM] = 4, --Pulse
        [DMG_BLAST] = 5, --Explosive
    },
    class = "scavenger",
    craft = {
        ["misc_scrap"] = 50,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 40,
        ["misc_hide_antlion"] = 1,
    },
})

AS.AddBaseItem("armor_riot", {
    name = "Riot Armor",
    desc = "Armor built to reselble the armor used by pre-collapse riot police.",
    category = "armor",
    model = "models/items/armor/metro.mdl",
    wep = "armor_riot",
    color = Color( 120, 40, 40 ),
    value = 50,
    weight = 3.5,
    armor = {
        ["movemult"] = 0.9,
        [DMG_BULLET] = 22,
        [DMG_SLASH] = 28,
        [DMG_BURN] = 20,
        [DMG_ENERGYBEAM] = 15,
        [DMG_BLAST] = 25,
    },
    hidden = true,
    class = "mercenary",
    craft = {
        ["misc_scrap"] = 100,
        ["misc_smallparts"] = 70,
        ["misc_chemical"] = 85,
        ["misc_hide_antlion"] = 2,
    },
})

AS.AddBaseItem("armor_recon", {
    name = "Recon Armor",
    desc = "A very light set of armor with technologies that improve the wearer's mobility.",
    category = "armor",
    model = "models/items/armor/recon.mdl",
    wep = "armor_recon",
    color = Color( 120, 40, 40 ),
    value = 200,
    weight = 4.5,
    armor = {
        ["movemult"] = 1.25,
        [DMG_BULLET] = 25,
        [DMG_SLASH] = 24,
        [DMG_BURN] = 18,
        [DMG_ENERGYBEAM] = 18,
        [DMG_BLAST] = 20,
    },
    hidden = true,
    class = "mercenary",
    craft = {
        ["misc_scrap"] = 250,
        ["misc_smallparts"] = 300,
        ["misc_chemical"] = 375,
        ["misc_hide_antlion"] = 3,
        ["misc_hide_guard"] = 2,
    },
})

AS.AddBaseItem("armor_exo", {
    name = "Exosuit Armor",
    desc = "A light set of armor that utilizes a mechanical suit to help with carrying heavy contents.",
    category = "armor",
    model = "models/items/armor/exo.mdl",
    wep = "armor_exo",
    color = Color( 120, 40, 40 ),
    value = 200,
    weight = 4.5,
    armor = {
        ["movemult"] = 1.2,
        ["carryinc"] = 0,
        [DMG_BULLET] = 35,
        [DMG_SLASH] = 25,
        [DMG_BURN] = 15,
        [DMG_ENERGYBEAM] = 39,
        [DMG_BLAST] = 45,
    },
    hidden = true,
    class = "mercenary",
    craft = {
        ["misc_scrap"] = 250,
        ["misc_smallparts"] = 300,
        ["misc_chemical"] = 375,
        ["misc_hide_antlion"] = 3,
        ["misc_hide_guard"] = 2,
    },
})

AS.AddBaseItem("armor_combine", {
    name = "Coalition Armor",
    desc = "Armor that is worn commonly by post collapse soldiers. Has everything you need to protect yourself from basic wasteland elements.",
    category = "armor",
    model = "models/items/armor/combine.mdl",
    wep = "armor_combine",
    color = Color( 120, 40, 40 ),
    value = 200,
    weight = 4.5,
    armor = {
        ["movemult"] = 0.85,
        [DMG_BULLET] = 35,
        [DMG_SLASH] = 25,
        [DMG_BURN] = 15,
        [DMG_ENERGYBEAM] = 39,
        [DMG_BLAST] = 45,
    },
    hidden = true,
    class = "mercenary",
    craft = {
        ["misc_combinebroken"] = 1,
        ["misc_scrap"] = 250,
        ["misc_smallparts"] = 300,
        ["misc_chemical"] = 375,
        ["misc_hide_antlion"] = 3,
        ["misc_hide_guard"] = 2,
    },
})

AS.AddBaseItem("armor_combat", {
    name = "Combat Armor",
    desc = "A heavy set of armor made of kevlar and a couple other materials. Useful for stopping several incoming bullets.",
    category = "armor",
    model = "models/items/armor/combat.mdl",
    wep = "armor_combat",
    value = 35,
    weight = 2,
    armor = {
        ["movemult"] = 0.8, --Movespeed Mult
        [DMG_BULLET] = 40, --Bullets
        [DMG_SLASH] = 52, --Melee
        [DMG_BURN] = 10, --Fire
        [DMG_ENERGYBEAM] = 42, --Pulse
        [DMG_BLAST] = 40, --Explosive
    },
    hidden = true,
    class = "scavenger",
    craft = {
        ["misc_scrap"] = 350,
        ["misc_smallparts"] = 200,
        ["misc_chemical"] = 300,
        ["misc_hide_antlion"] = 4,
        ["misc_hide_guard"] = 2,
        ["misc_heavyplate"] = 1,
    },
})

AS.AddBaseItem("armor_elite", {
    name = "Elite Armor",
    desc = "Some of the best armor worn by elite soldiers of the post collapse millitary.",
    category = "armor",
    model = "models/items/armor/elite.mdl",
    wep = "armor_elite",
    value = 35,
    weight = 2,
    armor = {
        ["movemult"] = 0.75, --Movespeed Mult
        [DMG_BULLET] = 40, --Bullets
        [DMG_SLASH] = 52, --Melee
        [DMG_BURN] = 10, --Fire
        [DMG_ENERGYBEAM] = 42, --Pulse
        [DMG_BLAST] = 40, --Explosive
    },
    hidden = true,
    class = "scavenger",
    craft = {
        ["misc_elitebroken"] = 1,
        ["misc_scrap"] = 400,
        ["misc_smallparts"] = 250,
        ["misc_chemical"] = 3,
        ["misc_hide_antlion"] = 4,
        ["misc_hide_guard"] = 2,
        ["misc_heavyplate"] = 1,
    },
})

AS.AddBaseItem("armor_juggernaut", {
    name = "Juggernaut Armor",
    desc = "An incredibly heavy set of ballistic armor. Heavily protects your most important vital spots. It's not exactly flexible for movement, though.",
    category = "armor",
    model = "models/items/armor/juggernaut.mdl",
    wep = "armor_juggernaut",
    value = 35,
    weight = 2,
    armor = {
        ["movemult"] = 0.6, --Movespeed Mult
        [DMG_BULLET] = 70, --Bullets
        [DMG_SLASH] = 52, --Melee
        [DMG_BURN] = 10, --Fire
        [DMG_ENERGYBEAM] = 42, --Pulse
        [DMG_BLAST] = 40, --Explosive
    },
    hidden = true,
    class = "scavenger",
    craft = {
        ["misc_scrap"] = 350,
        ["misc_smallparts"] = 200,
        ["misc_chemical"] = 300,
        ["misc_hide_antlion"] = 4,
        ["misc_hide_guard"] = 2,
        ["misc_heavyplate"] = 1,
    },
})