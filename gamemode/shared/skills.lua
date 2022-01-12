-- ███████╗██╗  ██╗██╗██╗     ██╗     ███████╗
-- ██╔════╝██║ ██╔╝██║██║     ██║     ██╔════╝
-- ███████╗█████╔╝ ██║██║     ██║     ███████╗
-- ╚════██║██╔═██╗ ██║██║     ██║     ╚════██║
-- ███████║██║  ██╗██║███████╗███████╗███████║
-- ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝╚══════╝
-- Desc: Functionality for the skills base.

-- Overall Leveling and Experience
function PlayerMeta:GetLevel()
    local experience = self:GetExperience()
    local level = 1
    while experience >= SET.BaseLevelExperience * (SET.LevelExperiencePower ^ level) do
        if experience < 1 then break end --Precaution
        level = level + 1
        if level >= SET.MaxLevel then break end --Precaution
    end
    return level
end

function PlayerMeta:ExpToLevel()
    local expreq = SET.BaseLevelExperience * (SET.LevelExperiencePower ^ self:GetLevel())
    return expreq
end

function CalcExpForLevel( lvl ) --Will calculate the XP required for a specific level.
    return SET.BaseLevelExperience * (SET.LevelExperiencePower ^ lvl)
end

function PlayerMeta:SetExperience( amt )
    amt = amt and math.Round(amt) or 0
    self.Experience = amt
end

function PlayerMeta:GetExperience()
    return self.Experience or 0
end

function PlayerMeta:IncreaseExperience( amt )
    amt = amt > 0 and amt or 1
    self:SetExperience( self:GetExperience() + amt )
end

function PlayerMeta:DecreaseExperience( amt ) --I don't foresee any need for this, but just incase.
    amt = amt > 0 and amt or 1
    self:SetExperience( self:GetExperience() - amt )
end

-- Individual Skills
function PlayerMeta:SetSkills( tbl ) --Set ALL skills, this will only be used for initialization.
    tbl = tbl or {}
    self.Skills = tbl
end

function PlayerMeta:GetSkills()
    return self.Skills
end

function PlayerMeta:SetSkillExperience( skill, amt ) --Set the experience for a single skill
    if not AS.Skills[skill] then AS.LuaError("Attempting to index a non-existant skill - " .. skill) return end
    amt = math.Round(amt)
    self.Skills[skill] = amt
end

function PlayerMeta:GetSkillExperience( skill ) --Get a specific skill
    if not AS.Skills[skill] then AS.LuaError("Attempting to index a non-existant skill - " .. skill) return end
    return self.Skills[skill]
end

function PlayerMeta:IncreaseSkillExperience( skill, amt )
    if not AS.Skills[skill] then AS.LuaError("Attempting to index a non-existant skill - " .. skill) return end
    amt = amt > 0 and amt or 1
    self:SetSkillExperience( skill, self:GetSkillExperience(skill) + amt )
end

function PlayerMeta:DecreaseSkillExperience( skill, amt )
    if not AS.Skills[skill] then AS.LuaError("Attempting to index a non-existant skill - " .. skill) return end
    amt = amt > 0 and amt or 1
    self:SetSkillExperience( skill, self:GetSkillExperience(skill) - amt )
end