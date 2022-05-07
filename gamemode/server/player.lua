-- ██████╗ ██╗      █████╗ ██╗   ██╗███████╗██████╗
-- ██╔══██╗██║     ██╔══██╗╚██╗ ██╔╝██╔════╝██╔══██╗
-- ██████╔╝██║     ███████║ ╚████╔╝ █████╗  ██████╔╝
-- ██╔═══╝ ██║     ██╔══██║  ╚██╔╝  ██╔══╝  ██╔══██╗
-- ██║     ███████╗██║  ██║   ██║   ███████╗██║  ██║
-- ╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
-- Desc: Player functionality managed here, i.e. creating/loading information, etc.

function GM:ShowHelp( ply ) ply:SendLua( "gui.OpenURL( GAMEMODE.Discord )" ) end --Discord
function GM:ShowTeam( ply ) ply:ConCommand( "as_settings" ) end --Settings menu

function GM:PlayerConnect( name, ip )
    if (SERVER) then
        for k, v in pairs( player.GetAll() ) do
            v:ChatPrint( name .. " has joined the server." )
        end
    end
end

function GM:PlayerInitialSpawn( ply ) --Player's first spawn.
    ply:SetNWBool( "as_spawned", false ) --Player just loaded in, they have not selected their profile yet.
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

    if not tobool(GetConVar("as_cases"):GetInt()) and ply.ItemReturns then
        for k, v in pairs( ply.ItemReturns ) do
            if k == "ammo" then
                for k2, v2 in pairs( v ) do
                    ply:GiveAmmo( v2, AS.Items[k2].use.ammotype, true )
                end
                continue 
            end
            ply:Give( AS.Items[k].wep )
        end
        ply.ItemReturns = nil
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
    victim:SetNWInt("AS_NextRespawn", CurTime() + length )
    victim:SetNWInt("AS_LastDeath", CurTime() )
end

function GM:PlayerDeathThink( ply )
    if CurTime() > (ply:GetNWInt("AS_NextRespawn") or 0) then
        ply:Spawn()
    end
    return false
end

hook.Add( "DoPlayerDeath", "AS_PlayerDeath", function( ply, attacker, dmginfo )
    ply:PlayCharacterSound( "Death", 95 )
    ply:ChatPrint("You died.")

    local snd = {
        "music/stingers/hl1_stinger_song16.mp3",
        "music/stingers/hl1_stinger_song7.mp3",
        "music/stingers/hl1_stinger_song8.mp3",
        "music/stingers/hl1_stinger_song28.mp3",
    }
    local tosnd = table.Random(snd)
    net.Start("as_deathstinger")
        net.WriteString( tosnd )
    net.Send(ply)

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

    if not tobool(GetConVar("as_cases"):GetInt()) then
        ply:ChatPrint("Your items will be returned to you when you respawn.")
        ply.ItemReturns = contents

        return --prevent the rest of the code from running
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

    --Recent Inventory
    if ply:HasRecentInventory() then --Player has recently taken items from a claimed case. We will make them drop those items.
        ply:ChatPrint("Recent items you have taken from a case have been dropped.")

        for k, v in pairs( ply:GetRecentInv() ) do
            if not ply:HasInInventory( k, v ) then continue end
            ply:TakeItemFromInventory( k, v )
            contents[k] = (contents[k] or 0) + v
            ply:ResyncInventory()
        end

        ply:ClearRecentInv()
        ply:SetRecentInvDelay( 0 )
    end

    --Entity
    if table.Count(contents) > 0 then
        local ent = ents.Create("as_case")
        local trace = util.TraceLine({
            start = ply:GetPos() + ply:OBBCenter(),
            endpos = (ply:GetPos() + ply:OBBCenter()) + Vector( 0, 0, -9999 ),
            filter = {ent, ply},
        })
        ent:SetPos( trace.HitPos + (ent:OBBCenter() + Vector( 0, 0, 20 )) )
        ent:SetInventory( contents )
        timer.Simple( 0.1, function() --im literally seetheing rn
            ent:ResyncInventory()
        end)
        ent:Spawn()
        local phys = ent:GetPhysicsObject()
        phys:EnableMotion( false )
        ent:SetNWString("owner", ply:Nickname())
        if attacker:IsPlayer() and ply != attacker then
            ent:SetNWEntity("killer", attacker)
        end
    end

    --War
    if attacker:IsPlayer() and ply:IsPlayer() and CurTime() >= (attacker.NextWarRequest or 0) then
        if attacker == ply then return end
        if not attacker:InCommunity() then return end
        if not ply:InCommunity() then return end
        if ply:GetCommunity() == attacker:GetCommunity() then return end --no civil wars please
        if ply:IsAtWar( attacker:GetCommunity() ) then return end --Don't generate more requests from war?

        community.CreateDiplomacy( ply:GetCommunity(), "war", { --This create's a diplomacy of war, and we'll add some information.
            cid = attacker:GetCommunity(),
            cname = attacker:GetCommunityName(),
            text = "The community, " .. attacker:GetCommunityName() .. ", has committed an act of war!\n\n" .. attacker:Nickname() .. " killed " .. ply:Nickname() .. " on " .. os.date( "%m/%d/%y - %I:%M %p", os.time() ) .. ".",
        })

        attacker:ChatPrint("You have committed an act of war.")
        attacker.NextWarRequest = CurTime() + 900 --This just stops us from making too many war requests in a short period of time.
    end

    ply:ClearAllStatuses()
    ply:ResyncStatuses()
    ply:SetHealth( 15 ) --This is just so it doesnt save 0 to the player's health in the database.
    ply:SaveCharacter()
end)

function GM:GetFallDamage( ply, speed )
    return math.max(1, ( speed - 526.5 ) * ( ply:GetMaxHealth() / 396 ))
end

function GM:PlayerDeathSound( ply )
    return true --Will hide the player death sound.
end

hook.Add( "CanPlayerEnterVehicle", "AS_CarSeatLock", function( ply, vehicle, role )
    if vehicle.Locked then return false end
    return true
end)

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

hook.Add( "EntityTakeDamage", "AS_DamageSounds", function( victim, dmginfo ) 
    if not victim:IsPlayer() then return end
    local ply = victim
    local amt = dmginfo:GetDamage()
    local type = dmginfo:GetDamageType()
    if type != DMG_SLASH and type != DMG_BULLET and type != DMG_ENERGYBEAM then return end

    if amt >= 15 and CurTime() > (ply.NextInjuredSound or 0) then
        ply.NextInjuredSound = CurTime() + 10

        local group = amt >= 15 and amt < 40 and "DamageLight" or "DamageHeavy"
        local volume = amt >= 15 and amt < 40 and 70 or 80
        ply:PlayCharacterSound( group, volume )
    end
end)

hook.Add( "PlayerSay", "AS_PlayerChatLog", function( ply, text )
	if ply and IsValid( ply ) then
		sql.Query("INSERT INTO as_chatlog VALUES ( " .. SQLStr(ply:SteamID()) .. ", " .. SQLStr(ply:Nickname()) .. ", " .. SQLStr(text) .. ", " .. SQLStr( os.date("%m/%d/%y - %I:%M %p", os.time()) ) .. ")")
	else
		sql.Query("INSERT INTO as_chatlog VALUES ( '-1', 'ERROR_NOUSER', " .. SQLStr(text) .. ", " .. SQLStr( os.date("%m/%d/%y - %I:%M %p", os.time()) ) .. ")")
	end
end)

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString( "as_chatmessage" )
util.AddNetworkString( "as_deathstinger" )