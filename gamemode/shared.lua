-- ███████╗██╗  ██╗ █████╗ ██████╗ ███████╗██████╗
-- ██╔════╝██║  ██║██╔══██╗██╔══██╗██╔════╝██╔══██╗
-- ███████╗███████║███████║██████╔╝█████╗  ██║  ██║
-- ╚════██║██╔══██║██╔══██║██╔══██╗██╔══╝  ██║  ██║
-- ███████║██║  ██║██║  ██║██║  ██║███████╗██████╔╝
-- ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═════╝
-- Desc: Mainly initialization.

AS = {}

DeriveGamemode("base")
GM.Name = "Aftershock"

if SERVER then
	AddCSLuaFile("tablebase.lua")
else
    include("tablebase.lua")
end

for k, v in pairs( file.Find("aftershock/gamemode/shared/*.lua", "LUA") ) do
    if SERVER then 
        AddCSLuaFile("shared/" .. v)
    else
        include("shared/" .. v)
    end
end

for k, v in pairs( file.Find("aftershock/gamemode/tables/*.lua", "LUA") ) do
	if SERVER then 
        AddCSLuaFile("tables/" .. v)
    else
		include("tables/" .. v)
	end
end

for k, v in pairs( file.Find("aftershock/gamemode/tables/items/*.lua", "LUA") ) do
	if SERVER then 
        AddCSLuaFile("tables/items/" .. v)
    else
		include("tables/items/" .. v)
	end
end

AS.Functions = {}

function AS.LuaError( message )
    ErrorNoHaltWithStack( "[AS] Error: " .. message .. "\n" )
end

function GM:Move( ply, mv )
    local movespeed = SKL.Movement
    ply:SetRunSpeed( movespeed )
    ply:SetWalkSpeed( movespeed )
    ply:SetSlowWalkSpeed( 75 )
end