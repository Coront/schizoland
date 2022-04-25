AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "as_plant"
ENT.PrintName		= "Orange Plant"
ENT.Category		= "Aftershock"
ENT.Spawnable		= false

ENT.Model = "models/props/cs_office/plant01.mdl"
ENT.Slots = { --Every key you make is another slot for the food to be grown. For example, the orange plant has 5 slots that can be filled over time.
    --If the object runs out of slots, it won't make any food.
    [1] = Vector( 18.894531, -2.468262, 35.852501 ), --Vector is just offset from the model's position.
    [2] = Vector( -15.881836, -3.449219, 66.970985 ),
    [3] = Vector( 1.513672, 21.993652, 50.648567 ),
    [4] = Vector( 4.345215, 17.054688, 28.806961 ),
    [5] = Vector( -2.718262, -21.478027, 28.670868 ),
}
ENT.Food = "food_orange" --The food we should grow, by item ID.
ENT.PruneMax = 100 --Maximum value of our prune.
ENT.PruneLoss = 10 --Prune amount lossed per grown food.
ENT.GrowthLength = 120 --How long it takes for the food to grow (in seconds).