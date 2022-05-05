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

util.AddNetworkString("as_stockpile_addresource")