AS.CharacterSelect = {}
CharacterSelectOpen = false

-- ███╗   ███╗███████╗███╗   ██╗██╗   ██╗
-- ████╗ ████║██╔════╝████╗  ██║██║   ██║
-- ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
-- ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
-- ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
-- ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝

function AS.CharacterSelect.Menu()
    if IsValid(frame_characters) then frame_characters:Close() end
    if IsValid(CharacterNew) then CharacterNew:Remove() end
    if LocalPlayer():IsLoaded() then LocalPlayer():ChatPrint("You have already loaded a character. Relog to switch characters.") return end

    selectedChar = nil

    frame_characters = vgui.Create("DFrame")
    frame_characters:SetSize(500, ScrH())
    frame_characters:SetPos(0, 0)
    frame_characters:MakePopup()
    frame_characters:SetDraggable( false )
    frame_characters:SetTitle( "" )
    frame_characters:ShowCloseButton( false )
    frame_characters.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    scroll_characters = vgui.Create("DScrollPanel", frame_characters)
    scroll_characters:SetPos(5, 5)
    scroll_characters:SetSize(frame_characters:GetWide() - 10, frame_characters:GetTall() - 65)
    scroll_characters.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)
    end

    loading_characters = vgui.Create("DLabel", scroll_characters)
    loading_characters:SetFont("AftershockText")
    loading_characters:SetText("Loading Characters...")
    loading_characters:SizeToContents()
    loading_characters:SetPos( scroll_characters:GetWide() / 2 - loading_characters:GetWide() / 2, scroll_characters:GetTall() / 2)

    net.Start("as_characters_requestdata")
    net.SendToServer()

    function frame_characters:OnClose()
        CharacterSelectOpen = false
    end
end
concommand.Add("as_characters", AS.CharacterSelect.Menu)

function AS.CharacterSelect.NewCharacter( new )
    local frame_newcharacter = vgui.Create("DFrame")
    frame_newcharacter:SetSize(500, ScrH())
    frame_newcharacter:SetPos(0, 0)
    frame_newcharacter:MakePopup()
    frame_newcharacter:SetDraggable( false )
    frame_newcharacter:SetTitle( "" )
    frame_newcharacter:ShowCloseButton( false )
    frame_newcharacter.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local scroll = vgui.Create("DScrollPanel", frame_newcharacter)
    scroll:SetPos(10, 10)
    scroll:SetSize(frame_characters:GetWide() - 20, frame_characters:GetTall() - 125)
    scroll.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)
    end

    if not new then --I use this to id new players, but its the same thing if a player doesnt have any characters.
        Button( "< Back", 0, frame_newcharacter:GetTall() - 40, 100, 40, frame_newcharacter, function()
            frame_newcharacter:Close()
            CharacterNew:Remove()
            RunConsoleCommand("as_characters")
        end)
    end

    local name = scroll:Add("DTextEntry")
    name:SetPlaceholderText("Enter your character's name.")
    name:SetValue("")
    name:SetSize( 400, 20 )
    name:SetPos(scroll:GetWide() / 2 - name:GetWide() / 2, 50 )

    local nameinfo = scroll:Add("DLabel")
    nameinfo:SetSize(400, 70)
    nameinfo:SetPos(scroll:GetWide() / 2 - nameinfo:GetWide() / 2, 70 )
    nameinfo:SetWrap(true)
    nameinfo:SetText("Remember that the name you enter will be displayed to other players on the game. This name cannot contain special characters or numbers. Please also make sure that your name is appropriate for everyone.\n\nYou will not be able to change your name freely.")

    local modellist = scroll:Add("DListView")
    modellist:SetSize(400, 150)
    modellist:SetPos( scroll:GetWide() / 2 - modellist:GetWide() / 2, 175)
    modellist:SetMultiSelect( false )
    modellist:AddColumn( "Models" )
    for k, v in SortedPairs(SET.SelectableModels) do
        modellist:AddLine(k)
    end
    local _, selectedModel = table.Random(SET.SelectableModels)
    function modellist:OnRowSelected( _, row )
        selectedModel = row:GetValue(1)
        surface.PlaySound(UICUE.SELECT)
    end

    local modelinfo = scroll:Add("DLabel")
    modelinfo:SetSize(400, 55)
    modelinfo:SetPos(scroll:GetWide() / 2 - modelinfo:GetWide() / 2, 330 )
    modelinfo:SetWrap(true)
    modelinfo:SetText("Your character model will be your physical appearance to other players on the game.\n\nYou will not be able to freely change your character model.")

    local tutorial = scroll:Add("DCheckBoxLabel")
    tutorial:SetText("Enable Tutorial (WIP)")
    tutorial:SizeToContents()
    tutorial:SetPos((scroll:GetWide() / 2) - (tutorial:GetWide() / 2), 410)

    local tutorialinfo = scroll:Add("DLabel")
    tutorialinfo:SetText("The tutorial offers to players an explaination on certain basics of the game. It is recommended to have this turned on if you are new entirely, as some systems may be complicated.")
    tutorialinfo:SetSize(400, 60)
    tutorialinfo:SetPos((scroll:GetWide() / 2) - (tutorialinfo:GetWide() / 2), 425 )
    tutorialinfo:SetWrap(true)
