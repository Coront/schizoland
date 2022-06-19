-- ███████╗ ██████╗██████╗  █████╗ ██████╗     ██╗████████╗███████╗███╗   ███╗███████╗
-- ██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
-- ███████╗██║     ██████╔╝███████║██████╔╝    ██║   ██║   █████╗  ██╔████╔██║███████╗
-- ╚════██║██║     ██╔══██╗██╔══██║██╔═══╝     ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
-- ███████║╚██████╗██║  ██║██║  ██║██║         ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
-- ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝         ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- Scrap items are raw resources. They will be used in almost everything.

AS.AddBaseItem("misc_scrap", {
    name = "Scrap",
    desc = "A piece of scrap. Used to craft items.",
    category = "misc",
    model = "models/gibs/scanner_gib02.mdl",
    color = Color( 150, 150, 150 ),
    value = 0,
    weight = 0,
    nostore = true,
    novendor = true,
})

AS.AddBaseItem("misc_smallparts", {
    name = "Small Parts",
    desc = "A small part. Used to craft items.",
    category = "misc",
    model = "models/props_wasteland/gear02.mdl",
    color = Color( 150, 150, 150 ),
    value = 0,
    weight = 0,
    nostore = true,
    novendor = true,
})

AS.AddBaseItem("misc_chemical", {
    name = "Chemicals",
    desc = "A chemical. Used to craft items.",
    category = "misc",
    model = "models/grub_nugget_small.mdl",
    color = Color( 150, 150, 150 ),
    value = 0,
    weight = 0,
    nostore = true,
    novendor = true,
})

-- ██████╗  █████╗ ██████╗ ████████╗    ██╗████████╗███████╗███╗   ███╗███████╗
-- ██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
-- ██████╔╝███████║██████╔╝   ██║       ██║   ██║   █████╗  ██╔████╔██║███████╗
-- ██╔═══╝ ██╔══██║██╔══██╗   ██║       ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
-- ██║     ██║  ██║██║  ██║   ██║       ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
-- ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝       ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- Part items are items that are generally required in crafting of other items, usually the player will have to scavenge these.

AS.AddBaseItem("misc_hide_antlion", {
    name = "Antlion Hide",
    desc = "Hide that has been carefully cut from a dead antlion. Useful in making armors.",
    category = "misc",
    model = "models/gibs/antlion_gib_large_1.mdl",
    value = 10,
    weight = 1,
    hidden = true,
    craft = {
        ["misc_scrap"] = 4,
        ["misc_smallparts"] = 2,
        ["misc_chemical"] = 4,
    }
})

AS.AddBaseItem("misc_hide_guard", {
    name = "Antlion Guard Hide",
    desc = "A very large hide that has been obtained from a fallen antlion guard. Used to make heavy armors.",
    category = "misc",
    model = "models/gibs/strider_gib2.mdl",
    value = 30,
    weight = 5,
    hidden = true,
    craft = {
        ["misc_scrap"] = 8,
        ["misc_smallparts"] = 4,
        ["misc_chemical"] = 6,
    }
})

AS.AddBaseItem("misc_gunpowder", {
    name = "Gunpowder",
    desc = "A jar containing some gunpowder. A neccessary ingredient to making ammunition.",
    category = "misc",
    model = "models/props_lab/jar01b.mdl",
    value = 5,
    weight = 0.2,
    hidden = true,
    craft = {
        ["misc_scrap"] = 1,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 2,
    }
})

AS.AddBaseItem("misc_gunpowderten", {
    name = "Gunpowder 10x",
    desc = "A large jar that contains significant amounts of gunpowder. Can be broken down into smaller amounts.",
    category = "misc",
    model = "models/props_lab/jar01a.mdl",
    value = 50,
    weight = 2,
    use = {
        items = {
            ["misc_gunpowder"] = 10,
        },
        soundcs = "fx/items/up/itm_ammunition_up01.wav",
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 20,
    }
})

