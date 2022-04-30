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
	if ply:GetASClass() != AS.Items[item].class then ply:ChatPrint("You must be a " .. AS.Items[item].class .. " to craft this!") return false end
	return true
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_workbench_open")
util.AddNetworkString("as_workbench_craftitem")

net.Receive("as_workbench_craftitem", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid(ent) then return end
	if ent.Base != "as_workbench" then return end
	if ply:GetPos():Distance(ent:GetPos()) > 300 then ply:ChatPrint("You're too far.") return end

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