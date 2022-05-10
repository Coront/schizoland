--  ██████╗██╗     ██╗███████╗███╗   ██╗████████╗███████╗██╗██████╗ ███████╗    ██╗███╗   ██╗██╗████████╗██╗ █████╗ ██╗     ██╗███████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
-- ██╔════╝██║     ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝██║██╔══██╗██╔════╝    ██║████╗  ██║██║╚══██╔══╝██║██╔══██╗██║     ██║╚══███╔╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
-- ██║     ██║     ██║█████╗  ██╔██╗ ██║   ██║   ███████╗██║██║  ██║█████╗      ██║██╔██╗ ██║██║   ██║   ██║███████║██║     ██║  ███╔╝ ███████║   ██║   ██║██║   ██║██╔██╗ ██║
-- ██║     ██║     ██║██╔══╝  ██║╚██╗██║   ██║   ╚════██║██║██║  ██║██╔══╝      ██║██║╚██╗██║██║   ██║   ██║██╔══██║██║     ██║ ███╔╝  ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
-- ╚██████╗███████╗██║███████╗██║ ╚████║   ██║   ███████║██║██████╔╝███████╗    ██║██║ ╚████║██║   ██║   ██║██║  ██║███████╗██║███████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
--  ╚═════╝╚══════╝╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝╚═════╝ ╚══════╝    ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   ╚═╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

MsgC( Color(0,0,255), "[AS] Loading Clientside Files...\n" )

ConVarDefaults = ConVarDefaults or {}
function AS_ClientConVar( name, str, save, sync, info, min, max )
    ConVarDefaults[name] = str
    local convar = CreateClientConVar( name, str, save, sync, info, min, max )
end

include("shared.lua")

COLHUD_DEFAULT = Color(GetConVar("as_hud_color_default_r"):GetInt(), GetConVar("as_hud_color_default_g"):GetInt(), GetConVar("as_hud_color_default_b"):GetInt(), 255) or Color(255,255,255,255)
COLHUD_GOOD = Color(GetConVar("as_hud_color_good_r"):GetInt(), GetConVar("as_hud_color_good_g"):GetInt(), GetConVar("as_hud_color_good_b"):GetInt(), 255) or Color(255,255,255,255)
COLHUD_BAD = Color(GetConVar("as_hud_color_bad_r"):GetInt(), GetConVar("as_hud_color_bad_g"):GetInt(), GetConVar("as_hud_color_bad_b"):GetInt(), 255) or Color(255,255,255,255)

KEYBIND_USE = input.LookupBinding("+use") or '"+use" -Unbound'

MsgC( Color(0,0,255), "[AS] Finished Loading!\n" )

AS_ClientConVar( "as_gameplay_verify", "1", true, false )
AS_ClientConVar( "as_entity_renderdist", "6000", true, false )