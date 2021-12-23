-- ████████╗ █████╗ ██████╗ ██╗     ███████╗██████╗  █████╗ ███████╗███████╗
-- ╚══██╔══╝██╔══██╗██╔══██╗██║     ██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝
--    ██║   ███████║██████╔╝██║     █████╗  ██████╔╝███████║███████╗█████╗
--    ██║   ██╔══██║██╔══██╗██║     ██╔══╝  ██╔══██╗██╔══██║╚════██║██╔══╝
--    ██║   ██║  ██║██████╔╝███████╗███████╗██████╔╝██║  ██║███████║███████╗
--    ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝
-- Desc: This file will contain all of the tables of information for the gamemode.

AS.Items = {}
function AS.AddBaseItem( id, data ) --Adds a baseitem to the item table
    AS.Items = AS.Items or {}

    AS.Items[id] = data
end

AS.Skills = {}
function AS.AddBaseSkill( id, data ) --Adds a skill to the skill table
    AS.Skills = AS.Skills or {}

    AS.Skills[id] = data
end

AS.Quests = {}
function AS.AddBaseQuest( id, data ) --Adds a quest.
    AS.Quests = AS.Quests or {}

    AS.Quests[id] = data
end

AS.Statistics = {}
function AS.AddBaseStatistic( id, data ) --Adds a statistic
    AS.Statistics = AS.Statistics or {}

    AS.Statistics[id] = data
end

AS.Maps = {}
function AS.AddMapData( id, data )
    AS.Maps = AS.Maps or {}

    AS.Maps[id] = data
end