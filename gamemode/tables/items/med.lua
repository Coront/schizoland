-- ███╗   ███╗███████╗██████╗ ██╗ ██████╗ █████╗ ██╗
-- ████╗ ████║██╔════╝██╔══██╗██║██╔════╝██╔══██╗██║
-- ██╔████╔██║█████╗  ██║  ██║██║██║     ███████║██║
-- ██║╚██╔╝██║██╔══╝  ██║  ██║██║██║     ██╔══██║██║
-- ██║ ╚═╝ ██║███████╗██████╔╝██║╚██████╗██║  ██║███████╗
-- ╚═╝     ╚═╝╚══════╝╚═════╝ ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝

AS.AddBaseItem("med_bag", {
    name = "Bag of Medical Supplies",
    desc = "An old garbage bag that contains some simple supplies for helping an individual recover from recent injuries. Heals 15 HP.",
    category = "med",
    model = "models/props_junk/garbage_bag001a.mdl",
    value = 20,
    weight = 0.7,
    use = {
        health = 15,
        sound = "physics/body/body_medium_impact_soft4.wav",
        stat = {
            [1] = {effect = "healingsickness", length = 1},
        },
    },
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 30,
    },
})

AS.AddBaseItem("med_vial", {
    name = "Health Vial",
    desc = "A vial that contains a strange green liquid from a mixture of an herb and other chemicals. It accelerates a person's regenerative capabilities when applied. Heals 25 HP.",
    category = "med",
    model = "models/healthvial.mdl",
    color = Color( 0, 115, 70 ),
    value = 20,
    weight = 1,
    use = {
        health = 25,
        sound = "items/medshot4.wav",
        stat = {
            [1] = {effect = "healingsickness", length = 3},
        },
    },
    class = "scientist",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 10,
        ["misc_chemical"] = 20,
        ["misc_herb"] = 1
    },
})

AS.AddBaseItem("med_kit", {
    name = "Medical Kit",
    desc = "A medical kit that contains a bunch of supplies, including that strange green liquid, to help a person recover from wounds. Heals 50 HP.",
    category = "med",
    model = "models/Items/HealthKit.mdl",
    color = Color( 0, 115, 70 ),
    value = 40,
    weight = 1.5,
    use = {
        health = 50,
        sound = "items/smallmedkit1.wav",
        stat = {
            [1] = {effect = "healingsickness", length = 8},
        },
    },
    class = "scientist",
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 20,
        ["misc_chemical"] = 35,
        ["misc_herb"] = 2,
    },
})

AS.AddBaseItem("med_bloodbag", {
    name = "Bloodbag",
    desc = "A large bag that contains an individuals blood. No one knows where the blood came from, but it's still usable. Heals 70 HP over time.",
    category = "med",
    model = "models/weapons/w_package.mdl",
    color = Color( 0, 115, 70 ),
    value = 80,
    weight = 1.65,
    use = {
        sound = "physics/flesh/flesh_bloody_impact_hard1.wav",
        stat = {
            [1] = {effect = "healingsickness", length = 20},
            [2] = {effect = "medicalitem", length = 35},
        },
    },
    hidden = true,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 45,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 65,
    },
})

AS.AddBaseItem("med_surgery", {
    name = "Surgery Kit",
    desc = "A bag the contains supplies for performing emergency surgery on yourself. Heals 150 HP over time.",
    category = "med",
    model = "models/props_c17/BriefCase001a.mdl",
    color = Color( 120, 40, 40 ),
    value = 175,
    weight = 2,
    use = {
        sound = "physics/body/body_medium_impact_soft6.wav",
        stat = {
            [1] = {effect = "healingsickness", length = 40},
            [2] = {effect = "medicalitem", length = 75},
        },
    },
    hidden = true,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 100,
        ["misc_smallparts"] = 65,
        ["misc_chemical"] = 120,
        ["misc_herb"] = 2,
    },
})

-- ██████╗ ██████╗ ██╗   ██╗ ██████╗ ███████╗
-- ██╔══██╗██╔══██╗██║   ██║██╔════╝ ██╔════╝
-- ██║  ██║██████╔╝██║   ██║██║  ███╗███████╗
-- ██║  ██║██╔══██╗██║   ██║██║   ██║╚════██║
-- ██████╔╝██║  ██║╚██████╔╝╚██████╔╝███████║
-- ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝

