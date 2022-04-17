-- ██████╗ ██╗      █████╗ ██╗   ██╗███████╗██████╗
-- ██╔══██╗██║     ██╔══██╗╚██╗ ██╔╝██╔════╝██╔══██╗
-- ██████╔╝██║     ███████║ ╚████╔╝ █████╗  ██████╔╝
-- ██╔═══╝ ██║     ██╔══██║  ╚██╔╝  ██╔══╝  ██╔══██╗
-- ██║     ███████╗██║  ██║   ██║   ███████╗██║  ██║
-- ╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
-- Desc: Player functionality managed here, i.e. creating/loading information, etc.

function GM:ShowHelp( ply ) ply:SendLua( "gui.OpenURL( GAMEMODE.Discord )" ) end --Discord
function GM:ShowTeam( ply ) ply:ConCommand( "as_settings" ) end --Settings menu

function GM:PlayerInitialSpawn( ply ) --Player's first spawn. 
    ply:SetNW2Bool( "as_spawned", false ) --Player just loaded in, they have not selected their profile yet.
    ply:ConCommand("as_spawnmenu")
end

function GM:PlayerSpawn( ply )
    if not ply:IsLoaded() then --Prevent players from spawning in, as they havent loaded a character yet.
        ply:Spectate(OBS_MODE_ROAMING)
        ply:Freeze(true)
        if AS.Maps[game.GetMap()] and AS.Maps[game.GetMap()].Load then
            ply:SetPos( AS.Maps[game.GetMap()].Load["pos"] )
            ply:SetEyeAngles( AS.Maps[game.GetMap()].Load["ang"] )
        else
            ply:SetPos( Vector(0, 0, 0) )
        end
        return
    end

    --Everything else here will be ran if the player has loaded their character.
    if AS.Maps[game.GetMap()] and AS.Maps[game.GetMap()].Spawns then
        ply:SetPos( table.Random(AS.Maps[game.GetMap()].Spawns) )
        ply:SetEyeAngles( Angle(0, 180, 0) )
    else
        if ply:IsAdmin() then ply:ChatPrint("[AS] There is no proper map data set up! Players will spawn at a random point!") end
    end

    local health = SKL.Health
    if ply:GetASClass() == "mercenary" then
        health = health * CLS.Mercenary.healthmult
    elseif ply:GetASClass() == "scavenger" then
        health = health * CLS.Scavenger.healthmult
    end
    ply:SetHealth(health)
    ply:SetMaxHealth(health)
    ply:SetupHands()
    ply:SetCustomCollisionCheck( true )
    ply:AddEFlags( EFL_NO_DAMAGE_FORCES )
    for k, v in SortedPairs( SET.DefaultWeapons ) do
        ply:Give( v )
    end
end

function GM:PlayerDisconnected( ply )
    if not ply:IsLoaded() and not ply.pid then return end

    local tools = ply:GetAllTools()
    for k, v in pairs( tools ) do
        v:Remove()
    end

    ply:SaveCharacter()

    for k, v in pairs( player.GetAll() ) do
        v:ChatPrint( ply:Nickname() .. " has left the server." )
    end
end

function GM:OnPlayerHitGround( ply, water, floater, speed )
    if water and speed > 525 then
        ply:TakeDamage( GAMEMODE:GetFallDamage( ply, speed ) )
        local num = {1, 3} --Because fallpain doesnt have a 2...
        ply:EmitSound( "player/pl_fallpain" .. table.Random( num ) .. ".wav" )
    end
end

function GM:PlayerDeath( victim, inflictor, attacker )
    local length = tobool(GetConVar("as_respawnwait"):GetInt()) and SET.DeathWait or 1
    victim:SetNW2Int("AS_NextRespawn", CurTime() + length )
    victim:SetNW2Int("AS_LastDeath", CurTime() )
end

function GM:PlayerDeathThink( ply )
    if CurTime() > (ply:GetNW2Int("AS_NextRespawn") or 0) then
        ply:Spawn()
    end
    return false
end

