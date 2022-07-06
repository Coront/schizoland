-- ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗
-- ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝
-- ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗
-- ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝
-- ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗
-- ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝

function PlayerMeta:MissionDataTableCheck()
    local data = sql.Query( "SELECT * FROM as_missions WHERE pid = " .. self:GetPID() )
    if not data then
        sql.Query( "INSERT INTO as_missions VALUES ( " .. self:GetPID() .. ", NULL )" )
    else
        local missions = sql.QueryValue( "SELECT data FROM as_missions WHERE pid = " .. self:GetPID() )
        missions = util.JSONToTable( missions )

        self:SetMissions( missions )
    end
end

function PlayerMeta:SaveMissions()
	sql.Query( "UPDATE as_missions SET data = " .. SQLStr( util.TableToJSON( self:GetMissions(), true ) ) .. " WHERE pid = " .. self:GetPID() )
end