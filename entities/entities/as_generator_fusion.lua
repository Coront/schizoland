AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "as_generator"
ENT.PrintName		= "Fusion Generator"
ENT.Category		= "Aftershock"
ENT.Spawnable		= false

ENT.Model = "models/props_combine/combine_generator01.mdl" --Object model
ENT.MaxHealth = 800 --Our health before being destroyed.
ENT.Fuel = "misc_deuterium" --What we need to be fueled.
ENT.FuelLength = 60 --How long our fuel should last for each fuel item inserted (in seconds).
ENT.Sound = "ambient/machines/combine_shield_loop3.wav" --Passive loop sound we play
ENT.PotentialElectricity = 250 --The amount of potential electricity we will produce. Basically how much to make when turned on.

--Aftershock Powerlinking System
ENT.PL = {}
POWER = ENT.PL
POWER.NoInlet = true --We will not intake electricity by any means.