AS.AddBaseItem("armor_makeshift", {
    name = "Makeshift Armor",
    desc = "Some old clothes that have been sewn together with padding for minimal protection.",
    category = "armor",
    model = "models/items/armor/rebel.mdl",
    wep = "armor_makeshift",
    value = 35,
    weight = 3,
    armor = {
        [DMG_BULLET] = 10,
        [DMG_SLASH] = 12,
        [DMG_BURN] = 5,
        [DMG_ENERGYBEAM] = 5,
        [DMG_BLAST] = 3,
    },
    craft = {
        ["misc_scrap"] = 50,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 40,
    },
})

AS.AddBaseItem("armor_bandit", {
    name = "Bandit Armor",
    desc = "A common set of armor worn by those who are generally hostile to others around here.",
    category = "armor",
    model = "models/items/armor/banditarmor.mdl",
    wep = "armor_bandit",
    value = 35,
    weight = 3.2,
    armor = {
        ["movemult"] = 0.95, --Movespeed Mult
        [DMG_BULLET] = 13, --Bullets
        [DMG_SLASH] = 14, --Melee
        [DMG_BURN] = 8, --Fire
        [DMG_ENERGYBEAM] = 4, --Pulse
        [DMG_BLAST] = 5, --Explosive
    },
    class = "mercenary",
    craft = {
        ["misc_scrap"] = 60,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 45,
        ["misc_hide_antlion"] = 1,
    },
})

AS.AddBaseItem("armor_riot", {
    name = "Riot Armor",
    desc = "Old armor that was worn by police during riots to protect themselves from sharp and blunt objects",
    category = "armor",
    model = "models/items/armor/metro.mdl",
    wep = "armor_riot",
    value = 50,
    weight = 5,
    armor = {
        ["movemult"] = 0.94,
        [DMG_BULLET] = 14,
        [DMG_SLASH] = 22,
        [DMG_BURN] = 15,
        [DMG_ENERGYBEAM] = 6,
        [DMG_BLAST] = 6,
    },
    hidden = true,
    class = "mercenary",
    craft = {
        ["misc_scrap"] = 125,
        ["misc_smallparts"] = 80,
        ["misc_chemical"] = 100,
        ["misc_hide_antlion"] = 1,
    },
})

AS.AddBaseItem("armor_exo", {
    name = "Exosuit Armor",
    desc = "A suit that has built in technology to support carrying of heavy objects. Increases overall carry weight.",
    category = "armor",
    model = "models/items/armor/exo.mdl",
    wep = "armor_exo",
    color = Color( 0, 70, 150 ),
    value = 200,
    weight = 10,
    armor = {
        ["movemult"] = 0.9,
        ["carryinc"] = 30,
        [DMG_BULLET] = 23,
        [DMG_SLASH] = 20,
        [DMG_BURN] = 16,
        [DMG_ENERGYBEAM] = 15,
        [DMG_BLAST] = 19,
    },
    hidden = true,
    class = "mercenary",
    craft = {
        ["misc_scrap"] = 300,
        ["misc_smallparts"] = 200,
        ["misc_chemical"] = 250,
        ["misc_hide_antlion"] = 2,
        ["misc_servo"] = 4,
        ["misc_electronicparts"] = 2,
    },
})

AS.AddBaseItem("armor_combine", {
    name = "Coalition Armor",
    desc = "A heavy set of armor that has been seen worn by military units that have been deployed around here.",
    category = "armor",
    model = "models/items/armor/combine.mdl",
    wep = "armor_combine",
    color = Color( 0, 70, 150 ),
    value = 200,
    weight = 12,
    armor = {
        ["movemult"] = 0.85,
        [DMG_BULLET] = 35,
        [DMG_SLASH] = 25,
        [DMG_BURN] = 20,
        [DMG_ENERGYBEAM] = 39,
        [DMG_BLAST] = 25,
    },
    hidden = true,
    class = "mercenary",
    craft = {
        ["misc_scrap"] = 250,
        ["misc_smallparts"] = 300,
        ["misc_chemical"] = 375,
        ["misc_broken_combine"] = 1,
        ["misc_hide_antlion"] = 2,
        ["misc_hide_guard"] = 1,
    },
})

