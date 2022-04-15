

-- ███████╗ ██████╗██████╗  █████╗ ██████╗     ██╗████████╗███████╗███╗   ███╗███████╗
-- ██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
-- ███████╗██║     ██████╔╝███████║██████╔╝    ██║   ██║   █████╗  ██╔████╔██║███████╗
-- ╚════██║██║     ██╔══██╗██╔══██║██╔═══╝     ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
-- ███████║╚██████╗██║  ██║██║  ██║██║         ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
-- ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝         ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- Scrap items are raw resources. They will be used in almost everything.

AS.AddBaseItem("misc_scrap", {
    name = "Scrap Metal",
    desc = "Metal, salvaged from various objects. Useful for crafting.",
    category = "misc",
    model = "models/gibs/scanner_gib02.mdl",
    color = Color( 125, 125, 125 ),
    value = 0,
    weight = 0,
    nostore = true,
})

AS.AddBaseItem("misc_smallparts", {
    name = "Small Parts",
    desc = "A bunch of small parts, gathered from various objects. Useful for crafting.",
    category = "misc",
    model = "models/props_wasteland/gear02.mdl",
    color = Color( 125, 125, 125 ),
    value = 0,
    weight = 0,
    nostore = true,
})

AS.AddBaseItem("misc_chemical", {
    name = "Chemicals",
    desc = "A nugget with chemicals. Found from salvaging chemical objects. Useful for crafting.",
    category = "misc",
    model = "models/grub_nugget_small.mdl",
    color = Color( 125, 125, 125 ),
    value = 0,
    weight = 0,
    nostore = true,
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
    desc = "A hide, harvested from an antlion. Useful in the creation of some items.",
    category = "misc",
    model = "models/gibs/antlion_gib_large_2.mdl",
    value = 10,
    weight = 0.75,
    hidden = true,
    craft = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 10,
    }
})

AS.AddBaseItem("misc_hide_guard", {
    name = "Antlion Guard Hide",
    desc = "A hide, harvested from a antlion guard. Useful in the creation of very protective armor.",
    category = "misc",
    model = "models/gibs/strider_gib2.mdl",
    value = 30,
    weight = 1.5,
    hidden = true,
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 15,
    }
})

AS.AddBaseItem("misc_gunpowder", {
    name = "Gunpowder",
    desc = "A black powder that pops when ignited. An important requirement for crafting ammunition.",
    category = "misc",
    model = "models/props_lab/jar01b.mdl",
    value = 5,
    weight = 0.2,
    hidden = true,
    craft = {
        ["misc_scrap"] = 4,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 2,
    }
})

AS.AddBaseItem("misc_gunpowderten", {
    name = "Gunpowder 10x",
    desc = "Everything you could possibly want. A large jar that contains enough gunpowder to be split into ten smaller jars.",
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
        ["misc_scrap"] = 40,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 20,
    }
})

AS.AddBaseItem("misc_heavyplate", {
    name = "Heavy Armor Plate",
    desc = "A heavy plate that is incredibly durable and rare. Required in the creation of some very efficient armors.",
    category = "misc",
    model = "models/gibs/shield_scanner_gib2.mdl",
    value = 200,
    weight = 1,
    hidden = true,
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 25,
    }
})

AS.AddBaseItem("misc_servo", {
    name = "Servo",
    desc = "A servomotor. A common requirement for automated tools.",
    model = "models/gibs/scanner_gib04.mdl",
    value = 5,
    weight = 0.1,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 10,
    },
})

AS.AddBaseItem("misc_electronicparts", {
    name = "Electronic Parts",
    desc = "A bunch of circuits, useful for constructing something that requires conduction of electricity.",
    category = "misc",
    model = "models/props/cs_office/computer_caseb_p2a.mdl",
    value = 5,
    weight = 0.1,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 30,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 20,
    },
})

AS.AddBaseItem("misc_saw", {
    name = "Diamond-Edged Saw",
    desc = "A saw that has been tipped with diamond. Useful for cutting through metals.",
    category = "misc",
    model = "models/props/cs_militia/circularsaw01.mdl",
    value = 10,
    weight = 1.5,
    hidden = true,
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 10,
        ["misc_chemical"] = 5,
    },
})

AS.AddBaseItem("misc_electronicreceiver", {
    name = "Electronic Receiver",
    desc = "An electronic receiver. With the proper parts, you could get this functioning again.",
    category = "misc",
    model = "models/props_lab/reciever01c.mdl",
    value = 10,
    weight = 0.2,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 30,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 15,
    },
})

AS.AddBaseItem("misc_sensorpod", {
    name = "Sensorpod",
    desc = "An old but still intact sensorpod that was salvaged from another object. Useful for relaying information that was gathered from a scan.",
    category = "misc",
    model = "models/gibs/shield_scanner_gib5.mdl",
    value = 10,
    weight = 0.2,
    hidden = true,
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 5,
    }
})

