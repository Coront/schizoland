function PlayerMeta:SetStatuses( tbl ) --Shut up, i know statuses is a bad name for it but i cant do SetEffect/GetEffect.
    self.Status = tbl
end

function PlayerMeta:GetStatuses()
    return self.Status or {}
end

function PlayerMeta:AddStatus( statusid, length )
    if self:HasStatus( "suppression" ) and AS.Effects[statusid].type == "negative" then return end

    local statTbl = self:GetStatuses()
    statTbl[statusid] = {time = CurTime() + length, maxtime = length}
    self:SetStatuses( statTbl )

    if statusid == "suppression" then
        self:ClearNegativeStatuses()
    end
end

function PlayerMeta:ClearStatus( statusid )
    local statTbl = self:GetStatuses()
    statTbl[statusid] = nil 
    self:SetStatuses( statTbl )
end

function PlayerMeta:HasStatus( statusid )
    local statTbl = self:GetStatuses()
    if statTbl[statusid] then return true end
    return false
end

function PlayerMeta:ClearAllStatuses()
    local statTbl = {}
    self:SetStatuses( statTbl )
end

function PlayerMeta:ClearPositiveStatuses()
    local statTbl = self:GetStatuses()
    for k, v in pairs( statTbl ) do
        if AS.Effects[k].type == "positive" then
            statTbl[k] = nil
        end
    end

    self:SetStatuses( statTbl )
end

function PlayerMeta:ClearNegativeStatuses()
    local statTbl = self:GetStatuses()
    for k, v in pairs( statTbl ) do
        if AS.Effects[k].type == "negative" then
            statTbl[k] = nil
        end
    end

    self:SetStatuses( statTbl )
end

-- ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝

hook.Add("Think", "AS_EffectTick", function() --This is the main ticking function for our effects.
    for _, ply in pairs( player.GetAll() ) do
        if CLIENT and not LocalPlayer() == ply then continue end --Clientside, it just tells us to tick only for ourselves.
        if table.Count(ply:GetStatuses()) <= 0 then continue end --Skips players who dont have any status effects.
        for k, v in pairs( ply:GetStatuses() ) do --We need to go through and make sure their status is up to date.
            if CurTime() > v.time then ply:ClearStatus( k ) end
        end
    end
end)

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if ( SERVER ) then

    util.AddNetworkString("as_syncstatus")

    function PlayerMeta:ResyncStatuses()
        net.Start("as_syncstatus")
            net.WriteTable( self:GetStatuses() )
        net.Send(self)
    end

elseif ( CLIENT ) then

    net.Receive("as_syncstatus", function()
        local statuses = net.ReadTable()
        LocalPlayer():SetStatuses( statuses )
    end)

end