AS.AddBaseItem("misc_fullmelon", {
    name = "Melon",
    desc = "A large melon that has been recently harvested. Can be sliced into edible pieces.",
    category = "misc",
    model = "models/props_junk/watermelon01.mdl",
    value = 50,
    weight = 1,
    use = {
        items = {
            ["food_melon"] = 4,
        },
        soundcs = "physics/flesh/flesh_squishy_impact_hard4.wav",
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 1,
    }
})

AS.AddBaseItem("misc_uraniumpack", {
    name = "Uranium Fuel (Packed)",
    desc = "A bundle of uranium fuel. Can be broken down into usable rods.",
    category = "misc",
    model = "models/items/crossbowrounds.mdl",
    value = 50,
    weight = 1,
    use = {
        items = {
            ["misc_uranium"] = 60,
        },
        soundcs = "entities/resources_1.wav",
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 4,
        ["misc_smallparts"] = 2,
        ["misc_chemical"] = 10,
    }
})

AS.AddBaseItem("misc_uranium", {
    name = "Uranium Fuel",
    desc = "A single rod of uranium fuel. Used to power nuclear generators.",
    category = "misc",
    model = "models/items/misc/uranium.mdl",
    value = 0,
    weight = 0.015,
    hidden = true,
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 1,
    }
})

AS.AddBaseItem("misc_deuteriumpod", {
    name = "Deuterium Fuel (Packed)",
    desc = "A pod containing several samples of deuterium fuel. Can be broken down into usable samples.",
    category = "misc",
    model = "models/Items/combine_rifle_ammo01.mdl",
    value = 50,
    weight = 1.5,
    use = {
        items = {
            ["misc_deuterium"] = 60,
        },
        soundcs = "entities/resources_1.wav",
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 3,
        ["misc_chemical"] = 15,
    }
})

AS.AddBaseItem("misc_deuterium", {
    name = "Deuterium Fuel",
    desc = "A single sample of deuterium fuel. Used to power fusion generators.",
    category = "misc",
    model = "models/items/misc/deuteriumsample.mdl",
    value = 0,
    weight = 0.025,
    hidden = true,
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 1,
    }
})

AS.AddBaseItem("misc_heavyplate", {
    name = "Heavy Armor Plate",
    desc = "A heavy plate of armor that has been ripped from other destroyed armors. A vital requirement to make heavy armors.",
    category = "misc",
    model = "models/gibs/shield_scanner_gib2.mdl",
    value = 200,
    weight = 3,
    hidden = true,
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 10,
    }
})

AS.AddBaseItem("misc_servo", {
    name = "Servo",
    desc = "A servomotor. A common requirement for automated tools.",
    category = "misc",
    model = "models/gibs/scanner_gib04.mdl",
    value = 5,
    weight = 1,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 5,
        ["misc_multitool"] = 0,
    },
})

AS.AddBaseItem("misc_electronicparts", {
    name = "Electronic Part",
    desc = "An electrical circuit, useful for conducting power.",
    category = "misc",
    model = "models/props/cs_office/computer_caseb_p2a.mdl",
    value = 5,
    weight = 1,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 20,
        ["misc_chemical"] = 10,
        ["misc_multitool"] = 0
    },
})

AS.AddBaseItem("misc_saw", {
    name = "Diamond-Edged Saw",
    desc = "An old saw that has been tipped with small amounts of solid carbon.",
    category = "misc",
    model = "models/props/cs_militia/circularsaw01.mdl",
    value = 10,
    weight = 1,
    hidden = true,
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 5,
    },
})

AS.AddBaseItem("misc_sensorpod", {
    name = "Sensorpod",
    desc = "A pod that is generally useful for sensing objects past the ground level.",
    category = "misc",
    model = "models/gibs/shield_scanner_gib5.mdl",
    value = 10,
    weight = 1,
    hidden = true,
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 10,
    }
})

