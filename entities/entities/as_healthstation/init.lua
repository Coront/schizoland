AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "menu.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_combine/health_charger001.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
end

function ENT:Use( ply )
	net.Start("as_healthstation_open")
		net.WriteEntity( self )
	net.Send( ply )
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_healthstation_open")
util.AddNetworkString("as_healthstation_use")
util.AddNetworkString("as_healthstation_updateprice")
util.AddNetworkString("as_healthstation_load")
util.AddNetworkString("as_healthstation_takeres")

net.Receive( "as_healthstation_use", function( _, ply ) 
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if ent:GetClass() != "as_healthstation" then return end
	if ent:GetPos():Distance( ply:GetPos() ) > 300 then ply:ChatPrint("You are too far to use this health station.") return end
	if ent:GetChargePercent() < ent.ChargeUse then ply:ChatPrint("There is not enough charge to use this health station.") return end
	if ply:Health() >= ply:GetMaxHealth() then ply:ChatPrint("You do not need this right now.") return end
	if CurTime() < (ply.NextHealthStationUse or 0) then ply:ChatPrint("You must wait " .. math.Round(ply.NextHealthStationUse - CurTime() ) .. " seconds before you can use this again.") return end

	local cost = ent:GetPrice()
	if ent:GetObjectOwner() != ply then
		for k, v in pairs( cost ) do --This first loop just make sures that the player has the items
			if ply:GetItemCount( k ) < v then
				return
			end
		end

		for k, v in pairs( cost ) do --This second one takes the items and adds it to the inventory
			if v > 0 then
				ply:TakeItemFromInventory( k, v )
				ent:AddItemToInventory( k, v )
			end
		end
	end

	ent:SetChargePercent( ent:GetChargePercent() - ent.ChargeUse )
	ply.NextHealthStationUse = CurTime() + ent.WaitLength
	ply:SetHealth( ply:GetMaxHealth() )
	ply:EmitSound("items/smallmedkit1.wav", 70)

	ply:ChatPrint("You have been fully healed.")
	if ent:GetObjectOwner() == ply then
		ply:ChatPrint("There was no charge as you are the owner.")
	end
end)

net.Receive("as_healthstation_updateprice", function( _, ply ) 
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if ent:GetClass() != "as_healthstation" then return end
	if ent:GetPos():Distance( ply:GetPos() ) > 300 then ply:ChatPrint("You are too far to manage this health station.") return end
	if ent:GetObjectOwner() != ply then ply:ChatPrint("You are not the owner of this health station.") return end

	local scrap = net.ReadFloat()
	local sp = net.ReadFloat()
	local chem = net.ReadFloat()

	if scrap < 0 then scrap = 0 return end
	if scrap > ent.MaxPrice then scrap = ent.MaxPrice return end
	scrap = math.Round( scrap )
	if sp < 0 then sp = 0 return end
	if sp > ent.MaxPrice then sp = ent.MaxPrice return end
	sp = math.Round( sp )
	if chem < 0 then chem = 0 return end
	if chem > ent.MaxPrice then chem = ent.MaxPrice return end
	chem = math.Round( chem )

	ent:SetPrice( scrap, sp, chem )
	ply:ChatPrint("Update price of Health Station.")
end)

net.Receive("as_healthstation_load", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if ent:GetClass() != "as_healthstation" then return end
	if ent:GetPos():Distance( ply:GetPos() ) > 300 then ply:ChatPrint("You are too far to manage this health station.") return end
	if ent:GetObjectOwner() != ply then ply:ChatPrint("You are not the owner of this health station.") return end
	if ent:GetChargePercent() >= ent.MaxCharge then ply:ChatPrint("This health station does not need to be filled.") return end

	local amt = net.ReadFloat()

	if amt <= 0 then amt = 1 end
	if amt > ply:GetItemCount( ent.ChargeItem ) then amt = ply:GetItemCount( ent.ChargeItem ) end
	amt = math.Clamp( math.Round( amt ), 0, 5 )
	if amt == 0 then ply:ChatPrint("You do not have any medicinal herbs to load.") return end

	ply:TakeItemFromInventory( ent.ChargeItem, amt )
	local chgamt = math.Clamp( ent:GetChargePercent() + (ent.ChargePerItem * amt), 0, ent.MaxCharge )
	ent:SetChargePercent( chgamt )

	ply:ChatPrint("You have loaded " .. amt .. " medicinal herbs into the health station.")
end)

net.Receive("as_healthstation_takeres", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if ent:GetClass() != "as_healthstation" then return end
	if ent:GetPos():Distance( ply:GetPos() ) > 300 then ply:ChatPrint("You are too far to withdraw the resources.") return end
	if ent:GetObjectOwner() != ply then ply:ChatPrint("You are not the owner of this health station.") return end

	local inv = ent:GetInventory()
	for k, v in pairs( ent:GetInventory() ) do
		ply:AddItemToInventory( k, v )
		ply:ChatPrint( AS.Items[k].name .. " (" .. v .. ") added to inventory.")
	end
	ent:SetInventory( {} )
	ent:ResyncInventory()
end)