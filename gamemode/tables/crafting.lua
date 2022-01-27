AS.AddWorkbench( "regular", {
    name = "Regular Workbench",
    desc = "Used for crafting basic items",
} )

AS.AddWorkbenchRecipe( "regular", {
    requirements = {
        items = {
            ["misc_can"] = 1,
        },
    },
    receive = {
        items = {
            ["misc_scrapaluminum"] = 1,
        },
        skill = {
            ["crafting"] = 3,
        },
        exp = 1,
    },
} )

AS.AddWorkbenchRecipe( "regular", {
    requirements = {
        items = {
            ["misc_shoe"] = 1,
        },
    },
    receive = {
        items = {
            ["misc_scrapwood"] = 1,
        },
        skill = {
            ["crafting"] = 3,
        },
        exp = 1,
    },
} )

AS.AddWorkbenchRecipe( "regular", {
    requirements = {
    
    },
    receive = {
        items = {
            ["med_healthvial"] = 1,
        },
        skill = {
            ["crafting"] = 5,
        },
        exp = 2,
    },
} )

--[[
AS.AddWorkbenchRecipe( "workbenchid", {
    nameoverride = "My Recipe!", --Will force override the recipe name to this, otherwise it will default to the first item's name in the items table.
    descoverride = "" --Same as above, but for description.
    requirements = {
        items = {}, --Items required for this recipe
        skill = {}, --Skills required for this recipe
        hiderecipe = false, --Will hide the recipe unless the player has skills that meet the requirement.
    },
    receive = {
        items = {}, --Items the player will receive
        skill = {}, --Skill experience the player will receive
        exp = 0, --Overall experience the player will receive
    },
} )
]]