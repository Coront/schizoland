-- ███████╗██╗  ██╗██╗██╗     ██╗     ███████╗
-- ██╔════╝██║ ██╔╝██║██║     ██║     ██╔════╝
-- ███████╗█████╔╝ ██║██║     ██║     ███████╗
-- ╚════██║██╔═██╗ ██║██║     ██║     ╚════██║
-- ███████║██║  ██╗██║███████╗███████╗███████║
-- ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝╚══════╝
-- Desc: Functionality for the skills base.

function PlayerMeta:SetSkills( tbl ) --Set ALL skills, this will only be used for initialization.
    tbl = tbl or {}
    self.Skills = tbl
end

function PlayerMeta:GetSkills()
    return self.Skills
end

function PlayerMeta:SetSkillExperience( skill, amt ) --Set the experience for a single skill
    if not AS.Skills[skill] then AS.LuaError("Attempting to index a non-existant skill - " .. skill) return end
    self.Skills[skill] = amt
end

function PlayerMeta:GetSkillExperience( skill ) --Get a specific skill
    if not AS.Skills[skill] then AS.LuaError("Attempting to index a non-existant skill - " .. skill) return end
    return self.Skills and self.Skills[skill] or 0
end

function PlayerMeta:ExpToLevelSkill( skill )
    if not AS.Skills[skill] then AS.LuaError("Attempting to index a non-existant skill - " .. skill) return end
    local expreq = (AS.Skills[skill].basexp * self:GetSkillLevel( skill )) ^ (AS.Skills[skill].power or 2)
    return math.Round(expreq, 2)
end

function PlayerMeta:GetSkillLevel( skill )
    if not AS.Skills[skill] then AS.LuaError("Attempting to index a non-existant skill - " .. skill) return end

    local experience = self:GetSkillExperience( skill )
    local level = 1
    while experience >= (AS.Skills[skill].basexp * level) ^ (AS.Skills[skill].power or 2) do
        if experience < 1 then break end --Precaution
        level = level + 1
        if level >= (AS.Skills[skill].max or 50) then break end --Precaution
    end
    return level
end

function PlayerMeta:IncreaseSkillExperience( skill, amt )
    if not AS.Skills[skill] then AS.LuaError("Attempting to index a non-existant skill - " .. skill) return end
    amt = amt > 0 and amt or 1
    local priorlevel = self:GetSkillLevel( skill )
    self:SetSkillExperience( skill, math.Round(self:GetSkillExperience(skill) + amt, 2) )
    local newlevel = self:GetSkillLevel( skill )

    if SERVER and newlevel > priorlevel then
        self:ChatPrint("Your " .. AS.Skills[skill].name .. " has increased to level " .. newlevel .. ".")
        self:ResyncSkills()
    end
end

function PlayerMeta:DecreaseSkillExperience( skill, amt )
    if not AS.Skills[skill] then AS.LuaError("Attempting to index a non-existant skill - " .. skill) return end
    amt = amt > 0 and amt or 1
    local priorlevel = self:GetSkillLevel( skill )
    self:SetSkillExperience( skill, math.Round(self:GetSkillExperience(skill) - amt, 2) )
    local newlevel = self:GetSkillLevel( skill )

    if SERVER and newlevel < priorlevel then
        self:ChatPrint("Your " .. AS.Skills[skill].name .. " has decreased to level " .. newlevel .. ".")
        self:ResyncSkills()
    end
end

-- ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝

hook.Add( "Think", "AS_Skill_Endurance", function()
    for k, v in pairs( player.GetAll() ) do
        if CLIENT and not v == LocalPlayer() then continue end
        if not v:IsLoaded() then continue end
        if CurTime() < (v.Skill_NextEnduranceUpdate or 0) then continue end
        if v:GetMoveType() == MOVETYPE_NOCLIP then continue end

        if (v:KeyDown( IN_FORWARD ) or v:KeyDown( IN_MOVELEFT ) or v:KeyDown( IN_MOVERIGHT ) or v:KeyDown( IN_BACK )) and v:IsSprinting() then
            v.Skill_NextEnduranceUpdate = CurTime() + SKL.Endurance.updatetime
            v:IncreaseSkillExperience( "endurance", SKL.Endurance.incamt )
        end
    end
end)

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if SERVER then

    util.AddNetworkString("as_syncskills")

    function PlayerMeta:ResyncSkills()
        net.Start("as_syncskills")
            net.WriteTable(self:GetSkills())
        net.Send(self)
    end
    concommand.Add("as_resyncskills", function(ply) ply:ResyncSkills() end)

elseif CLIENT then

    net.Receive("as_syncskills", function()
        local skills = net.ReadTable()
        LocalPlayer():SetSkills( skills )
    end)

end