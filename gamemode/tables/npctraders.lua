AS.NPCTraders = {}

function AS.AddNPCTrader(traderid, data)
    AS.NPCTraders = AS.NPCTraders or {}

    AS.NPCTraders[traderid] = data
end

--[[
    id = Trader shop ID. Although implemented, they are not really used for anything.
    name = Name of the NPC. This will show up in the HUD ingame.
    model = Model of the npc trader shop.
    currencyItem = Item ID of the currency NPC will use to buy and sell items.
    alwaysCarryItems = Items that the NPC will restock on a regular time interval. (item = item id and maxStock = max he will stock up to)
    restockTime = How frequently trader will restock his alwaysCarryItems. (unit = seconds)
    currencySymbol = Symbol used to represent currency in GUI.
    currencySymbolLocation = Where the currency symbol will be displayed. ('left' or 'right' are the only choices)
    stock = Items in the NPC stock when he firsts spawns. 
]]--

-- Add NPC Traders below this line --

AS.AddNPCTrader("oldwar_bob", {
    id = "oldwar_bob",
    name = "Old War Trader Bob",
    model = "models/odessa.mdl",
    currencyItem = "misc_oldworld_money",
    alwaysCarryItems = {
        {
            item = "misc_oldworld_money",
            maxStock = 65,
        }
    },
    restockTime = 10,
    currencySymbol = "$",
    currencySymbolLocation = "left",
    stock = {
        {
            item = "misc_oldworld_money",
            amountInStock = 50,
        },
        {
            item = "food_beans",
            amountInStock = 25
        }
    }
})

