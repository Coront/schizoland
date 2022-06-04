AS.Tutorial = {}
function AS.AddTutorial( id, data )
    AS.Tutorial = AS.Tutorial or {}

    AS.Tutorial[id] = data
end

-- ████████╗██╗   ██╗████████╗ ██████╗ ██████╗ ██╗ █████╗ ██╗
-- ╚══██╔══╝██║   ██║╚══██╔══╝██╔═══██╗██╔══██╗██║██╔══██╗██║
--    ██║   ██║   ██║   ██║   ██║   ██║██████╔╝██║███████║██║
--    ██║   ██║   ██║   ██║   ██║   ██║██╔══██╗██║██╔══██║██║
--    ██║   ╚██████╔╝   ██║   ╚██████╔╝██║  ██║██║██║  ██║███████╗
--    ╚═╝    ╚═════╝    ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚══════╝

AS.AddTutorial( "intro", {
    title = "Introduction",
    desc = [[
        Welcome to Aftershock! This menu you're currently viewing is a tutorial slide. These are shown to new players specifically to educate them on how the gamemode works to help reduce confusion. These will only ever appear once, so pay close attention.

        Aftershock is a semi-serious roleplay server. The gamemode is built on it's own base with it's own unique functionality, but there are still rules in place, and it is requested that you keep yourself up to date with them.

        You can open your inventory by pressing TAB by default. 
    ]],
} )

AS.AddTutorial( "intro", {
    title = "Introduction",
} )