AS.AddBaseItem("misc_seed_orange", {
    name = "Orange Seeds",
    desc = "A packet that contains orange seeds. Can be used to grow an orange plant, to harvest oranges.",
    category = "misc",
    model = "models/props_lab/box01a.mdl",
    value = 5,
    weight = 0.2,
    hidden = true,
    craft = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 15,
    }
})

AS.AddBaseItem("misc_seed_melon", {
    name = "Melon Seeds",
    desc = "A packet that contains melon seeds. Can be used to grow a melon plant, to harvest melons.",
    category = "misc",
    model = "models/props_junk/cardboard_box004a.mdl",
    value = 5,
    weight = 0.2,
    hidden = true,
    craft = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 20,
    }
})

AS.AddBaseItem("misc_solarfilmroll", {
    name = "Thin Solar Film Roll",
    desc = "A very thin roll that containers copper, indium, gallium, and selenide. Can absorb energy from the sun to be converted into electricity.",
    category = "misc",
    model = "models/props/de_nuke/wall_light.mdl",
    value = 50,
    weight = 2,
    hidden = true,
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 30,
    }
})

AS.AddBaseItem("misc_carbattery", {
    name = "Car Battery",
    desc = "A still functional battery salvaged from a vehicle. One of the many parts required to make a vehicle.",
    category = "misc",
    model = "models/items/car_battery01.mdl",
    value = 5,
    weight = 2,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 30,
        ["misc_smallparts"] = 45,
        ["misc_chemical"] = 20,
    },
})

AS.AddBaseItem("misc_wheel", {
    name = "Wheel",
    desc = "A wheel salvaged from a car. One of the many parts required to make a vehicle.",
    category = "misc",
    model = "models/props_vehicles/carparts_wheel01a.mdl",
    value = 50,
    weight = 4,
    craft = {
        ["misc_scrap"] = 30,
        ["misc_smallparts"] = 20,
        ["misc_chemical"] = 5,
    }
})

AS.AddBaseItem("misc_axel", {
    name = "Axel",
    desc = "An old axel that is still in good condition. One of the many parts required to make a vehicle.",
    category = "misc",
    model = "models/props_vehicles/carparts_axel01a.mdl",
    value = 10,
    weight = 2,
    hidden = true,
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 10,
    }
})

AS.AddBaseItem("misc_engine", {
    name = "Makeshift Engine",
    desc = "An engine made from found scraps. One of the many parts required to make a vehicle.",
    category = "misc",
    model = "models/props_c17/trappropeller_engine.mdl",
    value = 25,
    weight = 3,
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 50,
        ["misc_smallparts"] = 75,
        ["misc_chemical"] = 60,
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
    weight = 2,
    hidden = true,
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 10,
        ["misc_chemical"] = 30,
    }
})

AS.AddBaseItem("misc_gasoline", {
    name = "Gasoline",
    desc = "A jerry can that holds a homogeneous mixture of petroleum oil and many other substances, commonly referred to as gasoline. Used to power generators.",
    category = "misc",
    model = "models/props_junk/metalgascan.mdl",
    value = 5,
    weight = 4,
    class = "cultivator",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 20,
        ["misc_chemical"] = 35,
    },
})

AS.AddBaseItem("misc_paintcan", {
    name = "Paint Can",
    desc = "A medium-sized tin can that holds paint inside of it. Useful if you want to, you know, paint something.",
    category = "misc",
    model = "models/props_junk/metal_paintcan001a.mdl",
    value = 5,
    weight = 1.5,
    hidden = true,
    craft = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 15,
    }
})

AS.AddBaseItem("misc_pulsepod", {
    name = "Pulse Pod",
    desc = "A small pod that holds pulse charges. A necessary requirement for making pulse weapons.",
    category = "misc",
    model = "models/props_combine/headcrabcannister01a_skybox.mdl",
    value = 20,
    weight = 2,
    hidden = true,
    craft = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 25,
    }
})

AS.AddBaseItem("misc_egg", {
    name = "Grub Egg",
    desc = "An egg that contains an unborn antlion grub inside of it.",
    category = "misc",
    model = "models/props_hive/egg.mdl",
    value = 10,
    weight = 1,
    hidden = true,
    craft = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 30,
    }
})

AS.AddBaseItem("misc_emptybottle", {
    name = "Empty Bottle",
    desc = "An empty bottle. Can be filled with water if dropped into a water source.",
    category = "misc",
    model = "models/props_junk/garbage_plasticbottle003a.mdl",
    value = 1,
    weight = 0.1,
    hidden = true,
    craft = {
        ["misc_scrap"] = 2,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})

-- ████████╗ ██████╗  ██████╗ ██╗         ██╗████████╗███████╗███╗   ███╗███████╗
-- ╚══██╔══╝██╔═══██╗██╔═══██╗██║         ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
--    ██║   ██║   ██║██║   ██║██║         ██║   ██║   █████╗  ██╔████╔██║███████╗
--    ██║   ██║   ██║██║   ██║██║         ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
--    ██║   ╚██████╔╝╚██████╔╝███████╗    ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
--    ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝    ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- Tool items are items that are required in crafting but are never actually consumed, meaning it's reusable.

AS.AddBaseItem("misc_tool", {
    name = "Multitool",
    desc = "A small tool with the ability to perform multiple tasks. Useful for making smaller objects.",
    category = "misc",
    model = "models/gibs/shield_scanner_gib4.mdl",
    value = 5,
    weight = 1,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 15,
        ["misc_servo"] = 1,
        ["misc_electronicparts"] = 1,
    },
})

