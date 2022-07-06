function PlayerMeta:IsLoaded()
    return self:GetNWBool("as_spawned", false)
end

function PlayerMeta:GetPID()
    return self.pid
end

function PlayerMeta:Nickname() --Returns the player's name.
    if IsValid(self) then
        return self:GetNWString("as_name", self.name) != "" and self:GetNWString("as_name", self.name) or self:Nick()
    else
        return ""
    end
end

function PlayerMeta:IsFemale()
    if AS.CharacterModels[self:GetNWString("as_referencemodel")] and AS.CharacterModels[self:GetNWString( "as_referencemodel" )].female then return true end
    return false
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if SERVER then

    function PlayerMeta:LoadCharacter( playerid )
        self:SetNWBool("as_spawned", true)
        self:Freeze(false)
        self:UnSpectate()
        self:AllowFlashlight( true )
        self.pid = playerid

        --Basic Information (I know this is coded horribly.)
        local name = sql.QueryValue("SELECT name FROM as_characters WHERE pid = " .. self:GetPID())
        local model = sql.QueryValue("SELECT model FROM as_characters WHERE pid = " .. self:GetPID())
        local _, classbackup = table.Random(AS.Classes)
        local class = sql.QueryValue("SELECT class FROM as_characters WHERE pid = " .. self:GetPID()) or classbackup
        local stats = sql.Query("SELECT * FROM as_characters_stats WHERE pid = " .. self:GetPID())[1]
        local stattbl = sql.Query("SELECT * FROM as_characters_statistics WHERE pid = " .. self:GetPID())
        local statistics = {}
        if stattbl and istable(stattbl) then
            for k, v in pairs( stattbl ) do
                statistics[v.key] = v.value
            end
        end
        --Community
        local community = tonumber(sql.QueryValue("SELECT cid FROM as_communities_members WHERE pid = " .. self:GetPID())) or 0
        local rank = tonumber(sql.QueryValue("SELECT rank FROM as_communities_members WHERE pid = " .. self:GetPID())) or -1
        local title = sql.QueryValue("SELECT title FROM as_communities_members WHERE pid = " .. self:GetPID()) or ""
        title = title == "NULL" and "" or title

        self:Spawn()

        self:SetNWString( "as_name", name )
        self:SetNWString( "as_referencemodel", model )
        self:SetHealth(stats.health)
        self:SetModel(model)
        self:SetASClass(class)
        local health = SKL.Health
        if self:GetASClass() == "mercenary" then
            health = health * CLS.Mercenary.healthmult
        elseif self:GetASClass() == "scavenger" then
            health = health * CLS.Scavenger.healthmult
        end
        self:SetMaxHealth(health)

        --Table Checks, these are separate functions, just compressed.
        self:InventoryDataTableCheck()
        self:SkillsDataTableCheck()
        self:MissionDataTableCheck()

        --Stats
        self:SetHunger( tonumber( stats.hunger ) )
        self:SetThirst( tonumber( stats.thirst ) )
        self:SetToxic( tonumber( stats.toxic ) )
        self:SetPlaytime( tonumber( stats.playtime ) )
        self:SetCommunity( tonumber(community) )
        self:SetRank( rank )
        self:SetTitle( title )
        self:SetStatistics( statistics )

        self:ValidateInventory()
        self:ValidateStorage()

        net.Start("as_characters_syncdata")
            net.WriteUInt(self:GetHunger(), 8)
            net.WriteUInt(self:GetThirst(), 8)
            net.WriteUInt(self:GetPlaytime(), 32)
        net.Send(self)

        self.FullyLoadedCharacter = true --Don't touch this, although it looks pointless it's a failsafe to prevent character's data from getting wiped should they ever encounter an error while loading.

        for k, v in pairs( player.GetAll() ) do
            if self == v then continue end
            v:ChatPrint( self:Nickname() .. " has joined the server." )
        end

        if self:InCommunity() and table.Count(Communities[self:GetCommunity()].wars) >= 1 then
            self:ChatPrint("You are currently at war with other communities. Keep your eyes peeled.")
        end
    end

elseif CLIENT then

    net.Receive("as_characters_syncdata", function()
        local ply = LocalPlayer()
        ply:SetHunger(net.ReadUInt(8))
        ply:SetThirst(net.ReadUInt(8))
        ply:SetPlaytime(net.ReadUInt(32))

        timer.Simple( 3, function() --gmod gamer moment
            if IsValid( ply ) and ply:Alive() then
                RunConsoleCommand("as_resyncattachments")
            end
        end)
    end)

end