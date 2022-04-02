local PlayerMeta = FindMetaTable("Player")

util.AddNetworkString("as_characters_requestdata")
util.AddNetworkString("as_characters_senddata")
util.AddNetworkString("as_characters_finishcharacter")
util.AddNetworkString("as_characters_deletecharacter")
util.AddNetworkString("as_characters_loadcharacter")
util.AddNetworkString("as_characters_syncdata")

-- ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
-- ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
-- █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
-- ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
-- ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
-- ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

function PlayerMeta:CreateCharacter( name, model, class )
    local characters = sql.Query( "SELECT * FROM as_characters WHERE steamid = " .. SQLStr(self:SteamID()) .. " AND deleted IS NULL" ) or {}
    if #characters >= SET.MaxCharacters then self:ChatPrint("You have reached the character limit!") return end

    sql.Query( "INSERT INTO as_characters VALUES ( NULL, " .. SQLStr(self:SteamID()) .. ", " .. SQLStr(name) .. ", " .. SQLStr(model) .. ", " .. SQLStr(class) .. ", " .. SQLStr( os.date( "%m/%d/%y - %I:%M %p", os.time() ) ) .. ", NULL, NULL )" )
    local pids = sql.Query("SELECT pid FROM as_characters")
    local newpid = tonumber(sql.Query("SELECT pid FROM as_characters")[#pids]["pid"])
    sql.Query( "INSERT INTO as_characters_inventory VALUES ( " .. newpid .. ", NULL, NULL, NULL )" )
    sql.Query( "INSERT INTO as_characters_skills VALUES ( " .. newpid .. ", NULL )" )
    local health = class == "scavenger" and SKL.Health * CLS.Scavenger.healthmult or class == "mercenary" and SKL.Health * CLS.Mercenary.healthmult or SKL.Health
    sql.Query( "INSERT INTO as_characters_stats VALUES ( " .. newpid .. ", " .. health .. ", 100, 100, 0 )" )
    sql.Query( "INSERT INTO as_cache_tools VALUES ( " .. newpid .. ", NULL )" )

    self:ConCommand("as_characters")
end

function PlayerMeta:DeleteCharacter( pid )
    sql.Query( "UPDATE as_characters SET deleted = " .. SQLStr( os.date( "%m/%d/%y - %I:%M %p", os.time() ) ) .. " WHERE pid = " .. pid )
    self:ConCommand("as_characters")
end

function PlayerMeta:SaveCharacter()
    local pid = self.pid
    if not pid then return false end
    if not (self.FullyLoadedCharacter or false) then print("Stopped player: " .. self:Nickname() .. "'s data from saving, encountered an error while loading profile.") return false end

    local equipped = {}
    for k, v in pairs(self:GetAmmo()) do
        equipped.ammo = equipped.ammo or {}
        if AS.Items[translateAmmoNameID( game.GetAmmoName( k ) )] then
            equipped.ammo[string.lower(game.GetAmmoName( k ))] = v
        end
    end
    for k, v in pairs(self:GetWeapons()) do
        equipped.weps = equipped.weps or {}
        if v.ASID then
            equipped.weps[#equipped.weps + 1] = v:GetClass()
            if v:Clip1() > 0 then
                equipped.ammo = equipped.ammo or {}
                equipped.ammo[string.lower(game.GetAmmoName(v:GetPrimaryAmmoType()))] = (equipped.ammo[string.lower(game.GetAmmoName(v:GetPrimaryAmmoType()))] or 0) + v:Clip1()
            end
        end
    end
    sql.Query( "UPDATE as_characters_inventory SET inv = " .. SQLStr(util.TableToJSON( self:GetInventory(), true )) .. ", bank = " .. SQLStr(util.TableToJSON( self:GetBank(), true )) .. ", equipped = " .. SQLStr(util.TableToJSON( equipped, true )) .. " WHERE pid = " .. pid )
    sql.Query( "UPDATE as_characters_skills SET skills = " .. SQLStr(util.TableToJSON( self:GetSkills(), true )) .. " WHERE pid = " .. pid )
    sql.Query( "UPDATE as_characters_stats SET health = " .. self:Health() .. ", hunger = " .. self:GetHunger() .. ", thirst = " .. self:GetThirst() .. ", playtime = " .. self:GetPlaytime() .. " WHERE pid = " .. pid )
    sql.Query( "UPDATE as_characters SET class = " .. SQLStr( self:GetASClass() ) .. ", laston = " .. SQLStr( os.date( "%m/%d/%y - %I:%M %p", os.time() ) ) .. " WHERE pid = " .. pid )
    return true --Saving was successful.
end

function ManualSave( ply )
    if ply:SaveCharacter() then
        ply:ChatPrint("Player Saved.")
    else
        ply:ChatPrint("Error in saving character.")
    end
end
concommand.Add("as_save", ManualSave)

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

function RequestCharacters(len, ply)
    local characters = sql.Query( "SELECT * FROM as_characters WHERE steamid = " .. SQLStr(ply:SteamID()) .. "AND deleted IS NULL" )

    net.Start("as_characters_senddata")
    if characters then
        local stats = {}
        for k, v in pairs(characters) do
            stats[v.pid] = {}
            stats[v.pid].health = sql.QueryValue( "SELECT health FROM as_characters_stats WHERE pid = " .. SQLStr(v.pid) )
            stats[v.pid].playtime = sql.QueryValue( "SELECT playtime FROM as_characters_stats WHERE pid = " .. SQLStr(v.pid) )
            stats[v.pid].class = sql.QueryValue( "SELECT class FROM as_characters WHERE pid = " .. SQLStr(v.pid) )
        end

        net.WriteBit( true )
        net.WriteTable(characters)
        net.WriteTable(stats)
    else
        net.WriteBit( false )
    end
    net.Send(ply)
end
net.Receive("as_characters_requestdata", RequestCharacters)

function FinishCharacter(len, ply)
    local name = net.ReadString()
    local model = net.ReadString()
    local class = net.ReadString()

    if string.len(name:lower()) < SET.MinNameLength then ply:Kick("You must have a longer name") return end
    if string.find(name:lower(), "[%/%\\%!%@%#%$%%%^%&%*%(%)%+%=%.%'%\"]") then ply:Kick("Your character's name cannot have special characters in it") return end
    for k, v in pairs(SET.BannedWords) do
        if string.find(name:lower(), v) then ply:Kick("Inappropriate name usage") return end
    end
    if not SET.SelectableModels[model] then model = table.Random(SET.SelectableModels) ply:ChatPrint("Model validation failed. One was automatically assigned to you.") end --Dude literally tried to use a model that doesn't exist. We'll pick one for them.
    local _, classbackup = table.Random(AS.Classes)
    if not AS.Classes[class] then class = classbackup ply:ChatPrint("Class validation failed. One was automatically assigned to you.") return end --Apparently tried to use a invalid class. We will also pick one for them.

    ply:CreateCharacter( name, model, class )
end
net.Receive("as_characters_finishcharacter", FinishCharacter)

function DeleteCharacter(len, ply)
    local pid = net.ReadInt(32)

    local owner = sql.QueryValue("SELECT steamid FROM as_characters WHERE pid = " .. pid)
    if ply:SteamID() != owner then ply:Kick("This isn't your character") return end
    if ply:IsLoaded() then ply:ChatPrint("You cannot do this while loaded in.") return end

    ply:DeleteCharacter( pid )
end
net.Receive("as_characters_deletecharacter", DeleteCharacter)

function CheckoutCharacter(len, ply)
    local pid = net.ReadInt(32)

    local owner = sql.QueryValue("SELECT steamid FROM as_characters WHERE pid = " .. pid)
    if ply:SteamID() != owner then ply:Kick("This isn't your character") return end

    ply:LoadCharacter( pid )
end
net.Receive("as_characters_loadcharacter", CheckoutCharacter)