function GM:PostPlayerDeath( ply )
    local contents = {} --Player's dropped contents
    for k, v in pairs( ply:GetWeapons() ) do
        if not v.ASID then continue end
        contents[v.ASID] = 1
        if v:Clip1() >= 1 and translateAmmoNameID( game.GetAmmoName(v:GetPrimaryAmmoType()) ) then
            contents.ammo = contents.ammo or {}
            contents.ammo[translateAmmoNameID(game.GetAmmoName(v:GetPrimaryAmmoType()))] = v:Clip1()
        end
    end
    for k, v in pairs( ply:GetAmmo() ) do
        if not translateAmmoNameID( game.GetAmmoName(k) ) then continue end --not a AS ammotype
        contents.ammo = contents.ammo or {}
        contents.ammo[translateAmmoNameID(game.GetAmmoName(k))] = (contents.ammo[translateAmmoNameID(game.GetAmmoName(k))] or 0) + v
    end
    --resources
    for k, v in pairs( ply:GetInventory() ) do
        if k != "misc_scrap" and k != "misc_smallparts" and k != "misc_chemical" then continue end --skip everything that isnt a resource
        local reslost = math.ceil(v * (1 / SET.DeathResCost))
        if reslost <= 0 then continue end
        ply:TakeItemFromInventory( k, reslost )
        contents[k] = reslost
    end
    ply:ResyncInventory()

    --Entity
    if table.Count(contents) > 0 then
        local ent = ents.Create("as_case")
        local trace = util.TraceLine({
            start = ply:GetPos() + ply:OBBCenter(),
            endpos = (ply:GetPos() + ply:OBBCenter()) + Vector( 0, 0, -9999 ),
            filter = {ent},
        })
        ent:SetPos( trace.HitPos + (ent:OBBCenter() + Vector( 0, 0, 20 )) )
        ent:SetInventory( contents )
        timer.Simple( 0.1, function() --im literally seetheing rn
            ent:ResyncInventory()
        end)
        ent:Spawn()
        local phys = ent:GetPhysicsObject()
        phys:EnableMotion( false )
        ent:SetNW2String("owner", ply:Nickname())
    end

    ply:ClearAllStatuses()
    ply:ResyncStatuses()
    ply:SetHealth( 15 ) --This is just so it doesnt save 0 to the player's health in the database.
    ply:SaveCharacter()
end

function GM:GetFallDamage( ply, speed )
    return math.max(1, ( speed - 526.5 ) * ( ply:GetMaxHealth() / 396 ))
end

function GM:PlayerDeathSound( ply )
    return true --Will hide the player death sound.
end

hook.Add( "Think", "AS_PassiveHealing", function()
    for k, v in pairs(player.GetAll()) do
        if not v:IsLoaded() then continue end --We skip players who arent loaded for this check.
        if v:Health() >= v:GetMaxHealth() then continue end --Skip players at full hp, no reason for them to have this check.

        local hpToHeal = 0
        if v:GetHunger() >= SAT.SatBuffs and v:GetThirst() >= SAT.SatBuffs then
            hpToHeal = hpToHeal + 1
        end
        for k2, v2 in pairs(ents.FindByClass("env_fire")) do
            if v:GetPos():Distance(v2:GetPos()) > 150 then continue end
            hpToHeal = hpToHeal + 1
            break
        end
        if hpToHeal == 0 then continue end --We skip this player because they cannot be healed.

        if CurTime() > (v.NextHealthUpdate or 0) then
            v.NextHealthUpdate = CurTime() + SET.HealthUpdating
            v:SetHealth( v:Health() + hpToHeal )
            if v:Health() >= v:GetMaxHealth() then
                v:SetHealth( v:GetMaxHealth() )
            end
        end
    end
end)

hook.Add( "EntityTakeDamage", "AS_ArmorResistance", function( victim, dmginfo )
    if not victim:IsPlayer() then return end --This is a function for players only.
    local ply = victim
    if not ply:HasArmor() then return end --Doesn't have armor. No reason to run this.
    local curarmor = ply:GetArmor()
    local armorres = AS.Items[curarmor].armor
    local dmgtype = dmginfo:GetDamageType()
    if not armorres[dmgtype] then return end --Defense value doesnt exist. ignore.

    local overallDamage = dmginfo:GetDamage()
    local multDamage = 1 - (armorres[dmgtype] / 100)
    local toDamage = (overallDamage * multDamage)
    local damage = toDamage < 1 and 1 or math.Round( toDamage )
    dmginfo:SetDamage( damage )
end)