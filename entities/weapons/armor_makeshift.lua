AddCSLuaFile()

SWEP.Base = "armor_base"
SWEP.Category = "Aftershock - Armors"
SWEP.PrintName = "Makeshift Armor"
SWEP.Spawnable = false

SWEP.ASID = "armor_makeshift" --Aftershock ID. The armor will reference this ItemID for information.
SWEP.ModelOverride = { --Model override should only be used in the case where players with one model need to reference a specific one.
    ["models/player/group01/female_01.mdl"] = "models/player/group03/female_01.mdl", --Players with female01 will reference the group03 model of female01.
    ["models/player/group01/female_02.mdl"] = "models/player/group03/female_02.mdl",
    ["models/player/group01/female_03.mdl"] = "models/player/group03/female_03.mdl",
    ["models/player/group01/female_04.mdl"] = "models/player/group03/female_04.mdl",
    ["models/player/group01/female_05.mdl"] = "models/player/group03/female_05.mdl",
    ["models/player/group01/female_06.mdl"] = "models/player/group03/female_06.mdl",
    ["models/player/group01/male_01.mdl"] = "models/player/group03/male_01.mdl",
    ["models/player/group01/male_02.mdl"] = "models/player/group03/male_02.mdl",
    ["models/player/group01/male_03.mdl"] = "models/player/group03/male_03.mdl",
    ["models/player/group01/male_04.mdl"] = "models/player/group03/male_04.mdl",
    ["models/player/group01/male_05.mdl"] = "models/player/group03/male_05.mdl",
    ["models/player/group01/male_06.mdl"] = "models/player/group03/male_06.mdl",
    ["models/player/group01/male_07.mdl"] = "models/player/group03/male_07.mdl",
    ["models/player/group01/male_08.mdl"] = "models/player/group03/male_08.mdl",
    ["models/player/group01/male_09.mdl"] = "models/player/group03/male_09.mdl",
    ["default"] = "models/player/group03/male_02.mdl", --This is important. If we cannot find a reference for us, we default to this one in case.
}