--[[
    local hardcore = scroll:Add("DCheckBoxLabel")
    hardcore:SetPos(scroll:GetWide() / 2 - hardcore:GetWide() / 2, 500)
    hardcore:SetText("Hardcore Mode")
    hardcore:SizeToContents()

    local hardcoreinfo = scroll:Add("DLabel")
    hardcoreinfo:SetSize(400, 165)
    hardcoreinfo:SetPos(scroll:GetWide() / 2 - hardcoreinfo:GetWide() / 2, 525 )
    hardcoreinfo:SetWrap(true)
    hardcoreinfo:SetText("nil")
]]
    local button = vgui.Create("DButton", frame_newcharacter)
    button:SetSize(200, 50)
    button:SetPos(frame_newcharacter:GetWide() / 2 - button:GetWide() / 2, frame_newcharacter:GetTall() * 0.9)
    button:SetFont("AftershockButtonSmall")
    button.DoClick = function()
        surface.PlaySound("buttons/button15.wav")
        frame_newcharacter:Close()
        CharacterNew:Remove()
        net.Start("as_characters_finishcharacter")
            net.WriteString(name:GetValue())
            net.WriteString(selectedModel)
        net.SendToServer()
    end
    button.Paint = function(_, w, h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end
    button.Think = function()
        if string.len(name:GetValue()) < SET.MinNameLength and button:IsEnabled() then
            button:SetEnabled( false )
            button:SetText("Enter a name.")
        elseif string.len(name:GetValue()) >= SET.MinNameLength and not button:IsEnabled() then
            button:SetEnabled( true )
            button:SetText("Finish")
        end
    end

    CharacterNew = vgui.Create( "DModelPanel" )
    CharacterNew:SetSize(ScrW() - 500, ScrH())
    CharacterNew:SetPos(500, 0)
    CharacterNew:SetFOV( 40 )
    CharacterNew:SetModel(selectedModel)
    local eyepos = CharacterNew.Entity:GetBonePosition(CharacterNew.Entity:LookupBone("ValveBiped.Bip01_Head1")) or Vector(0,0,0)
    eyepos:Add(Vector(0,0,-20))
	CharacterNew:SetLookAt( eyepos )
    CharacterNew:SetCamPos( eyepos - Vector(-170,0,0) )
    CharacterNew.Angles = Angle( 0, 70, 90 )
    function CharacterNew:DragMousePress()
        self.PressX, self.PressY = gui.MousePos()
        self.Pressed = true
    end
    function CharacterNew:DragMouseRelease()
        self.Pressed = false
    end
    function CharacterNew:LayoutEntity( Entity )
        Entity:SetEyeTarget(Entity:GetForward() * 20 + Entity:GetUp() * 70)
        if ( self.Pressed ) then
            local mx, my = gui.MousePos()
            self.Angles = self.Angles - Angle( 0, ( self.PressX or mx ) - mx, 0 )

            self.PressX, self.PressY = gui.MousePos()
        end
        Entity:SetPos(Vector(0,0,5))
        Entity:SetAngles( self.Angles + Angle(0,-100,-90) )
    end
    function CharacterNew:Think()
        if self:GetModel() != selectedModel then
            self:SetModel(selectedModel)
        end
    end
end

-- ██████╗ ██╗   ██╗██╗██╗     ██████╗ ███████╗
-- ██╔══██╗██║   ██║██║██║     ██╔══██╗██╔════╝
-- ██████╔╝██║   ██║██║██║     ██║  ██║███████╗
-- ██╔══██╗██║   ██║██║██║     ██║  ██║╚════██║
-- ██████╔╝╚██████╔╝██║███████╗██████╔╝███████║
-- ╚═════╝  ╚═════╝ ╚═╝╚══════╝╚═════╝ ╚══════╝

function AS.CharacterSelect.BuildCharacters( characters, chardata )
    for k, v in pairs(characters) do
        if k == 1 then selectedChar = v.pid end

        local panel = scroll_characters:Add( "DButton" )
        panel:SetTall( 85 )
        panel:Dock( TOP )
        panel:DockMargin( 3, 3, 3, 0 )
        panel:SetText("")
        panel.Paint = function(_,w,h)
            if selectedChar and selectedChar == v.pid then
                surface.SetDrawColor( COLHUD_GOOD )
            else
                surface.SetDrawColor( COLHUD_PRIMARY )
            end
            surface.DrawRect( 0, 0, w, h )
        end
        function panel:DoClick()
            selectedChar = v.pid
            surface.PlaySound(UICUE.SELECT)
        end

        CharacterIcon( v.model, 5, 5, 75, 75, panel, function() panel.DoClick() end)

        local name = vgui.Create("DLabel", panel)
        name:SetPos( 85, 0 )
        name:SetFont("AftershockText")
        name:SetText(v.name)
        name:SizeToContents()

        local health = vgui.Create("DLabel", panel)
        health:SetPos( 85, 20 )
        health:SetFont("AftershockText")
        local hp = chardata[v.pid] and chardata[v.pid].health or "char?health"
        health:SetText("Health: " .. hp)
        health:SizeToContents()

        local experience = vgui.Create("DLabel", panel)
        experience:SetPos( 85, 40 )
        experience:SetFont("AftershockText")
        local exp = chardata[v.pid] and chardata[v.pid].exp or "char?exp"
        experience:SetText("Experience: " .. exp)
        experience:SizeToContents()

        local playtime = vgui.Create("DLabel", panel)
        playtime:SetPos( 85, 60 )
        playtime:SetFont("AftershockText")
        local pt = chardata[v.pid] and chardata[v.pid].playtime or "char?playtime"
        if pt == "NULL" then
            playtime:SetText("Playtime: None")
        else
            playtime:SetText("Playtime: " .. GetPlaytimeHourMin( pt ) )
        end
        playtime:SizeToContents()
    end
end

function AS.CharacterSelect.BuildButtons(characters)
    local xpos = 5
    local ypos = frame_characters:GetTall() - 55
    local function addSpace()
        xpos = xpos + 165
    end

    Button( "Select Character", xpos, ypos, 160, 50, frame_characters, function()
        frame_characters:Close()
        Character:Remove()
        net.Start("as_characters_loadcharacter")
            net.WriteInt(selectedChar, 32)
        net.SendToServer()
    end)
    addSpace()

    if #characters >= SET.MaxCharacters then
        Button( "Max Characters", xpos, ypos, 160, 50, frame_characters, function() end)
    else
        Button( "New Character", xpos, ypos, 160, 50, frame_characters, function()
            frame_characters:Close()
            Character:Remove()
            AS.CharacterSelect.NewCharacter()
        end)
    end
    addSpace()

    Button( "Delete Character", xpos, ypos, 160, 50, frame_characters, function()
        Verify(function()
            net.Start("as_characters_deletecharacter")
                net.WriteInt(selectedChar, 32)
            net.SendToServer()
            frame_characters:Close()
            Character:Remove()
        end, true)
    end)
end

function AS.CharacterSelect.BuildCharacterDisplay( characters )
    if IsValid(Character) then Character:Remove() end
    local realchars = {}
    for k, v in pairs( characters ) do
        realchars[v.pid] = {}
        realchars[v.pid].model = v.model
    end
    Character = vgui.Create( "DModelPanel" )
    Character:SetSize(ScrW() - 500, ScrH())
    Character:SetPos(500, 0)
    Character:SetFOV( 40 )
    Character:SetModel(realchars[selectedChar].model)
    local eyepos = Character.Entity:GetBonePosition(Character.Entity:LookupBone("ValveBiped.Bip01_Head1")) or Vector(0,0,0)
    eyepos:Add(Vector(0,0,-20))
	Character:SetLookAt( eyepos )
    Character:SetCamPos( eyepos - Vector(-170,0,0) )
    Character.Angles = Angle( 0, 70, 90 )
    function Character:DragMousePress()
        self.PressX, self.PressY = gui.MousePos()
        self.Pressed = true
    end
    function Character:DragMouseRelease()
        self.Pressed = false
    end
    function Character:LayoutEntity( Entity )
        Entity:SetEyeTarget(Entity:GetForward() * 20 + Entity:GetUp() * 70)
        if ( self.Pressed ) then
            local mx, my = gui.MousePos()
            self.Angles = self.Angles - Angle( 0, ( self.PressX or mx ) - mx, 0 )

            self.PressX, self.PressY = gui.MousePos()
        end
        Entity:SetPos(Vector(0,0,5))
        Entity:SetAngles( self.Angles + Angle(0,-100,-90) )
    end
    function Character:Think()
        if realchars and realchars[selectedChar] and self:GetModel() != realchars[selectedChar].model then
            self:SetModel(realchars[selectedChar].model)
        end
    end
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

function AS.CharacterSelect.ReceiveCharacters()
    local hasChar = tobool(net.ReadBit())

    if hasChar then
        local characters = net.ReadTable()
        local data = net.ReadTable()
        loading_characters:Remove()
        AS.CharacterSelect.BuildCharacters( characters, data )
        AS.CharacterSelect.BuildButtons( characters )
        AS.CharacterSelect.BuildCharacterDisplay( characters )
    else
        frame_characters:Close()
        AS.CharacterSelect.NewCharacter( true )
    end
end
net.Receive("as_characters_senddata", AS.CharacterSelect.ReceiveCharacters)