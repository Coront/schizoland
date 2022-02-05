AS.LoadIn = {}

function AS.LoadIn.SpawnMenu()
    if IsValid(frame_spawnmenu) then frame_spawnmenu:Close() end
    if IsValid(frame_characters) then print("What are you doing! There is no need for that! Just select your character and start playing!!!") return end
    if LocalPlayer():IsLoaded() then LocalPlayer():ChatPrint("You have already loaded a character. Relog to switch characters.") return end
    surface.PlaySound("buttons/button1.wav") --Just to notify the player that they have loaded into the server.

    frame_spawnmenu = vgui.Create("DFrame")
    frame_spawnmenu:SetSize(600, ScrH())
    frame_spawnmenu:SetPos( 0, 0 )
    frame_spawnmenu:MakePopup()
    frame_spawnmenu:SetDraggable( false )
    frame_spawnmenu:SetTitle( "" )
    frame_spawnmenu:ShowCloseButton( false )
    frame_spawnmenu.Paint = function() end

    local title = vgui.Create("DLabel", frame_spawnmenu)
    title:SetFont("AftershockTitle")
    title:SetText(GAMEMODE.Name)
    title:SetPos(100, ScrH() * 0.2)
    title:SetContentAlignment(7)
    title:SizeToContents()
    title.Think = function()
        title:SetColor( COLHUD_DEFAULT )
    end

    AS.LoadIn.BuildMenu()
end
concommand.Add("as_spawnmenu", AS.LoadIn.SpawnMenu)

function AS.LoadIn.BuildMenu()
    local width = 400
    local height = 60
    local xpos = 100
    local ypos = ScrH() * 0.85
    local function addSpace() ypos = (ypos - height) - 1 end

    -- I do this in opposite order so it can accend in height instead.
    MainMenuButton( "Disconnect", xpos, ypos, width, height, frame_spawnmenu, function()
        RunConsoleCommand("disconnect")
    end)
    addSpace()

    MainMenuButton( "Settings", xpos, ypos, width, height, frame_spawnmenu, function()
        RunConsoleCommand("as_settings")
        input.SetCursorPos( ScrW() / 2, ScrH() / 2)
    end)
    addSpace()

    MainMenuButton( "Start Playing", xpos, ypos, width, height, frame_spawnmenu, function()
        RunConsoleCommand("as_characters")
        frame_spawnmenu:Close()
        if IsValid( frame_settings ) then frame_settings:Close() end
    end)
end