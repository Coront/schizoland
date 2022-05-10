AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "menu.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_interiors/vendingmachinesoda01a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
end

function ENT:Use( ply )
	local profiles = ply:FetchVendorProfiles()
	net.Start( "as_vendor_open" )
		net.WriteEntity( self )
		net.WriteTable( profiles )
	net.Send( ply )
end

-- ██████╗ ██████╗  ██████╗ ███████╗██╗██╗     ███████╗███████╗
-- ██╔══██╗██╔══██╗██╔═══██╗██╔════╝██║██║     ██╔════╝██╔════╝
-- ██████╔╝██████╔╝██║   ██║█████╗  ██║██║     █████╗  ███████╗
-- ██╔═══╝ ██╔══██╗██║   ██║██╔══╝  ██║██║     ██╔══╝  ╚════██║
-- ██║     ██║  ██║╚██████╔╝██║     ██║███████╗███████╗███████║
-- ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

function PlayerMeta:FetchVendorProfiles()
	local query = sql.Query("SELECT * FROM as_vendors WHERE pid = " .. self.pid .. " AND deleted IS NULL")
	query = query or {}
	return query
end

function PlayerMeta:EstablishVendorProfile( name )
	sql.Query("INSERT INTO as_vendors VALUES ( NULL, " .. self.pid .. ", " .. SQLStr( name ) .. ", NULL, NULL, NULL )")
	self:ChatPrint("New profile established: " .. name)
end

function PlayerMeta:DeleteVendorProfile( vid )
	sql.Query("UPDATE as_vendors SET deleted = " .. SQLStr( os.date( "%m/%d/%y - %I:%M %p", os.time() ) ) .. " WHERE vid = " .. vid)
	self:ChatPrint("Deleted profile (" .. vid .. ")")
end

function PlayerMeta:RenameVendorProfile( vid, name )
	sql.Query("UPDATE as_vendors SET name = " .. SQLStr( name ) .. " WHERE vid = " .. vid)
	self:ChatPrint("Renamed profile to " .. name .. " (" .. vid .. ")")
end

-- ██╗████████╗███████╗███╗   ███╗    ██╗     ██╗███████╗████████╗██╗███╗   ██╗ ██████╗
-- ██║╚══██╔══╝██╔════╝████╗ ████║    ██║     ██║██╔════╝╚══██╔══╝██║████╗  ██║██╔════╝
-- ██║   ██║   █████╗  ██╔████╔██║    ██║     ██║███████╗   ██║   ██║██╔██╗ ██║██║  ███╗
-- ██║   ██║   ██╔══╝  ██║╚██╔╝██║    ██║     ██║╚════██║   ██║   ██║██║╚██╗██║██║   ██║
-- ██║   ██║   ███████╗██║ ╚═╝ ██║    ███████╗██║███████║   ██║   ██║██║ ╚████║╚██████╔╝
-- ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝    ╚══════╝╚═╝╚══════╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝

function PlayerMeta:CreateSale( ent, item, amount, scrapcost, spcost, chemcost )
	self:TakeItemFromInventory( item, amount )
	ent:AddSale( item, { amt = amount, scrap = scrapcost, smallp = spcost, chemical = chemcost} )
	ent:SaveSales()

	self:ChatPrint("You have created a sale for " .. AS.Items[item].name .. " (" .. amount .. ").")
end

function PlayerMeta:AddToExistingSale( ent, item, amount )
	self:TakeItemFromInventory( item, amount )
	ent:AddToExistingSale( item, amount )
	ent:SaveSales()

	self:ChatPrint("You have added to an existing sale " .. AS.Items[item].name .. " (" .. amount .. ")")
end

function PlayerMeta:WithdrawItemFromSale( ent, item, amount )
	ent:TakeFromExistingSale( item, amount )
	self:AddItemToInventory( item, amount )
	ent:SaveSales()

	self:ChatPrint("You have withdrawn " .. AS.Items[item].name .. " (" .. amount .. ")")
end

function PlayerMeta:ModifySalePrice( ent, item, scrap, sp, chem )
	ent:SetSalePrice( item, scrap, sp, chem )
	ent:SaveSales()

	self:ChatPrint("You have updated the sale price for " .. AS.Items[item].name .. ".")
end

