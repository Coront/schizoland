local PlayerMeta = FindMetaTable("Player")

if SERVER then

    function PlayerMeta:LoadCharacter( playerid )
        self:SetNW2Bool("as_spawned", true)
        self:Freeze(false)
        self:UnSpectate()
        self.pid = playerid
        local model = sql.QueryValue("SELECT model FROM as_characters WHERE pid = " .. self.pid)
        local stats = sql.Query("SELECT * FROM as_characters_stats WHERE pid = " .. self.pid)[1]
        local skills = util.JSONToTable(sql.QueryValue("SELECT skills FROM as_characters_skills WHERE pid = " .. self.pid)) or {}
        local inv = util.JSONToTable(sql.QueryValue("SELECT inv FROM as_characters_inventory WHERE pid = " .. self.pid)) or {}
        self:SetModel(model)
        self:SetHealth(stats.health)
        self:SetMaxHealth(SKL.Health)
        self:SetExperience(stats.exp)
        self:SetSkills(skills)
        self:SetInventory(inv)

        net.Start("as_characters_syncdata")
            net.WriteInt(self:GetExperience(), 32)
            net.WriteTable(self:GetInventory())
            net.WriteTable(self:GetSkills())
        net.Send(self)

        self:Spawn()
    end

elseif CLIENT then

    function LoadCharacter()
        local ply = LocalPlayer()

        ply:SetExperience(net.ReadInt(32))
        ply:SetSkills(net.ReadTable())
        ply:SetInventory(net.ReadTable())
    end
    net.Receive("as_characters_syncdata", LoadCharacter)

end