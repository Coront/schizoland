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
    if self:GetCommunity() == ply:GetCommunity() then
        net.Start("as_stockpile_open")
            net.WriteEntity( self )
        net.Send( ply )
    else
    
    end
end

-- Database

if ( SERVER ) then

    function ENT:DataTableCheck()
        sql.Query( "SELECT * FROM as_communities_storage WHERE cid = " .. self:GetCommunity() )
    end

    function ENT:SaveResources()
        sql.Query( "UPDATE as_communities_storage SET res = " .. SQLStr( util.TableToJSON( self:GetResources(), true ) ) .. " WHERE cid = " .. self:GetCommunity() )
    end

end

-- Networking

util.AddNetworkString("as_stockpile_open")
util.AddNetworkString("as_stockpile_addresource")
util.AddNetworkString("as_stockpile_takeresource")

net.Receive("as_stockpile_addresource", function( _, ply )
    local ent = net.ReadEntity()
    if not IsValid( ent ) then return end
    if ent:GetClass() != "as_community_stockpile" then return end
    if ply:GetPos():Distance(ent:GetPos()) > 300 then ply:ChatPrint("You are too far away.") return end
    if ent:GetCommunity() != ply:GetCommunity() and not ent.Broken then ply:ChatPrint("Unable to store.") return end
    
    local scrap = net.ReadInt( 32 )
    if scrap < 0 then scrap = 0 end
    if scrap > ply:GetItemCount( "misc_scrap" ) then scrap = ply:GetItemCount( "misc_scrap" ) end

    local smallp = net.ReadInt( 32 )
    if smallp < 0 then smallp = 0 end
    if smallp > ply:GetItemCount( "misc_smallparts" ) then smallp = ply:GetItemCount( "misc_smallparts" ) end
    
    local chem = net.ReadInt( 32 )
    if chem < 0 then chem = 0 end
    if chem > ply:GetItemCount( "misc_chemical" ) then chem = ply:GetItemCount( "misc_chemical" ) end

    if scrap > 0 then
        ent:PlayerAddResource( ply, "misc_scrap", scrap )
        ply:ChatPrint( "Stored " .. scrap .. " " .. AS.Items["misc_scrap"].name .. ".")
    end
    if smallp > 0 then
        ent:PlayerAddResource( ply, "misc_smallparts", smallp )
        ply:ChatPrint( "Stored " .. smallp .. " " .. AS.Items["misc_smallparts"].name .. ".")
    end
    if chem > 0 then
        ent:PlayerAddResource( ply, "misc_chemical", chem )
        ply:ChatPrint( "Stored " .. chem .. " " .. AS.Items["misc_chemical"].name .. ".")
    end
end)

net.Receive("as_stockpile_takeresource", function( _, ply ) 
    local ent = net.ReadEntity()
    if not IsValid( ent ) then return end
    if ent:GetClass() != "as_community_stockpile" then return end
    if ply:GetPos():Distance( ent:GetPos() ) > 300 then ply:ChatPrint("You are too far away.") return end
    if ent:GetCommunity() != ply:GetCommunity() and not ent.Broken then ply:ChatPrint("Unable to withdraw.") return end

    local scrap = net.ReadInt( 32 )
    if scrap < 0 then scrap = 0 end
    if scrap > ent:GetResourceAmount( "misc_scrap" ) then scrap = ent:GetResourceAmount( "misc_scrap" ) end

    local smallp = net.ReadInt( 32 )
    if smallp < 0 then smallp = 0 end
    if smallp > ent:GetResourceAmount( "misc_smallparts" ) then smallp = ent:GetResourceAmount( "misc_smallparts" ) end

    local chem = net.ReadInt( 32 )
    if chem < 0 then chem = 0 end
    if chem > ent:GetResourceAmount( "misc_chemical" ) then chem = ent:GetResourceAmount( "misc_chemical" ) end

    if scrap > 0 then
        ent:PlayerTakeResource( ply, "misc_scrap", scrap )
        ply:ChatPrint( "Withdrew " .. scrap .. " " .. AS.Items["misc_scrap"].name .. ".")
    end
    if smallp > 0 then
        ent:PlayerTakeResource( ply, "misc_smallparts", smallp )
        ply:ChatPrint( "Withdrew " .. smallp .. " " .. AS.Items["misc_smallparts"].name .. ".")
    end
    if chem > 0 then
        ent:PlayerTakeResource( ply, "misc_chemical", chem )
        ply:ChatPrint( "Withdrew " .. chemical .. " " .. AS.Items["misc_chemical"].name .. ".")
    end
end)