AS.AddBaseItem("misc_munitionpress", {
    name = "Munition Press",
    desc = "A press that allows you to handcraft some basic ammunition wherever you are!",
    category = "misc",
    model = "models/props/cs_militia/reloadingpress01.mdl",
    value = 1,
    weight = 2,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 40,
        ["misc_smallparts"] = 50,
        ["misc_chemical"] = 25,
    },
})

-- ███████╗ █████╗ ██╗    ██╗   ██╗ █████╗  ██████╗ ███████╗    ██╗████████╗███████╗███╗   ███╗███████╗
-- ██╔════╝██╔══██╗██║    ██║   ██║██╔══██╗██╔════╝ ██╔════╝    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
-- ███████╗███████║██║    ██║   ██║███████║██║  ███╗█████╗      ██║   ██║   █████╗  ██╔████╔██║███████╗
-- ╚════██║██╔══██║██║    ╚██╗ ██╔╝██╔══██║██║   ██║██╔══╝      ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
-- ███████║██║  ██║███████╗╚████╔╝ ██║  ██║╚██████╔╝███████╗    ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
-- ╚══════╝╚═╝  ╚═╝╚══════╝ ╚═══╝  ╚═╝  ╚═╝ ╚═════╝ ╚══════╝    ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝
-- Salvage items are just junk items. They don't do anything and cannot be used for crafting, but can be salvaged for raw resources.

AS.AddBaseItem("misc_shoe", {
    name = "Shoe",
    desc = "A leather shoe. Can be salvaged for raw resources.",
    category = "misc",
    model = "models/props_junk/Shoe001a.mdl",
    color = Color( 70, 70, 70 ),
    value = 1,
    weight = 0.4,
    hidden = true,
    craft = {
        ["misc_scrap"] = 4,
        ["misc_smallparts"] = 2,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("misc_emptysodacan", {
    name = "Empty Soda Can",
    desc = "An empty soda can. Can be salvaged for raw resources.",
    category = "misc",
    model = "models/props_junk/PopCan01a.mdl",
    color = Color( 70, 70, 70 ),
    value = 1,
    weight = 0.1,
    hidden = true,
    craft = {
        ["misc_scrap"] = 2,
        ["misc_smallparts"] = 1,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("misc_metalcan", {
    name = "Metal Can",
    desc = "A empty aluminum can. Not sure what this could be used for.",
    category = "misc",
    model = "models/props_junk/garbage_metalcan002a.mdl",
    color = Color( 70, 70, 70 ),
    value = 1,
    weight = 0.125,
    hidden = true,
    craft = {
        ["misc_scrap"] = 2,
        ["misc_smallparts"] = 1,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("misc_mug", {
    name = "Coffee Mug",
    desc = "A coffee mug. Not really used for, well, anything.",
    category = "misc",
    model = "models/props/cs_office/coffee_mug.mdl",
    color = Color( 70, 70, 70 ),
    value = 1,
    weight = 0.125,
    hidden = true,
    craft = {
        ["misc_scrap"] = 3,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("misc_towels", {
    name = "Paper Towels",
    desc = "Useful if you need to clean up a spilled drink.",
    category = "misc",
    model = "models/props/cs_office/paper_towels.mdl",
    color = Color( 70, 70, 70 ),
    value = 1,
    weight = 0.125,
    hidden = true,
    craft = {
        ["misc_scrap"] = 2,
        ["misc_smallparts"] = 1,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("misc_chemicalbucket", {
    name = "Chemical Bucket",
    desc = "A bucket that has some random chemicals inside of it. Probably not really useful for much.",
    category = "misc",
    model = "models/props_junk/plasticbucket001a.mdl",
    color = Color( 70, 70, 70 ),
    value = 1,
    weight = 1,
    hidden = true,
    craft = {
        ["misc_scrap"] = 5,
        ["misc_smallparts"] = 2,
        ["misc_chemical"] = 20,
    }
})

AS.AddBaseItem("misc_leadpipe", {
    name = "Lead Pipe",
    desc = "There's not much this can be used for. It's pretty heavy though.",
    category = "misc",
    model = "models/props_canal/mattpipe.mdl",
    color = Color( 70, 70, 70 ),
    value = 1,
    weight = 1,
    hidden = true,
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 0,
    }
})