function PlayerMeta:CreateDisplayObject( vend, item )
	local tr = self:TraceFromEyes( 150 )

	local ent = ents.Create("as_vendor_display")
	ent:SetPos( tr.HitPos )
	ent:SetAngles( Angle( 0, 0, 0 ) )
	ent:Spawn()
	ent:SetParentVendor( vend )
	ent:SetPackaged( true )
	ent:SetDisplayItem( item )
	ent:SetObjectOwner( self )
end

function PlayerMeta:PurchaseItem( ent, reqs, item, amt )
	for k, v in pairs( reqs ) do
		self:TakeItemFromInventory( k, v )
		ent:AddResource( k, v )
	end

	ent:TakeFromExistingSale( item, amt )
	self:AddItemToInventory( item, amt )
	ent:SaveSales()

	ent:EmitSound( "buttons/lever7.wav" )
	self:ChatPrint("You have purchased " .. AS.Items[item].name .. " (" .. amt .. ")")
end

function PlayerMeta:WithdrawResources( ent )
	for k, v in pairs( ent:GetResources() ) do
		ent:RemoveResource( k, v )
		self:AddItemToInventory( k, v )
		self:ChatPrint(AS.Items[k].name .. " (" .. v .. ") added to inventory.")
	end
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_vendor_open")
util.AddNetworkString("as_vendor_createprofile")
util.AddNetworkString("as_vendor_deleteprofile")
util.AddNetworkString("as_vendor_renameprofile")
util.AddNetworkString("as_vendor_setprofile")
util.AddNetworkString("as_vendor_unloadprofile")
util.AddNetworkString("as_vendor_withdrawres")
util.AddNetworkString("as_vendor_changemodel")
util.AddNetworkString("as_vendor_item_list")
util.AddNetworkString("as_vendor_item_unlist")
util.AddNetworkString("as_vendor_item_modifyprice")
util.AddNetworkString("as_vendor_item_createdisplay")
util.AddNetworkString("as_vendor_item_purchase")

net.Receive( "as_vendor_createprofile", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	local name = net.ReadString()

	if ent:GetClass() != "as_vendor" then return end
	if ent:GetObjectOwner() != ply then return end
	if string.len( name ) <= 2 then ply:ChatPrint("Your profile name is not long enough.") return end
	for k, v in pairs(SET.BannedWords) do
        if string.find(name:lower(), v) then ply:Kick("Inappropriate name usage") return end
    end

	local profiles = ply:FetchVendorProfiles()

	if #profiles <= 0 then --First profile is always free.
		ply:EstablishVendorProfile( name )
	else --Players will have to pay a price for making more.
		for k, v in pairs( ent.ProfileCost ) do
			if not ply:HasInInventory( k, v ) then
				ply:ChatPrint("You do not have enough " .. AS.Items[k].name .. " to make a profile.")
				return
			end
		end

		for k, v in pairs( ent.ProfileCost ) do
			ply:TakeItemFromInventory( k, v )
		end
		ply:ResyncInventory()
		ply:EstablishVendorProfile( name )
	end
end)

net.Receive( "as_vendor_deleteprofile", function( _, ply ) 
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	local vid = net.ReadInt( 32 )

	if ent:GetClass() != "as_vendor" then return end
	if ent:GetObjectOwner() != ply then return end

	local profile = sql.QueryValue("SELECT pid FROM as_vendors WHERE vid = " .. vid)
	if tonumber(profile) != ply.pid then ply:ChatPrint("This is not your profile.") return end

	for k, v in pairs( ents.FindByClass("as_vendor") ) do
		if v:GetProfile() == vid then
			v:SetProfile( 0, "" )
			v:SetSales( {} )
			v:SetResources( {} )
		end
	end

	ply:DeleteVendorProfile( vid )
end)

net.Receive( "as_vendor_renameprofile", function( _, ply ) 
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	local name = net.ReadString()

	if ent:GetClass() != "as_vendor" then return end
	if ent:GetObjectOwner() != ply then return end
	if string.len( name ) <= 2 then ply:ChatPrint("Your profile name is not long enough.") return end
	for k, v in pairs(SET.BannedWords) do
        if string.find(name:lower(), v) then ply:Kick("Inappropriate name usage") return end
    end

	local vid = ent:GetProfile()
	if vid == 0 then ply:ChatPrint("No Profile.") return end
	local profile = sql.QueryValue("SELECT pid FROM as_vendors WHERE vid = " .. vid)
	if tonumber(profile) != ply.pid then ply:ChatPrint("This is not your profile.") return end

	ply:RenameVendorProfile( vid, name )
	ent:SetProfile( vid, name )
end)

