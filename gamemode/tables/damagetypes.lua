AS.DamageTypes = {}
function AS.AddDamageType( ENUM, info )
    AS.DamageTypes = AS.DamageTypes or {}

    AS.DamageTypes[ENUM] = info
end

AS.AddDamageType( DMG_BULLET, {
    name = "Bullet Resistance",
    icon = "icon16/gun.png",
})

AS.AddDamageType( DMG_SLASH, {
    name = "Melee Resistance",
    icon = "icon16/user_gray.png",
})

AS.AddDamageType( DMG_BURN, {
    name = "Fire Resistance",
    icon = "icon16/fire.png",
})

AS.AddDamageType( DMG_ENERGYBEAM, {
    name = "Pulse Resistance",
    icon = "icon16/lightning.png",
})

AS.AddDamageType( DMG_BLAST, {
    name = "Explosive Resistance",
    icon = "icon16/bomb.png",
})