AS.AddBaseItem("armor_recon", {
    name = "Recon Armor",
    desc = "An extremely light set of armor with technologies built in to enhance the wearer's movement speed.",
    category = "armor",
    model = "models/items/armor/recon.mdl",
    wep = "armor_recon",
    color = Color( 120, 40, 40 ),
    value = 200,
    weight = 7,
    armor = {
        ["movemult"] = 1.2,
        [DMG_BULLET] = 25,
        [DMG_SLASH] = 18,
        [DMG_BURN] = 14,
        [DMG_ENERGYBEAM] = 18,
        [DMG_BLAST] = 10,
    },
    hidden = true,
    class = "mercenary",
    craft = {
        ["misc_scrap"] = 350,
        ["misc_smallparts"] = 250,
        ["misc_chemical"] = 400,
        ["misc_broken_recon"] = 1,
        ["misc_hide_antlion"] = 3,
        ["misc_hide_guard"] = 1,
        ["misc_servo"] = 2,
        ["misc_electronicparts"] = 2,
    },
})

AS.AddBaseItem("armor_combat", {
    name = "Combat Armor",
    desc = "A strap-on kevlar vest with protection for your limbs. Useful for active combat.",
    category = "armor",
    model = "models/items/armor/combat.mdl",
    wep = "armor_combat",
    color = Color( 120, 40, 40 ),
    value = 35,
    weight = 15,
    armor = {
        ["movemult"] = 0.825, --Movespeed Mult
        [DMG_BULLET] = 40, --Bullets
        [DMG_SLASH] = 30, --Melee
        [DMG_BURN] = 15, --Fire
        [DMG_ENERGYBEAM] = 35, --Pulse
        [DMG_BLAST] = 20, --Explosive
    },
    hidden = true,
    class = "mercenary",
    craft = {
        ["misc_scrap"] = 400,
        ["misc_smallparts"] = 350,
        ["misc_chemical"] = 375,
        ["misc_hide_antlion"] = 3,
        ["misc_hide_guard"] = 1,
        ["misc_heavyplate"] = 1,
    },
})

AS.AddBaseItem("armor_elite", {
    name = "Elite Armor",
    desc = "Used frequently by highly skilled and elite soldiers of military units. Heavy, but very durable and strong.",
    category = "armor",
    model = "models/items/armor/elite.mdl",
    wep = "armor_elite",
    color = Color( 120, 40, 40 ),
    value = 35,
    weight = 16,
    armor = {
        ["movemult"] = 0.75, --Movespeed Mult
        [DMG_BULLET] = 46, --Bullets
        [DMG_SLASH] = 38, --Melee
        [DMG_BURN] = 26, --Fire
        [DMG_ENERGYBEAM] = 43, --Pulse
        [DMG_BLAST] = 34, --Explosive
    },
    hidden = true,
    class = "mercenary",
    craft = {
        ["misc_scrap"] = 425,
        ["misc_smallparts"] = 375,
        ["misc_chemical"] = 350,
        ["misc_broken_elite"] = 1,
        ["misc_hide_antlion"] = 3,
        ["misc_hide_guard"] = 1,
        ["misc_heavyplate"] = 1,
    },
})

AS.AddBaseItem("armor_juggernaut", {
    name = "Juggernaut Armor",
    desc = "An old suit that has been hand-crafted with some of the finest materials found. Extremely heavy and hard to move in, but returns the favor with significant protection.",
    category = "armor",
    model = "models/items/armor/juggernaut.mdl",
    wep = "armor_juggernaut",
    color = Color( 160, 130, 0 ),
    value = 35,
    weight = 30,
    armor = {
        ["movemult"] = 0.6, --Movespeed Mult
        [DMG_BULLET] = 71, --Bullets
        [DMG_SLASH] = 61, --Melee
        [DMG_BURN] = 20, --Fire
        [DMG_ENERGYBEAM] = 35, --Pulse
        [DMG_BLAST] = 52, --Explosive
    },
    hidden = true,
    class = "mercenary",
    craft = {
        ["misc_scrap"] = 600,
        ["misc_smallparts"] = 550,
        ["misc_chemical"] = 650,
        ["misc_hide_antlion"] = 4,
        ["misc_hide_guard"] = 2,
        ["misc_heavyplate"] = 2,
    },
})