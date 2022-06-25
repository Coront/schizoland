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
        if v:GetCommunity() != cid then continue end --ignore players not part of this community
        v:ClearCommunity()
        v:ClearCommunityName()
        v:ClearRank()
        v:ClearTitle()
        v:ChatPrint( "Your community, " .. community.GetName( cid ) .. ", has been abandoned." )
    end

    local members = sql.Query( "SELECT pid FROM as_communities_members WHERE cid = " .. cid )
    for k, v in pairs( members ) do
        sql.Query( "UPDATE as_communities_members SET cid = 0, title = '', rank = -1 WHERE pid = " .. v.pid )
    end

    for k, v in pairs( Communities ) do --We need to clear all of the alliances, wars, and pending requests to prevent future errors.
        for k2, v2 in pairs( v.pending ) do
            if not v2.info.cid == cid then continue end
            v.pending[k2] = nil
        end
        --[[
        for k2, v2 in pairs( v.allies ) do
            if not 
        end
        ]]
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
    Communities[ cid ].ranks[ rid ].name = rankName
    Communities[ cid ].ranks[ rid ].permissions = perms

    community.Update( cid )
end

function community.DeleteRank( cid, rid )
    Communities[ cid ].ranks[ rid ] = nil

    local defaultrankid = 2

    for k, v in pairs( player.GetAll() ) do
        if v:GetCommunity() != cid then continue end --Not in community
        if v:GetRank() != rid then continue end --Rank is not our rank
        v:SetRank( 2 )
        v:ChatPrint("You rank has been set to recruit as the rank you were apart of was deleted.")
    end

    local members = community.GetMembers( cid )
    for k, v in pairs( members ) do --Update database rank
        if v.rank != rid then continue end
        sql.Query( "UPDATE as_communities_members SET rank = 2 WHERE pid = " .. v.pid )
    end

    community.Update( cid )
end

function community.UpdateDescription( cid, newdesc )
    Communities[ cid ].desc = newdesc
    community.Update( cid )
end

function community.CreateDiplomacy( cid, dtype, desc )
    local diplos = #Communities[cid].pending
    Communities[ cid ].pending[ diplos + 1 ] = {
        type = dtype,
        info = desc,
        time = os.time(),
    }
    community.Update( cid )
end

function community.DeleteDiplomacy( cid, did )
    Communities[ cid ].pending[ did ] = nil 
    community.Update( cid )
end

function community.AcceptDiplomacy( cid, did )
    local diplotype = Communities[ cid ].pending[ did ].type
    local othercid = Communities[ cid ].pending[ did ].info.cid
    if diplotype == "ally" then
        community.EstablishAlliance( cid, othercid )
    elseif diplotype == "war" then
        community.DeclareWar( cid, othercid )
    elseif diplotype == "endally" then
        community.EndAlliance( cid, othercid )
    elseif diplotype == "endwar" then
        community.EndWar( cid, othercid )
    end
    community.DeleteDiplomacy( cid, did )
end

function community.EstablishAlliance( cid, ocid )
    Communities[ cid ].allies[ ocid ] = {
        name = Communities[ocid].name,
        date = os.time(),
    }
    community.Update( cid )

    Communities[ ocid ].allies[ cid ] = {
        name = Communities[cid].name,
        date = os.time(),
    }
    community.Update( ocid )

    for k, v in pairs( player.GetAll() ) do
        if not v:GetCommunity() == cid and not v:GetCommunity() == ocid then continue end
        if v:GetCommunity() == cid then
            v:ChatPrint("You are now allied with " .. Communities[ocid].name .. ".")
            v:ResyncAllies()
        end
        if v:GetCommunity() == ocid then
            v:ChatPrint("You are now allied with " .. Communities[cid].name .. ".")
            v:ResyncAllies()
        end
    end
end

function community.EndAlliance( cid, ocid )
    Communities[ cid ].allies[ ocid ] = nil 
    community.Update( cid )
    Communities[ ocid ].allies[ cid ] = nil 
    community.Update( ocid )

    for k, v in pairs( player.GetAll() ) do
        if not v:GetCommunity() == cid and not v:GetCommunity() == ocid then continue end
        if v:GetCommunity() == cid then
            v:ChatPrint("Your alliance with " .. Communities[ocid].name .. " has ended.")
            v:ResyncAllies()
        end
        if v:GetCommunity() == ocid then
            v:ChatPrint("Your alliance with " .. Communities[cid].name .. " has ended.")
            v:ResyncAllies()
        end
    end
