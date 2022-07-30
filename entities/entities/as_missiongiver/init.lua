AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "menu.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/hunter/blocks/cube025x025x025.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
end

function ENT:Use( ply )
	net.Start("as_missiongiver_open")
		net.WriteEntity( self )
	net.Send( ply )
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString( "as_missiongiver_open" )
util.AddNetworkString( "as_missiongiver_acceptmission" )
util.AddNetworkString( "as_missiongiver_finishmission" )

net.Receive("as_missiongiver_acceptmission", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	local missionid = net.ReadString()

	if ent.Base != "as_missiongiver" then return end
	if ply:GetPos():Distance( ent:GetPos() ) > 300 then ply:ChatPrint("You are too far away to accept this mission.") return end
	if not ply:CanAcceptMission( missionid ) then ply:ChatPrint("You are unable to take this mission.") return end

	ply:AddMission( missionid )
	local minfo = FetchMissionInfo( missionid )
	ply:ChatPrint("You have accepted the mission: " .. minfo.name)
end)

net.Receive("as_missiongiver_finishmission", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	local missionid = net.ReadString()

	if ent.Base != "as_missiongiver" then return end
	if ply:GetPos():Distance( ent:GetPos() ) > 300 then ply:ChatPrint("You are too far away to turn in this mission.") return end
	if ent.GiverID != FindCharacterByMission( missionid ) then ply:ChatPrint("You cannot turn this mission in from this character.") return end
	if not ply:CanTurnMissionIn( missionid ) then ply:ChatPrint("You are unable to turn in this mission.") return end

	ply:FinishMission( missionid )
	local minfo = FetchMissionInfo( missionid )
	ply:ChatPrint("You have completed the mission: " .. minfo.name)
end)