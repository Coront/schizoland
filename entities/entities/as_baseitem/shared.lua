ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Base Item"
ENT.Author			= "Tampy"
ENT.Purpose			= "Base item that contains data"

function ENT:SetItem( item )
	self:SetNW2String( "ItemID", item )
end

function ENT:SetAmount( amt )
	self:SetNW2Int( "Amount", amt )
end

function ENT:GetItem()
	return self:GetNW2String( "ItemID", "item?itemid" )
end

function ENT:GetAmount()
	return self:GetNW2Int( "Amount", 1 )
end