AS.AddBaseItem("med_painkiller", {
    name = "Bottle of Painkillers",
    desc = "A small bottle that contains a bunch of pills, generally used as an opioid for relieving pain. Reduces incoming damage by 10% for 2 minutes.",
    category = "med",
    model = "models/props_junk/PopCan01a.mdl",
    skin = 1,
    value = 15,
    weight = 0.5,
    use = {
        sound = "items/medshot4.wav",
        stat = {
            [1] = {effect = "painkillers", length = 120},
        },
    },
    hidden = true,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 40,
    }
})

AS.AddBaseItem("med_adrenaline", {
    name = "Adrenaline Shot",
    desc = "A syringe that carries adrenaline. Will increase your movement speed by 15% for 1 minute.",
    category = "med",
    model = "models/props_junk/PopCan01a.mdl",
    skin = 1,
    value = 15,
    weight = 0.5,
    use = {
        sound = "items/medshot4.wav",
        stat = {
            [1] = {effect = "adrenaline", length = 60},
        },
    },
    hidden = true,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 45,
    }
})
AS.AddBaseItem("med_antidote", {
    name = "Antidote",
    desc = "A small dose of an antidote, useful for quickly treating any active poison in your body. Will nullify poison and provide regeneration for 10 seconds.",
    category = "med",
    model = "models/props_junk/PopCan01a.mdl",
    skin = 1,
    value = 15,
    weight = 0.5,
    use = {
        sound = "items/medshot4.wav",
        stat = {
            [1] = {effect = "poison", length = 0},
            [2] = {effect = "poisonsevere", length = 0}, --SHHHHHH
            [3] = {effect = "medicalitem", length = 10},
        },
    },
    hidden = true,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 20,
        ["misc_chemical"] = 35,
        ["misc_herb"] = 1,
    }
})

AS.AddBaseItem("med_suppression", {
    name = "Suppression",
    desc = "A small dose of a strange chemical. Will nullify all negative effects and suppress any negative effects from being inflicted for 5 minutes.",
    category = "med",
    model = "models/props_junk/PopCan01a.mdl",
    skin = 1,
    value = 15,
    weight = 0.5,
    use = {
        sound = "items/medshot4.wav",
        stat = {
            [1] = {effect = "suppression", length = 300},
        },
    },
    hidden = true,
    class = "scientist",
    craft = {
        ["misc_scrap"] = 35,
        ["misc_smallparts"] = 30,
        ["misc_chemical"] = 65,
    }
})

--  ██████╗ ████████╗██╗  ██╗███████╗██████╗
-- ██╔═══██╗╚══██╔══╝██║  ██║██╔════╝██╔══██╗
-- ██║   ██║   ██║   ███████║█████╗  ██████╔╝
-- ██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗
-- ╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║
--  ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝

AS.AddBaseItem("misc_expbook", {
    name = "Book of Experience",
    desc = "A strange book. Contains information that might improve one of your skills, but is also extremely fragile. Cannot be dropped or traded.",
    category = "misc",
    model = "models/props_lab/binderredlabel.mdl",
    color = Color( 160, 130, 0 ),
    value = 0,
    weight = 0,
    use = {
        func = function( ply )
            local skills = {
                "strength",
                "endurance",
                "weaponhandling",
                "salvaging",
            }
            for k, v in pairs( skills ) do --We're excluding all skills that are already maxed.
                if ply:GetSkillLevel( v ) >= AS.Skills[v].max then
                    skills[v] = nil
                end
            end
            local skill = table.Random( skills )
            local amt = math.random( 30, 150 )
            amt = amt * 0.01 --because math.random only uses whole numbers, how unfortunate.

            ply:IncreaseSkillExperience( skill, amt )
            ply:ChatPrint( AS.Skills[skill].name .. " +" .. amt .. " experience" )
            ply:ResyncSkills()
        end,
    },
    hidden = true,
    nodrop = true,
    nostore = true,
    novendor = true,
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 0,
        ["misc_chemical"] = 0,
    }
})