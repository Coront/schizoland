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