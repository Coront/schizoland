-- ███████╗███████╗██████╗ ██╗   ██╗███████╗██████╗ ███████╗██╗██████╗ ███████╗    ██╗███╗   ██╗██╗████████╗██╗ █████╗ ██╗     ██╗███████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
-- ██╔════╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗██╔════╝██║██╔══██╗██╔════╝    ██║████╗  ██║██║╚══██╔══╝██║██╔══██╗██║     ██║╚══███╔╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
-- ███████╗█████╗  ██████╔╝██║   ██║█████╗  ██████╔╝███████╗██║██║  ██║█████╗      ██║██╔██╗ ██║██║   ██║   ██║███████║██║     ██║  ███╔╝ ███████║   ██║   ██║██║   ██║██╔██╗ ██║
-- ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██╔══╝  ██╔══██╗╚════██║██║██║  ██║██╔══╝      ██║██║╚██╗██║██║   ██║   ██║██╔══██║██║     ██║ ███╔╝  ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
-- ███████║███████╗██║  ██║ ╚████╔╝ ███████╗██║  ██║███████║██║██████╔╝███████╗    ██║██║ ╚████║██║   ██║   ██║██║  ██║███████╗██║███████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
-- ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝╚═════╝ ╚══════╝    ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   ╚═╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
-- Desc: Most of the gamemode modules are sorted in the server/shared/client folders. You won't find much other than initialization here.

GAMEMODEFIRSTLOAD = GAMEMODEFIRSTLOAD or false

if not GAMEMODEFIRSTLOAD then
	MsgC( Color(0,0,255), "[AS] Loading game files...\n" )
else
	MsgC( Color(0,0,255), "[AS] Reloading game files...\n" )
end

AddCSLuaFile("cl_init.lua")
print("CS File: cl_init.lua")
AddCSLuaFile("shared.lua")
print("CS File: shared.lua")
AddCSLuaFile( "tablebase.lua" )
print("CS File: tablebase.lua")
include("shared.lua")
print("Server File: shared.lua")
include("tablebase.lua")
print("Server File: tablebase.lua")

for k, v in pairs( file.Find("aftershock/gamemode/client/*.lua",  "LUA") ) do
	AddCSLuaFile("client/" .. v)
end
print("CS Folder: client/*.lua")

for k, v in pairs( file.Find("aftershock/gamemode/server/*.lua", "LUA") ) do
	include("server/" .. v)
end
print("Server Folder: server/*.lua")

for k, v in pairs( file.Find("aftershock/gamemode/shared/*.lua",  "LUA") ) do
	include("shared/" .. v)
end
print("Server Folder: shared/*.lua")

for k, v in pairs( AS.FileIncludes ) do
    for k2, v2 in pairs( file.Find("aftershock/gamemode/" .. v .. "*.lua", "LUA") ) do
        include( v .. v2 )
    end
	print("Server Folder: " .. v .. "*.lua")
end

-- Databases
DATABASECHECKED = DATABASECHECKED or false
local function DatabaseCheck()
	MsgC( Color(0,0,255), "[AS] Checking Databases...\n" )
	--Character Information
	sql.Query("CREATE TABLE IF NOT EXISTS as_characters (pid INTEGER PRIMARY KEY AUTOINCREMENT, steamid TEXT, name TEXT, model TEXT, class TEXT, created TEXT, laston TEXT, deleted TEXT)")
	sql.Query("CREATE TABLE IF NOT EXISTS as_characters_stats (pid INTEGER, health INTEGER, hunger INTEGER, thirst INTEGER, playtime INTEGER)")
	sql.Query("CREATE TABLE IF NOT EXISTS as_characters_skills (pid INTEGER, skills TEXT)")
	sql.Query("CREATE TABLE IF NOT EXISTS as_characters_inventory (pid INTEGER, inv TEXT, bank TEXT, equipped TEXT)")
	--Item Deployment Cache
	sql.Query("CREATE TABLE IF NOT EXISTS as_cache_tools (pid INTEGER, tools TEXT)")
	--Mob Spawner
	sql.Query("CREATE TABLE IF NOT EXISTS as_grids (map TEXT, data TEXT)")
	--Other
	sql.Query("CREATE TABLE IF NOT EXISTS as_chatlog (steamid TEXT, name TEXT, str TEXT, time TEXT)")
	DATABASECHECKED = true --Don't see the purpose of reloading this multiple times, just restart the server, it's a new table anyways.
end
if not DATABASECHECKED then DatabaseCheck() end

MsgC( Color(0,0,255), "[AS] Finished Loading!\n" )
GAMEMODEFIRSTLOAD = true

hook.Add( "PlayerSay", "AS_PlayerChatLog", function( ply, text )
	if ply and IsValid( ply ) then
		sql.Query("INSERT INTO as_chatlog VALUES ( " .. SQLStr(ply:SteamID()) .. ", " .. SQLStr(ply:Nickname()) .. ", " .. SQLStr(text) .. ", " .. SQLStr( os.date("%m/%d/%y - %I:%M %p", os.time()) ) .. ")")
	else
		sql.Query("INSERT INTO as_chatlog VALUES ( '-1', 'ERROR_NOUSER', " .. SQLStr(text) .. ", " .. SQLStr( os.date("%m/%d/%y - %I:%M %p", os.time()) ) .. ")")
	end
end)

-- ███████╗ █████╗ ███████╗████████╗    ██████╗ ██╗
-- ██╔════╝██╔══██╗██╔════╝╚══██╔══╝    ██╔══██╗██║
-- █████╗  ███████║███████╗   ██║       ██║  ██║██║
-- ██╔══╝  ██╔══██║╚════██║   ██║       ██║  ██║██║
-- ██║     ██║  ██║███████║   ██║       ██████╔╝███████╗
-- ╚═╝     ╚═╝  ╚═╝╚══════╝   ╚═╝       ╚═════╝ ╚══════╝

local WorkshopFastDL = {
	["2794939351"] = "Aftershock: Content - Generic 1",
	["104603291"] = "Extended Spawnmenu",
	["104604709"] = "Easy Animation Tool",
	["180507408"] = "FA:S 2.0 Alpha SWEPs",
	["181283903"] = "FA:S 2.0 Alpha SWEPs - Pistols",
	["183139624"] = "FA:S 2.0 Alpha SWEPs - SMGs",
	["181656972"] = "FA:S 2.0 Alpha SWEPs - Rifles",
	["183140076"] = "FA:S 2.0 Alpha SWEPs - Shotguns",
	["201027715"] = "FA:S 2.0 Alpha SWEPs - U. Rifles",
	["462119296"] = "FA:S 2.0 Alpha SWEPs - Unused Weapons (Unofficial)",
	["201027186"] = "FA:S 2.0 Alpha SWEPs - Misc",
	--Maps
	["2795340202"] = "r_postnukemetro_dry",
	["2595136841"] = "RP Asheville",
}

for k, v in pairs(WorkshopFastDL) do
	resource.AddWorkshop( k )
end