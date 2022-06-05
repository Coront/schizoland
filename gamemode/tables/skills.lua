AS.Skills = {}
function AS.AddBaseSkill( id, data )
    AS.Skills = AS.Skills or {}

    AS.Skills[id] = data
end

-- ███████╗██╗  ██╗██╗██╗     ██╗     ███████╗
-- ██╔════╝██║ ██╔╝██║██║     ██║     ██╔════╝
-- ███████╗█████╔╝ ██║██║     ██║     ███████╗
-- ╚════██║██╔═██╗ ██║██║     ██║     ╚════██║
-- ███████║██║  ██╗██║███████╗███████╗███████║
-- ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝╚══════╝

AS.AddBaseSkill( "strength", {
    name = "Strength",
    desc = "Increases your carry capacity as well as the ability to deal damage with melee weapons. Leveled by use of melee weapons.",
    icon = "",
    max = 25,
    basexp = 1,
    power = 1.6,
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

AS.AddBaseSkill( "treatment", {
    name = "Treatment",
    desc = "Increases the lasting length of your treatments and reduces the cooldown time. Leveled by treating players.",
    icon = "",
    max = 10,
    basexp = 1,
    power = 1.85,
} )

AS.AddBaseSkill( "farming", {
    name = "Farming",
    desc = "Decreases the time it takes for plants to produce food, and the time it takes to prune them. Leveled when plants produce food.",
    icon = "",
    max = 20,
    basexp = 1,
    power = 1.85,
} )

AS.AddBaseSkill( "mining", {
    name = "Mining",
    desc = "Decreases the time it takes for a miner to produce resources. Leveled by miner production.",
    icon = "",
    max = 5,
    basexp = 1,
    power = 1.85,
} )
--[[
AS.AddBaseSkill( "charisma", {
    name = "Charisma",
    desc = "(Work In Progress) Decreases the cost of items at traders, while increasing the price of items that are sold. Leveled by bartering with traders.",
    icon = "",
    max = 5,
    basexp = 1,
    power = 1.85,
} )
]]