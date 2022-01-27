function PlayerMeta:IsLoaded()
    return self:GetNW2Bool("as_spawned", false)
end

if SERVER then

    function PlayerMeta:LoadCharacter( playerid )
        self:SetNW2Bool("as_spawned", true)
        self:Freeze(false)
        self:UnSpectate()
        self.pid = playerid
        local name = sql.QueryValue("SELECT name FROM as_characters WHERE pid = " .. self.pid)
        local model = sql.QueryValue("SELECT model FROM as_characters WHERE pid = " .. self.pid)
        local stats = sql.Query("SELECT * FROM as_characters_stats WHERE pid = " .. self.pid)[1]
        local skills = util.JSONToTable(sql.QueryValue("SELECT skills FROM as_characters_skills WHERE pid = " .. self.pid)) or {}
        local inv = util.JSONToTable(sql.QueryValue("SELECT inv FROM as_characters_inventory WHERE pid = " .. self.pid)) or {}
        self:Spawn()

        self:SetNW2String( "as_name", name ) --Temp, will find a simpler solution.
        self.name = name
        self:SetModel(model)
        self:SetHealth(stats.health)
        self:SetMaxHealth(SKL.Health)
        self:SetExperience(stats.exp)
        self:SetHunger(stats.hunger)
        self:SetThirst(stats.thirst)
        self:SetSkills(skills)
        self:SetInventory(inv)
        self:SetPlaytime(stats.playtime)
        self:ValidateInventory()

        net.Start("as_characters_syncdata")
            net.WriteString(self.name)
            net.WriteInt(self:GetExperience(), 32)
            net.WriteInt(self:GetHunger(), 32)
            net.WriteInt(self:GetThirst(), 32)
            net.WriteInt(self:GetPlaytime(), 32)
            net.WriteTable(self:GetInventory())
            net.WriteTable(self:GetSkills())
        net.Send(self)
    end

elseif CLIENT then

    function LoadCharacter()
        local ply = LocalPlayer()

        ply.name = net.ReadString()
        ply:SetExperience(net.ReadInt(32))
        ply:SetHunger(net.ReadInt(32))
        ply:SetThirst(net.ReadInt(32))
        ply:SetPlaytime(net.ReadInt(32))
        ply:SetInventory(net.ReadTable())
        ply:SetSkills(net.ReadTable())
    end
    net.Receive("as_characters_syncdata", LoadCharacter)

end