AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "menu.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
end

function ENT:Use( ply )
    net.Start("as_workbench_open")
		net.WriteEntity( self )
	net.Send( ply )
end

-- ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
-- ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
-- █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
-- ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
-- ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
-- ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

function ENT:PlayerCanCraftItem( ply, item, amt )
	if ply:GetPos():Distance(self:GetPos()) >= 200 then ply:ChatPrint("You are too far to craft this item.") return false end
	return true
end

function ENT:PickedUp( ply )
	self:Remove()

	local item = FetchToolIDByClass( self:GetClass() )
	if not item then AS.LuaError("Attempt to pick up an object with no entity tied, cannot find itemid - " .. self:GetClass()) return end

	ply:ChatPrint("Picked up " .. AS.Items[item].name .. ".")
	ply:AddItemToInventory( item, 1 )
	ply:RemoveToolFromCache( item )
	ply:ResyncInventory()
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_workbench_open")
util.AddNetworkString("as_workbench_pickup")
util.AddNetworkString("as_workbench_craftitem")

net.Receive("as_workbench_pickup", function( _, ply )
	local ent = net.ReadEntity()

	if not ent:PlayerCanPickUp( ply ) then return end
	if ply:GetCarryWeight() + AS.Items[FetchToolIDByClass( ent:GetClass() )].weight > ply:MaxCarryWeight() then ply:ChatPrint("You are too overweight to carry this.") return end

	ent:PickedUp( ply )
end)

net.Receive("as_workbench_craftitem", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid(ent) then return end
	local item = net.ReadString()
	local amt = net.ReadInt( 32 )

	if not AS.Items[item] then ply:ChatPrint("This isnt a valid item.") ply:ResyncInventory() return end --item doesnt exist
	if not ent.CraftTable then ply:ChatPrint("This isnt a workbench.") ply:ResyncInventory() return end
    if not ent.CraftTable[item] then ply:ChatPrint("You cannot make this item at this workbench.") ply:ResyncInventory() return end --Item exists but is not craftable at this workbench
    if amt < 1 then amt = 1 end --Person might try negative numbers
    amt = math.Round( amt ) --Person might try decimals
    if not ply:CanCraftItem( item, amt ) then ply:ChatPrint("You lack the sufficient materials to craft this item.") ply:ResyncInventory() return end --no materials????
	if not ent:PlayerCanCraftItem( ply, item, amt ) then ply:ResyncInventory() return end

	ply:CraftItem( item, amt )
end)