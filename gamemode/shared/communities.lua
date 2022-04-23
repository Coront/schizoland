function PlayerMeta:GetCommunity()
    return self:GetNWInt( "as_cid", 0 )
end

function PlayerMeta:GetCommunityName()
    return self:GetNWString( "as_cname", "" )
end

function PlayerMeta:GetTitle()
    return self:GetNWString( "as_ctitle", "" )
end

function PlayerMeta:GetRank()
    return self:GetNWInt( "as_crank", 0 )
end

function PlayerMeta:InCommunity()
    if self:GetCommunity() != 0 then return true end
    return false
end

function PlayerMeta:HasPerm( perm )
    local com = self:GetCommunity()
    if Communities[com].ranks[self:GetRank()].permissions["admin"] then return true end
    if Communities[com].ranks[self:GetRank()].permissions[perm] then return true end
    return false
end

function translatePermNameID( perm )
    for k, v in pairs( SET.CommunitiesPerms ) do
        if v.name == perm then
            return k
        end
    end
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if ( SERVER ) then

    util.AddNetworkString("as_community_requestdata")
    util.AddNetworkString("as_community_requestranks")
    util.AddNetworkString("as_community_senddata")
    util.AddNetworkString("as_community_sendranks")
    util.AddNetworkString("as_community_sendranksmodify")

    net.Receive("as_community_requestdata", function( _, ply )
        local members = sql.Query( "SELECT pid FROM as_communities_members WHERE cid = " .. ply:GetCommunity() )
        local memtbl = {}
        for k, v in pairs( members ) do
            for k2, v2 in pairs( v ) do
                local data = sql.Query( "SELECT * FROM as_characters WHERE pid = " .. v2 )[1]
                local title = sql.QueryValue( "SELECT title FROM as_communities_members WHERE pid = " .. v2 )
                local currank = tonumber(sql.QueryValue( "SELECT rank FROM as_communities_members WHERE pid = " .. v2 ))
                data.title = title
                data.rank = Communities[ ply:GetCommunity() ].ranks[currank].name
                memtbl[v2] = data
            end
        end

        net.Start("as_community_senddata")
            net.WriteTable( Communities[ ply:GetCommunity() ] )
            net.WriteTable( memtbl )
        net.Send(ply)
    end)

    net.Receive("as_community_requestranks", function( _, ply )
        local modifying = tobool(net.ReadBit())

        local tbl = sql.QueryValue( "SELECT data FROM as_communities WHERE cid = " .. ply:GetCommunity() )
        tbl = util.JSONToTable( tbl )

        if modifying then
            net.Start("as_community_sendranksmodify")
        else
            net.Start("as_community_sendranks")
        end
            net.WriteTable( tbl.ranks )
        net.Send(ply)
    end)

end