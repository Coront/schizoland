AS.AddLootTable( "drawer", {
    name = "Drawers", --Name of container (This won't be displayed to players)
    model = "models/props_c17/FurnitureDrawer001a.mdl", --Model of container
    opensound = "physics/wood/wood_plank_impact_soft1.wav", --Sound played when player opens the container
    closesound = "physics/wood/wood_plank_impact_soft3.wav", --Sound played when the player closes the container
    generation = {
        time = 300, --Time to regenerate
        chance = 80, --Chance to regenerate on timer call
        minitem = 1, --Minimal items that will spawn on regenerate call
        maxitem = 5, --Maximum items that will spawn on regenerate call (item stacks not included)
        items = {
            ["misc_scrapmetal"] = {tickets = 100, min = 1, max = 6}, --key is itemid, tickets is drawing chance, min is minimal stack, max is maximum stack
            ["misc_smallparts"] = {tickets = 95, min = 1, max = 4},
            ["misc_shoe"] = {tickets = 90, min = 1, max = 1},
        },
    },
} )

AS.AddLootTable( "drawer2", {
    name = "Drawers 2",
    model = "models/props_c17/FurnitureDrawer002a.mdl",
} )

AS.AddLootTable( "desk", {
    name = "Desk",
    model = "models/props_interiors/Furniture_Desk01a.mdl",
} )

AS.AddLootTable( "desk2", {
    name = "Desk 2",
    model = "models/props_interiors/Furniture_Vanity01a.mdl",
} )

AS.AddLootTable( "dresser", {
    name = "Desser",
    model = "models/props_c17/FurnitureDresser001a.mdl",
} )

AS.AddLootTable( "computer", {
    name = "Computer",
    model = "models/props/cs_office/computer_caseB.mdl",
} )

AS.AddLootTable( "stove", {
    name = "Stove",
    model = "models/props_c17/furnitureStove001a.mdl",
} )

AS.AddLootTable( "fridge", {
    name = "Fridge",
    model = "models/props_c17/FurnitureFridge001a.mdl",
} )

AS.AddLootTable( "vending", {
    name = "Vending Machine",
    model = "models/props_interiors/VendingMachineSoda01a.mdl",
} )

AS.AddLootTable( "box", {
    name = "Cardboard Box",
    model = "models/props_junk/cardboard_box001a.mdl",
} )

AS.AddLootTable( "crate", {
    name = "Crate",
    model = "models/props_junk/wood_crate002a.mdl",
} )

AS.AddLootTable( "file", {
    name = "Filing Cabinet",
    model = "models/props_wasteland/controlroom_filecabinet002a.mdl",
} )

AS.AddLootTable( "file2", {
    name = "Office Cabinet",
    model = "models/props/cs_office/file_cabinet1.mdl",
} )

AS.AddLootTable( "lockers", {
    name = "Lockers",
    model = "models/props_c17/Lockers001a.mdl",
} )

AS.AddLootTable( "storagelocker", {
    name = "Storage Locker",
    model = "models/props_wasteland/controlroom_storagecloset001a.mdl",
} )

AS.AddLootTable( "footlocker", {
    name = "Foot Locker",
    model = "models/props/CS_militia/footlocker01_closed.mdl",
} )

AS.AddLootTable( "guncabinet", {
    name = "Gun Cabinet",
    model = "models/props/CS_militia/gun_cabinet.mdl",
} )

AS.AddLootTable( "stash", {
    name = "Barrel Stash",
    model = "models/props_borealis/bluebarrel001.mdl",
} )