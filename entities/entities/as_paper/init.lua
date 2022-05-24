AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "menu.lua" )
include( "shared.lua" )

function ENT:Initialize()
    self:SetModel( "models/props_c17/paper01.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
end

function ENT:Use( ply )
    if self:GetObjectOwner() == ply then
        net.Start( "as_paper_open" )
            net.WriteEntity( self )
        net.Send( ply )
    else
        net.Start( "as_paper_read" )
            net.WriteEntity( self )
        net.Send( ply )
    end
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString( "as_paper_open" )
util.AddNetworkString( "as_paper_read" )
util.AddNetworkString( "as_paper_modify" )

net.Receive( "as_paper_modify", function( _, ply )
    local ent = net.ReadEntity()
    if not IsValid(ent) then return end
    if ent:GetClass() != "as_paper" then return end
    if ply:GetPos():Distance(ent:GetPos()) > 300 then ply:ChatPrint("You are too far to modify this paper.") return end
    if ent:GetObjectOwner() != ply then ply:ChatPrint("You are not the owner.") return end

    local title = net.ReadString()
    if string.len(title) > ent.TitleLimit then ply:ChatPrint("Too many characters in title.") return end

    local str = net.ReadString()
    if string.len(str) > ent.CharacterLimit then ply:ChatPrint("Too many characters in description.") return end

    ent:SetTitle( title )
    ent:SetParagraph( str )
    ply:ChatPrint("Updated Paper!")
end)