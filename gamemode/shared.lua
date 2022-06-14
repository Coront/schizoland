-- ███████╗██╗  ██╗ █████╗ ██████╗ ███████╗██████╗     ██╗███╗   ██╗██╗████████╗██╗ █████╗ ██╗     ██╗███████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
-- ██╔════╝██║  ██║██╔══██╗██╔══██╗██╔════╝██╔══██╗    ██║████╗  ██║██║╚══██╔══╝██║██╔══██╗██║     ██║╚══███╔╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
-- ███████╗███████║███████║██████╔╝█████╗  ██║  ██║    ██║██╔██╗ ██║██║   ██║   ██║███████║██║     ██║  ███╔╝ ███████║   ██║   ██║██║   ██║██╔██╗ ██║
-- ╚════██║██╔══██║██╔══██║██╔══██╗██╔══╝  ██║  ██║    ██║██║╚██╗██║██║   ██║   ██║██╔══██║██║     ██║ ███╔╝  ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
-- ███████║██║  ██║██║  ██║██║  ██║███████╗██████╔╝    ██║██║ ╚████║██║   ██║   ██║██║  ██║███████╗██║███████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
-- ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═════╝     ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   ╚═╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

AS = {}

DeriveGamemode("sandbox")
GM.Name = "Aftershock"
GM.Discord = "https://discord.gg/S3xQjZefuF"
GM.Rules = "https://docs.google.com/document/d/1gtxH4Jcli8R9vZIke9wXKbgNIh_EmCdDNx8T-TnhIDQ/edit?usp=sharing"

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

PlayerMeta = FindMetaTable( "Player" )
EntityMeta = FindMetaTable( "Entity" )

include( "_moduleloader.lua" )
if SERVER then
    AddCSLuaFile( "_moduleloader.lua" )
end

-- ███████╗ ██████╗ ██╗   ██╗███╗   ██╗██████╗      ██████╗██╗   ██╗███████╗███████╗
-- ██╔════╝██╔═══██╗██║   ██║████╗  ██║██╔══██╗    ██╔════╝██║   ██║██╔════╝██╔════╝
-- ███████╗██║   ██║██║   ██║██╔██╗ ██║██║  ██║    ██║     ██║   ██║█████╗  ███████╗
-- ╚════██║██║   ██║██║   ██║██║╚██╗██║██║  ██║    ██║     ██║   ██║██╔══╝  ╚════██║
-- ███████║╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝    ╚██████╗╚██████╔╝███████╗███████║
-- ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═════╝ ╚══════╝╚══════╝

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

--  ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ ██████╗ ███╗   ██╗    ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
-- ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔═══██╗████╗  ██║    ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
-- ██║     ██║   ██║██╔████╔██║██╔████╔██║██║   ██║██╔██╗ ██║    █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
-- ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██║   ██║██║╚██╗██║    ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
-- ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║╚██████╔╝██║ ╚████║    ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
--  ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
-- These are all functions that have exeptions to my organization, mainly because they're used in more than one location which requires it.

function AS.LuaError( message )
    ErrorNoHaltWithStack( "[AS] Error: " .. message .. "\n" )
end

hook.Add( "OnReloaded", "AS_Reload", function()
    if (CLIENT) then
        LocalPlayer():PrintMessage( HUD_PRINTCENTER, "Gamemode reloaded at " .. math.Round(CurTime()) .. "!" )
    end
end)

function BoolToInt( bool )
    if bool then return 1 end
    return 0
end

function ToConValue( bool )
	local int = BoolToInt( bool )
	return tostring(int)
end

function PlayerMeta:IsDeveloping() --Will return if a player is in developer mode
    if not IsValid(self) or not self:Alive() then return false end
    if self:IsAdmin() and (self:GetMoveType() == MOVETYPE_NOCLIP and not self:InVehicle()) and (self:GetActiveWeapon():GetClass() == "weapon_physgun" or self:GetActiveWeapon():GetClass() == "gmod_tool") then return true end
    return false
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

function EntityMeta:Alive()
    if IsValid( self ) and self:Health() > 0 then return true end
    return false
end

function FindPlayerByName( name )
    local options = {}
    for k, v in pairs( player.GetAll() ) do
        if not string.find( string.lower( v:Nickname() ), string.lower( name ) ) then continue end
        options[#options + 1] = v
    end

    if #options > 1 then
        return options, true --We'll return the options, but say there are too many.
    elseif #options <= 0 then
        return nil --We'll return nothing, because nothing was found.
    else
        return options[1] --Return the first and only option.
    end
end

--  ██████╗ ██████╗ ███╗   ██╗███████╗ ██████╗ ██╗     ███████╗     ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
-- ██╔════╝██╔═══██╗████╗  ██║██╔════╝██╔═══██╗██║     ██╔════╝    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
-- ██║     ██║   ██║██╔██╗ ██║███████╗██║   ██║██║     █████╗      ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
-- ██║     ██║   ██║██║╚██╗██║╚════██║██║   ██║██║     ██╔══╝      ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
-- ╚██████╗╚██████╔╝██║ ╚████║███████║╚██████╔╝███████╗███████╗    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
--  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚══════╝╚══════╝     ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝

CreateConVar( "as_alltalk", "0", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enables all talk for players.", 0, 1 )
CreateConVar( "as_pve", "0", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enables PvE only.", 0, 1 )
CreateConVar( "as_nosandbox", "0", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable satiation ticking.", 0, 1 )
CreateConVar( "as_mobs", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable spawning of mobs.", 0, 1 )
CreateConVar( "as_nodes", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enables spawning of nodes.", 0, 1 )
CreateConVar( "as_events", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable spawning of events.", 0, 1 )
CreateConVar( "as_satiation", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable satiation ticking.", 0, 1 )
CreateConVar( "as_occupation", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable occupation zone spawners.", 0, 1 )
CreateConVar( "as_collisions", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable collisions between players.", 0, 1 )
CreateConVar( "as_respawnwait", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable respawn wait.", 0, 1 )
CreateConVar( "as_classchange", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable class changing.", 0, 1 )
CreateConVar( "as_classchangecost", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable cost for class changing.", 0, 1 )
CreateConVar( "as_stress", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable combat timer.", 0, 1 )
CreateConVar( "as_cases", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Enable player case dropping.", 0, 1 )