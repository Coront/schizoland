-- ███████╗██╗  ██╗ █████╗ ██████╗ ███████╗██████╗     ██╗███╗   ██╗██╗████████╗██╗ █████╗ ██╗     ██╗███████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
-- ██╔════╝██║  ██║██╔══██╗██╔══██╗██╔════╝██╔══██╗    ██║████╗  ██║██║╚══██╔══╝██║██╔══██╗██║     ██║╚══███╔╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
-- ███████╗███████║███████║██████╔╝█████╗  ██║  ██║    ██║██╔██╗ ██║██║   ██║   ██║███████║██║     ██║  ███╔╝ ███████║   ██║   ██║██║   ██║██╔██╗ ██║
-- ╚════██║██╔══██║██╔══██║██╔══██╗██╔══╝  ██║  ██║    ██║██║╚██╗██║██║   ██║   ██║██╔══██║██║     ██║ ███╔╝  ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
-- ███████║██║  ██║██║  ██║██║  ██║███████╗██████╔╝    ██║██║ ╚████║██║   ██║   ██║██║  ██║███████╗██║███████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
-- ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═════╝     ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   ╚═╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
-- Desc: Mainly initialization.

AS = {}

DeriveGamemode("sandbox")
GM.Name = "Aftershock"
GM.Discord = "https://discord.gg/S3xQjZefuF"

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

    KEYBIND_USE = input.LookupBinding("+use") or '"+use" -Unbound'

end

ConVarDefaults = ConVarDefaults or {}
function AS_ClientConVar( name, str, save, sync, info, min, max )
    ConVarDefaults[name] = str
    local convar = CreateClientConVar( name, str, save, sync, info, min, max )
end

PlayerMeta = FindMetaTable("Player")
EntityMeta = FindMetaTable( "Entity" )

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
ITEMCUE.TAKE = "physics/body/body_medium_impact_soft4.wav"
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

hook.Add( "OnReloaded", "AS_Reload", function()
    if (CLIENT) then
        LocalPlayer():PrintMessage( HUD_PRINTCENTER, "Gamemode reloaded at " .. math.Round(CurTime()) .. "!" )
    end
end)

function GM:Move( ply, mv )
    local scavbonus = ply:GetASClass() == "scavenger" and CLS.Scavenger.movespeedmult or 1
    local movespeed = (SKL.Movement + math.floor(ply:GetSkillLevel( "endurance" ) * SKL.Endurance.runspeed)) * scavbonus
    local sprintmovespeed = (SKL.SprintMovement + math.floor(ply:GetSkillLevel( "endurance" ) * SKL.Endurance.runspeed)) * scavbonus
    movespeed = ply:HasArmor() and AS.Items[ply:GetArmor()].armor["movemult"] and  (movespeed * AS.Items[ply:GetArmor()].armor["movemult"]) or movespeed
    sprintmovespeed = ply:HasArmor() and AS.Items[ply:GetArmor()].armor["movemult"] and (sprintmovespeed * AS.Items[ply:GetArmor()].armor["movemult"]) or sprintmovespeed
    ply:SetRunSpeed( sprintmovespeed )
    ply:SetWalkSpeed( movespeed )
    ply:SetSlowWalkSpeed( 75 )
    ply:SetDuckSpeed( 0.4 )
    ply:SetViewOffset( Vector( 0, 0, 61 ) )
    ply:SetViewOffsetDucked( Vector( 0, 0, 35 ) )
end

function BoolToInt( bool )
    if bool then return 1 end
    return 0
end

function PlayerMeta:Nickname() --Will return the name of the player. Use this over self:Nick().
    return self:GetNW2String("as_name", self.name) or self:Nick()
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

function PlayerMeta:IsDeveloping() --Will return if a player is in developer mode
    if not IsValid(self) or not self:Alive() then return false end
    if self:IsAdmin() and self:GetMoveType() == MOVETYPE_NOCLIP and (self:GetActiveWeapon():GetClass() == "weapon_physgun" or self:GetActiveWeapon():GetClass() == "gmod_tool") then return true end
    return false
end

function EntityMeta:Alive()
    if IsValid( self ) and self:Health() > 0 then return true end
    return false
end

hook.Add( "ChatText", "AS_HideJoinLeave", function( index, name, text, type ) 
    if type == "joinleave" or type == "namechange" or type == "teamchange" then return true end
end)

function GM:PlayerConnect( name, ip )
    if (SERVER) then
        for k, v in pairs( player.GetAll() ) do
            v:ChatPrint( name .. " has joined the server." )
        end
    end
end

if CLIENT then

    function GetPos( ply )
        local pos = ply:GetPos():ToTable()
        local str = "Vector( " .. math.Round(pos[1], 2) .. ", " .. math.Round(pos[2], 2) .. ", " .. math.Round(pos[3], 2) .. " )"
        ply:ChatPrint( str )
        SetClipboardText( str )
    end
    concommand.Add("GetPosV2", GetPos)

    function GM:DrawPhysgunBeam( ply, wep, bool, target, phys, hit )
        if ply:IsDeveloping() and not IsValid(target) then return false end
        return true
    end

end

--  ██████╗ ██████╗ ███╗   ██╗███████╗ ██████╗ ██╗     ███████╗     ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
-- ██╔════╝██╔═══██╗████╗  ██║██╔════╝██╔═══██╗██║     ██╔════╝    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
-- ██║     ██║   ██║██╔██╗ ██║███████╗██║   ██║██║     █████╗      ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
-- ██║     ██║   ██║██║╚██╗██║╚════██║██║   ██║██║     ██╔══╝      ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
-- ╚██████╗╚██████╔╝██║ ╚████║███████║╚██████╔╝███████╗███████╗    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
--  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚══════╝╚══════╝     ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝

function ToConValue( bool )
	local int = BoolToInt( bool )
	return tostring(int)
end

CreateConVar( "as_alltalk", "0", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enables all talk for players.", 0, 1 )
CreateConVar( "as_pve", "0", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enables PvE only.", 0, 1 )
CreateConVar( "as_nosandbox", "0", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable satiation ticking.", 0, 1 )
CreateConVar( "as_mobs", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable spawning of mobs.", 0, 1 )
CreateConVar( "as_nodes", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enables spawning of nodes.", 0, 1 )
CreateConVar( "as_events", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable spawning of events.", 0, 1 )
CreateConVar( "as_satiation", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable satiation ticking.", 0, 1 )
CreateConVar( "as_occupation", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable occupation zone spawners.", 0, 1 )
CreateConVar( "as_collisions", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable collisions between players.", 0, 1 )