end

function community.DeclareWar( cid, ocid )
    Communities[ cid ].wars[ ocid ] = {
        name = Communities[ocid].name,
        date = os.time(),
        endtime = os.time() + SET.WarLength,
    }
    community.Update( cid )

    Communities[ ocid ].wars[ cid ] = {
        name = Communities[cid].name,
        date = os.time(),
        endtime = os.time() + SET.WarLength,
    }
    community.Update( ocid )

    for k, v in pairs( player.GetAll() ) do
        if not v:GetCommunity() == cid and not v:GetCommunity() == ocid then continue end
        if v:GetCommunity() == cid then
            v:ChatPrint("You are now at war with " .. Communities[ocid].name .. "!")
        end
        if v:GetCommunity() == ocid then
            v:ChatPrint("You are now at war with " .. Communities[cid].name .. "!")
        end
        v:ResyncWars()
    end
end

function community.EndWar( cid, ocid )
    Communities[ cid ].wars[ ocid ] = nil
    community.Update( cid )
    Communities[ ocid ].wars[ cid ] = nil
    community.Update( ocid )

    for k, v in pairs( player.GetAll() ) do
        if not v:GetCommunity() == cid and not v:GetCommunity() == ocid then continue end
        if v:GetCommunity() == cid then
            v:ChatPrint("The war with " .. Communities[ocid].name .. " has ended.")
            v:ResyncWars()
        end
        if v:GetCommunity() == ocid then
            v:ChatPrint("The war with " .. Communities[cid].name .. " has ended.")
            v:ResyncWars()
        end
    end
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

function community.GetMembers( cid )
    local members = sql.Query( "SELECT * FROM as_communities_members WHERE cid = " .. cid )
    return members
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
    self:ResyncAllies()
    self:ResyncWars()
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

function PlayerMeta:ClearCommunityName()
    self:SetNWString( "as_cname", "" )
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
    self:ClearCommunityName()
    self:ClearTitle()
    self:ClearRank()

    self:SaveCharacter()
end

function PlayerMeta:KickPlayer( pid )
    sql.Query( "UPDATE as_communities_members SET title = '', rank = -1, cid = 0 WHERE pid = " .. pid )
    for k, v in pairs( player.GetAll() ) do
        if v.pid == pid then
            v:ClearCommunity()
            v:ClearCommunityName()
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

function PlayerMeta:AcceptDiplomacy( diploid )
    self:ChatPrint("You have accepted the diplomacy - id " .. diploid .. ".")
    community.AcceptDiplomacy( self:GetCommunity(), diploid )
end

function PlayerMeta:DeclineDiplomacy( diploid )
    self:ChatPrint("You have declined the diplomacy - id " .. diploid .. ".")
    community.DeleteDiplomacy( self:GetCommunity(), diploid )
end

function PlayerMeta:IsAtWar( othercid )
    if Communities[self:GetCommunity()].wars[othercid] then return true end
    return false
end

function PlayerMeta:EndWarRequest( warid )
    community.CreateDiplomacy( warid, "endwar", {
        cid = self:GetCommunity(),
        text = self:Nickname() .. " (" .. self:GetCommunityName() .. ") has requested to end the war.",
    })
end

function PlayerMeta:SendAllyRequest( cid )
    community.CreateDiplomacy( cid, "ally", {
        cid = self:GetCommunity(),
        text = self:Nickname() .. " (" .. self:GetCommunityName() .. ") wants to be your ally."
    })
end

function PlayerMeta:SendWarRequest( cid )
    community.CreateDiplomacy( cid, "war", {
        cid = self:GetCommunity(),
        text = self:Nickname() .. " (" .. self:GetCommunityName() .. ") wishes to declare war."
    })
end

function PlayerMeta:EndAlliance( ocid )
    community.EndAlliance( self:GetCommunity(), ocid )
end

function PlayerMeta:DeployLocker()
    local ent = ents.Create("as_community_storage")
    ent:SetCommunity( self:GetCommunity(), self:GetCommunityName() )
    ent:Spawn()
    ent:SetPos( self:TracePosFromEyes( 300 ) + Vector( 0, 0, 12 ))
end

function PlayerMeta:DeployStockpile()
    local ent = ents.Create("as_community_stockpile")
    ent:SetCommunity( self:GetCommunity(), self:GetCommunityName() )
    ent:Spawn()
    ent:SetPos( self:TracePosFromEyes( 300 ) + Vector( 0, 0, 80 ))
end

