ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
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

function ENT:CalcCanCarry( ply )
	local item = self:GetItem()
	local amt = self:GetAmount()

	local carryamt = 0
	local carrywgt = 0
	for i = 1, amt do
		if ply:GetCarryWeight() + (carrywgt + AS.Items[item].weight) < ply:MaxCarryWeight() then
			carryamt = carryamt + 1
			carrywgt = carrywgt + AS.Items[item].weight
		else
			break
		end
	end

	return carryamt
end