AS.AddBaseItem("misc_herb", {
    name = "Medicinal Herb",
    desc = "An newly grown medicinal herb that's used to create medicine.",
    category = "misc",
    model = "models/items/misc/herb.mdl",
    value = 5,
    weight = 0.35,
    hidden = true,
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 2,
    }
})

AS.AddBaseItem("misc_seed_orange", {
    name = "Orange Seeds",
    desc = "A packet of orange seeds that can be used to grow an orange plant.",
    category = "misc",
    model = "models/props_lab/box01a.mdl",
    value = 5,
    weight = 0.5,
    hidden = true,
    craft = {
        ["misc_scrap"] = 3,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 5,
    }
})

AS.AddBaseItem("misc_seed_melon", {
    name = "Melon Seeds",
    desc = "A packet of melon seeds that can be used to grow a melon plant.",
    category = "misc",
    model = "models/props_junk/cardboard_box004a.mdl",
    value = 5,
    weight = 0.5,
    hidden = true,
    craft = {
        ["misc_scrap"] = 4,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 8,
    }
})

AS.AddBaseItem("misc_seed_herb", {
    name = "Medicinal Herb Seeds",
    desc = "A packet of herbal seeds that can be used to grow an herb plant.",
    category = "misc",
    model = "models/props_junk/cardboard_box004a.mdl",
    value = 5,
    weight = 0.5,
    hidden = true,
    craft = {
        ["misc_scrap"] = 4,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 8,
    }
})

AS.AddBaseItem("misc_solarfilmroll", {
    name = "Thin Solar Film Roll",
    desc = "A very thin roll that contains copper, indium, gallium, and selenide. Can absorb energy from the sun to be converted into electricity.",
    category = "misc",
    model = "models/props/de_nuke/wall_light.mdl",
    value = 50,
    weight = 2,
    hidden = true,
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 35,
        ["misc_chemical"] = 20,
    }
})

AS.AddBaseItem("misc_nukecore", {
    name = "Nuclear Core",
    desc = "The core needed to create a nuclear generator. Recommended to be careful with this.",
    category = "misc",
    model = "models/Combine_Helicopter/helicopter_bomb01.mdl",
    value = 50,
    weight = 4,
    hidden = true,
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 35,
        ["misc_chemical"] = 50,
    }
})

AS.AddBaseItem("misc_fusioncore", {
    name = "Fusion Core",
    desc = "A core that is needed to make a fusion generator. Can blow up an entire town. Proceed with caution.",
    category = "misc",
    model = "models/props_combine/combine_light002a.mdl",
    value = 50,
    weight = 8,
    hidden = true,
    craft = {
        ["misc_scrap"] = 30,
        ["misc_smallparts"] = 40,
        ["misc_chemical"] = 70,
    }
})

AS.AddBaseItem("misc_carbattery", {
    name = "Car Battery",
    desc = "An old galvanic cell that still works. Useful for powering certain objects. A vital part in making a vehicle.",
    category = "misc",
    model = "models/items/car_battery01.mdl",
    value = 5,
    weight = 4,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 20,
    },
})

AS.AddBaseItem("misc_wheel", {
    name = "Wheel",
    desc = "A wheel that's still in good shape, one of the many parts needed to make a vehicle.",
    category = "misc",
    model = "models/props_vehicles/carparts_wheel01a.mdl",
    value = 50,
    weight = 10,
    hidden = true,
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 15,
    }
})

AS.AddBaseItem("misc_axel", {
    name = "Axel",
    desc = "An axel in which wheels can be attached to. Transfers the rotary motion of the motor to move the wheels. A vital part in making a vehicle.",
    category = "misc",
    model = "models/props_vehicles/carparts_axel01a.mdl",
    value = 10,
    weight = 5,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 15,
    }
})

