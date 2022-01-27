-- Skills

AS.AddBaseSkill( "hitpoints", {
    name = "Hitpoints", --Name
    desc = "Determines the total amount of damage you can take before dying.", --Description
    icon = "", --Icon defaulted to, use silkicons
    max = 100, --Level capacity, we will not gain any more experience one we reach this.
    basexp = 25, --Base Experience
})

AS.AddBaseSkill( "melee", {
    name = "Melee",
    desc = "Determines the effectiveness of melee weapons.",
    icon = "",
    max = 100,
    basexp = 25,
})

AS.AddBaseSkill( "firearms", {
    name = "Firearms",
    desc = "Determines the effectiveness of firearms.",
    icon = "",
    max = 100,
    basexp = 25,
})

AS.AddBaseSkill( "crafting", {
    name = "Crafting",
    desc = "Increases chance of successful crafts and unlocks new recipes.",
    icon = "",
    max = 100,
    basexp = 25,
})

AS.AddBaseSkill( "endurance", {
    name = "Endurance",
    desc = "Increases base run speed.",
    icon = "",
    max = 100,
    basexp = 25,
})

AS.AddBaseSkill( "mining", {
    name = "Mining",
    desc = "Increases the chance of obtaining items from mining and unlocks new resources.",
    icon = "",
    max = 100,
    basexp = 25,
})