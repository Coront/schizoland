AS.Settings = {}
SET = AS.Settings

--Game Settings
SET.MaxCharacters = 5 --Maximum characters players are allowed to have.
SET.MinNameLength = 3 --Minimal length of a players name.
SET.BankWeight = 1000 --Maximum space a player's bank can hold.
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
--Skill Settings
SET.Skills = {}
SKL = SET.Skills
SKL.Health = 10 --Player starts with 10 hp.
SKL.Movement = 165 --Player starts with 150 move speed.
SKL.DefaultCarryWeight = 20 --Player starts with 20 carry weight.























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
}