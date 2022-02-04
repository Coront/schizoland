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

function PlayerMeta:CreateCharacter( name, model )
    local characters = sql.Query( "SELECT * FROM as_characters WHERE steamid = " .. SQLStr(self:SteamID()) .. " AND deleted IS NULL" ) or {}
    if #characters >= SET.MaxCharacters then self:ChatPrint("You have reached the character limit!") return end

    sql.Query( "INSERT INTO as_characters VALUES ( NULL, " .. SQLStr(self:SteamID()) .. ", " .. SQLStr(name) .. ", " .. SQLStr(model) .. ", " .. SQLStr( os.date( "%m/%d/%y - %I:%M %p", os.time() ) ) .. ", NULL, NULL )" )
    local pids = sql.Query("SELECT pid FROM as_characters")
    local newpid = tonumber(sql.Query("SELECT pid FROM as_characters")[#pids]["pid"])
    sql.Query( "INSERT INTO as_characters_inventory VALUES ( " .. newpid .. ", NULL, NULL )" )
    sql.Query( "INSERT INTO as_characters_skills VALUES ( " .. newpid .. ", NULL )" )
    sql.Query( "INSERT INTO as_characters_stats VALUES ( " .. newpid .. ", " .. SKL.Health .. ", 100, 100, 0 )" )

    self:ConCommand("as_characters")
end

function PlayerMeta:DeleteCharacter( pid )
    sql.Query( "UPDATE as_characters SET deleted = " .. SQLStr( os.date( "%m/%d/%y - %I:%M %p", os.time() ) ) .. " WHERE pid = " .. pid )
    self:ConCommand("as_characters")
end

function PlayerMeta:SaveCharacter()
    local pid = self.pid
    if not pid then return false end

    sql.Query( "UPDATE as_characters_inventory SET inv = " .. SQLStr(util.TableToJSON( self:GetInventory(), true )) .. ", bank = " .. SQLStr(util.TableToJSON( self:GetBank(), true )) .. " WHERE pid = " .. pid )
    sql.Query( "UPDATE as_characters_skills SET skills = " .. SQLStr(util.TableToJSON( self:GetSkills(), true )) .. " WHERE pid = " .. pid )
    sql.Query( "UPDATE as_characters_stats SET health = " .. self:Health() .. ", hunger = " .. self:GetHunger() .. ", thirst = " .. self:GetThirst() .. ", exp = " .. self:GetExperience() .. ", playtime = " .. self:GetPlaytime() .. " WHERE pid = " .. pid )
    return true --Saving was successful.
end

function ManualSave( ply )
    if ply:SaveCharacter() then
        ply:ChatPrint("Player Saved.")
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
            stats[v.pid].exp = sql.QueryValue( "SELECT exp FROM as_characters_stats WHERE pid = " .. SQLStr(v.pid) )
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

    if string.len(name:lower()) < SET.MinNameLength then ply:Kick("You must have a longer name") return end
    if string.find(name:lower(), "[%/%\\%!%@%#%$%%%^%&%*%(%)%+%=%.%'%\"]") then ply:Kick("Your character's name cannot have special characters in it") return end
    for k, v in pairs(SET.BannedWords) do
        if string.find(name:lower(), v) then ply:Kick("Inappropriate name usage") return end
    end
    if not SET.SelectableModels[model] then ply:Kick("This model doesn't exist as a selectable model") return end

    ply:CreateCharacter( name, model )
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