-- ███╗   ███╗ ██████╗ ██████╗ ███████╗██╗     ███████╗
-- ████╗ ████║██╔═══██╗██╔══██╗██╔════╝██║     ██╔════╝
-- ██╔████╔██║██║   ██║██║  ██║█████╗  ██║     ███████╗
-- ██║╚██╔╝██║██║   ██║██║  ██║██╔══╝  ██║     ╚════██║
-- ██║ ╚═╝ ██║╚██████╔╝██████╔╝███████╗███████╗███████║
-- ╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝

AS.CharacterModels = {
    --Male 1
    ["models/player/group01/male_01.mdl"] = {name = "Male 1"},
    ["models/kayf/humans/group01/male_01.mdl"] = {name = "Male 1 - Leather Jacket"},
    ["models/kayf/humans/group02/male_01.mdl"] = {name = "Male 1 - Flannel"},
    --Male 2
    ["models/player/group01/male_02.mdl"] = {name = "Male 2"},
    ["models/player/group02/male_02.mdl"] = {name = "Male 2 - Cotton"},
    ["models/kayf/humans/group01/male_02.mdl"] = {name = "Male 2 - Hoodie"},
    ["models/kayf/humans/group02/male_02.mdl"] = {name = "Male 2 - Uniform"},
    --Male 3
    ["models/player/group01/male_03.mdl"] = {name = "Male 3"},
    ["models/kayf/humans/group01/male_03.mdl"] = {name = "Male 3 - Leather Jacket"},
    ["models/kayf/humans/group02/male_03.mdl"] = {name = "Male 3 - Flannel"},
    --Male 4
    ["models/player/group01/male_04.mdl"] = {name = "Male 4"},
    ["models/player/group02/male_04.mdl"] = {name = "Male 4 - Cotton"},
    ["models/kayf/humans/group01/male_04.mdl"] = {name = "Male 4 - Hoodie"},
    --Male 5
    ["models/player/group01/male_05.mdl"] = {name = "Male 5"},
    ["models/kayf/humans/group01/male_05.mdl"] = {name = "Male 5 - Leather Jacket"},
    ["models/kayf/humans/group02/male_05.mdl"] = {name = "Male 5 - Flannel"},
    --Male 6
    ["models/player/group01/male_06.mdl"] = {name = "Male 6"},
    ["models/player/group02/male_06.mdl"] = {name = "Male 6 - Cotton"},
    ["models/kayf/humans/group01/male_06.mdl"] = {name = "Male 6 - Hoodie"},
    ["models/kayf/humans/group02/male_06.mdl"] = {name = "Male 6 - Uniform"},
    --Male 7
    ["models/player/group01/male_07.mdl"] = {name = "Male 7"},
    ["models/kayf/humans/group01/male_07.mdl"] = {name = "Male 7 - Leather Jacket"},
    ["models/kayf/humans/group02/male_07.mdl"] = {name = "Male 7 - Flannel"},
    --Male 8
    ["models/player/group01/male_08.mdl"] = {name = "Male 8"},
    ["models/player/group02/male_08.mdl"] = {name = "Male 8 - Cotton"},
    ["models/kayf/humans/group01/male_08.mdl"] = {name = "Male 8 - Hoodie"},
    ["models/kayf/humans/group02/male_08.mdl"] = {name = "Male 8 - Uniform"},
    --Male 9
    ["models/player/group01/male_09.mdl"] = {name = "Male 9"},
    ["models/kayf/humans/group01/male_09.mdl"] = {name = "Male 9 - Leather Jacket"},
    ["models/kayf/humans/group02/male_09.mdl"] = {name = "Male 9 - Flannel"},

    --Female 1
    ["models/player/group01/female_01.mdl"] = {name = "Female 1", female = true},
    ["models/kayf/humans/group01/female_01.mdl"] = {name = "Female 1 - Tracksuit", female = true},
    ["models/kayf/humans/group02/female_01.mdl"] = {name = "Female 1 - Casual", female = true},
    --Female 2
    ["models/player/group01/female_02.mdl"] = {name = "Female 2", female = true},
    ["models/kayf/humans/group01/female_02.mdl"] = {name = "Female 2 - Tracksuit", female = true},
    ["models/kayf/humans/group02/female_02.mdl"] = {name = "Female 2 - Casual", female = true},
    --Female 3
    ["models/player/group01/female_03.mdl"] = {name = "Female 3", female = true},
    ["models/kayf/humans/group01/female_03.mdl"] = {name = "Female 3 - Tracksuit", female = true},
    ["models/kayf/humans/group02/female_03.mdl"] = {name = "Female 3 - Casual", female = true},
    --Female 4
    ["models/player/group01/female_04.mdl"] = {name = "Female 4", female = true},
    ["models/kayf/humans/group01/female_04.mdl"] = {name = "Female 4 - Tracksuit", female = true},
    ["models/kayf/humans/group02/female_04.mdl"] = {name = "Female 4 - Casual", female = true},
    --Female 5
    ["models/player/group01/female_05.mdl"] = {name = "Female 5", female = true},
    ["models/kayf/humans/group01/female_07.mdl"] = {name = "Female 5 - Tracksuit", female = true},
    ["models/kayf/humans/group02/female_07.mdl"] = {name = "Female 5 - Casual", female = true},
    --Female 6
    ["models/player/group01/female_06.mdl"] = {name = "Female 6", female = true},
    ["models/kayf/humans/group01/female_06.mdl"] = {name = "Female 6 - Tracksuit", female = true},
    ["models/kayf/humans/group02/female_06.mdl"] = {name = "Female 6 - Casual", female = true},
}

