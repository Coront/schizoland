AS.Settings = {}
SET = AS.Settings

--Game Settings
SET.MaxCharacters = 5 --Maximum characters players are allowed to have.
SET.MinNameLength = 3 --Minimal length of a players name.
SET.BankWeight = 1000 --Maximum weight a player's bank can hold.
SET.HealthUpdating = 3 --Seconds until passive health updates
SET.ClassChange = true --Players able to change classes?
SET.ClassChangeCost = true --Player have to pay to change classes?
SET.ClassChangeCostTbl = { --If classchangecost is on, what do player's have to pay to change?
    ["misc_scrap"] = 100,
    ["misc_smallparts"] = 100,
    ["misc_chemical"] = 100,
}
SET.CraftTime = 1 --Craft time per item (seconds)
SET.DeathResCost = 30 --Percentage of player's resources (scrap, smallparts, chemicals) that will be lost upon death.
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
    [1] = "weapon_hands",
    [2] = "weapon_physgun",
    [3] = "gmod_tool",
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
PERM.ToolWhitelist = { --Tools that regular players can use
    ["precision"] = true,
    ["weld"] = true,
    ["button"] = true,
    ["duplicator"] = true,
    ["light"] = true,
    ["nocollide"] = true,
    ["nocollideeverything"] = true,
    ["remover"] = true,
    ["stacker_improved"] = true,
    ["colour"] = true,
    ["material"] = true,
}
--Class Settings
SET.Classes = {}
CLS = SET.Classes
CLS.Mercenary = {
    healthmult = 1.4,
}
CLS.Scavenger = {
    healthmult = 0.85,
    carryweightinc = 20,
    movespeedmult = 1.15,
    scavresourceinc = 1,
}
--Skill Settings
SET.Skills = {}
SKL = SET.Skills
SKL.Health = 100 --Player starts with 100 hp.
SKL.Movement = 163.5 --Player starts with 165 move speed.
SKL.SprintMovement = 248.5 --Player starts with 250 sprint move speed.
SKL.DefaultCarryWeight = 18.8 --Player starts with 20 carry weight.
SKL.Strength = {
    incamt = 0.02, --Amount to increase per melee impact
    dmgmultinc = 0.04, --(1+(level*dmgmultinc)) The number to mult overall damage by per level, as in higher means more damage per level.
    carryweight = 1.3, --Max weight increase per level
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
SKL.Salvaging = {
    incamt = 0.02, --Amount to increase per salvage
    decsalvtime = 0.06, --Decreases the amount of time to salvage per level
    incscavsuccess = 1, --Increases the chance of successful scavenges per level
    incscavitem = 0.6, --Increases the chance of finding an item per level
    incminres = 0.25, --Increases the minimal amount of resources found
    incmaxres = 0.3, --Increases the maximum amount of resources found
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
SAT.SatBuffs = 85 --The amount of hunger + thirst a player must remain above in order to receive the passive buffs.
--Mobs
SET.Mobs = {}
MOB = SET.Mobs
MOB.SpawnMult = 1 --Multiplier for the amount of NPCs that will spawn. This is rounded down if decimal.
MOB.RespawnTime = 60 --Time it takes for NPCs to respawn.
MOB.NPCs = {
    --amt is maximum amount, indoor means they spawn on indoor nodes, outdoor means they spawn on outdoor nodes
    ["npc_as_zombie"] = {amt = 8, indoor = true, outdoor = true},
    ["npc_as_fastzombie"] = {amt = 5, outdoor = true},
    ["npc_as_bandit"] = {amt = 4, outdoor = true},
    ["npc_as_antlion"] = {amt = 3, outdoor = true},
}
--Nodes
SET.Nodes = {}
NOD = SET.Nodes
NOD.Maximum = 20 --Maximum nodes
NOD.SpawnMult = 1 --Multiplier for the maximum number of nodes
NOD.MaxPerSpawner = 2 --Maximum nodes per spawner. This helps spread out the nodes a bit more, so they don't spawn in one location.
NOD.BaseScavTime = 3 --Base time length to scavenge
NOD.ScavengeChance = 44 --Base chance for a successful scavenge
NOD.ItemChance = 25 --Chance per scavenge to find an item, need to have a successful scavenge roll first
NOD.ScrapMinScavs = 6 --Minimal scavenges of a scrap node before despawning
NOD.ScrapMaxScavs = 14 --Maximum scavenges of a scrap node before despawning
NOD.ChemMinScavs = 5 --Minimal scavenges of a chem node before despawning
NOD.ChemMaxScavs = 10 --Maximum scavenges of a chem node before despawning
NOD.ResBaseMin = 1 --Base minimum resources found in a successful scavenge
NOD.ResBaseMax = 6 --Base maximum resources found in a successful scavenge
NOD.ScrapNodeModels = {
    ["models/props_vehicles/car001a_hatchback.mdl"] = true,
    ["models/props_vehicles/car001b_hatchback.mdl"] = true,
    ["models/props_vehicles/car002a_physics.mdl"] = true,
    ["models/props_vehicles/car002b_physics.mdl"] = true,
    ["models/props_vehicles/car003a_physics.mdl"] = true,
    ["models/props_vehicles/car003b_physics.mdl"] = true,
    ["models/props_vehicles/car004a_physics.mdl"] = true,
    ["models/props_vehicles/car004b_physics.mdl"] = true,
    ["models/props_vehicles/car005a_physics.mdl"] = true,
    ["models/props_vehicles/car005b_physics.mdl"] = true,
}
NOD.ScrapNodeModelsIndoor = {
    ["models/props_c17/tv_monitor01.mdl"] = true,
    ["models/props_c17/FurnitureWashingMachine001a.mdl"] = true,
    ["models/props_interiors/Radiator01a.mdl"] = true,
    ["models/props_junk/bicycle01a.mdl"] = true,
    ["models/props_lab/harddrive01.mdl"] = true,
    ["models/props_lab/partsbin01.mdl"] = true,
}
NOD.ScavItems = { --Table containing potential items that will spawn if a item is scavenged. Key is itemid, value is tickets.
    --Weapons
    ["wep_p228"] = 25,
    --Ammo
    ["ammo_pistol"] = 50,
    --Food
    ["food_beans"] = 500,
    ["food_dirty_water"] = 450,
    ["food_soda"] = 450,
    ["food_clean_water"] = 350,
    ["food_milk"] = 50,
    --Med
    ["med_bag"] = 50,
    ["med_vial"] = 50,
    --Misc
    ["misc_gunpowder"] = 475,
    ["misc_emptybottle"] = 400,
    ["misc_shoe"] = 300,
    ["misc_emptysodacan"] = 300,
    ["misc_metalcan"] = 300,
    ["misc_leadpipe"] = 250,
    ["misc_servo"] = 200,
    ["misc_electronicparts"] = 180,
    ["misc_sensorpod"] = 180,
    ["misc_seed_orange"] = 175,
    ["misc_seed_melon"] = 150,
    ["misc_saw"] = 150,
    ["misc_axel"] = 100,
    ["misc_paintcan"] = 100,
    ["misc_propane"] = 80,
    ["misc_carbattery"] = 75,
    ["misc_chemicalbucket"] = 60,
    ["misc_gunpowderten"] = 50,
    ["misc_solarfilmroll"] = 40,
    ["misc_wheel"] = 40,
}






















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