net.Receive( "as_vendor_setprofile", function( _, ply ) 
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if ent:GetClass() != "as_vendor" then return end
	if ent:GetObjectOwner() != ply then return end
	if ent:GetProfile() != 0 then ply:ChatPrint("This vendor already has a profile selected.") return end

	local vid = net.ReadInt( 32 )
	local profile = sql.Query("SELECT * FROM as_vendors WHERE vid = " .. vid)[1]
	if tonumber(profile.pid) != ply.pid then ply:ChatPrint("You do not own this profile.") return end
	if profile.deleted != "NULL" then ply:ChatPrint("This profile is deleted.") return end
	for k, v in pairs( ents.FindByClass("as_vendor") ) do
		if v:GetProfile() == vid then
			ply:ChatPrint("A vendor with this profile is already active.")
			return
		end
	end

	local sales = profile.sale == "NULL" and {} or util.JSONToTable( profile.sale )
	local resources = profile.res == "NULL" and {} or util.JSONToTable( profile.res )

	ply:ChatPrint("You have loaded the profile: " .. profile.name)
	ent:SetProfile( vid, profile.name )
	ent:SetSales( sales )
	ent:SetResources( resources )
end)

net.Receive( "as_vendor_unloadprofile", function( _, ply ) 
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if ent:GetClass() != "as_vendor" then return end
	if ent:GetObjectOwner() != ply then return end
	if ent:GetProfile() == 0 then ply:ChatPrint("No profile to unload.") return end

	ply:ChatPrint("You have unloaded this vendor's profile.")
	ent:SetProfile( 0, "" )
	ent:SetSales( {} )
	ent:SetResources( {} )
end)

net.Receive( "as_vendor_changemodel", function( _, ply ) 
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if ent:GetClass() != "as_vendor" then return end
	if ent:GetObjectOwner() != ply then return end
	if ent:GetProfile() == 0 then ply:ChatPrint("No profile is loaded.") return end

	local model = net.ReadString()
	if not ent.Models[model] then ply:ChatPrint("The vending machine cannot change to this model.") return end
	if CurTime() <= (ent.NextModelChange or 0) then ply:ChatPrint("You must wait " .. math.Round(ent.NextModelChange - CurTime(), 1) .. " seconds before changing the model again.") return end

	ent.NextModelChange = CurTime() + 10
	ent:SetModel( model )
	ent:PhysicsInit( SOLID_VPHYSICS )
	ent:EmitSound("ambient/energy/weld2.wav")
end)

net.Receive( "as_vendor_item_list", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if ent:GetClass() != "as_vendor" then return end
	if ent:GetObjectOwner() != ply then return end
	if ent:GetProfile() == 0 then ply:ChatPrint("No profile is loaded.") return end

	local item = net.ReadString()
	if not AS.Items[item] then return end --fake item
	if AS.Items[item].novendor then ply:ChatPrint("This item cannot be sold in a vendor.") return end --cannot be put in a vendor.

	local amount = net.ReadInt( 32 )
	if amount <= 0 then amount = 1 end
	if amount > ply:GetItemCount( item ) then amount = ply:GetItemCount( item ) end
	if amount == 0 then ply:ChatPrint("You need an item in order to list it.") return end --Player doesnt have this item.

	if ent:CarryWeight() + (AS.Items[item].weight * amount) > ent.ProfileCapacity then ply:ChatPrint("This profile has reached its weight capacity.") return end

	local scrap = net.ReadInt( 32 )
	if scrap < 0 then scrap = 0 end
	if scrap > ent.MaxPrice then scrap = ent.MaxPrice end

	local sp = net.ReadInt( 32 )
	if sp < 0 then sp = 0 end
	if sp > ent.MaxPrice then sp = ent.MaxPrice end

	local chem = net.ReadInt( 32 )
	if chem < 0 then chem = 0 end
	if chem > ent.MaxPrice then chem = ent.MaxPrice end

	if not ent:SaleExists( item ) then
		ply:CreateSale( ent, item, amount, scrap, sp, chem )
	else
		ply:AddToExistingSale( ent, item, amount )
	end
end)

