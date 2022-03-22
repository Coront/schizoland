AS.Settings = {}
SET = AS.Settings

--Game Settings
SET.MaxCharacters = 5 --Maximum characters players are allowed to have.
SET.MinNameLength = 3 --Minimal length of a players name.
SET.BankWeight = 1000 --Maximum weight a player's bank can hold.
SET.MaxLevel = 150 --Max level of characters.
SET.SelectableModels = {
    --All of the models in here are models that the player is allowed to select during character creation.
    ["models/player/group01/male_01.mdl"] = true,
    ["models/player/group01/male_02.mdl"] = true,
    ["models/player/group01/male_03.mdl"] = true,
    ["models/player/group01/male_04.mdl"] = true,
    ["models/player/group01/male_05.mdl"] = true,
    ["models/player/group01/male_06.mdl"] = true,
    ["models/player/group01/male_07.mdl"] = true,
    ["models/player/group01/male_08.mdl"] = true,
    ["models/player/group01/male_09.mdl"] = true,
    ["models/player/group02/male_02.mdl"] = true,
    ["models/player/group02/male_04.mdl"] = true,
    ["models/player/group02/male_06.mdl"] = true,
    ["models/player/group02/male_08.mdl"] = true,
    ["models/player/group01/female_01.mdl"] = true,
    ["models/player/group01/female_02.mdl"] = true,
    ["models/player/group01/female_03.mdl"] = true,
    ["models/player/group01/female_04.mdl"] = true,
    ["models/player/group01/female_05.mdl"] = true,
    ["models/player/group01/female_06.mdl"] = true,
}
SET.DefaultWeapons = {
    ["weapon_physgun"] = true,
    ["gmod_tool"] = true,
    ["weapon_hands"] = true,
}
--Permission Settings
SET.PERM = {}
PERM = SET.PERM
PERM.Physgunable = { --Entities that are allowed to be physgunned by normal players.
    ["prop_physics"] = true,
}
PERM.MaxProps = 50 --Maximum props a player can spawn.
PERM.PropBlacklist = { --Props that are forbidden from being spawned
    ["models/props_c17/oildrum001_explosive.mdl"] = true, --Explosive
    ["models/Combine_Helicopter/helicopter_bomb01.mdl"] = true, --Explosive
    ["models/props_junk/propane_tank001a.mdl"] = true, --Explosive
    ["models/props_junk/gascan001a.mdl"] = true, --Explosive
    ["models/props_phx/oildrum001_explosive.mdl"] = true, --Explosive
    ["models/props_phx/amraam.mdl"] = true, --Explosive
    ["models/props_phx/cannonball.mdl"] = true, --Explosive
    ["models/props_phx/cannonball_solid.mdl"] = true, --Explosive
    ["models/props_phx/misc/smallcannonball.mdl"] = true, --Explosive
    ["models/props_phx/mk-82.mdl"] = true, --Explosive
    ["models/props_phx/rocket1.mdl"] = true, --Explosive
    ["models/props_phx/torpedo.mdl"] = true, --Explosive
    ["models/props_phx/ww2bomb.mdl"] = true, --Explosive
    ["models/props_phx/misc/flakshell_big.mdl"] = true, --Explosive
    ["models/props_phx/misc/potato_launcher_explosive.mdl"] = true, --Explosive
}
--Skill Settings
SET.Skills = {}
SKL = SET.Skills
SKL.Health = 100 --Player starts with 100 hp.
SKL.Movement = 163.5 --Player starts with 165 move speed.
SKL.DefaultCarryWeight = 18.8 --Player starts with 20 carry weight.
SKL.Strength = {
    incamt = 0.02, --Amount to increase per melee impact
    carryweight = 1.2, --Max weight increase per level
}
SKL.Endurance = {
    updatetime = 1.5, --Every second until updates again
    incamt = 0.01, --Amount to increase per update
    runspeed = 1.5, --Run speed increase per level
}
SKL.WeaponHandling = {
    incamt = 0.01, --Amount to increase per shot
    recoilmultloss = 0.036, --(1-(level*recoilmultloss)) The number to mult overall recoil by per level, as in higher means less recoil per level.
    reloadmultinc = 0.013, --(1+(level*reloadmultinc)) The number to mult reload speed by per level, as in higher means faster reloading per level.
}
--Satiation Settings
SET.Satiation = {}
SAT = SET.Satiation
SAT.HungerUpdate = 50 --Timer in seconds that the player's hunger will update
SAT.HungerLoss = 1 --Hunger loss on update
SAT.ThirstUpdate = 35 --Timer in seconds that the player's thirst will update
SAT.ThirstLoss = 1 --Thirst loss on update
SAT.StarveDamage = 2 --How much damage starvation should deal on next hunger update
SAT.DehydratedDamage = 1 --How much damage dehydration should deal on next thirst update
SAT.SatBuffs = 80 --The amount of hunger + thirst a player must remain above in order to receive the passive buffs.
--Mobs
SET.Mobs = {}
MOB = SET.Mobs
MOB.NPCs = {
    ["npc_antlion"] = 10, --Key is NPC class, value is maximum spawned
    ["npc_zombie"] = 12,
    ["npc_fastzombie"] = 8,
    ["npc_poisonzombie"] = 6,
}
MOB.SpawnMult = 1 --Multiplier for the amount of NPCs that will spawn. This is rounded down if decimal.
MOB.RespawnTime = 60 --Time it takes for NPCs to respawn.























--Restrictions
SET.BannedWords = {
    --Words in here will be searched by a filter system where players can customize names. Players will be kicked if they try to use any of these words.
    "nigger",
    "nigga",
    "niglet",
    "nig",
    "nickgur",
    "spic",
    "wetback",
    "zipperhead",
    "ricer",
    "beaner",
    "gringo",
    "jigabo",
    "redskin",
    "tarbaby",
    "fag",
    "faggot",
    "queer",
    "retard",
    "tranny",
    "trannies",
    "cracker",
    "sneed",
    "fuck",
    "shit",
    "ass",
    "balls",
    "testical",
    "cunt",
    "penis",
    "vagina",
    "dick",
    "asshole",
    "anus",
    "pussy",
    "puss",
    "cum",
    "semen",
    "condom",
    "tampon",
    "cunny",
}