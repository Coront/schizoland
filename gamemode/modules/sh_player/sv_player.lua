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
    if ply:GetInfoNum("as_acknowledgerules", 0) < 1 then
        ply:ConCommand("as_firstjoinmenu")
    else
        ply:ConCommand("as_spawnmenu")
    end

    if not sql.QueryValue("SELECT * FROM as_playerdata WHERE steamid = " .. SQLStr(ply:SteamID()) ) then
        sql.Query("INSERT INTO as_playerdata VALUES( " .. SQLStr( ply:SteamID() ) .. ", " .. SQLStr( ply:Nick() ) .. ", " .. SQLStr( ply:IPAddress() ) .. ", " .. SQLStr( os.date( "%m/%d/%y - %I:%M %p", os.time() ) ) .. ")")
    end
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

    if IsValid( ply:GetNWEntity( "Deathdoll" ) ) then
        ply:GetNWEntity( "Deathdoll" ):Remove()
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
            if AS.Items[k].category == "misc" then
                ply:AddItemToInventory( k, v )
                continue
            end
            if AS.Items[k].wep then
                ply:Give( AS.Items[k].wep )
            end
        end
        ply.ItemReturns = nil
    end

    if ply:InCommunity() and table.Count(Communities[ply:GetCommunity()].wars) >= 1 then
        ply:ChatPrint("Temporary Godmode Enabled (Reason: War).")
        ply:GodEnable()
        ply.DisableGodmodeIn = CurTime() + 20
    end
end

function GM:PlayerDisconnected( ply )
    if not ply:IsLoaded() and not ply.pid then return end

    local tools = ply:GetAllTools()
    for k, v in pairs( tools ) do
        if v:GetClass() == "as_healthstation" then
            local inv = v:GetInventory()
            for k, v in pairs( inv ) do
                ply:AddItemToInventory( k, v )
            end
        end
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

function GM:DoPlayerDeath( ply, attacker, dmg )
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
    for k, v in pairs( ply:GetAttachmentInventory() ) do
        if not AS.Items[v] then continue end
        contents[v] = 1
    end
    for k, v in pairs( ply:GetAmmo() ) do
        if not translateAmmoNameID( game.GetAmmoName(k) ) then continue end --not a AS ammotype
        contents.ammo = contents.ammo or {}
        contents.ammo[translateAmmoNameID(game.GetAmmoName(k))] = (contents.ammo[translateAmmoNameID(game.GetAmmoName(k))] or 0) + v
    end
    ply:SetAttachmentInventory( {} ) --Wipe Attachments

    if not tobool(GetConVar("as_cases"):GetInt()) then
        ply:ChatPrint("Your items will be returned to you when you respawn.")
        ply.ItemReturns = contents
    else
        --resources
        for k, v in pairs( ply:GetInventory() ) do
            if k != "misc_scrap" and k != "misc_smallparts" and k != "misc_chemical" then continue end --skip everything that isnt a resource
            local reslost = math.ceil(v * (1 / SET.DeathResCost))
            if reslost <= 0 then continue end
            ply:TakeItemFromInventory( k, reslost )
            contents[k] = reslost
        end

        --Recent Inventory
        if ply:HasRecentInventory() then --Player has recently taken items from a claimed case. We will make them drop those items.
            ply:ChatPrint("Recent items you have taken from a case have been dropped.")

            for k, v in pairs( ply:GetRecentInv() ) do
                if not ply:HasInInventory( k, v ) then continue end
                ply:TakeItemFromInventory( k, v )
                contents[k] = (contents[k] or 0) + v
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
    end

    --War
    if attacker:IsPlayer() and ply:IsPlayer() and CurTime() >= (attacker.NextWarRequest or 0) then
        if not attacker == ply and attacker:InCommunity() and ply:InCommunity() and not ply:GetCommunity() == attacker:GetCommunity() and not ply:IsAtWar( attacker:GetCommunity() ) then
            community.CreateDiplomacy( ply:GetCommunity(), "war", { --This create's a diplomacy of war, and we'll add some information.
                cid = attacker:GetCommunity(),
                cname = attacker:GetCommunityName(),
                text = "The community, " .. attacker:GetCommunityName() .. ", has committed an act of war!\n\n" .. attacker:Nickname() .. " killed " .. ply:Nickname() .. " on " .. os.date( "%m/%d/%y - %I:%M %p", os.time() ) .. ".",
            })

            attacker:ChatPrint("You have committed an act of war.")
            attacker.NextWarRequest = CurTime() + 900 --This just stops us from making too many war requests in a short period of time.
        end
    end

    --Stat
    if attacker:IsPlayer() and attacker != ply then
        attacker:AddToStatistic( "kills_player", 1 )
    end

    --Rag
    local rag = ents.Create("prop_ragdoll")
    ply:SetNWEntity( "Deathdoll", rag )
    rag.Owner = ply
    rag:SetModel( ply:GetModel() )
    rag:SetPos( ply:GetPos() )
    rag:SetAngles( ply:GetAngles() )
    rag:Spawn()
    local bones = rag:GetPhysicsObjectCount()
	for i=1,bones-1 do
		local bone = rag:GetPhysicsObjectNum( i )
		if bone then
			local bonepos, boneang = ply:GetBonePosition( rag:TranslatePhysBoneToBone( i ) )
			bone:SetPos( bonepos )
			bone:SetAngles( boneang )
		end
	end
    rag:SetCollisionGroup( COLLISION_GROUP_WEAPON )
    timer.Simple( 60, function() 
        if IsValid( rag ) then
            rag:Remove()
        end
    end)

    ply.LastDeathPos = ply:GetPos()
    ply:ClearAllStatuses()
    ply:ResyncStatuses()
    ply:SetHealth( 15 ) --This is just so it doesnt save 0 to the player's health in the database.
    ply:SaveCharacter()

    ply:AddToStatistic( "deaths", 1 )
