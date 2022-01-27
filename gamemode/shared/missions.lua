function PlayerMeta:SetMissions( tbl )
    tbl = tbl or {}
    self.Missions = tbl
end

function PlayerMeta:GetMissions()
    return self.Missions
end

function PlayerMeta:AddMission( id )
    self.Missions[id] = {}
end

function PlayerMeta:RemoveMission( id )
    self.Missions[id] = nil
end

function PlayerMeta:SetMissionProgress()

end