AS.Grid = {}
AS.GridEnts = {}
AS.Events = {}
ActiveGrid = ActiveGrid or {} --The AS. table is reset every time the server is updated, so to prevent the active grid from being wiped I made this independent instead.
PendingEvents = PendingEvents or {}
ActiveEvents = ActiveEvents or {}

-- ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗
-- ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝
-- █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗
-- ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║
-- ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║
-- ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝

function AS.AddEvent( id, data )
    AS.Events = AS.Events or {}
    AS.Events[id] = data
end

AS.AddEvent( "antlion_guard", {
    enable = true, --Should we actually be spawning?
    mintime = 600, --Minimal time before we spawn in seconds
    maxtime = 1200, --Maximum time before we spawn
    max = 2, --Maximum amount of this event that can spawn at once
    eventspot = false, --Should we only spawn in event spots?
    outdoor = true, --Spawn outdoor
    ent = "npc_as_antlionguard", --Entity to spawn
} )

AS.AddEvent( "antlion_nest", {
    enable = true,
    mintime = 600,
    maxtime = 1800,
    max = 1,
    eventspot = true,
    outdoor = true,
    ent = "as_event_mound", --Replace this with the antlionnest entity when finished
    sound = "ambient/atmosphere/terrain_rumble1.wav", --This will play a sound to everyone as a notification
} )

AS.AddEvent( "zombie_horde", {
    enable = true,
    mintime = 1800,
    maxtime = 7200,
    max = 1,
    eventspot = true,
    outdoor = true,
    ent = "npc_as_fastzombie", --Replace this with the antlionnest entity when finished
    entamt = {min = 20, max = 30},
    notify = {"A large horde of fast zombies have been spotted out in the wasteland."},
} )

AS.AddEvent( "raider_party", {
    enable = true,
    mintime = 3600,
    maxtime = 6000,
    max = 1,
    eventspot = true,
    outdoor = true,
    ent = "npc_as_raider",
    entamt = {min = 4, max = 6}, --This tells us how much of the entity to spawn in the same location.
    notify = {"A group of heavily armed raiders have been spotted roaming the lands."}, --Will print text to everyone's chat
} )

AS.AddEvent( "combine_scout", {
    enable = true,
    mintime = 4200,
    maxtime = 8000,
    max = 1,
    eventspot = true,
    outdoor = true,
    ent = "as_event_canister",
    sound = "npc/env_headcrabcanister/launch.wav",
    notify = {"The distant sound of an explosion can be heard from the sky. Something bad is coming.", "The sound of a loud explosion from the sky shakes the land. Watch out from above.", "An explosion from above ruptures your eardrums. The government is on their way."},
} )

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
        ply:PrintMessage( HUD_PRINTCONSOLE, "|| Current Mob Mult: " .. MOB.SpawnMult * (AS.Maps[game.GetMap()] and AS.Maps[game.GetMap()].MobMult or 1) )
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
        print( "|| Current Mob Multiplier: " .. MOB.SpawnMult * (AS.Maps[game.GetMap()] and AS.Maps[game.GetMap()].NodeMult or 1) )
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
    local overallNodes = 0
    for k, v in pairs( ents.FindByClass("as_lootnode") ) do
        overallNodes = overallNodes + 1
    end

    if ply and IsValid( ply ) then
        ply:PrintMessage( HUD_PRINTCONSOLE, "[[============================================================================]]" )
        ply:PrintMessage( HUD_PRINTCONSOLE, "||                                Node Report                                 ||")
        ply:PrintMessage( HUD_PRINTCONSOLE, "[[============================================================================]]" )
        ply:PrintMessage( HUD_PRINTCONSOLE, "|| Current Node Multiplier: " .. NOD.SpawnMult * (AS.Maps[game.GetMap()] and AS.Maps[game.GetMap()].NodeMult or 1) )
        ply:PrintMessage( HUD_PRINTCONSOLE, "|| Total Nodes: " .. overallNodes )
        ply:PrintMessage( HUD_PRINTCONSOLE, "[[============================================================================]]" )
    else
        print( "[[============================================================================]]" )
        print( "||                                Node Report                                 ||")
        print( "[[============================================================================]]" )
        print( "|| Current Node Multiplier: " .. NOD.SpawnMult * (AS.Maps[game.GetMap()] and AS.Maps[game.GetMap()].NodeMult or 1) )
        print( "|| Total Nodes: " .. overallNodes )
        print( "[[============================================================================]]" )
    end
