function PlayerMeta:SetToolCache( tbl )
    self.ToolCache = tbl
end

function PlayerMeta:GetToolCache()
    return self.ToolCache or {}
end

function PlayerMeta:SaveToolCache()
    sql.Query("UPDATE as_cache_tools SET tools = " .. SQLStr(util.TableToJSON( self:GetToolCache(), true )) .. " WHERE pid = " .. self.pid)
end

function PlayerMeta:AddToolToCache( item )
    local tbl = self:GetToolCache()

    tbl[item] = (tbl[item] or 0) + 1
    self:SetToolCache( tbl )
    self:SaveToolCache()
end

function PlayerMeta:RemoveToolFromCache( item )
    local tbl = self:GetToolCache()

    tbl[item] = (tbl[item] or 0) - 1
    if tbl[item] <= 0 then tbl[item] = nil end
    self:SetToolCache( tbl )
    self:SaveToolCache()
end