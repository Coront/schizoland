AS.Effects = {}
function AS.AddEffect( id, data )
    AS.Effects = AS.Effects or {}

    AS.Effects[id] = data
end

-- ███╗   ██╗███████╗██╗   ██╗████████╗██████╗  █████╗ ██╗         ███████╗███████╗███████╗███████╗ ██████╗████████╗███████╗
-- ████╗  ██║██╔════╝██║   ██║╚══██╔══╝██╔══██╗██╔══██╗██║         ██╔════╝██╔════╝██╔════╝██╔════╝██╔════╝╚══██╔══╝██╔════╝
-- ██╔██╗ ██║█████╗  ██║   ██║   ██║   ██████╔╝███████║██║         █████╗  █████╗  █████╗  █████╗  ██║        ██║   ███████╗
-- ██║╚██╗██║██╔══╝  ██║   ██║   ██║   ██╔══██╗██╔══██║██║         ██╔══╝  ██╔══╝  ██╔══╝  ██╔══╝  ██║        ██║   ╚════██║
-- ██║ ╚████║███████╗╚██████╔╝   ██║   ██║  ██║██║  ██║███████╗    ███████╗██║     ██║     ███████╗╚██████╗   ██║   ███████║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    ╚══════╝╚═╝     ╚═╝     ╚══════╝ ╚═════╝   ╚═╝   ╚══════╝

AS.AddEffect( "treatmentdelay", {
    name = "Treatment Cooldown",
    desc = "Unable to treat other players.",
    icon = "icon16/pill_delete.png",
    type = "neutral",
} )

-- ███╗   ██╗███████╗ ██████╗  █████╗ ████████╗██╗██╗   ██╗███████╗    ███████╗███████╗███████╗███████╗ ██████╗████████╗███████╗
-- ████╗  ██║██╔════╝██╔════╝ ██╔══██╗╚══██╔══╝██║██║   ██║██╔════╝    ██╔════╝██╔════╝██╔════╝██╔════╝██╔════╝╚══██╔══╝██╔════╝
-- ██╔██╗ ██║█████╗  ██║  ███╗███████║   ██║   ██║██║   ██║█████╗      █████╗  █████╗  █████╗  █████╗  ██║        ██║   ███████╗
-- ██║╚██╗██║██╔══╝  ██║   ██║██╔══██║   ██║   ██║╚██╗ ██╔╝██╔══╝      ██╔══╝  ██╔══╝  ██╔══╝  ██╔══╝  ██║        ██║   ╚════██║
-- ██║ ╚████║███████╗╚██████╔╝██║  ██║   ██║   ██║ ╚████╔╝ ███████╗    ███████╗██║     ██║     ███████╗╚██████╗   ██║   ███████║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═══╝  ╚══════╝    ╚══════╝╚═╝     ╚═╝     ╚══════╝ ╚═════╝   ╚═╝   ╚══════╝

AS.AddEffect( "poison", {
    name = "Poison",
    desc = "Lose health over time.",
    icon = "icon16/bug.png",
    color = Color( 205, 180, 0),
    type = "negative",
} )

AS.AddEffect( "poisonsevere", {
    name = "Poison - Severe",
    desc = "Lose health quickly over time.",
    icon = "icon16/bug.png",
    color = Color( 205, 180, 0),
    type = "negative",
} )

AS.AddEffect( "healingsickness", {
    name = "Healing Sickness",
    desc = "Cannot use healing items.",
    icon = "icon16/heart_delete.png",
    type = "negative",
} )

AS.AddEffect( "stunned", {
    name = "Stunned",
    desc = "Slowed movement speed.",
    icon = "icon16/arrow_refresh.png",
    color = Color( 160, 135, 55 ),
    type = "negative",
} )

-- ██████╗  ██████╗ ███████╗██╗████████╗██╗██╗   ██╗███████╗    ███████╗███████╗███████╗███████╗ ██████╗████████╗███████╗
-- ██╔══██╗██╔═══██╗██╔════╝██║╚══██╔══╝██║██║   ██║██╔════╝    ██╔════╝██╔════╝██╔════╝██╔════╝██╔════╝╚══██╔══╝██╔════╝
-- ██████╔╝██║   ██║███████╗██║   ██║   ██║██║   ██║█████╗      █████╗  █████╗  █████╗  █████╗  ██║        ██║   ███████╗
-- ██╔═══╝ ██║   ██║╚════██║██║   ██║   ██║╚██╗ ██╔╝██╔══╝      ██╔══╝  ██╔══╝  ██╔══╝  ██╔══╝  ██║        ██║   ╚════██║
-- ██║     ╚██████╔╝███████║██║   ██║   ██║ ╚████╔╝ ███████╗    ███████╗██║     ██║     ███████╗╚██████╗   ██║   ███████║
-- ╚═╝      ╚═════╝ ╚══════╝╚═╝   ╚═╝   ╚═╝  ╚═══╝  ╚══════╝    ╚══════╝╚═╝     ╚═╝     ╚══════╝ ╚═════╝   ╚═╝   ╚══════╝

AS.AddEffect( "treatment", {
    name = "Treatment",
    desc = "Regain health over time.",
    icon = "icon16/heart_add.png",
    type = "positive",
} )

AS.AddEffect( "painkillers", {
    name = "Painkillers",
    desc = "Reduces incoming damage by 10%.",
    icon = "icon16/shield_add.png",
    type = "positive",
} )

AS.AddEffect( "adrenaline", {
    name = "Adrenaline Shot",
    desc = "Increases movement speed by 15%.",
    icon = "icon16/lightning.png",
    type = "positive",
} )

-- ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝

hook.Add( "Think", "AS_Effect_Treatment", function()
    for k, v in pairs( player.GetAll() ) do
        if not v:HasStatus( "treatment" ) then continue end --Skip every player that doesn't have this effect.
        if v:Health() >= v:GetMaxHealth() then continue end --Skip players that are at max health.
        if CurTime() < (v.Treatment_NextTick or 0) then continue end --Still waiting for tick.

        v.Treatment_NextTick = CurTime() + 0.99
        if ( SERVER ) then
            v:SetHealth( math.Clamp( v:Health() + 1, 0, v:GetMaxHealth() ) )
        end
    end
end)

hook.Add( "Think", "AS_Effect_Poison", function()
    for k, v in pairs( player.GetAll() ) do
        if not v:HasStatus( "poison" ) and not v:HasStatus( "poisonsevere" ) then continue end --Skip every player that doesn't have this effect.
        if CurTime() < (v.Poison_NextTick or 0) then continue end --Still waiting for tick.
        local severepoison = v:HasStatus( "poisonsevere" ) and true or false

        v.Poison_NextTick = CurTime() + (severepoison and 0.39 or 0.99)
        if ( SERVER ) then
            v:TakeDamage( 1 )
        end
    end
end)

hook.Add( "EntityTakeDamage", "AS_Effect_Painkiller", function( target, dmginfo )
    if target:IsPlayer() and target:HasStatus( "painkillers" ) then
        dmginfo:SetDamage( dmginfo:GetDamage() * 0.9 )
    end
end)