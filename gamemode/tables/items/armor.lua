AS.AddBaseItem("armor_makeshift", {
    name = "Makeshift Armor",
    desc = "Some old clothes that have been sewed together. Hopefully it helps protect you.",
    category = "armor",
    model = "models/items/armor/rebel.mdl",
    wep = "armor_makeshift",
    value = 35,
    weight = 2,
    armor = {
        ["movemult"] = 0.95, --Movespeed Mult
        [DMG_BULLET] = 8, --Bullets
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
        [DMG_BULLET] = 38, --Bullets
        [DMG_SLASH] = 52, --Melee
        [DMG_BURN] = 10, --Fire
        [DMG_ENERGYBEAM] = 30, --Pulse
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

AS.AddBaseItem("armor_combine", {
    name = "Combine Soldier Armor",
    desc = "Armor that is worn commonly by combine soldiers. Has everything you need to protect yourself from basic wasteland elements.",
    category = "armor",
    model = "models/items/armor/combine.mdl",
    wep = "armor_combine",
    color = Color( 120, 40, 40 ),
    value = 200,
    weight = 4.5,
    armor = {
        ["movemult"] = 0.85,
        [DMG_BULLET] = 30,
        [DMG_SLASH] = 25,
        [DMG_BURN] = 15,
        [DMG_ENERGYBEAM] = 21,
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