AddCSLuaFile()

SWEP.Base = "armor_base"
SWEP.Category = "Aftershock - Armors"
SWEP.PrintName = "Coalition Armor"
SWEP.Spawnable = false

SWEP.ASID = "armor_combine" --Aftershock ID. The armor will reference this ItemID for information.
SWEP.Model = "models/player/combine_soldier.mdl" --This will just straight up set a player to a single model.
SWEP.Footsteps = { --Custom footsteps
    "npc/combine_soldier/gear1.wav",
    "npc/combine_soldier/gear2.wav",
    "npc/combine_soldier/gear3.wav",
    "npc/combine_soldier/gear4.wav",
    "npc/combine_soldier/gear5.wav",
    "npc/combine_soldier/gear6.wav",
}
SWEP.FootstepsSprinting = true --Only use custom footsteps when sprinting