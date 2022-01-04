-- ██╗███╗   ██╗██╗████████╗
-- ██║████╗  ██║██║╚══██╔══╝
-- ██║██╔██╗ ██║██║   ██║
-- ██║██║╚██╗██║██║   ██║
-- ██║██║ ╚████║██║   ██║
-- ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝
-- Desc: Most of the gamemode modules are sorted in the server/shared/client folders. You won't find much other than initialization here.

GAMEMODEFIRSTLOAD = GAMEMODEFIRSTLOAD or false

if not GAMEMODEFIRSTLOAD then
	MsgC( Color(0,0,255), "[AS] Loading game files...\n" )
else
	MsgC( Color(0,0,255), "[AS] Reloading game files...\n" )
end

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile( "tablebase.lua" )
include("shared.lua")
include("tablebase.lua")

for k, v in pairs( file.Find("aftershock/gamemode/server/*.lua", "LUA") ) do
	include("server/" .. v)
end

for k, v in pairs( file.Find("aftershock/gamemode/client/*.lua",  "LUA") ) do
	AddCSLuaFile("client/" .. v)
end

for k, v in pairs( file.Find("aftershock/gamemode/shared/*.lua",  "LUA") ) do
	include("shared/" .. v)
end

for k, v in pairs( file.Find("aftershock/gamemode/tables/*.lua",  "LUA") ) do
	include("tables/" .. v)
end

for k, v in pairs( file.Find("aftershock/gamemode/tables/items/*.lua",  "LUA") ) do
	include("tables/items/" .. v)
end

-- Databases
DATABASECHECKED = DATABASECHECKED or false
local function DatabaseCheck()
	MsgC( Color(0,0,255), "[AS] Checking Databases...\n" )
	sql.Query("CREATE TABLE IF NOT EXISTS as_characters (pid INTEGER PRIMARY KEY AUTOINCREMENT, steamid TEXT, name TEXT, model TEXT, created TEXT, laston TEXT, deleted TEXT)")
	sql.Query("CREATE TABLE IF NOT EXISTS as_characters_stats (pid INTEGER, health INTEGER, hunger INTEGER, thirst INTEGER, exp INTEGER)")
	sql.Query("CREATE TABLE IF NOT EXISTS as_characters_skills (pid INTEGER, skills TEXT)")
	sql.Query("CREATE TABLE IF NOT EXISTS as_characters_inventory (pid INTEGER, inv TEXT, bank TEXT)")
	DATABASECHECKED = true --Don't see the purpose of reloading this multiple times, just restart the server, it's a new table anyways.
end
if not DATABASECHECKED then DatabaseCheck() end

MsgC( Color(0,0,255), "[AS] Finished Loading!\n" )
GAMEMODEFIRSTLOAD = true