-- ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗
-- ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝
-- ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗
-- ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝
-- ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗
-- ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝

function PlayerMeta:SkillsDataTableCheck()
    local data = sql.Query( "SELECT * FROM as_characters_skills WHERE pid = " .. self:GetPID() )
    if not data then
        sql.Query( "INSERT INTO as_characters_skills VALUES ( " .. self:GetPID() .. ", NULL )" )
    else
        local skills = util.JSONToTable( sql.QueryValue( "SELECT skills FROM as_characters_skills WHERE pid = " .. self:GetPID() ) )

        self:SetSkills( skills )
    end
end

function PlayerMeta:SaveSkills()
    sql.Query("UPDATE as_characters_skills SET skills = " .. SQLStr( util.TableToJSON( self:GetSkills(), true ) ) .. " WHERE pid = " .. self:GetPID() )
end