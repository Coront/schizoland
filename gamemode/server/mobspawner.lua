AS.Grid = {}
AS.GridEnts = {}
ActiveGrid = ActiveGrid or {} --The AS. table is reset every time the server is updated, so to prevent the active grid from being wiped I made this independent instead.

--  ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
-- ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
-- ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
-- ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
-- ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
--  ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝

function AS.Grid.Modify( ply )
    if not ply:IsAdmin() then ply:ChatPrint("You are not an admin.") return end

    ply:ChatPrint("Spawning active grid table entities. Server may lag...")
    for k, v in pairs( ents.FindByClass("as_mobspawner") ) do --We need to clear any previous spawners we might of had.
        v:Remove()
    end
    for k, v in pairs( ActiveGrid ) do
        local ent = ents.Create("as_mobspawner")
        ent:SetPos( v.pos )
        ent:Spawn()
        ent:GetPhysicsObject():EnableMotion(false)
        ent:SetMoveType(MOVETYPE_NONE)
        ent:SetNWInt( "Distance", v.distance )
        ent:SetNWBool( "Nodes", v.nodes )
        ent:SetNWBool( "Mobs", v.mobs )
        ent:SetNWBool( "Events", v.events )
        ent:SetNWBool( "Indoor", v.indoor )
    end

    ply:ChatPrint("Finished! Total of " .. #ActiveGrid .. " ent(s) created. You can view them in noclip with your physgun/toolgun.")
    ply:ChatPrint("Remember that these entities can cause passive lag. Make sure you clear them when finished modifying the grid.")
end
concommand.Add( "as_grid_modify", AS.Grid.Modify )

function AS.Grid.Save( ply )
    if not ply:IsAdmin() then ply:ChatPrint("You are not an admin.") return end
    if #ents.FindByClass("as_mobspawner") == 0 then ply:ChatPrint("There is nothing to save.") return end

    --Update the live server's grid table
    ply:ChatPrint("Updating active grid table...")
    ActiveGrid = {} --We need to reset the current ones so we arent accidentily stacking on old spawnpoints.
    for k, v in pairs( ents.FindByClass("as_mobspawner") ) do
        ActiveGrid[#ActiveGrid + 1] = {
            pos         = v:GetPos(),
            distance    = v:GetNWInt("Distance", 1000),
            nodes       = v:GetNWBool("Nodes", true),
            mobs        = v:GetNWBool("Mobs", true),
            events      = v:GetNWBool("Events", false),
            indoor      = v:GetNWBool("Indoor", false),
        }
    end

    --Save the new grid to the database
    ply:ChatPrint("Saving current grid to database...")
    local mapExists = sql.QueryValue("SELECT * FROM as_grids WHERE map = " .. SQLStr(game.GetMap()) )
    if not mapExists then
        ply:ChatPrint("No map grid found, creating a new one...")
        sql.Query( "INSERT INTO as_grids VALUES ( " .. SQLStr(game.GetMap()) .. ", " .. SQLStr( util.TableToJSON(ActiveGrid, true) ) .. " )" )
    else
        sql.Query( "UPDATE as_grids SET data = " .. SQLStr( util.TableToJSON(ActiveGrid, true) ) .. " WHERE map = " .. SQLStr(game.GetMap()) )
    end

    ply:ChatPrint("Finished! Total of " .. #ActiveGrid .. " Spawner(s) on " .. game.GetMap() .. ".")
end
concommand.Add( "as_grid_save", AS.Grid.Save )

function AS.Grid.ClearEnt( ply )
    if not ply:IsAdmin() then ply:ChatPrint("You are not an admin.") return end

    ply:ChatPrint("Clearing active grid entities...")
    for k, v in pairs( ents.FindByClass("as_mobspawner") ) do
        v:Remove()
    end
    ply:ChatPrint("Finished! All of the entities should be cleared.")
end
concommand.Add( "as_grid_clearent", AS.Grid.ClearEnt )

-- ███████╗███╗   ██╗████████╗██╗████████╗██╗   ██╗     ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
-- ██╔════╝████╗  ██║╚══██╔══╝██║╚══██╔══╝╚██╗ ██╔╝    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
-- █████╗  ██╔██╗ ██║   ██║   ██║   ██║    ╚████╔╝     ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
-- ██╔══╝  ██║╚██╗██║   ██║   ██║   ██║     ╚██╔╝      ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
-- ███████╗██║ ╚████║   ██║   ██║   ██║      ██║       ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
-- ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝   ╚═╝      ╚═╝        ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝

-- Mobs

function AS.GridEnts.CountMobs( ply ) --This will count all of the mobs that are spawned and make a detailed report in the console.
    local totalMobs = {}
    local overallMobs = 0
    for k, v in pairs( ents.FindByClass("npc_*") ) do
        if not v.ASGridMob then continue end
        totalMobs[v:GetClass()] = (totalMobs[v:GetClass()] or 0) + 1
        overallMobs = overallMobs + 1
    end

    if ply and IsValid( ply ) then
        ply:PrintMessage( HUD_PRINTCONSOLE, "[[============================================================================]]" )
        ply:PrintMessage( HUD_PRINTCONSOLE, "||                                 Mob Report                                 ||")
        ply:PrintMessage( HUD_PRINTCONSOLE, "[[============================================================================]]" )
        for k, v in pairs( totalMobs ) do
            ply:PrintMessage( HUD_PRINTCONSOLE, "|| " .. k .. " = " .. v )
        end
        ply:PrintMessage( HUD_PRINTCONSOLE, "||------------------------------------------------------------------------------" )
        ply:PrintMessage( HUD_PRINTCONSOLE, "|| Overall Mobs: " .. overallMobs )
        ply:PrintMessage( HUD_PRINTCONSOLE, "[[============================================================================]]" )
    else
        print( "[[============================================================================]]" )
        print( "||                                 Mob Report                                 ||")
        print( "[[============================================================================]]" )
        for k, v in pairs( totalMobs ) do
            print( "|| " .. k .. " = " .. v )
        end
        print( "||------------------------------------------------------------------------------" )
        print( "|| Overall Mobs: " .. overallMobs )
        print( "[[============================================================================]]" )
    end
end
concommand.Add( "as_mobs_count", AS.GridEnts.CountMobs )

function AS.GridEnts.ClearMobs( ply ) --This will clear all of the mobs.
    if ply and IsValid(ply) and not ply:IsAdmin() then ply:ChatPrint("You are not an admin.") return end

    local totalmobs = 0
    for k, v in pairs( ents.FindByClass("npc_*") ) do
        if not v.ASGridMob then continue end
        v:Remove()
        totalmobs = totalmobs + 1 
    end

    if ply and IsValid( ply ) then
        ply:PrintMessage( HUD_PRINTCONSOLE, "Cleared " .. totalmobs .. " mobs." )
    else
        print( "Cleared " .. totalmobs .. " mobs." )
    end
end
concommand.Add( "as_mobs_clear", AS.GridEnts.ClearMobs )

-- Nodes

function AS.GridEnts.CountNodes( ply ) --This will count all of the nodes that are spawned and make a detailed report in the console.

end
concommand.Add( "as_nodes_count", AS.GridEnts.CountNodes )

function AS.GridEnts.ClearNodes( ply ) --This will clear all of the nodes.

end
concommand.Add( "as_nodes_clear", AS.GridEnts.ClearNodes )

-- Events

function AS.GridEnts.CountEvents( ply ) --This will count all of the active events

end
concommand.Add( "as_events_count", AS.GridEnts.CountEvents )

function AS.GridEnts.ClearEvents( ply ) --This will clear all events.

end
concommand.Add( "as_events_clear", AS.GridEnts.ClearEvents )

-- ███████╗██████╗  █████╗ ██╗    ██╗███╗   ██╗██╗███╗   ██╗ ██████╗
-- ██╔════╝██╔══██╗██╔══██╗██║    ██║████╗  ██║██║████╗  ██║██╔════╝
-- ███████╗██████╔╝███████║██║ █╗ ██║██╔██╗ ██║██║██╔██╗ ██║██║  ███╗
-- ╚════██║██╔═══╝ ██╔══██║██║███╗██║██║╚██╗██║██║██║╚██╗██║██║   ██║
-- ███████║██║     ██║  ██║╚███╔███╔╝██║ ╚████║██║██║ ╚████║╚██████╔╝
-- ╚══════╝╚═╝     ╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚═════╝
-- Automatic Spawning.

function AS.Grid.SpawnMobs()
    --We need to find a valid spawn for NPCs first. We'll go through all of the spawns and see what's available.
    local ValidSpawners = {}
    for _, info in pairs( ActiveGrid ) do
        local ValidSpawn = true --By default, lets assume all of the spawners work. We will need to add checks in which case they may not work.

        --If a player is in the radius of a spawner, it shouldn't be valid. This prevents NPCS from spawning on top of players.
        for k, v in pairs( ents.FindByClass( "player" ) ) do
            if info["pos"]:Distance(v:GetPos()) < info["distance"] * 1.5 then
                ValidSpawn = false 
                break
            end
        end

        if ValidSpawn then
            ValidSpawners[#ValidSpawners + 1] = info
        end
    end
    if #ValidSpawners <= 0 then return end --No valid spawners. Although extremely rare, still a precaution to have.

    --Now, since we have a table containing valid spawn points, we need to spawn NPCs on them.
    for mob, amt in pairs( MOB.NPCs ) do
        local maxMobs = math.floor( amt * MOB.SpawnMult )
        if #ents.FindByClass(mob) >= maxMobs then continue end --We've already capped this NPC, skip to the next one.
        local mobsToSpawn = maxMobs - #ents.FindByClass(mob) --How many NPCs we need to spawn.

        for i = 1, mobsToSpawn do
            local spawnPoint = ValidSpawners[math.random(1, #ValidSpawners)] --This is just selecting a random spawner.
            local spawnPointPos = spawnPoint["pos"]:ToTable()
            local position = Vector( spawnPointPos[1] + math.random( spawnPoint["distance"] * -1, spawnPoint["distance"] ), spawnPointPos[2] + math.random(spawnPoint["distance"] * -1 , spawnPoint["distance"] ), spawnPointPos[3] )

            if util.IsInWorld( position ) then
                local ent = ents.Create(mob)
                ent:SetPos( position )
                ent:Spawn()
                if mob == "npc_combine_s" then
                    ent:Give("weapon_ar2")
                end
                ent.ASGridMob = true
            end
        end
    end
end
concommand.Add( "as_mobs_spawn", AS.Grid.SpawnMobs )

function AS.Grid.SpawnNodes()

end
concommand.Add( "as_nodes_spawn", AS.Grid.SpawnNodes )

hook.Add( "Think", "AS_GridSpawn", function() --This is just for automatically spawning mobs.
    if CurTime() > (NextSpawn or 0) then
        NextSpawn = CurTime() + MOB.RespawnTime
        AS.Grid.SpawnMobs()
    end
end)

-- ██████╗ ██████╗ ███████╗    ██╗      ██████╗  █████╗ ██████╗ ██╗███╗   ██╗ ██████╗
-- ██╔══██╗██╔══██╗██╔════╝    ██║     ██╔═══██╗██╔══██╗██╔══██╗██║████╗  ██║██╔════╝
-- ██████╔╝██████╔╝█████╗█████╗██║     ██║   ██║███████║██║  ██║██║██╔██╗ ██║██║  ███╗
-- ██╔═══╝ ██╔══██╗██╔══╝╚════╝██║     ██║   ██║██╔══██║██║  ██║██║██║╚██╗██║██║   ██║
-- ██║     ██║  ██║███████╗    ███████╗╚██████╔╝██║  ██║██████╔╝██║██║ ╚████║╚██████╔╝
-- ╚═╝     ╚═╝  ╚═╝╚══════╝    ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝
--This is for loading the grid automatically when the game starts, so we never have to do it manually.

hook.Add( "Initialize", "AS_LoadGrid", function()
    local gridExists = sql.QueryValue("SELECT * FROM as_grids WHERE map = " .. SQLStr(game.GetMap()) )
    if not gridExists then
        MsgC( Color(255,0,55), "[AS] There is no saved grid for " .. game.GetMap() .. ". Mobs will not spawn until one is properly set up.\n" )
    else
        local grid = sql.QueryValue("SELECT data FROM as_grids WHERE map = " .. SQLStr(game.GetMap()) )
        grid = util.JSONToTable( grid )

        for k, v in pairs( grid ) do
            ActiveGrid[k] = v
        end
        MsgC( Color(0,0,255), "[AS] Grid with " .. #ActiveGrid .. " Mob Spawner(s) was loaded for " .. game.GetMap() .. ".\n" )
    end
end)