function FindModelByName( name )
    for k, v in pairs( AS.CharacterModels ) do
        if v.name == name then
            return k
        end
    end
end

-- ███████╗ ██████╗ ██╗   ██╗███╗   ██╗██████╗ ███████╗
-- ██╔════╝██╔═══██╗██║   ██║████╗  ██║██╔══██╗██╔════╝
-- ███████╗██║   ██║██║   ██║██╔██╗ ██║██║  ██║███████╗
-- ╚════██║██║   ██║██║   ██║██║╚██╗██║██║  ██║╚════██║
-- ███████║╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝███████║
-- ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚══════╝

AS.CharacterSounds = {}
AS.CharacterSounds.Male = {}
AS.CharacterSounds.Female = {}

-- Male

AS.CharacterSounds.Male["DamageLight"] = {
    [1] = "vo/npc/male01/pain01.wav",
    [2] = "vo/npc/male01/pain02.wav",
    [3] = "vo/npc/male01/pain03.wav",
    [4] = "vo/npc/male01/pain04.wav",
    [5] = "vo/npc/male01/pain05.wav",
    [6] = "vo/npc/male01/pain06.wav",
    [7] = "vo/npc/male01/ow01.wav",
    [8] = "vo/npc/male01/ow02.wav",
    [9] = "vo/npc/male01/startle02.wav",
}
AS.CharacterSounds.Male["DamageHeavy"] = {
    [1] = "vo/npc/male01/pain07.wav",
    [2] = "vo/npc/male01/pain08.wav",
    [3] = "vo/npc/male01/pain09.wav",
    [4] = "vo/npc/male01/hitingut01.wav",
    [5] = "vo/npc/male01/hitingut02.wav",
    [6] = "vo/npc/male01/myarm01.wav",
    [7] = "vo/npc/male01/myarm02.wav",
    [8] = "vo/npc/male01/mygut02.wav",
    [9] = "vo/npc/male01/myleg01.wav",
    [0] = "vo/npc/male01/myleg02.wav",
}
AS.CharacterSounds.Male["Death"] = {
    [1] = "vo/npc/male01/help01.wav",
    [2] = "vo/npc/male01/no02.wav",
}

-- Female

AS.CharacterSounds.Female["DamageLight"] = {
    [1] = "vo/npc/female01/pain01.wav",
    [2] = "vo/npc/female01/pain02.wav",
    [3] = "vo/npc/female01/pain03.wav",
    [4] = "vo/npc/female01/pain04.wav",
    [5] = "vo/npc/female01/pain05.wav",
    [6] = "vo/npc/female01/pain07.wav",
    [7] = "vo/npc/female01/pain08.wav",
    [8] = "vo/npc/female01/pain09.wav",
}
AS.CharacterSounds.Female["DamageHeavy"] = {
    [1] = "vo/npc/female01/hitingut01.wav",
    [2] = "vo/npc/female01/hitingut02.wav",
    [3] = "vo/npc/female01/imhurt01.wav",
    [4] = "vo/npc/female01/imhurt02.wav",
    [5] = "vo/npc/female01/myarm01.wav",
    [6] = "vo/npc/female01/myarm02.wav",
    [7] = "vo/npc/female01/mygut02.wav",
    [8] = "vo/npc/female01/myleg01.wav",
    [9] = "vo/npc/female01/myleg02.wav",
    [10] = "vo/npc/female01/ow01.wav",
    [11] = "vo/npc/female01/ow02.wav",
}
AS.CharacterSounds.Female["Death"] = {
    [1] = "vo/npc/female01/help01.wav",
    [2] = "vo/npc/female01/uhoh.wav",
}

function PlayerMeta:PlayCharacterSound( group, vol )
    if not group then return end
    vol = vol or 100
    local female = self:IsFemale()
    local snd = female and table.Random( AS.CharacterSounds.Female[group] ) or table.Random( AS.CharacterSounds.Male[group] )

    self:EmitSound( snd, vol, 100, 1, CHAN_STATIC )
end