-- ██████╗ ██████╗ ███████╗    ██╗      ██████╗  █████╗ ██████╗ ███████╗██████╗
-- ██╔══██╗██╔══██╗██╔════╝    ██║     ██╔═══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
-- ██████╔╝██████╔╝█████╗█████╗██║     ██║   ██║███████║██║  ██║█████╗  ██████╔╝
-- ██╔═══╝ ██╔══██╗██╔══╝╚════╝██║     ██║   ██║██╔══██║██║  ██║██╔══╝  ██╔══██╗
-- ██║     ██║  ██║███████╗    ███████╗╚██████╔╝██║  ██║██████╔╝███████╗██║  ██║
-- ╚═╝     ╚═╝  ╚═╝╚══════╝    ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝

hook.Add( "Initialize", "AS_Communities_Load", function()
    local com = sql.Query("SELECT * FROM as_communities")
    if com then
        for _, res in pairs( com ) do
            Communities[ tonumber(res.cid) ] = util.JSONToTable(res.data)
        end
    end
end)

-- ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝

hook.Add( "Think", "AS_Communities_WarTime", function() --Will automatically calculate the time for which a war will end.
    for k, v in pairs( Communities ) do
        if table.Count(v.wars) <= 0 then continue end
        for k2, v2 in pairs( v.wars ) do
            if os.time() > v2.endtime then
                community.EndWar( k, k2 )
                for k3, v3 in pairs( player.GetAll() ) do --Basically just tell everyone that the war is over.
                    if not v3:GetCommunity() == k and not v3:GetCommunity() == k2 then continue end
                    if v3:GetCommunity() == k then
                        v3:ChatPrint("The war against " .. Communities[ k2 ].name .. " has ended.")
                    end
                    if v3:GetCommunity() == k2 then
                        v3:ChatPrint("The war against " .. Communities[ k ].name .. " has ended.")
                    end
                    v3:ResyncWars()
                end
            end
        end
    end
end)

