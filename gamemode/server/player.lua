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
    for k, v in pairs( SET.DefaultWeapons ) do
        ply:Give( k )
    end
end

function GM:PlayerDisconnected( ply )
    if not ply:IsLoaded() and not ply.pid then return end

    ply:SaveCharacter()
end

function GM:OnPlayerHitGround( ply, water, floater, speed )
    if water and speed > 525 then
        ply:TakeDamage( GAMEMODE:GetFallDamage( ply, speed ) )
        local num = {1, 3} --Because fallpain doesnt have a 2...
        ply:EmitSound( "player/pl_fallpain" .. table.Random( num ) .. ".wav" )
    end
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