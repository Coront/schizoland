AS.AddBaseItem("armor_makeshift", {
    name = "Makeshift Armor",
    desc = "Some old clothes sewed together. Hopefully it helps protect you.",
    category = "armor",
    model = "models/items/armor/rebel.mdl",
    value = 35,
    weight = 2,
    armor = {
        ["movemult"] = 0.95, --Movespeed Mult
        [DMG_BULLET] = 8, --Bullets
        [DMG_SLASH] = 12, --Melee
        [DMG_BURN] = 9, --Fire
        [DMG_PLASMA] = 5, --Pulse
        [DMG_BLAST] = 3, --Explosive
    },
    class = "scavenger",
    craft = {
        ["misc_scrap"] = 50,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 40,
        ["misc_hide_antlion"] = 1,
    },
    salvage = {
        ["misc_scrap"] = 17,
        ["misc_smallparts"] = 8,
        ["misc_chemical"] = 13,
    },
})

AS.AddBaseItem("armor_police", {
    name = "Police Armor",
    desc = "Armor that was one day used to protect police in riots. May it service you better now.",
    category = "armor",
    model = "models/props/cs_office/Cardboard_box03.mdl",
    value = 80,
    weight = 3.5,
    armor = {
        ["movemult"] = 0.9,
        [DMG_BULLET] = 14,
        [DMG_SLASH] = 20,
        [DMG_BURN] = 25,
        [DMG_PLASMA] = 9,
    },
    hidden = true,
    class = "mercenary",
    craft = {
        ["misc_scrap"] = 120,
        ["misc_smallparts"] = 80,
        ["misc_chemical"] = 140,
        ["misc_hide_antlion"] = 2,
        ["misc_hide_guard"] = 1,
    },
    salvage = {
        ["misc_scrap"] = 40,
        ["misc_smallparts"] = 27,
        ["misc_chemical"] = 47,
    },
})

AS.AddBaseItem("armor_combine", {
    name = "Combine Soldier Armor",
    desc = "Armor that is worn commonly by combine soldiers. Has everything you need to protect yourself from basic wasteland elements.",
    category = "armor",
    model = "models/items/armor/combine.mdl",
    color = Color( 120, 40, 40 ),
    value = 200,
    weight = 4.5,
    armor = {
        ["movemult"] = 0.85,
        [DMG_BULLET] = 30,
        [DMG_SLASH] = 25,
        [DMG_BURN] = 15,
        [DMG_PLASMA] = 21,
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
    salvage = {
        ["misc_scrap"] = 83,
        ["misc_smallparts"] = 100,
        ["misc_chemical"] = 125,
    },
})

AS.AddBaseItem("armor_supersoldier", {
    name = "Super Soldier Armor",
    desc = "Armor worn by superior soldiers in the combine. Offers significant protection at the cost of be able to move flexibly.",
    category = "armor",
    model = "models/props/cs_office/Cardboard_box03.mdl",
    color = Color( 150, 120, 60 ),
    value = 400,
    weight = 6,
    hidden = true,
    armor = {
        ["movemult"] = 0.7,
        [DMG_BULLET] = 55,
        [DMG_SLASH] = 40,
        [DMG_BURN] = 20,
        [DMG_PLASMA] = 50,
    },
    class = "mercenary",
    craft = {
        ["misc_scrap"] = 400,
        ["misc_smallparts"] = 450,
        ["misc_chemical"] = 500,
        ["misc_hide_antlion"] = 4,
        ["misc_hide_guard"] = 3,
    },
    salvage = {
        ["misc_scrap"] = 133,
        ["misc_smallparts"] = 150,
        ["misc_chemical"] = 167,
    },
})