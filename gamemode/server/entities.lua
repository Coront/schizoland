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

	if not ent:PlayerCanPickUp( ply ) then return end
    local item = FetchToolIDByClass( ent:GetClass() )
	if not item then AS.LuaError("Attempt to pick up an object with no entity tied, cannot find itemid - " .. self:GetClass()) return end
	if ply:GetCarryWeight() + AS.Items[item].weight > ply:MaxCarryWeight() then ply:ChatPrint("You are too overweight to carry this.") return end

	ent:PickedUp( ply, item )
end)