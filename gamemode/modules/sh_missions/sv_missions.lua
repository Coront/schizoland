-- ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗
-- ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝
-- ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗
-- ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝
-- ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗
-- ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝

function PlayerMeta:MissionDataTableCheck()
    local data = sql.Query( "SELECT * FROM as_missions WHERE pid = " .. self:GetPID() )
    if not data then
        sql.Query( "INSERT INTO as_missions VALUES ( " .. self:GetPID() .. ", NULL, NULL )" )
    else
        local missions = sql.QueryValue( "SELECT active FROM as_missions WHERE pid = " .. self:GetPID() )
        local completed = sql.QueryValue( "SELECT completed FROM as_missions WHERE pid = " .. self:GetPID() )
        missions = util.JSONToTable( missions )
        completed = util.JSONToTable( completed )

        self:SetMissions( missions )
        self:SetFinishedMissions( completed )
    end
end

function PlayerMeta:SaveMissions()
	sql.Query( "UPDATE as_missions SET active = " .. SQLStr( util.TableToJSON( self:GetMissions(), true ) ) .. ", completed = " .. SQLStr( util.TableToJSON( self:GetFinishedMissions(), true ) ) .. " WHERE pid = " .. self:GetPID() )
end