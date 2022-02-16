-- ███████╗██╗  ██╗ █████╗ ██████╗ ███████╗██████╗
-- ██╔════╝██║  ██║██╔══██╗██╔══██╗██╔════╝██╔══██╗
-- ███████╗███████║███████║██████╔╝█████╗  ██║  ██║
-- ╚════██║██╔══██║██╔══██║██╔══██╗██╔══╝  ██║  ██║
-- ███████║██║  ██║██║  ██║██║  ██║███████╗██████╔╝
-- ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═════╝
-- Desc: Mainly initialization.

AS = {}

DeriveGamemode("sandbox")
GM.Name = "Aftershock"
GM.Discord = "https://www.google.com/"

--Shared Variables
AS.Colors = {}
AS.Colors.Primary = Color( 100, 100, 100, 255 )
AS.Colors.Secondary = Color( 50, 50, 50, 255 )
AS.Colors.Tertiary = Color( 0, 100, 225, 255 )
AS.Colors.Quaternary = Color( 0, 0, 0, 255 )
AS.Colors.Quinary = Color( 0, 0, 0, 255 )

COLHUD_PRIMARY = AS.Colors.Primary
COLHUD_SECONDARY = AS.Colors.Secondary
COLHUD_TERTIARY = AS.Colors.Tertiary
COLHUD_QUATERNARY = AS.Colors.Quaternary
COLHUD_QUINARY = AS.Colors.Quinary

--Clientside
if CLIENT then

    KEYBIND_INV = input.LookupBinding("+showscores") or '"+showscores" -Unbound'
    KEYBIND_SKL = input.LookupBinding("+menu") or '"+menu" -Unbound'
    KEYBIND_MSN = input.LookupBinding("+menu_context") or '"+menu_context" -Unbound'
    KEYBIND_USE = input.LookupBinding("+use") or '"+use" -Unbound'

end

PlayerMeta = FindMetaTable("Player")

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

AS.FileIncludes = {
    "tables/",
    "tables/items/",
    "tables/characters/",
    "tables/characters/jackson/",
}

for k, v in pairs( AS.FileIncludes ) do
    for k2, v2 in pairs( file.Find("aftershock/gamemode/" .. v .. "*.lua", "LUA") ) do
        if SERVER then
            AddCSLuaFile( v .. v2 )
        else
            include( v  .. v2 )
        end
    end
end

-- Sound Cues

AS.SoundCues = {}
CUE = AS.SoundCues

CUE.UI = {}
UICUE = CUE.UI
UICUE.PRESS = "ui/buttonclick.wav"
UICUE.HOVER = "ui/buttonrollover.wav"
UICUE.ACCEPT = "buttons/button15.wav"
UICUE.DECLINE = "buttons/button16.wav"
UICUE.SELECT = "buttons/lightswitch2.wav"

CUE.ITEM = {}
ITEMCUE = CUE.ITEM
ITEMCUE.EQUIPARMOR = ""
ITEMCUE.DROP = "items/ammo_pickup.wav"
ITEMCUE.DESTROY = "physics/cardboard/cardboard_box_break1.wav"

CUE.STORAGE = {}
STORAGECUE = CUE.STORAGE
STORAGECUE.TRANSFER = "physics/body/body_medium_impact_soft1.wav"
STORAGECUE.OPEN = "items/ammocrate_open.wav"
STORAGECUE.CLOSE = "items/ammocrate_close.wav"

function AS.LuaError( message )
    ErrorNoHaltWithStack( "[AS] Error: " .. message .. "\n" )
end

function GM:Move( ply, mv )
    local movespeed = SKL.Movement
    ply:SetRunSpeed( movespeed )
    ply:SetWalkSpeed( movespeed )
    ply:SetSlowWalkSpeed( 75 )
end

function PlayerMeta:Nickname() --Will return the name of the player. Use this over self:Nick().
    return self.name or self:Nick()
end

function PlayerMeta:TracePosFromEyes( dist ) --Will return just a position.
    local trace = util.TraceLine({
        start = self:GetShootPos(),
        endpos = self:GetShootPos() + (self:GetAimVector() * dist),
        filter = self,
    })

	return trace.HitPos
end

function PlayerMeta:TraceFromEyes( dist ) --Will return the trace table.
    local trace = util.TraceLine({
        start = self:GetShootPos(),
        endpos = self:GetShootPos() + (self:GetAimVector() * dist),
        filter = self,
    })

	return trace
end