function EntityMeta:SetLinks( tbl )
    self.PowerLinks = tbl
end

function EntityMeta:GetLinks()
    return self.PowerLinks or {}
end

function EntityMeta:AddLink( ent ) --Add a link
    local tbl = self:GetLinks()
    tbl[ent] = true
    self:SetLinks( tbl )
end

function EntityMeta:RemoveLink( ent ) --Remove a link
    local tbl = self:GetLinks()
    tbl[ent] = nil 
    self:SetLinks( tbl )
end

function EntityMeta:HasLink( ent )
    if self:GetLinks()[ent] then return true end
    return false
end

function EntityMeta:ValidateLinks() --Clear invalid entities
    local tbl = self:GetLinks()

    for k, v in pairs( tbl ) do
        if not IsValid(k) then
            tbl[k] = nil
        end
    end

    self:SetLinks( tbl )
end

function EntityMeta:EstablishLink( otherEnt )
    if not self.AS_Conductor or not otherEnt.AS_Conductor then return end

    print("here")
end

function EntityMeta:DestroyLink( otherEnt )
    print("here")
end