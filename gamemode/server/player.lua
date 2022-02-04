-- ██████╗ ██╗      █████╗ ██╗   ██╗███████╗██████╗
-- ██╔══██╗██║     ██╔══██╗╚██╗ ██╔╝██╔════╝██╔══██╗
-- ██████╔╝██║     ███████║ ╚████╔╝ █████╗  ██████╔╝
-- ██╔═══╝ ██║     ██╔══██║  ╚██╔╝  ██╔══╝  ██╔══██╗
-- ██║     ███████╗██║  ██║   ██║   ███████╗██║  ██║
-- ╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
-- Desc: Player functionality managed here, i.e. creating/loading information, etc.

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

    ply:SetHealth(SKL.Health)
    ply:SetMaxHealth(SKL.Health)
    ply:SetupHands()
    --ply:Give( "as_mainwep" )
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