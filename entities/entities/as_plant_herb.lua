AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "as_plant"
ENT.PrintName		= "Herb Box"
ENT.Category		= "Aftershock"
ENT.Spawnable		= false

ENT.Model = "models/tools/dirtbox.mdl"
ENT.Slots = {
    [1] = Vector( 20, 15, 12 ),
    [2] = Vector( -20, 15, 12 ),
    [3] = Vector( 20, -15, 12 ),
    [4] = Vector( -20, -15, 12 ),
}
ENT.Food = "misc_herb"
ENT.PruneMax = 200
ENT.PruneLoss = 20
ENT.GrowthLength = 100