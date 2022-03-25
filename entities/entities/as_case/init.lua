AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

--To note quickly, a lot of the case's functionality is built off of the container's base. If you're looking for something here make sure you reference that.
--Also a lot of this was monkey coded and i probably should have just built a separate base but im lazy

function ENT:Initialize()
	self:SetModel( "models/props_c17/SuitCase_Passenger_Physics.mdl" )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
    self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

function ENT:Think()
    if table.Count(self:GetInventory()) <= 0 then
        self:Remove()
    end
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString( "as_case_takeammo" )

net.Receive( "as_case_takeammo", function(_, ply) 
	local ent = net.ReadEntity()
	local item = net.ReadString()
	local amt = net.ReadInt( 32 )

	--We are going to take ammo from a case. We need to make sure that the case actually CONTAINS the ammo, and the right amount.
	if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() ent:ResyncInventory() return end --Person might try an invalid item
    if not ent:HasInAmmoInventory( item, amt ) then ply:ChatPrint("This item isn't in the container.") ply:ResyncInventory() ent:ResyncInventory() return end --Person might try running without the container actually having the item
    if not ent:PlayerCanTakeAmmo( ply ) then return end
    if amt < 1 then amt = 1 end --Person might try negative numbers
    local inv = ent:GetInventory().ammo
    if amt > inv[item] then amt = inv[item] end --Person might try higher numbers than what they actually have
    amt = math.Round(amt) --Person might try decimals

    --It's all verified.
    ent:PlayerTakeAmmo( ply, item, amt )
	ply:ChatPrint( AS.Items[item].name .. " (" .. amt .. ") Taken from case." )

	ent:ResyncInventory() --We need to resync the inventory to all clients.
end)