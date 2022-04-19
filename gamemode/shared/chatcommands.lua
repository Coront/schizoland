AS.ChatCommands = {}

function AS.AddChatCommand( str, callback )
    AS.ChatCommands = AS.ChatCommands or {}
    if not str then return end
    if not callback then AS.LuaError("Chat Command does not have a function callback - " .. str) return end

    AS.ChatCommands[str] = callback
end

-- ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝

hook.Add( "PlayerSay", "AS_ChatCommands", function( ply, txt, team )
    if dead then return end
    txt = string.lower( txt )
    local args = string.Explode(" ", txt)

    if AS.ChatCommands[string.Replace(args[1], "/", "")] then
        local newtxt = string.Replace(args[1], "/", "")
        args[1] = nil
        AS.ChatCommands[newtxt]( ply, args )
        return ""
    end
end)