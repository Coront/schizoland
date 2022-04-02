function PlayerMeta:IsLoaded()
    return self:GetNW2Bool("as_spawned", false)
end

if SERVER then

    function PlayerMeta:LoadCharacter( playerid )
        self:SetNW2Bool("as_spawned", true)
        self:Freeze(false)
        self:UnSpectate()
        self:AllowFlashlight( true )
        self.pid = playerid
        local name = sql.QueryValue("SELECT name FROM as_characters WHERE pid = " .. self.pid)
        local model = sql.QueryValue("SELECT model FROM as_characters WHERE pid = " .. self.pid)
        local _, classbackup = table.Random(AS.Classes)
        local class = sql.QueryValue("SELECT class FROM as_characters WHERE pid = " .. self.pid) or classbackup
        local stats = sql.Query("SELECT * FROM as_characters_stats WHERE pid = " .. self.pid)[1]
        local skills = util.JSONToTable(sql.QueryValue("SELECT skills FROM as_characters_skills WHERE pid = " .. self.pid)) or {}
        local inv = util.JSONToTable(sql.QueryValue("SELECT inv FROM as_characters_inventory WHERE pid = " .. self.pid)) or {}
        local toolcache = util.JSONToTable(sql.QueryValue("SELECT tools FROM as_cache_tools WHERE pid = " .. self.pid)) or {}
        local bank = util.JSONToTable(sql.QueryValue("SELECT bank FROM as_characters_inventory WHERE pid = " .. self.pid)) or {}
        local equipment = util.JSONToTable(sql.QueryValue("SELECT equipped FROM as_characters_inventory WHERE pid = " .. self.pid)) or {}
        self:Spawn()

        self:SetNW2String( "as_name", name )
        self.name = name
        self:SetModel(model)
        self:SetASClass(class)
        self:SetNW2String( "as_class", self:GetASClass() )
        self:SetHealth(stats.health)
        local health = SKL.Health
        if self:GetASClass() == "mercenary" then
            health = health * CLS.Mercenary.healthmult
        elseif self:GetASClass() == "scavenger" then
            health = health * CLS.Scavenger.healthmult
        end
        self:SetMaxHealth(health)
        self:SetHunger(stats.hunger)
        self:SetThirst(stats.thirst)
        self:SetSkills(skills)
        self:SetInventory(inv)
        self:SetBank(bank)
        for k, v in pairs(toolcache) do --Player apparently had deployed tools when they disconnected. We'll give them back.
            self:AddItemToInventory( k, v )
        end
        self:SetToolCache({}) --This will erase the cache
        self:SaveToolCache() --Then save it to the database
        if equipment and equipment.weps then
            for k, v in pairs(equipment.weps) do
                self:Give( v )
            end
        end
        if equipment and equipment.ammo then
            for k, v in pairs(equipment.ammo) do
                self:GiveAmmo( v, k )
            end
        end
        self:SetPlaytime(stats.playtime)
        self:ValidateInventory()
        self:ValidateStorage()

        net.Start("as_characters_syncdata")
            net.WriteString(self.name)
            net.WriteString(self:GetASClass())
            net.WriteInt(self:GetHunger(), 32)
            net.WriteInt(self:GetThirst(), 32)
            net.WriteInt(self:GetPlaytime(), 32)
            net.WriteTable(self:GetInventory())
            net.WriteTable(self:GetBank())
            net.WriteTable(self:GetSkills())
        net.Send(self)

        self.FullyLoadedCharacter = true --Don't touch this, although it looks pointless it's a failsafe to prevent character's data from getting wiped should they ever encounter an error while loading.

        ResyncAllContainerInventories( self )
    end

elseif CLIENT then

    net.Receive("as_characters_syncdata", function()
        local ply = LocalPlayer()
    
        ply.name = net.ReadString()
        ply:SetASClass(net.ReadString())
        ply:SetHunger(net.ReadInt(32))
        ply:SetThirst(net.ReadInt(32))
        ply:SetPlaytime(net.ReadInt(32))
        ply:SetInventory(net.ReadTable())
        ply:SetBank(net.ReadTable())
        ply:SetSkills(net.ReadTable())
    end)

end