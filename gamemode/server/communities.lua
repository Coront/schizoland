Communities = Communities or {}

function CreateNewCommunityObject()
    Communities[ #Communities + 1 ] = {} --This will create a new table.
    return #Communities --We'll return the CID.
end

--  ██████╗ ██████╗ ███╗   ███╗███╗   ███╗██╗   ██╗███╗   ██╗██╗████████╗██╗   ██╗    ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
-- ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██║   ██║████╗  ██║██║╚══██╔══╝╚██╗ ██╔╝    ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
-- ██║     ██║   ██║██╔████╔██║██╔████╔██║██║   ██║██╔██╗ ██║██║   ██║    ╚████╔╝     ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
-- ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██║   ██║██║╚██╗██║██║   ██║     ╚██╔╝      ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
-- ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██║   ██║      ██║       ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
--  ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝   ╚═╝      ╚═╝       ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

community = {} --No this isnt a metatable (I'm too dumb to figure out how they work.)

function community.Create( ply, cname, cdesc )
    local cid = CreateNewCommunityObject()

    Communities[ cid ] = {
        --Most of these values will be defaults for the community to use.
        name = cname, --Community's name
        desc = cdesc,
        creator = ply:Nickname(), --Original Creator
        ranks = { --Default ranks
            [1] = {
                name = "Owner", 
                permissions = {
                    ["admin"] = true, --'admin' perm means access to everything. This will affect how functions respond.
                },
                nodelete = true, --This rank cannot be deleted. If it were, players could softlock their community management.
                nomodify = true, --This rank cannot be modified.
            },
            [2] = {
                name = "Recruit",
                permissions = {},
                nodelete = true,
            },
            [3] = {
                name = "Member",
                permissions = {
                    ["title"] = true,
                    ["kick"] = true,
                    ["invite"] = true,
                },
            },
        },
        pending = {}, --Our pending list (like stuff we have to acknowledge, news, whatever)
        allies = {}, --Current alliances
        wars = {}, --Current wars
    }

    sql.Query("INSERT INTO as_communities VALUES ( " .. cid .. ", " .. SQLStr( util.TableToJSON(Communities[cid], true) ) .. ", NULL )")

    return cid
end

function community.Delete( cid )
    for k, v in pairs( player.GetAll() ) do --We'll go through all the players on the server and clear their community vars.
        if not v:GetCommunity() == cid then continue end
        v:ClearCommunity()
        v:ClearRank()
        v:ClearTitle()
        v:ChatPrint( "Your community, " .. community.GetName( cid ) .. ", has been abandoned." )
    end

    local members = sql.Query( "SELECT pid FROM as_communities_members WHERE cid = " .. cid )
    for k, v in pairs( members ) do
        sql.Query( "UPDATE as_communities_members SET cid = 0, title = '', rank = -1 WHERE pid = " .. v.pid )
    end

    sql.Query( "UPDATE as_communities SET deleted = " .. SQLStr( os.date( "%m/%d/%y - %I:%M %p", os.time() ) ) .. " WHERE cid = " .. cid ) --Then community go bye bye
end

function community.NewRank( cid, rankName, perms )
    local rid = #Communities[ cid ].ranks + 1

    Communities[ cid ].ranks[ rid ] = {
        name = rankName,
        permissions = perms,
    }

    community.Update( cid )
end

function community.ModifyRank( cid, rid, rankName, perms )
    Communities[ cid ].ranks[ rid ] = {
        name = rankName,
        permissions = perms,
    }

    community.Update( cid )
end

function community.DeleteRank( cid, rid )
    Communities[ cid ].ranks[ rid ] = nil
    community.Update( cid )
end

function community.UpdateDescription( cid, newdesc )
    Communities[ cid ].desc = newdesc
    community.Update( cid )
end

function community.GetName( cid )
    return Communities[ cid ].name
end

function community.GetCreator( cid )
    return Communities[ cid ].creator
end

function community.GetRanks( cid )
    return Communities[ cid ].ranks
end

function community.Update( cid )
    sql.Query( "UPDATE as_communities SET data = " .. SQLStr( util.TableToJSON(Communities[cid], true) ) .. " WHERE cid = " .. cid )
end

-- ██████╗ ██╗      █████╗ ██╗   ██╗███████╗██████╗      █████╗  ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
-- ██╔══██╗██║     ██╔══██╗╚██╗ ██╔╝██╔════╝██╔══██╗    ██╔══██╗██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
-- ██████╔╝██║     ███████║ ╚████╔╝ █████╗  ██████╔╝    ███████║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
-- ██╔═══╝ ██║     ██╔══██║  ╚██╔╝  ██╔══╝  ██╔══██╗    ██╔══██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
-- ██║     ███████╗██║  ██║   ██║   ███████╗██║  ██║    ██║  ██║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
-- ╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

function PlayerMeta:SetCommunity( cid )
    self:SetNWInt( "as_cid", cid )
    if Communities[cid] then
        self:SetNWString( "as_cname", Communities[cid].name )
    end
end

function PlayerMeta:SetRank( rank )
    self:SetNWInt( "as_crank", rank )
end

function PlayerMeta:SetTitle( title )
    self:SetNWString( "as_ctitle", title )
end

function PlayerMeta:ClearCommunity()
    self:SetCommunity( 0 )
end

function PlayerMeta:ClearRank()
    self:SetRank( -1 )
end

function PlayerMeta:ClearTitle()
    self:SetTitle( "" )
end

function PlayerMeta:CreateCommunity( name, desc )
    local cid = community.Create( self, name, desc )
    self:SetCommunity( cid )
    self:SetTitle( "Founder" )
    self:SetRank( 1 )
    self:ChatPrint("You have created the community: " .. name .. ".")

    self:SaveCharacter()
end

function PlayerMeta:DeleteCommunity()
    community.Delete( self:GetCommunity() )
    self:SaveCharacter()
end

function PlayerMeta:InvitePlayer( otherply )
    self:ChatPrint("You've invited " .. otherply:Nickname() .. " to join your community.")
    otherply.NextInvite = CurTime() + 60
    otherply.PendingInvite = self:GetCommunity()
    net.Start( "as_community_inviteplayer_sendrequest" )
        net.WriteEntity( self )
    net.Send( otherply )
end

function PlayerMeta:AcceptInvite( cid )
    self:SetCommunity( cid )
    self:SetRank( 2 )
    self:SetTitle( "Recruit" )

    self:SaveCharacter()
end

function PlayerMeta:LeaveCommunity()
    self:ChatPrint("You have left the community " .. Communities[self:GetCommunity()].name)
    self:ClearCommunity()
    self:ClearTitle()
    self:ClearRank()

    self:SaveCharacter()
end

function PlayerMeta:KickPlayer( pid )
    sql.Query( "UPDATE as_communities_members SET title = '', rank = -1, cid = 0 WHERE pid = " .. pid )
    for k, v in pairs( player.GetAll() ) do
        if v.pid == pid then
            v:ClearCommunity()
            v:ClearTitle()
            v:ClearRank()

            v:ChatPrint("You have been kicked from your community.")
            v:SaveCharacter()
            break
        end
    end
end

function PlayerMeta:ChangeTitle( pid, title )
    sql.Query( "UPDATE as_communities_members SET title = " .. SQLStr( title ) .. " WHERE pid = " .. pid )
    for k, v in pairs( player.GetAll() ) do
        if v.pid == pid then
            v:SetTitle( title )
            v:ChatPrint( self:Nickname() .. " has changed your title to: " .. title)
            v:SaveCharacter()
            break
        end
    end

    self:ChatPrint("Title Updated.")
end

function PlayerMeta:CreateRank( name, perms )
    community.NewRank( self:GetCommunity(), name, perms )
    self:ChatPrint("You have created a new rank: " .. name .. ".")
end

function PlayerMeta:ModifyRank( rankid, name, perms )
    community.ModifyRank( self:GetCommunity(), rankid, name, perms )
    self:ChatPrint("You have updated the rank: " .. name .. ".")
end

function PlayerMeta:DeleteRank( rankid )
    self:ChatPrint("You have deleted a rank: " .. Communities[self:GetCommunity()].ranks[rankid].name)
    community.DeleteRank( self:GetCommunity(), rankid )
end

function PlayerMeta:ChangeRank( pid, rankid )
    sql.Query( "UPDATE as_communites_members SET rank = " .. rankid .. " WHERE pid = " .. pid )
    for k, v in pairs( player.GetAll() ) do
        if v.pid == pid then
            v:SetRank( rankid )
            v:ChatPrint( self:Nickname() .. " has changed your rank to: " .. Communities[self:GetCommunity()].ranks[rankid].name .. ".")
            v:SaveCharacter()
            break
        end
    end

    self:ChatPrint("Rank Updated.")
end

function PlayerMeta:UpdateDescription( desc )
    community.UpdateDescription( self:GetCommunity(), desc )
    self:ChatPrint("Community Description Updated.")
end

-- ██████╗ ██████╗ ███████╗    ██╗      ██████╗  █████╗ ██████╗ ███████╗██████╗
-- ██╔══██╗██╔══██╗██╔════╝    ██║     ██╔═══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
-- ██████╔╝██████╔╝█████╗█████╗██║     ██║   ██║███████║██║  ██║█████╗  ██████╔╝
-- ██╔═══╝ ██╔══██╗██╔══╝╚════╝██║     ██║   ██║██╔══██║██║  ██║██╔══╝  ██╔══██╗
-- ██║     ██║  ██║███████╗    ███████╗╚██████╔╝██║  ██║██████╔╝███████╗██║  ██║
-- ╚═╝     ╚═╝  ╚═╝╚══════╝    ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝

hook.Add( "Initialize", "AS_Communities_Load", function()
    local com = sql.Query("SELECT * FROM as_communities WHERE deleted IS NULL")
    if com then
        for _, res in pairs( com ) do
            Communities[ tonumber(res.cid) ] = util.JSONToTable(res.data)
        end
    end
end)

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString( "as_community_create" )
util.AddNetworkString( "as_community_delete" )
util.AddNetworkString( "as_community_updatedescription" )
util.AddNetworkString( "as_community_inviteplayer" )
util.AddNetworkString( "as_community_inviteplayer_sendrequest" )
util.AddNetworkString( "as_community_inviteplayer_acceptrequest" )
util.AddNetworkString( "as_community_inviteplayer_declinerequest" )
util.AddNetworkString( "as_community_kickplayer" )
util.AddNetworkString( "as_community_leave" )
util.AddNetworkString( "as_community_changetitle" )
util.AddNetworkString( "as_community_createrank" )
util.AddNetworkString( "as_community_deleterank" )
util.AddNetworkString( "as_community_modifyrank" )
util.AddNetworkString( "as_community_changerank" )

net.Receive( "as_community_create", function( _, ply )
    local name = net.ReadString()
    local desc = net.ReadString()

    if string.len(name) < SET.MinNameLength then ply:ChatPrint("Your community name is too short.") return end
    for k, v in pairs(SET.BannedWords) do
        if string.find(name:lower(), v) then ply:Kick("Inappropriate name usage") return end
    end
    if ply:InCommunity() then ply:ChatPrint("You cannot be in a community to make a new one.") return end

    ply:CreateCommunity( name, desc )
end)

net.Receive( "as_community_delete", function( _, ply )
    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if not ply:HasPerm( "admin" ) then ply:ChatPrint("You must have the permission 'admin' to delete the community.") return end

    ply:DeleteCommunity()
end)

net.Receive( "as_community_inviteplayer", function( _, ply )
    local otherply = net.ReadEntity()

    local members = tonumber( sql.QueryValue( "SELECT COUNT(*) FROM as_communities_members WHERE cid = " .. ply:GetCommunity() ) )
    if members >= SET.MaxMembers then ply:ChatPrint("You've reached the maximum members for a community.") return end
    if not otherply:IsLoaded() then return end
    if CurTime() < (otherply.NextInvite or 0) then ply:ChatPrint("Please wait before trying to invite this person again.") return end
    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if not ply:HasPerm( "invite" ) then ply:ChatPrint("You must have the permission 'invite' to invite players.") return end
    if otherply:InCommunity() then ply:ChatPrint("This player is already in a community.") return end

    ply:InvitePlayer( otherply )
end)

net.Receive( "as_community_inviteplayer_acceptrequest", function( _, ply )
    local inviter = net.ReadEntity()

    if not ply.PendingInvite then ply:ChatPrint("There is no pending invite.") return end
    ply.NextInvite = 0
    ply.PendingInvite = nil
    ply:ChatPrint("You have accepted " .. inviter:Nickname() .. "'s invitation.")
    ply:ChatPrint("You are now a member of " .. inviter:GetCommunityName() .. ".")
    inviter:ChatPrint( ply:Nickname() .. " has accepted your invitation." )

    ply:AcceptInvite( inviter:GetCommunity() )
end)

net.Receive( "as_community_inviteplayer_declinerequest", function( _, ply )
    local inviter = net.ReadEntity()

    if not ply.PendingInvite then ply:ChatPrint("There is no pending invite.") return end
    ply.NextInvite = 0
    ply.PendingInvite = nil
    ply:ChatPrint("You have declined " .. inviter:Nickname() .. "'s invitation.")
    inviter:ChatPrint( ply:Nickname() .. " has declined your invitation.")
end)

net.Receive( "as_community_leave", function( _, ply )
    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end

    ply:LeaveCommunity()
end)

net.Receive( "as_community_kickplayer", function( _, ply )
    local pid = tonumber( net.ReadInt( 32 ) )

    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if not ply:HasPerm( "kick" ) then ply:ChatPrint("You must have the permission 'kick' to kick players.") return end
    local inCommunity = tonumber(sql.QueryValue( "SELECT cid FROM as_communities_members WHERE pid = " .. pid ))
    if ply:GetCommunity() != inCommunity then ply:ChatPrint("This player isn't in your community") return end

    ply:KickPlayer( pid )
end)

net.Receive( "as_community_changetitle", function( _, ply ) 
    local pid = tonumber( net.ReadInt( 32 ) )
    local title = net.ReadString()

    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if not ply:HasPerm( "title" ) then ply:ChatPrint("You must have the permission 'title' to change titles.") return end
    local inCommunity = tonumber(sql.QueryValue( "SELECT cid FROM as_communities_members WHERE pid = " .. pid ))
    if ply:GetCommunity() != inCommunity then ply:ChatPrint("This player isn't in your community") return end
    for k, v in pairs(SET.BannedWords) do
        if string.find(title:lower(), v) then ply:Kick("Inappropriate title usage") return end
    end

    ply:ChangeTitle( pid, title )
end)

net.Receive( "as_community_createrank", function( _, ply ) 
    local name = net.ReadString()
    local perms = net.ReadTable()

    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if not ply:HasPerm( "admin" ) then ply:ChatPrint("You must have the permission 'admin' to create ranks.") return end
    for k, v in pairs(SET.BannedWords) do
        if string.find(name:lower(), v) then ply:Kick("Inappropriate name usage") return end
    end
    for k, v in pairs( perms ) do
        if not SET.CommunitiesPerms[ k ] then
            perms[ k ] = nil
        end
    end

    ply:CreateRank( name, perms )
end)

net.Receive( "as_community_deleterank", function( _, ply )
    local rankid = net.ReadInt( 32 )

    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if not ply:HasPerm( "admin" ) then ply:ChatPrint( "You must have the permission 'admin' to delete ranks." ) return end
    if Communities[ply:GetCommunity()].ranks[rankid].nodelete then ply:ChatPrint("This rank cannot be deleted.") return end

    ply:DeleteRank( rankid )
end)

net.Receive( "as_community_modifyrank", function( _, ply )
    local rankid = net.ReadInt( 32 )
    local name = net.ReadString()
    local perms = net.ReadTable()

    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if Communities[ply:GetCommunity()].ranks[rankid].nomodify then ply:ChatPrint("You cannot modify this rank.") return end
    if not ply:HasPerm("admin") then ply:ChatPrint("You must have the permission 'admin' to modify ranks.") return end
    for k, v in pairs(SET.BannedWords) do
        if string.find(name:lower(), v) then ply:Kick("Inappropriate name usage") return end
    end
    for k, v in pairs( perms ) do
        if not SET.CommunitiesPerms[ k ] then
            perms[ k ] = nil
        end
    end

    ply:ModifyRank( rankid, name, perms )
end)

net.Receive( "as_community_changerank", function( _, ply ) 
    local rankid = net.ReadInt( 32 )
    local pid = net.ReadInt( 32 )

    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if not ply:HasPerm("admin") then ply:ChatPrint("You must have the permission 'admin' to modify ranks.") return end
    local inCommunity = tonumber(sql.QueryValue( "SELECT cid FROM as_communities_members WHERE pid = " .. pid ))
    if ply:GetCommunity() != inCommunity then ply:ChatPrint("This player isn't in your community") return end

    ply:ChangeRank( pid, rankid )
end)

net.Receive( "as_community_updatedescription", function( _, ply )
    local desc = net.ReadString()

    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if not ply:HasPerm("admin") then ply:ChatPrint("You must have the permission 'admin' to update the community description.") return end

    ply:UpdateDescription( desc )
end)