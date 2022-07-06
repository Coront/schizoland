-- ███████╗███████╗██████╗ ██╗   ██╗███████╗██████╗ ███████╗██╗██████╗ ███████╗    ██╗███╗   ██╗██╗████████╗██╗ █████╗ ██╗     ██╗███████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
-- ██╔════╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗██╔════╝██║██╔══██╗██╔════╝    ██║████╗  ██║██║╚══██╔══╝██║██╔══██╗██║     ██║╚══███╔╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
-- ███████╗█████╗  ██████╔╝██║   ██║█████╗  ██████╔╝███████╗██║██║  ██║█████╗      ██║██╔██╗ ██║██║   ██║   ██║███████║██║     ██║  ███╔╝ ███████║   ██║   ██║██║   ██║██╔██╗ ██║
-- ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██╔══╝  ██╔══██╗╚════██║██║██║  ██║██╔══╝      ██║██║╚██╗██║██║   ██║   ██║██╔══██║██║     ██║ ███╔╝  ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
-- ███████║███████╗██║  ██║ ╚████╔╝ ███████╗██║  ██║███████║██║██████╔╝███████╗    ██║██║ ╚████║██║   ██║   ██║██║  ██║███████╗██║███████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
-- ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝╚═════╝ ╚══════╝    ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   ╚═╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

GAMEMODEFIRSTLOAD = GAMEMODEFIRSTLOAD or false

if not GAMEMODEFIRSTLOAD then
	MsgC( Color(0,0,255), "[AS] Loading game files...\n" )
else
	MsgC( Color(0,0,255), "[AS] Reloading game files...\n" )
end

