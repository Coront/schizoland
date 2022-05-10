--fas2 no real sync method, super based

function PlayerMeta:SetAttachmentInventory( tbl )
    if ( SERVER ) then
        self.FAS2Attachments = tbl
        self:ResyncAttachments()
        self:SaveAttachmentInventory()
    elseif ( CLIENT ) then
        FAS2AttOnMe = tbl
    end
end

function PlayerMeta:GetAttachmentInventory()
    if ( SERVER ) then
        return self.FAS2Attachments or {}
    elseif ( CLIENT ) then
        return FAS2AttOnMe or {}
    end
end

function PlayerMeta:AddAttachment( id )
    local tbl = self:GetAttachmentInventory()
    tbl[#tbl + 1] = id
    self:SetAttachmentInventory( tbl )
end

function PlayerMeta:RemoveAttachment( id )
    local tbl = self:GetAttachmentInventory()
    table.RemoveByValue( tbl, id )
    self:SetAttachmentInventory( tbl )
end

function PlayerMeta:HasAttachment( id )
    local tbl = self:GetAttachmentInventory()
    if table.HasValue( tbl, id ) then return true end
    return false
end

-- ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗
-- ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝
-- ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗
-- ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝
-- ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗
-- ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝

function PlayerMeta:SaveAttachmentInventory()
    sql.Query("UPDATE as_characters_inventory SET atch = " .. SQLStr( util.TableToJSON(self:GetAttachmentInventory(), true) ) .. " WHERE pid = " .. self:GetPID())
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if ( SERVER ) then

    util.AddNetworkString("as_syncattachments")

    function PlayerMeta:ResyncAttachments()
        net.Start("as_syncattachments")
            net.WriteTable( self:GetAttachmentInventory() )
        net.Send( self )
    end
    concommand.Add( "as_resyncattachments", function( ply ) ply:ResyncAttachments() end)

elseif ( CLIENT ) then

    net.Receive("as_syncattachments", function()
        local atch = net.ReadTable()
        LocalPlayer():SetAttachmentInventory( atch )
    end)

end