AS.AddBaseItem("tritiumsights", {
    name = "Tritium Sights",
    desc = "A weapon modification. This can be attached to your weapon to alter its functionality.",
    category = "misc",
    model = "models/Items/BoxMRounds.mdl",
    value = 5,
    weight = 0.2,
    use = {
        func = function( ply )
            ply:AddAttachment( "tritiumsights" )
            ply:ChatPrint("Equipped Tritium Sights.")
        end
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 0,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 20,
    }
})

AS.AddBaseItem("compm4", {
    name = "CompM4",
    desc = "A weapon modification. This can be attached to your weapon to alter its functionality.",
    category = "misc",
    model = "models/Items/BoxMRounds.mdl",
    value = 5,
    weight = 0.2,
    use = {
        func = function( ply )
            ply:AddAttachment( "compm4" )
            ply:ChatPrint("Equipped CompM4.")
        end
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 5,
    }
})

AS.AddBaseItem("eotech", {
    name = "EoTech 553",
    desc = "A weapon modification. This can be attached to your weapon to alter its functionality.",
    category = "misc",
    model = "models/Items/BoxMRounds.mdl",
    value = 5,
    weight = 0.2,
    use = {
        func = function( ply )
            ply:AddAttachment( "eotech" )
            ply:ChatPrint("Equipped EoTech 553.")
        end
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 10,
    }
})

AS.AddBaseItem("c79", {
    name = "ELCAN C79",
    desc = "A weapon modification. This can be attached to your weapon to alter its functionality.",
    category = "misc",
    model = "models/Items/BoxMRounds.mdl",
    value = 5,
    weight = 0.2,
    use = {
        func = function( ply )
            ply:AddAttachment( "c79" )
            ply:ChatPrint("Equipped ELCAN C79.")
        end
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 35,
        ["misc_chemical"] = 15,
    }
})

AS.AddBaseItem("pso1", {
    name = "PSO-1",
    desc = "A weapon modification. This can be attached to your weapon to alter its functionality.",
    category = "misc",
    model = "models/Items/BoxMRounds.mdl",
    value = 5,
    weight = 0.2,
    use = {
        func = function( ply )
            ply:AddAttachment( "pso1" )
            ply:ChatPrint("Equipped PSO-1")
        end
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 35,
        ["misc_chemical"] = 15,
    }
})

AS.AddBaseItem("leupold", {
    name = "Leupold MK4",
    desc = "A weapon modification. This can be attached to your weapon to alter its functionality.",
    category = "misc",
    model = "models/Items/BoxMRounds.mdl",
    value = 5,
    weight = 0.2,
    use = {
        func = function( ply )
            ply:AddAttachment( "leupold" )
            ply:ChatPrint("Equipped Leupold MK4.")
        end
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 40,
        ["misc_chemical"] = 25,
    }
})

AS.AddBaseItem("sks20mag", {
    name = "SKS 20-Round Magazine",
    desc = "A weapon modification. This can be attached to your weapon to alter its functionality.",
    category = "misc",
    model = "models/Items/BoxMRounds.mdl",
    value = 5,
    weight = 0.2,
    use = {
        func = function( ply )
            ply:AddAttachment( "sks20mag" )
            ply:ChatPrint("Equipped SKS 20-Round Magazine.")
        end
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 20,
        ["misc_smallparts"] = 20,
        ["misc_chemical"] = 20,
    }
})

AS.AddBaseItem("foregrip", {
    name = "Foregrip",
    desc = "A weapon modification. This can be attached to your weapon to alter its functionality.",
    category = "misc",
    model = "models/Items/BoxMRounds.mdl",
    value = 5,
    weight = 0.2,
    use = {
        func = function( ply )
            ply:AddAttachment( "foregrip" )
            ply:ChatPrint("Equipped Foregrip.")
        end
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 10,
        ["misc_smallparts"] = 5,
        ["misc_chemical"] = 0,
    }
})

AS.AddBaseItem("suppressor", {
    name = "Suppressor",
    desc = "A weapon modification. This can be attached to your weapon to alter its functionality.",
    category = "misc",
    model = "models/Items/BoxMRounds.mdl",
    value = 5,
    weight = 0.2,
    use = {
        func = function( ply )
            ply:AddAttachment( "suppressor" )
            ply:ChatPrint("Equipped Suppressor")
        end
    },
    hidden = true,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 25,
        ["misc_chemical"] = 10,
    }
})