hook.Add( "Think", "AS_Communities_WarPending", function() --Calculates the time in which a war request will be valid.
    for k, v in pairs( Communities ) do
        if table.Count(v.pending) <= 0 then continue end
        for k2, v2 in pairs(v.pending) do
            if v2.type != "war" then continue end
            if os.time() > (v2.time or 0) + SET.WarDiploLength then
                community.DeleteDiplomacy( k, k2 )
            end
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
util.AddNetworkString( "as_community_acceptdiplomacy" )
util.AddNetworkString( "as_community_declinediplomacy" )
util.AddNetworkString( "as_community_ally" )
util.AddNetworkString( "as_community_war" )
util.AddNetworkString( "as_community_endwarrequest" )
util.AddNetworkString( "as_community_endally" )
util.AddNetworkString( "as_community_deploylocker" )
util.AddNetworkString( "as_community_deploystockpile" )

net.Receive( "as_community_create", function( _, ply )
    local name = net.ReadString()
    local desc = net.ReadString()

    if string.len( name ) < SET.MinCommLength then ply:ChatPrint("This title is too short.") return end
    if string.len( name ) > SET.MaxCommLength then ply:ChatPrint("This title is too long.") return end
    for k, v in pairs(SET.BannedWords) do
        if string.find(name:lower(), v) then ply:Kick("Inappropriate name usage") return end
    end
    if string.len( desc ) > SET.MaxDescLength then ply:ChatPrint("This description is too long.") return end
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
    local pid = tonumber( net.ReadUInt( NWSetting.UIDAmtBits ) )

    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if not ply:HasPerm( "kick" ) then ply:ChatPrint("You must have the permission 'kick' to kick players.") return end
    local inCommunity = tonumber(sql.QueryValue( "SELECT cid FROM as_communities_members WHERE pid = " .. pid ))
    if ply:GetCommunity() != inCommunity then ply:ChatPrint("This player isn't in your community") return end

    ply:KickPlayer( pid )
end)

net.Receive( "as_community_changetitle", function( _, ply ) 
    local pid = tonumber( net.ReadUInt( NWSetting.UIDAmtBits ) )
    local title = net.ReadString()

    if string.len( title ) < SET.MinTitleLength then ply:ChatPrint("This title is too short.") return end
    if string.len( title ) > SET.MaxTitleLength then ply:ChatPrint("This title is too long.") return end
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
    local rankid = net.ReadUInt( NWSetting.UIDAmtBits )

    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if not ply:HasPerm( "admin" ) then ply:ChatPrint( "You must have the permission 'admin' to delete ranks." ) return end
    if Communities[ply:GetCommunity()].ranks[rankid].nodelete then ply:ChatPrint("This rank cannot be deleted.") return end

    ply:DeleteRank( rankid )
end)

net.Receive( "as_community_modifyrank", function( _, ply )
    local rankid = net.ReadUInt( NWSetting.UIDAmtBits )
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
    local rankid = net.ReadUInt( NWSetting.UIDAmtBits )
    local pid = net.ReadUInt( NWSetting.UIDAmtBits )

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

net.Receive( "as_community_acceptdiplomacy", function( _, ply ) 
    local diploid = net.ReadUInt( NWSetting.UIDAmtBits )

    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    local diplotype = Communities[ply:GetCommunity()].pending[diploid].type
    if diplotype == "ally" and not ply:HasPerm("ally") then ply:ChatPrint("You must have the permission 'ally' to accept or decline ally diplomacies.") return end
    if diplotype == "war" and not ply:HasPerm("war") then ply:ChatPrint("You must have the permission 'war' to accept or decline war diplomacies.") return end
    if diplotype == "endwar" and not ply:HasPerm("war") then ply:ChatPrint("You must have the permission 'war' to accept war ending diplomacies.") return end

    ply:AcceptDiplomacy( diploid )
end)

net.Receive( "as_community_declinediplomacy", function( _, ply ) 
    local diploid = net.ReadUInt( NWSetting.UIDAmtBits )

    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    local diplotype = Communities[ply:GetCommunity()].pending[diploid].type
    if diplotype == "ally" and not ply:HasPerm("ally") then ply:ChatPrint("You must have the permission 'ally' to accept or decline ally diplomacies.") return end
    if diplotype == "war" and not ply:HasPerm("war") then ply:ChatPrint("You must have the permission 'war' to accept or decline war diplomacies.") return end

    ply:DeclineDiplomacy( diploid )
end)

net.Receive( "as_community_ally", function( _, ply ) 
    local cid = net.ReadUInt( NWSetting.UIDAmtBits )

    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if not ply:HasPerm("ally") then ply:ChatPrint("You must have the permission 'ally' to send alliance requests to other communities.") return end

    ply:ChatPrint("You have sent an alliance request to this community.")
    ply:SendAllyRequest( cid )
end)

net.Receive( "as_community_war", function( _, ply ) 
    local cid = net.ReadUInt( NWSetting.UIDAmtBits )

    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if not ply:HasPerm("war") then ply:ChatPrint("You must have the permission 'war' to send war requests to other communities.") return end

    ply:ChatPrint("You have sent an war request to this community.")
    ply:SendWarRequest( cid )
end)

net.Receive( "as_community_endally", function( _, ply ) 
    local cid = net.ReadUInt( NWSetting.UIDAmtBits )

    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if not ply:HasPerm("ally") then ply:ChatPrint("You must have the permission 'ally' to end alliances with other communities.") return end

    ply:EndAlliance( cid )
end)

net.Receive( "as_community_endwarrequest", function( _, ply ) 
    local warid = net.ReadUInt( NWSetting.UIDAmtBits )

    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if not ply:HasPerm("war") then ply:ChatPrint("You must have the permission 'war' to send requests to end a war.") return end

    ply:ChatPrint("You have sent a request to end this war.")
    ply:EndWarRequest( warid )
end)

net.Receive( "as_community_deploylocker", function( _, ply )
    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if not ply:HasPerm("locker") then ply:ChatPrint("You must have the permission 'locker' to deploy the community locker.") return end

    for k, v in pairs( ents.FindByClass("as_community_storage") ) do
        if v:GetCommunity() == ply:GetCommunity() then
            ply:ChatPrint("Your community storage is already deployed.")
            return
        end
    end

    ply:ChatPrint("You have deployed your community's locker.")
    ply:DeployLocker()
end)

net.Receive( "as_community_deploystockpile", function( _, ply )
    if not ply:InCommunity() then ply:ChatPrint("You are not in a community.") return end
    if not ply:HasPerm("stockpile") then ply:ChatPrint("You must have the permission 'stockpile' to deploy the community stockpile.") return end

    for k, v in pairs( ents.FindByClass("as_community_stockpile") ) do
        if v:GetCommunity() == ply:GetCommunity() then
            ply:ChatPrint("Your community stockpile is already deployed.")
            return
        end
    end

    ply:ChatPrint("You have deployed your community's stockpile.")
    ply:DeployStockpile()
end)