end
concommand.Add( "as_nodes_count", AS.GridEnts.CountNodes )

function AS.GridEnts.ClearNodes( ply ) --This will clear all of the nodes.
    if ply and IsValid(ply) and not ply:IsAdmin() then ply:ChatPrint("You are not an admin.") return end

    local totalnodes = 0
    for k, v in pairs( ents.FindByClass("as_lootnode") ) do
        v:Remove()
        totalnodes = totalnodes + 1
    end

    if ply and IsValid( ply ) then
        ply:PrintMessage( HUD_PRINTCONSOLE, "Cleared " .. totalnodes .. " nodes.")
    else
        print( "Cleared " .. totalnodes .. " nodes." )
    end
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

function AS.Grid.FetchValidSpawners() --Every spawner that is valid
    local ValidSpawners = {}
    for _, info in pairs( ActiveGrid ) do
        local ValidSpawn = true

        --A spawner shouldnt be valid if a player is nearby. This prevents nodes or npcs from spawning on them directly.
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

    return ValidSpawners
end

function AS.Grid.FetchValidEventSpawners( tbl ) --Every event spawner that is valid
    local ValidSpawners = tbl
    local NewValidSpawners = {}

    for _, info in pairs( ValidSpawners ) do
        if not info.events then continue end
        NewValidSpawners[#NewValidSpawners + 1] = info
    end

    return NewValidSpawners
end

function AS.Grid.FetchValidOutdoorSpawners( tbl ) --Every outdoor spawner that is valid from a provided table
    local ValidSpawners = tbl
    local NewValidSpawners = {}

    for _, info in pairs( ValidSpawners ) do
        if info.indoor then continue end
        NewValidSpawners[#NewValidSpawners + 1] = info
    end

    return NewValidSpawners
end

function AS.Grid.FetchValidIndoorSpawners( tbl ) --Every indoor spawner that is valid from a provided table
    local ValidSpawners = tbl
    local NewValidSpawners = {}

    for _, info in pairs( ValidSpawners ) do
        if not info.indoor then continue end
        NewValidSpawners[#NewValidSpawners + 1] = info
    end

    return NewValidSpawners
end

function AS.Grid.SpawnMobs()
    if not tobool(GetConVar("as_mobs"):GetInt()) then return end

    --We need to find a valid spawn for NPCs first. We'll go through all of the spawns and see what's available.
    local ValidSpawners = AS.Grid.FetchValidSpawners()
    if #ValidSpawners <= 0 then return end --No valid spawners. Although extremely rare, still a precaution to have.

    --Now, since we have a table containing valid spawn points, we need to spawn NPCs on them.
    for mob, info in pairs( MOB.NPCs ) do
        ValidSpawners = info.indoor and info.outdoor and ValidSpawners or info.indoor and AS.Grid.FetchValidIndoorSpawners( ValidSpawners ) or info.outdoor and AS.Grid.FetchValidOutdoorSpawners( ValidSpawners )
    
        local maxMobs = math.floor( (info.amt * MOB.SpawnMult) * (AS.Maps[game.GetMap()] and AS.Maps[game.GetMap()].MobMult or 1) )
        if #ents.FindByClass(mob) >= maxMobs then continue end --We've already capped this NPC, skip to the next one.
        local mobsToSpawn = maxMobs - #ents.FindByClass(mob) --How many NPCs we need to spawn.

        for i = 1, mobsToSpawn do
            local spawnPoint = ValidSpawners[math.random(1, #ValidSpawners)]
            local spawnPointPos = spawnPoint["pos"]:ToTable()
            local position = Vector( spawnPointPos[1] + math.random( spawnPoint["distance"] * -1, spawnPoint["distance"] ), spawnPointPos[2] + math.random(spawnPoint["distance"] * -1 , spawnPoint["distance"] ), spawnPointPos[3] )

            if util.IsInWorld( position ) then
                local ent = ents.Create(mob)
                ent:SetPos( position )
                ent:Spawn()
                ent.ASGridMob = true
            end
        end
    end
end
concommand.Add( "as_mobs_spawn", function( ply, cmd, args )
    if ply and IsValid(ply) then
        if not ply:IsAdmin() then ply:ChatPrint("You are not an admin.") return end
    end
    AS.Grid.SpawnMobs()
end)

function AS.Grid.SpawnNodes()
    if not tobool(GetConVar("as_nodes"):GetInt()) then return end

    --Similar with mobs, we need to find a valid spawn location.
    local ValidSpawners = AS.Grid.FetchValidSpawners()
    if #ValidSpawners <= 0 then return end --None are valid
    local SpawnerCap = {}

    --Now we place nodes.
    local maxnodes = math.floor( (NOD.Maximum * NOD.SpawnMult) * (AS.Maps[game.GetMap()] and AS.Maps[game.GetMap()].NodeMult or 1) )
    local nodesToSpawn = maxnodes - #ents.FindByClass("as_lootnode")
    for i = 1, nodesToSpawn do
        local spawnPoint = ValidSpawners[math.random(1, #ValidSpawners)] --Random spawner
        local isIndoor = spawnPoint.indoor and true or false
        local spawnPointPos = spawnPoint["pos"]:ToTable()
        local position = Vector( spawnPointPos[1] + math.random( spawnPoint["distance"] * -1, spawnPoint["distance"] ), spawnPointPos[2] + math.random(spawnPoint["distance"] * -1 , spawnPoint["distance"] ), spawnPointPos[3] )

        if util.IsInWorld( position ) then
            local ent = ents.Create("as_lootnode")
            ent:SetPos(position)
            ent:SetAngles( Angle(0, math.random( 0, 360 ), 0) )
            ent:SetIndoor( isIndoor )
            ent:Spawn()
            if ent:GetResourceType() == "Scrap" or ent:GetModel() == "models/props/de_train/pallet_barrels.mdl" then
                if not ent:GetIndoor() then
                    ent:DropToFloor()
                end
                local physobj = ent:GetPhysicsObject()
                physobj:Wake()
                timer.Simple( 5, function()
                    if ent and IsValid(ent) then
                        physobj:EnableMotion( false )
                    end
                end)
            elseif ent:GetResourceType() == "Chemical" then
                local trace = util.TraceLine({
                    start = ent:GetPos() + ent:OBBCenter(),
                    endpos = ent:GetPos() + Vector( 0, 0, -9999 ),
                    filter = {ent},
                })
                ent:SetPos(trace.HitPos - Vector( 0, 0, 17 ))
                ent:SetAngles( ent:GetAngles() - Angle( math.random( 5, 20 ), 0, 0 ) )
                local physobj = ent:GetPhysicsObject()
                physobj:EnableMotion( false )
            end
        end

        SpawnerCap[spawnPoint] = (SpawnerCap[spawnPoint] or 0) + 1
        if SpawnerCap[spawnPoint] >= NOD.MaxPerSpawner then --This will remove a spawner from the valid spawn table if too many nodes plan on spawning at it.
            ValidSpawners[spawnPoint] = nil
        end
    end
end
concommand.Add( "as_nodes_spawn", function( ply, cmd, args )
    if ply and IsValid(ply) then
        if not ply:IsAdmin() then ply:ChatPrint("You are not an admin.") return end
    end
    AS.Grid.SpawnNodes()
end)

function AS.Grid.SpawnEvent( id ) --This will activate an event.
    if not tobool(GetConVar("as_events"):GetInt()) then return end

    local data = AS.Events[id]
    ActiveEvents[id] = ActiveEvents[id] or {}
    local num = #ActiveEvents[id] + 1
    ActiveEvents[id][num] = {}

    local ValidSpawners = AS.Grid.FetchValidSpawners()
    ValidSpawners = data.eventspot and AS.Grid.FetchValidEventSpawners( ValidSpawners ) or ValidSpawners
    --This next line will just get indoor/outdoor spawners based on the assigned values
    ValidSpawners = data.indoor and data.outdoor and ValidSpawners or data.indoor and AS.Grid.FetchValidIndoorSpawners( ValidSpawners ) or data.outdoor and AS.Grid.FetchValidOutdoorSpawners( ValidSpawners )
    if #ValidSpawners <= 0 then return end --None are valid

    local spawnPoint = ValidSpawners[math.random(1, #ValidSpawners)] --Random spawner of the valid spawners
    local spawnPointPos = spawnPoint["pos"]:ToTable()
    local entamt = data.entamt and math.random(data.entamt.min, data.entamt.max) or 1

    for i = 1, entamt do
        local position = Vector( spawnPointPos[1] + math.random( spawnPoint["distance"] * -1, spawnPoint["distance"] ), spawnPointPos[2] + math.random(spawnPoint["distance"] * -1 , spawnPoint["distance"] ), spawnPointPos[3] )

        local ent = ents.Create(data.ent)
        ent:SetPos( position )
        ent:Spawn()
        table.insert( ActiveEvents[id][num], ent )
    end

    if data.sound then
        for k, v in pairs(player.GetAll()) do
            v:SendLua("surface.PlaySound('" .. data.sound .. "')")
        end
    end
    if data.notify then
        local text = table.Random(data.notify)
        for k, v in pairs(player.GetAll()) do
            v:ChatPrint( text )
        end
    end
end
concommand.Add( "as_event_spawn", function( ply, cmd, args ) 
    if not args[1] then return end
    if not AS.Events[ args[1] ] then return end
    if ply and IsValid(ply) then
        if not ply:IsAdmin() then ply:ChatPrint("You are not an admin.") return end
        print(ply:Nickname() .. " (" .. ply:Nick() .. ") spawned an event: " .. args[1])
    end
    AS.Grid.SpawnEvent( args[1] )
end)

function AS.Grid.GenerateEvent( id ) --This will generate an event, as in put it into the pending table and wait to be called.
    if PendingEvents[id] then return end --This event is already pending.

    PendingEvents[id] = CurTime() + math.random(AS.Events[id].mintime, AS.Events[id].maxtime)
end

function AS.Grid.GetEventAmount( id )
    local amt = 0
    if ActiveEvents[id] then
        for k, v in pairs( ActiveEvents[id] ) do
            for k2, v2 in pairs( v ) do
                if not IsValid(v2) then continue end
                amt = amt + 1
                break
            end
        end
    end
    return amt
end

hook.Add( "Think", "AS_GridSpawn", function() --This is just for automatically spawning mobs.
    if CurTime() > (NextSpawn or 0) then
        NextSpawn = CurTime() + MOB.RespawnTime
        AS.Grid.SpawnMobs()
        AS.Grid.SpawnNodes()
    end
end)

hook.Add( "Think", "AS_EventCheck", function()
    for k, v in pairs( AS.Events ) do
        if not AS.Events[k].enable then continue end

        if PendingEvents[k] then
            if CurTime() > PendingEvents[k] then
                PendingEvents[k] = nil --Clears the pending event. The next think will make a new one for us.
                if AS.Grid.GetEventAmount( k ) < (AS.Events[k].max or 1) then
                    AS.Grid.SpawnEvent( k )
                end
            end
        else
            AS.Grid.GenerateEvent( k )
        end
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