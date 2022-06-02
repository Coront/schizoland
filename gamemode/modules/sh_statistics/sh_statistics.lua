function PlayerMeta:SetStatistics( tbl )
    self.Statistics = tbl
    if ( SERVER ) then
        self:ResyncStatistics()
    end
end

function PlayerMeta:GetStatistics()
    return self.Statistics or {}
end

function PlayerMeta:AddToStatistic( stat, amt )
    local tbl = self:GetStatistics()
    tbl[stat] = (tbl[stat] or 0) + amt
    self:SetStatistics( tbl )
    self:SaveStatistic( stat )
end

function PlayerMeta:GetStat( stat )
    local tbl = self:GetStatistics()
    return (tbl[stat] or 0)
end

-- ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗
-- ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝
-- ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗
-- ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝
-- ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗
-- ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝

if ( SERVER ) then

    function PlayerMeta:CheckStatistic( stat )
        local exists = sql.Query( "SELECT * FROM as_characters_statistics WHERE pid = " .. self:GetPID() .. " AND key = " .. SQLStr(stat) )

        if not exists then
            sql.Query("INSERT INTO as_characters_statistics VALUES( " .. self:GetPID() .. ", " .. SQLStr(stat) .. ", 0 )")
        end
    end
    
    function PlayerMeta:SaveStatistic( stat )
        self:CheckStatistic( stat )
        sql.Query( "UPDATE as_characters_statistics SET value = " .. self:GetStat( stat ) .. " WHERE pid = " .. self:GetPID() .. " AND key = " .. SQLStr( stat ) )
    end

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