net.Receive( "as_vendor_item_unlist", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if ent:GetClass() != "as_vendor" then return end
	if ent:GetObjectOwner() != ply then return end
	if ent:GetProfile() == 0 then ply:ChatPrint("No profile is loaded.") return end

	local item = net.ReadString()
	if not AS.Items[item] then return end
	if not ent:SaleExists( item ) then return end

	local amount = net.ReadInt( 32 )
	if amount <= 0 then amount = 1 end
	if amount > ent:GetSaleAmount( item ) then amount = ent:GetSaleAmount( item ) end
	if amount == 0 then ply:ChatPrint("This profile doesn't have this item.") return end

	if ply:GetCarryWeight() + (AS.Items[item].weight * amount) > ply:MaxCarryWeight() then ply:ChatPrint("You are too overweight to carry this.") return end

	ply:WithdrawItemFromSale( ent, item, amount )
end)

net.Receive( "as_vendor_item_modifyprice", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if ent:GetClass() != "as_vendor" then return end
	if ent:GetObjectOwner() != ply then return end
	if ent:GetProfile() == 0 then ply:ChatPrint("No profile is loaded.") return end

	local item = net.ReadString()
	if not AS.Items[item] then return end --fake item
	if not ent:SaleExists( item ) then return end

	local scrap = net.ReadInt( 32 )
	if scrap < 0 then scrap = 0 end
	if scrap > ent.MaxPrice then scrap = ent.MaxPrice end

	local sp = net.ReadInt( 32 )
	if sp < 0 then sp = 0 end
	if sp > ent.MaxPrice then sp = ent.MaxPrice end

	local chem = net.ReadInt( 32 )
	if chem < 0 then chem = 0 end
	if chem > ent.MaxPrice then chem = ent.MaxPrice end

	ply:ModifySalePrice( ent, item, scrap, sp, chem )
end)

net.Receive( "as_vendor_item_createdisplay", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if ent:GetClass() != "as_vendor" then return end
	if ent:GetObjectOwner() != ply then return end
	if ent:GetProfile() == 0 then ply:ChatPrint("No profile is loaded.") return end

	local item = net.ReadString()
	if not ent:SaleExists( item ) then return end

	ply:CreateDisplayObject( ent, item )
end)

net.Receive( "as_vendor_item_purchase", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if ent:GetClass() != "as_vendor" then return end
	if ent:GetObjectOwner() == ply then ply:ChatPrint("You cannot purchase items from your own vending machine.") return end
	if ent:GetProfile() == 0 then ply:ChatPrint("No profile is loaded.") return end

	local item = net.ReadString()
	if not ent:SaleExists( item ) then return end

	local amt = net.ReadInt( 32 )
	if amt <= 0 then amt = 1 end
	if amt > ent:GetSaleAmount( item ) then amt = ent:GetSaleAmount( item ) end
	if amt == 0 then return end

	local reqs = {}
	reqs["misc_scrap"] = ent:GetSales()[item].scrap * amt
	reqs["misc_smallparts"] = ent:GetSales()[item].smallp * amt
	reqs["misc_chemical"] = ent:GetSales()[item].chemical * amt

	for k, v in pairs( reqs ) do
		if not ply:HasInInventory( k, v ) then
			ply:ChatPrint("You do not have enough " .. AS.Items[k].name .. " to purchase this.")
			return
		end

		if (ent:GetResources()[k] or 0) + v > ent.ResCapacity then
			ply:ChatPrint("There are too many resources in the vendor for you to insert more. The owner must empty it first for you to purchase this.")
			return
		end
	end

	ply:PurchaseItem( ent, reqs, item, amt )
end)

net.Receive( "as_vendor_withdrawres", function( _, ply )
	local ent = net.ReadEntity()
	if not IsValid( ent ) then return end
	if ent:GetClass() != "as_vendor" then return end
	if ent:GetObjectOwner() != ply then ply:ChatPrint("fuck off lol") return end
	if ent:GetProfile() == 0 then ply:ChatPrint("No profile is loaded.") return end

	ply:WithdrawResources( ent )
end)