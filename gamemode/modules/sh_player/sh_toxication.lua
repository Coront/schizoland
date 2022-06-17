function PlayerMeta:SetToxic( int )
    self.Toxic = int
end

function PlayerMeta:GetToxic()
    return self.Toxic or 0
end

function PlayerMeta:AddToxic( int )
    local toxic = self:GetToxic()
    toxic = toxic + int
    self:SetToxic( toxic )
end

function PlayerMeta:RemoveToxic()
    local toxic = self:GetToxic()
    toxic = toxic - int
    self:SetToxic( toxic )
end