AS.AddBaseItem("misc_engine", {
    name = "Makeshift Engine",
    desc = "A handmade engine. With the use of fuel, it can create electricity the use of magnets and also produce a rotary motion, which can be useful for other means.",
    category = "misc",
    model = "models/props_c17/trappropeller_engine.mdl",
    value = 25,
    weight = 15,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 30,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 25,
        ["misc_servo"] = 3,
        ["misc_multitool"] = 0,
    },
})

AS.AddBaseItem("misc_propane", {
    name = "Propane",
    desc = "A canister that holds C3H8, or Propane Gas, useful when it comes to having a temporary source of fire for welding or burning.",
    category = "misc",
    model = "models/props_junk/PropaneCanister001a.mdl",
    value = 10,
    weight = 3,
    hidden = true,
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 25,
    }
})

AS.AddBaseItem("misc_gasoline", {
    name = "Gasoline Can",
    desc = "A can of gasoline that has been assembled with raw chemicals. Used to power a gas generator.",
    category = "misc",
    model = "models/props_junk/metalgascan.mdl",
    value = 5,
    weight = 4,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 20,
        ["misc_chemical"] = 15,
    },
})

AS.AddBaseItem("misc_pulsepod", {
    name = "Pulse Pod",
    desc = "A rare pulse pod. Ignites pulse charges to be fired. A requirement to make pulse weaponry.",
    category = "misc",
    model = "models/props_combine/headcrabcannister01a_skybox.mdl",
    value = 20,
    weight = 0.4,
    hidden = true,
    craft = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 5,
    }
})

AS.AddBaseItem("misc_egg", {
    name = "Grub Egg",
    desc = "A grub egg that has been theived from an antlion nest. With the proper training and materials, can be hatched into an antlion grub.",
    category = "misc",
    model = "models/props_hive/egg.mdl",
    value = 10,
    weight = 2,
    hidden = true,
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 20,
    }
})

