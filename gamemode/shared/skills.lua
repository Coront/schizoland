-- ███████╗██╗  ██╗██╗██╗     ██╗     ███████╗
-- ██╔════╝██║ ██╔╝██║██║     ██║     ██╔════╝
-- ███████╗█████╔╝ ██║██║     ██║     ███████╗
-- ╚════██║██╔═██╗ ██║██║     ██║     ╚════██║
-- ███████║██║  ██╗██║███████╗███████╗███████║
-- ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝╚══════╝
-- Desc: Functionality for the skills base.

local PlayerMeta = FindMetaTable("Player")

-- Overall Leveling and Experience

function PlayerMeta:GetLevel()
    local level = self:GetExperience() / 100 --This second value will be 'experience to level' which will be its own thing. Not finished.
    return level
end

function PlayerMeta:SetExperience( exp )
    exp = math.Round(exp)
    self.Experience = exp
end

function PlayerMeta:GetExperience()
    return self.Experience 
end

function PlayerMeta:IncreaseExperience( amt )
    amt = amt > 0 and amt or 1
    self:SetExperience( self:GetExperience() + amt )
end

function PlayerMeta:DecreaseExperience( amt ) --I don't foresee any need for this, but just incase.
    amt = amt > 0 and amt or 1
    self:SetExperience( self:GetExperience() - amt )
end

-- Skills

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