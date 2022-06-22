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

function PlayerMeta:IsAllied( cid )
    if self:InCommunity() then
        if ( SERVER ) then
            if Communities[self:GetCID()].allies[cid] then
                return true
            end
        elseif ( CLIENT ) then
            if CommunityAllies[cid] then
                return true
            end
        end
    end

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
    util.AddNetworkString("as_community_senddata")
    util.AddNetworkString("as_community_requestranks")
    util.AddNetworkString("as_community_sendranks")
    util.AddNetworkString("as_community_requestcommunitiesbyname")
    util.AddNetworkString("as_community_sendcommunities")
    util.AddNetworkString("as_community_sendranksmodify")
    util.AddNetworkString("as_community_requestlookup")
    util.AddNetworkString("as_community_sendlookup")
    util.AddNetworkString("as_community_syncallies")
    util.AddNetworkString("as_community_syncwars")

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

        if Communities[ ply:GetCommunity() ] then
            net.Start("as_community_senddata")
                net.WriteTable( Communities[ ply:GetCommunity() ] )
                net.WriteTable( memtbl )
            net.Send(ply)
        end
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

    net.Receive("as_community_requestcommunitiesbyname", function( _, ply )
        local comname = net.ReadString()

        local tbl = sql.Query( "SELECT data FROM as_communities" )
        local newtbl = {}

        for k, v in pairs( tbl ) do
            if k == ply:GetCommunity() then continue end
            for k2, v2 in pairs( v ) do
                v2 = util.JSONToTable( v2 )
                if not string.find( string.lower(v2.name), string.lower(comname) ) then continue end
                newtbl[k] = v2
            end
        end

        net.Start( "as_community_sendcommunities" )
            net.WriteTable( newtbl )
        net.Send( ply )
    end)

    net.Receive("as_community_requestlookup", function( _, ply )
        local cid = net.ReadUInt( NWSetting.UIDAmtBits )

        local commdata = sql.Query( "SELECT data FROM as_communities WHERE cid = " .. SQLStr( cid ) )[1]
        local cmemberinfo = sql.Query( "SELECT * FROM as_communities_members WHERE cid = " .. SQLStr( cid ) )
        for k, v in pairs( cmemberinfo ) do
            local charinfo = sql.Query( "SELECT * FROM as_characters WHERE pid = " .. SQLStr( v.pid ) )[1]
            table.Merge( cmemberinfo[k], charinfo )
        end

        net.Start( "as_community_sendlookup" )
            net.WriteUInt( cid, NWSetting.UIDAmtBits )
            net.WriteTable( commdata )
            net.WriteTable( cmemberinfo )
        net.Send( ply )
    end)

    function PlayerMeta:ResyncAllies()
        net.Start("as_community_syncallies")
            net.WriteTable( Communities[self:GetCommunity()] and Communities[self:GetCommunity()].allies or {} )
        net.Send( self )
    end

    function PlayerMeta:ResyncWars()
        net.Start("as_community_syncwars")
            net.WriteTable( Communities[self:GetCommunity()] and Communities[self:GetCommunity()].wars or {} )
        net.Send( self )
    end

else

    net.Receive("as_community_syncallies", function()
        CommunityAllies = net.ReadTable()
    end)

    net.Receive("as_community_syncwars", function()
        CommunityWars = net.ReadTable()
    end)

end