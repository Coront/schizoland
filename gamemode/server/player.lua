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
    if ply:GetNW2Bool("as_spawned", false) == false then --Prevent players from spawning in, as they havent loaded a character yet.
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
end