local CUE = {}
CUE.Own = "buttons/blip1.wav"
CUE.Unown = "buttons/button14.wav"
CUE.Error = "buttons/button10.wav"

-- ███████╗███╗   ██╗████████╗██╗████████╗██╗   ██╗    ███╗   ███╗███████╗████████╗ █████╗
-- ██╔════╝████╗  ██║╚══██╔══╝██║╚══██╔══╝╚██╗ ██╔╝    ████╗ ████║██╔════╝╚══██╔══╝██╔══██╗
-- █████╗  ██╔██╗ ██║   ██║   ██║   ██║    ╚████╔╝     ██╔████╔██║█████╗     ██║   ███████║
-- ██╔══╝  ██║╚██╗██║   ██║   ██║   ██║     ╚██╔╝      ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║
-- ███████╗██║ ╚████║   ██║   ██║   ██║      ██║       ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║
-- ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝   ╚═╝      ╚═╝       ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝

function EntityMeta:SetObjectOwner( ent )
    self:SetNWEntity( "as_owner", ent )
end

function EntityMeta:ClearObjectOwner()
    self:SetNWEntity( "as_owner", "nil" )
end

function EntityMeta:IsObjectOwnable()
    if self:GetNWBool( "NoObjectOwner", false ) then return false end
    if self:GetClass() == "prop_door_rotating" or self:GetClass() == "func_door_rotating" or self:GetClass() == "func_door" or self:GetClass() == "prop_physics" then return true end
    if self:GetClass() == "as_vendor_display" then return true end
    if self:GetNWBool( "AS_OwnableObject", false ) then return true end
    if self.AS_OwnableObject then return true end
    return false
end

function EntityMeta:GetObjectOwner()
    return self:GetNWEntity( "as_owner", "nil" )
end

function EntityMeta:HasObjectOwner()
    if IsValid(self:GetNWEntity( "as_owner", "nil" )) then return true end
    return false
end

function EntityMeta:PlayerCanPickUp( ply )
    if ply:GetPos():Distance(self:GetPos()) > 300 then return false end
	if IsValid(self:GetObjectOwner()) and self:GetObjectOwner() == ply then return true end
	return false
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if (SERVER) then

    util.AddNetworkString("as_ownership_becomeowner")

    net.Receive("as_ownership_becomeowner", function( _, ply )
        local ent = net.ReadEntity()
        if not ent:IsObjectOwnable() then ply:ChatPrint("You cannot own this object.") return end
        if ent:HasObjectOwner() then
            if ply:IsAdmin() and ply:IsDeveloping() and ent:GetObjectOwner() != ply then
                local oldowner = ent:GetObjectOwner()
                ply:ChatPrint("Admin Force Unown of object: " .. ent:GetClass() .. " (Old Owner: " .. oldowner:Nickname() .. ")")
                ent:EmitSound(CUE.Unown)
                ent:ClearObjectOwner()
                if ent.AS_OwnableObject or ent:GetNWBool("AS_OwnableObject", false) then
                    local item = ent:IsVehicle() and ent:GetNWString( "ASID" ) or FetchToolIDByClass( ent:GetClass() )
                    oldowner:RemoveToolFromCache( item )
                end
                return 
            end

            if ent:GetObjectOwner() != ply then
                ent:EmitSound(CUE.Error)
                ply:ChatPrint("This object is already owned by " .. ent:GetObjectOwner():Nickname() )
                return
            else
                ent:EmitSound(CUE.Unown)
                ent:ClearObjectOwner()
                if ent.AS_OwnableObject or ent:GetNWBool("AS_OwnableObject", false) then
                    local item = ent:IsVehicle() and ent:GetNWString( "ASID" ) or FetchToolIDByClass( ent:GetClass() )
                    ply:RemoveToolFromCache( item )
                end
            end
        else
            ent:EmitSound(CUE.Own)
            ent:SetObjectOwner( ply )
            if ent.AS_OwnableObject or ent:GetNWBool("AS_OwnableObject", false) then
                local item = ent:IsVehicle() and ent:GetNWString( "ASID" ) or FetchToolIDByClass( ent:GetClass() )
                ply:AddToolToCache( item )
            end
        end
    end)

elseif ( CLIENT ) then
    
    function PlayerMeta:BecomeObjectOwner( ent )
        net.Start("as_ownership_becomeowner")
            net.WriteEntity( ent )
        net.SendToServer()
    end

end