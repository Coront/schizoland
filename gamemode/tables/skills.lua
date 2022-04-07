-- Skills

AS.AddBaseSkill( "health", {
    name = "Health", --Name
    desc = "Increases your maximum health. Leveled by special circumstances.", --Description
    icon = "", --Icon defaulted to, use silkicons
    max = 10, --Level capacity, we will not gain any more experience one we reach this.
    basexp = 5, --Base Experience
    power = 2 --How much the next xp req will be powered by. Defaults to 2.
} )

AS.AddBaseSkill( "strength", {
    name = "Strength",
    desc = "Increases your carry capacity as well as the ability to deal damage with melee weapons. Leveled by use of melee weapons.",
    icon = "",
    max = 50,
    basexp = 1,
    power = 1.5,
} )

AS.AddBaseSkill( "endurance", {
    name = "Endurance",
    desc = "Increases overall movement speed. Leveled by actively moving.",
    icon = "",
    max = 50,
    basexp = 1,
    power = 1.4,
} )

AS.AddBaseSkill( "weaponhandling", {
    name = "Weapon Handling",
    desc = "Reduces overall weapon recoil. Leveled by use of firearms.",
    icon = "",
    max = 25,
    basexp = 1,
    power = 2,
} )

AS.AddBaseSkill( "salvaging", {
    name = "Salvaging",
    desc = "Increases your chances of successfully finding resources from salvaging a node, increases the minimal and maximum amount that can be found, and increases your chances of finding items. Leveled by salvaging nodes.",
    icon = "",
    max = 20,
    basexp = 1,
    power = 1.85,
} )