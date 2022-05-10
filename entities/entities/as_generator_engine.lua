AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "as_generator"
ENT.PrintName		= "Gas Generator"
ENT.Category		= "Aftershock"
ENT.Spawnable		= false

ENT.Model = "models/props_vehicles/generatortrailer01.mdl" --Object model
ENT.MaxHealth = 350 --Our health before being destroyed.
ENT.Fuel = "misc_gasoline" --What we need to be fueled.
ENT.FuelLength = 900 --How long our fuel should last for each fuel item inserted (in seconds).
ENT.Sound = "ambient/machines/diesel_engine_idle1.wav" --Passive loop sound we play

ENT.PotentialElectricity = 75 --The amount of potential electricity we will produce. Basically how much to make when turned on.