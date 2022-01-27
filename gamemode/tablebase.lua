-- ████████╗ █████╗ ██████╗ ██╗     ███████╗██████╗  █████╗ ███████╗███████╗
-- ╚══██╔══╝██╔══██╗██╔══██╗██║     ██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝
--    ██║   ███████║██████╔╝██║     █████╗  ██████╔╝███████║███████╗█████╗
--    ██║   ██╔══██║██╔══██╗██║     ██╔══╝  ██╔══██╗██╔══██║╚════██║██╔══╝
--    ██║   ██║  ██║██████╔╝███████╗███████╗██████╔╝██║  ██║███████║███████╗
--    ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝
-- Desc: This file will contain all of the tables of information for the gamemode.

--Items
AS.Items = {}
function AS.AddBaseItem( id, data )
    AS.Items = AS.Items or {}

    AS.Items[id] = data
end

--Workbenches
AS.Workbenches = {}
function AS.AddWorkbench( id, data )
    AS.Workbenches = AS.Workbenches or {}
    
    AS.Workbenches[id] = data
end

function AS.AddWorkbenchRecipe( workbenchid, data )
    if not AS.Workbenches[workbenchid] then AS.LuaError( "Attempt to index a non-existant workbench id - " .. workbenchid ) return end
    AS.Workbenches[workbenchid].recipes = AS.Workbenches[workbenchid].recipes or {}
    local num = #AS.Workbenches[workbenchid].recipes + 1
    
    AS.Workbenches[workbenchid].recipes[num] = data
end

--Skills
AS.Skills = {}
function AS.AddBaseSkill( id, data )
    AS.Skills = AS.Skills or {}

    AS.Skills[id] = data
end

--Statistics
AS.Statistics = {}
function AS.AddBaseStatistic( id, data )
    AS.Statistics = AS.Statistics or {}

    AS.Statistics[id] = data
end

--Maps
AS.Maps = {}
function AS.AddMapData( id, data )
    AS.Maps = AS.Maps or {}

    AS.Maps[id] = data
end

--Characters
AS.Characters = {}
function AS.AddCharacter( id, data )
    AS.Characters = AS.Characters or {}
    
    AS.Characters[id] = data
end

function AS.AddDialog( characterid, data )
    if not AS.Characters[characterid] then AS.LuaError( "Attempt to index a non-existant character id - " .. characterid ) return end
    AS.Characters[characterid].dialog = AS.Characters[characterid].dialog or {}
    
    AS.Characters[characterid].dialog = data
end

function AS.AddMission( characterid, missionid, data )
    if not AS.Characters[characterid] then AS.LuaError( "Attempt to index a non-existant character id - " .. characterid ) return end
    AS.Characters[characterid].missions = AS.Characters[characterid].missions or {}
    
    AS.Characters[characterid].missions[missionid] = data
end