include( "shared.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

-- Databases
DATABASECHECKED = DATABASECHECKED or false
local function DatabaseCheck()
	MsgC( Color(0,0,255), "[AS] Checking Databases...\n" )
	--Character Information
	sql.Query("CREATE TABLE IF NOT EXISTS as_characters (pid INTEGER PRIMARY KEY AUTOINCREMENT, steamid TEXT, name TEXT, model TEXT, class TEXT, created TEXT, laston TEXT, deleted TEXT)")
	sql.Query("CREATE TABLE IF NOT EXISTS as_characters_stats (pid INTEGER, health INTEGER, hunger INTEGER, thirst INTEGER, toxic INTEGER, playtime INTEGER)")
	sql.Query("CREATE TABLE IF NOT EXISTS as_characters_statistics (pid INTEGER, key TEXT, value INTEGER)") --fuck why didnt i choose a better name
	sql.Query("CREATE TABLE IF NOT EXISTS as_characters_skills (pid INTEGER, skills TEXT)")
	sql.Query("CREATE TABLE IF NOT EXISTS as_characters_inventory (pid INTEGER, inv TEXT, bank TEXT, atch TEXT, equipped TEXT)")
	--Communities
	sql.Query("CREATE TABLE IF NOT EXISTS as_communities (cid INTEGER, data TEXT, deleted)")
	sql.Query("CREATE TABLE IF NOT EXISTS as_communities_members (pid INTEGER, cid INTEGER, title TEXT, rank TEXT)")
	sql.Query("CREATE TABLE IF NOT EXISTS as_communities_storage (cid INTEGER, res TEXT, inv TEXT)")
	--Item Deployment Cache
	sql.Query("CREATE TABLE IF NOT EXISTS as_cache_tools (pid INTEGER, tools TEXT)")
	--Missions
	sql.Query("CREATE TABLE IF NOT EXISTS as_missions (pid INTEGER, data TEXT)")
	--Other Profiles
	sql.Query("CREATE TABLE IF NOT EXISTS as_vendors (vid INTEGER PRIMARY KEY AUTOINCREMENT, pid INTEGER, name TEXT, sale TEXT, res TEXT, deleted TEXT)")
	sql.Query("CREATE TABLE IF NOT EXISTS as_lockers (lid INTEGER PRIMARY KEY AUTOINCREMENT, pid INTEGER, name TEXT, items TEXT, deleted TEXT)")
	--Mob Spawner
	sql.Query("CREATE TABLE IF NOT EXISTS as_grids (map TEXT, data TEXT)")
	--Other
	sql.Query("CREATE TABLE IF NOT EXISTS as_playerdata (steamid TEXT, name TEXT, ip TEXT, firstconnect TEXT)")
	sql.Query("CREATE TABLE IF NOT EXISTS as_chatlog (steamid TEXT, name TEXT, str TEXT, time TEXT)")
	sql.Query("CREATE TABLE IF NOT EXISTS plogs (steamid TEXT, type TEXT, str TEXT, time TEXT)")
	sql.Query("CREATE TABLE IF NOT EXISTS pac_whitelist (steamid TEXT, date TEXT, admin TEXT)")
	DATABASECHECKED = true --Don't see the purpose of reloading this multiple times, just restart the server, it's a new table anyways.
end
if not DATABASECHECKED then DatabaseCheck() end

MsgC( Color(0,0,255), "[AS] Finished Loading!\n" )
GAMEMODEFIRSTLOAD = true

-- ███████╗ █████╗ ███████╗████████╗    ██████╗ ██╗
-- ██╔════╝██╔══██╗██╔════╝╚══██╔══╝    ██╔══██╗██║
-- █████╗  ███████║███████╗   ██║       ██║  ██║██║
-- ██╔══╝  ██╔══██║╚════██║   ██║       ██║  ██║██║
-- ██║     ██║  ██║███████║   ██║       ██████╔╝███████╗
-- ╚═╝     ╚═╝  ╚═╝╚══════╝   ╚═╝       ╚═════╝ ╚══════╝

local WorkshopFastDL = {
	--Value doesn't do anything, i just use it so i know what the workshop ID is.
	["2794939351"] = "Aftershock: Content - Generic 1",
	["104648051"] = "Half-Life 2 Driveable Vehicles",
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
	["579832711"] = "Sniper Scope Overlays",
	["104691717"] = "PAC3",
	["108424005"] = "Keypad Tool and Cracker with Wire Support",
	["104815552"] = "SmartSnap",
	["2595136841"] = "rp_asheville", --Event Map
}

local WorkshopFastDLMaps = {
	--Value here does do something, make sure the map's name is tied to the key, or the fast dl wont identify it.
	["2795340202"] = "r_postnukemetro_dry",
	["2225370566"] = "rp_outercanals_p",
	["2220973603"] = "rp_mojave_v3_p",
	["22209959703"] = "rp_cscdesert_v4b2",
	["2227565470"] = "pn_wastedwaters_beta_2_p",
	["2220995823"] = "gm_disaster_v3_nodust",
	["143547520"] = "rp_ineu_pass",
	["2222705223"] = "rp_pripyat_p",
	["428781078"] = "gm_aftermath",
	["132901080"] = "rp_salvation_2_stalker_snow",
	["105984257"] = "gm_atomic",
	["2826876381"] = "pn_vault121_v1_p3",
	["2826879810"] = "gm_valley_f1",
	["1996718112"] = "rp_cscdesert_v2_b1",
	["1572373847"] = "gm_boreas", --Event Map
	["326332456"] = "gm_fork", --Event Map
}

for k, v in pairs(WorkshopFastDLMaps) do
	if string.find( string.lower( game.GetMap() ), string.lower( v ) ) then
		WorkshopFastDL[k] = v
		break
	end
end

for k, v in pairs(WorkshopFastDL) do
	resource.AddWorkshop( k )
end

function GM:InitPostEntity()
	for k, v in pairs( ents.FindByClass("prop_physics*") ) do
		v:Remove()
	end

	for k, v in pairs( ents.FindByClass("item*") ) do
		v:Remove()
	end
end

function GM:ShutDown()
	for k, v in pairs( player.GetAll() ) do
		if not v:IsLoaded() then continue end
		v:SaveCharacter()
	end
end