end

function GM:PlayerDeath( victim, inflictor, attacker )
    local length = tobool(GetConVar("as_respawnwait"):GetInt()) and SET.DeathWait or 1
    victim:SetNWInt("AS_NextRespawn", CurTime() + length )
    victim:SetNWInt("AS_LastDeath", CurTime() )
end

function GM:PlayerDeathThink( ply )
    if CurTime() > (ply:GetNWInt("AS_NextRespawn") or 0) then
        ply.NoDefib = 0
        ply:Spawn()
    end
    return false
end

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
        if v:IsSitting() then
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

hook.Add( "Think", "AS_TempGodmode", function()
    for k, v in pairs(player.GetAll()) do
        if not v.DisableGodmodeIn or v.DisableGodmodeIn == 0 then continue end

        if CurTime() > v.DisableGodmodeIn then
            v.DisableGodmodeIn = 0
            v:GodDisable()
            v:ChatPrint("Temporary Godmode Disabled.")
        end
    end
end)

hook.Add( "EntityTakeDamage", "AS_TempGodmode", function( victim, dmginfo ) 
    if not victim:IsPlayer() then return end
    local ply = victim

    if ply:HasGodMode() then
        local attacker = dmginfo:GetAttacker()
        if attacker and IsValid(attacker) and attacker:IsPlayer() then
            attacker:ChatPrint( victim:Nickname() .. " has temporary godmode enabled.")
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

function PlayerMeta:Sit()
    if CurTime() < (self.NextSit or 0) then self:ChatPrint("Please wait before attempting to sit again!") return end
    self.Sitting = true
    net.Start("as_sitting")
        net.WriteEntity( self )
    net.Broadcast()

    self:ResyncSit()
end

function PlayerMeta:Unsit()
    self.Sitting = false
    self.NextSit = CurTime() + 5
    net.Start("as_sitting_end")
        net.WriteEntity( self )
    net.Broadcast()

    self:ResyncSit()
end

function PlayerMeta:IsSitting()
    if self.Sitting then return true end
    return false
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString( "as_chatmessage" )
util.AddNetworkString( "as_deathstinger" )
util.AddNetworkString( "as_sitting" )
util.AddNetworkString( "as_sitting_end" )
util.AddNetworkString( "as_sitting_resync" )
util.AddNetworkString( "as_sitting_request" )

function PlayerMeta:ResyncSit()
    net.Start("as_sitting_resync")
        net.WriteEntity( self )
        net.WriteBit( self.Sitting )
    net.Broadcast()
end

net.Receive("as_sitting_request", function( _, ply )
    local ent = net.ReadEntity()
    if not IsValid( ent ) then return end

    net.Start("as_sitting_resync")
        net.WriteEntity( ent )
        net.WriteBit( ent.Sitting )
    net.Send( ply )
end)