ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Item Base"
ENT.Author			= "Tampy"
ENT.Purpose			= "Base item that contains data"
ENT.Category		= "Aftershock"
ENT.Spawnable		= false

function ENT:SetItem( item )
	self:SetNWString( "ItemID", item )
end

function ENT:SetAmount( amt )
	self:SetNWInt( "Amount", amt )
end

function ENT:GetItem()
	return self:GetNWString( "ItemID", "item?itemid" )
end

function ENT:GetAmount()
	return self:GetNWInt( "Amount", 1 )
end