AS.AddBaseItem("misc_emptybottle", {
    name = "Empty Bottle",
    desc = "An empty plastic bottle. Can be filled with water at a water source.",
    category = "misc",
    model = "models/props_junk/garbage_plasticbottle003a.mdl",
    value = 1,
    weight = 0.15,
    hidden = true,
    craft = {
        ["misc_scrap"] = 4,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("misc_broken_combine", {
    name = "Broken Coalition Armor",
    desc = "A full set of destroyed coalition armor. With the proper materials, it can be repaired to be useable again.",
    category = "misc",
    model = "models/items/armor/combine.mdl",
    value = 100,
    weight = 5,
    hidden = true,
    craft = {
        ["misc_scrap"] = 30,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 15,
    }
})

AS.AddBaseItem("misc_broken_recon", {
    name = "Broken Recon Armor",
    desc = "A full set of destroyed recon armor. With the correct materials, it can be repaired to be usable again.",
    category = "misc",
    model = "models/items/armor/recon.mdl",
    value = 100,
    weight = 12,
    hidden = true,
    craft = {
        ["misc_scrap"] = 30,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 15,
    }
})

AS.AddBaseItem("misc_broken_elite", {
    name = "Broken Elite Armor",
    desc = "A full set of destroyed elite armor. With the correct materials, it can be repaired to be usable again.",
    category = "misc",
    model = "models/items/armor/elite.mdl",
    value = 150,
    weight = 14,
    hidden = true,
    craft = {
        ["misc_scrap"] = 40,
        ["misc_smallparts"] = 40,
        ["misc_chemical"] = 20,
    }
})

AS.AddBaseItem("misc_broken_assault", {
    name = "Broken Assault Armor",
    desc = "A full set of destroyed assault armor. With the correct materials, it can be repaired to be usable again.",
    category = "misc",
    model = "models/items/armor/assault.mdl",
    value = 150,
    weight = 15,
    hidden = true,
    craft = {
        ["misc_scrap"] = 45,
        ["misc_smallparts"] = 40,
        ["misc_chemical"] = 30,
    }
})

AS.AddBaseItem("misc_broken_hardsuit", {
    name = "Broken Hardsuit Armor",
    desc = "A full set of destroyed hardsuit armor. With the correct materials, it can be repaired to be usable again.",
    category = "misc",
    model = "models/items/armor/hardsuit.mdl",
    value = 150,
    weight = 25,
    hidden = true,
    craft = {
        ["misc_scrap"] = 50,
        ["misc_smallparts"] = 45,
        ["misc_chemical"] = 40,
    }
})

AS.AddBaseItem("misc_gyro", {
    name = "Gyroscope",
    desc = "An extremely advanced piece of technology. Very rare, too. Used in crafting.",
    category = "misc",
    model = "models/maxofs2d/hover_rings.mdl",
    color = Color( 235, 190, 0 ),
    value = 150,
    weight = 5,
    hidden = true,
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 10,
    }
})

-- ████████╗ ██████╗  ██████╗ ██╗         ██╗████████╗███████╗███╗   ███╗███████╗
-- ╚══██╔══╝██╔═══██╗██╔═══██╗██║         ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
--    ██║   ██║   ██║██║   ██║██║         ██║   ██║   █████╗  ██╔████╔██║███████╗
--    ██║   ██║   ██║██║   ██║██║         ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
--    ██║   ╚██████╔╝╚██████╔╝███████╗    ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
--    ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝    ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- Tool items are items that are required in crafting but are never actually consumed, meaning it's reusable.

AS.AddBaseItem("misc_multitool", {
    name = "Multitool",
    desc = "A tool that serves multiple purposes. Useful in assembling certain objects.",
    category = "misc",
    model = "models/gibs/shield_scanner_gib4.mdl",
    value = 5,
    weight = 0.75,
    class = "engineer",
    hidden = true,
    craft = {
        ["misc_scrap"] = 45,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 10,
    },
})

AS.AddBaseItem("misc_munitionpress", {
    name = "Munition Press",
    desc = "A press for ammunition. Allows one to craft bullets with ease.",
    category = "misc",
    model = "models/props/cs_militia/reloadingpress01.mdl",
    value = 1,
    weight = 1.5,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 30,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 20,
    },
})

AS.AddBaseItem("misc_weaponkit", {
    name = "Advanced Weapon Construction Kit",
    desc = "An advanced weapon construction kit. Needed to assemble more advanced or heavy weaponry.",
    category = "misc",
    model = "models/props_c17/BriefCase001a.mdl",
    value = 1,
    weight = 3,
    class = "engineer",
    hidden = true,
    craft = {
        ["misc_scrap"] = 250,
        ["misc_smallparts"] = 350,
        ["misc_chemical"] = 200,
    },
})

-- ███████╗ █████╗ ██╗    ██╗   ██╗ █████╗  ██████╗ ███████╗    ██╗████████╗███████╗███╗   ███╗███████╗
-- ██╔════╝██╔══██╗██║    ██║   ██║██╔══██╗██╔════╝ ██╔════╝    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
-- ███████╗███████║██║    ██║   ██║███████║██║  ███╗█████╗      ██║   ██║   █████╗  ██╔████╔██║███████╗
-- ╚════██║██╔══██║██║    ╚██╗ ██╔╝██╔══██║██║   ██║██╔══╝      ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
-- ███████║██║  ██║███████╗╚████╔╝ ██║  ██║╚██████╔╝███████╗    ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
-- ╚══════╝╚═╝  ╚═╝╚══════╝ ╚═══╝  ╚═╝  ╚═╝ ╚═════╝ ╚══════╝    ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- Salvage items are just junk items. They don't do anything and cannot be used for crafting, but can be salvaged for raw resources.

AS.AddBaseItem("misc_towels", {
    name = "Paper Towels",
    desc = "Useful for cleaning up a spilled drink, otherwise just scrap.",
    category = "misc",
    model = "models/props/cs_office/paper_towels.mdl",
    color = Color( 60, 60, 60 ),
    value = 1,
    weight = 0.15,
    hidden = true,
    craft = {
        ["misc_scrap"] = 4,
        ["misc_smallparts"] = 1,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("misc_emptysodacan", {
    name = "Empty Soda Can",
    desc = "An empty can of soda. Not much you could do with this.",
    category = "misc",
    model = "models/props_junk/PopCan01a.mdl",
    color = Color( 60, 60, 60 ),
    value = 1,
    weight = 0.1,
    hidden = true,
    craft = {
        ["misc_scrap"] = 4,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("misc_metalcan", {
    name = "Metal Can",
    desc = "A metal can that once contained beans.",
    category = "misc",
    model = "models/props_junk/garbage_metalcan002a.mdl",
    color = Color( 60, 60, 60 ),
    value = 1,
    weight = 0.1,
    hidden = true,
    craft = {
        ["misc_scrap"] = 4,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("misc_shoe", {
    name = "Shoe",
    desc = "A shoe. Not sure what it would be useful for.",
    category = "misc",
    model = "models/props_junk/Shoe001a.mdl",
    color = Color( 60, 60, 60 ),
    value = 1,
    weight = 0.1,
    hidden = true,
    craft = {
        ["misc_scrap"] = 4,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("misc_wrench", {
    name = "Old Wrench",
    desc = "An old wrench, too old to be useful. Might serve better use as scrap.",
    category = "misc",
    model = "models/props_c17/tools_wrench01a.mdl",
    color = Color( 60, 60, 60 ),
    value = 5,
    weight = 0.2,
    hidden = true,
    craft = {
        ["misc_scrap"] = 6,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("misc_leadpipe", {
    name = "Lead Pipe",
    desc = "A lead pipe. Doesn't make for a good weapon, but it is good for scrap.",
    category = "misc",
    model = "models/props_canal/mattpipe.mdl",
    color = Color( 60, 60, 60 ),
    value = 1,
    weight = 1.5,
    hidden = true,
    craft = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 2,
    }
})

AS.AddBaseItem("misc_phonereceiver", {
    name = "Broken Phone Receiver",
    desc = "A destroyed phone receiver.",
    category = "misc",
    model = "models/props_trainstation/payphone_reciever001a.mdl",
    color = Color( 60, 60, 60 ),
    value = 2,
    weight = 0.1,
    hidden = true,
    craft = {
        ["misc_scrap"] = 4,
        ["misc_smallparts"] = 7,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("misc_pulley", {
    name = "Pulley",
    desc = "An old pulley. Unsure where this came from.",
    category = "misc",
    model = "models/props_c17/pulleywheels_small01.mdl",
    color = Color( 60, 60, 60 ),
    value = 3,
    weight = 3,
    hidden = true,
    craft = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 8,
        ["misc_chemical"] = 1,
    }
})

AS.AddBaseItem("misc_lamp", {
    name = "Lamp",
    desc = "A broken lamp.",
    category = "misc",
    model = "models/props_lab/desklamp01.mdl",
    color = Color( 60, 60, 60 ),
    value = 5,
    weight = 1,
    hidden = true,
    craft = {
        ["misc_scrap"] = 6,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("misc_damagedtransceiver", {
    name = "Damaged Transceiver",
    desc = "A damaged transceiver, possibly beyond repair.",
    category = "misc",
    model = "models/props_lab/reciever01b.mdl",
    color = Color( 60, 60, 60 ),
    value = 5,
    weight = 0.5,
    hidden = true,
    craft = {
        ["misc_scrap"] = 4,
        ["misc_smallparts"] = 7,
        ["misc_chemical"] = 1,
    }
})

AS.AddBaseItem("misc_bustedcomputer", {
    name = "Busted Computer",
    desc = "Theres not much use for this anymore. A good source of small parts though.",
    category = "misc",
    model = "models/props_lab/harddrive01.mdl",
    color = Color( 60, 60, 60 ),
    value = 20,
    weight = 1,
    hidden = true,
    craft = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 11,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("misc_cleaner", {
    name = "Discarded Cleaner",
    desc = "A bottle of cleaner. It's moslty empty, unfortunately.",
    category = "misc",
    model = "models/props_junk/garbage_plasticbottle002a.mdl",
    color = Color( 60, 60, 60 ),
    value = 3,
    weight = 0.1,
    hidden = true,
    craft = {
        ["misc_scrap"] = 2,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 4,
    }
})

AS.AddBaseItem("misc_acid", {
    name = "Bottle of Acid",
    desc = "A bottle of an acidic chemical. Can be salvaged for chemicals.",
    category = "misc",
    model = "models/props_junk/garbage_milkcarton001a.mdl",
    color = Color( 60, 60, 60 ),
    value = 5,
    weight = 0.8,
    hidden = true,
    craft = {
        ["misc_scrap"] = 2,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 8,
    }
})

AS.AddBaseItem("misc_bleach", {
    name = "Bleach",
    desc = "Rumor has it you can drink this to cure viruses, they just don't want you to know. Useful for chemicals though.",
    category = "misc",
    model = "models/props_junk/garbage_plasticbottle001a.mdl",
    color = Color( 60, 60, 60 ),
    value = 7,
    weight = 1,
    use = {
        soundcs = "npc/barnacle/barnacle_gulp1.wav",
        items = {
            ["misc_emptybottle"] = 1,
        },
        stat = {
            [1] = {effect = "poisonsevere", length = 20, stack = true},
        },
    },
    hidden = true,
    craft = {
        ["misc_scrap"] = 2,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 10,
    }
})

AS.AddBaseItem("misc_fireextinguisher", {
    name = "Expired Fire Extinguisher",
    desc = "An expired fire extinguisher, Not sure if there will be any fires that need to be put out soon.",
    category = "misc",
    model = "models/props/cs_office/Fire_Extinguisher.mdl",
    color = Color( 60, 60, 60 ),
    value = 11,
    weight = 3,
    hidden = true,
    craft = {
        ["misc_scrap"] = 6,
        ["misc_smallparts"] = 3,
        ["misc_chemical"] = 9,
    }
})

AS.AddBaseItem("misc_chemicalbucket", {
    name = "Chemical Bucket",
    desc = "A large bucket containing unidentified chemicals. The chemicals could be used for something else.",
    category = "misc",
    model = "models/props_junk/plasticbucket001a.mdl",
    color = Color( 60, 60, 60 ),
    value = 20,
    weight = 4,
    hidden = true,
    craft = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 2,
        ["misc_chemical"] = 15,
    }
})

-- ██╗   ██╗███╗   ██╗██╗ ██████╗ ██╗   ██╗███████╗    ██╗████████╗███████╗███╗   ███╗███████╗
-- ██║   ██║████╗  ██║██║██╔═══██╗██║   ██║██╔════╝    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
-- ██║   ██║██╔██╗ ██║██║██║   ██║██║   ██║█████╗      ██║   ██║   █████╗  ██╔████╔██║███████╗
-- ██║   ██║██║╚██╗██║██║██║▄▄ ██║██║   ██║██╔══╝      ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
-- ╚██████╔╝██║ ╚████║██║╚██████╔╝╚██████╔╝███████╗    ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
--  ╚═════╝ ╚═╝  ╚═══╝╚═╝ ╚══▀▀═╝  ╚═════╝ ╚══════╝    ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- Just a troll

AS.AddBaseItem("unique_bucket", {
    name = "Metal Bucket",
    desc = "Just for joe phil :)",
    category = "misc",
    model = "models/props_junk/MetalBucket02a.mdl",
    color = Color( 255, 255, 255),
    value = 20,
    weight = 0,
    hidden = true,
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})