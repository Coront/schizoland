function PlayerMeta:SetStatistics( tbl )
    self.Statistics = tbl
end

function PlayerMeta:GetStatistics()
    return self.Statistics or {}
end

function PlayerMeta:AddToStatistic( stat, amt )
    local tbl = self:GetStatistics()
    tbl[stat] = (tbl[stat] or 0) + amt
    self:SetStatistics( tbl )
end

function PlayerMeta:GetStat( stat )
    local tbl = self:GetStatistics()
    return (tbl[stat] or 0)
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if ( SERVER ) then

    util.AddNetworkString("as_statistics_sync")

    function PlayerMeta:ResyncStatistics()
        net.Start( "as_statistics_sync" )
            net.WriteTable( self:GetStatistics() )
        net.Send( self )
    end
    concommand.Add("as_resyncstatistics", function( ply ) ply:ResyncStatistics() end)

elseif ( CLIENT ) then

    net.Receive( "as_statistics_sync", function()
        local stats = net.ReadTable()

        LocalPlayer():SetStatistics( stats )
    end)

end