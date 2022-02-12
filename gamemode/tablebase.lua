-- ████████╗ █████╗ ██████╗ ██╗     ███████╗██████╗  █████╗ ███████╗███████╗
-- ╚══██╔══╝██╔══██╗██╔══██╗██║     ██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝
--    ██║   ███████║██████╔╝██║     █████╗  ██████╔╝███████║███████╗█████╗
--    ██║   ██╔══██║██╔══██╗██║     ██╔══╝  ██╔══██╗██╔══██║╚════██║██╔══╝
--    ██║   ██║  ██║██████╔╝███████╗███████╗██████╔╝██║  ██║███████║███████╗
--    ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝
-- Desc: This file will contain all of the tables of information for the gamemode.

--Maps
AS.Maps = {}
function AS.AddMapData( id, data )
    AS.Maps = AS.Maps or {}

    AS.Maps[id] = data
end

AS.Loot = {}
function AS.AddLootTable( id, data )
    AS.Loot = AS.Loot or {}

    AS.Loot[id] = data
end

--Items
AS.Items = {}
function AS.AddBaseItem( id, data )
    AS.Items = AS.Items or {}

    AS.Items[id] = data
end

--Skills
AS.Skills = {}
function AS.AddBaseSkill( id, data )
    AS.Skills = AS.Skills or {}

    AS.Skills[id] = data
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