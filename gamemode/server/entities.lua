--This file is meant for item tools specifically. Don't try running these on anything else, as it probably won't work.

function EntityMeta:PickedUp( ply, item )
	self:Remove()
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

util.AddNetworkString("as_tool_pickup")

net.Receive("as_tool_pickup", function( _, ply )
	local ent = net.ReadEntity()

	if ent.PickupDelay and ent.PickupDelayActive then ply:ChatPrint("You are already attempting to pick this up, please wait.") return end
	if not ent:PlayerCanPickUp( ply ) then return end
    local item = FetchToolIDByClass( ent:GetClass() )
	if not item then AS.LuaError("Attempt to pick up an object with no entity tied, cannot find itemid - " .. ent:GetClass()) return end
	if ply:GetCarryWeight() + AS.Items[item].weight > ply:MaxCarryWeight() then ply:ChatPrint("You are too overweight to carry this.") return end

	if ent.PickupDelay then
		ply:ChatPrint("This object has a pickup delay. You will pick it up in " .. ent.PickupDelay .. " seconds.")
		ent.PickupDelayActive = true
		timer.Simple( ent.PickupDelay, function()
			if IsValid( ent ) then
				ent:PickedUp( ply, item )
			end
		end)
	else
		ent:PickedUp( ply, item )
	end
end)