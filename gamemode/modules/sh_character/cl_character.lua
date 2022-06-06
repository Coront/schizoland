AS.CharacterSelect = {}

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
    function frame_characters:Paint( w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    scroll_characters = vgui.Create("DScrollPanel", frame_characters)
    scroll_characters:SetPos(2, 2)
    scroll_characters:SetSize(frame_characters:GetWide() - 4, frame_characters:GetTall() - 64)
    function scroll_characters:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    loading_characters = vgui.Create("DLabel", scroll_characters)
    loading_characters:SetFont("AftershockText")
    loading_characters:SetText("Loading Characters...")
    loading_characters:SizeToContents()
    loading_characters:SetPos( scroll_characters:GetWide() / 2 - loading_characters:GetWide() / 2, scroll_characters:GetTall() / 2)

    net.Start("as_characters_requestdata")
    net.SendToServer()
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
    function frame_newcharacter:Paint( w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local scroll = vgui.Create("DScrollPanel", frame_newcharacter)
    scroll:SetPos(2, 2)
    scroll:SetSize(frame_characters:GetWide() - 4, frame_characters:GetTall() - 60)
    function scroll:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    if not new then --I use this to id new players, but its the same thing if a player doesnt have any characters.
        Button( "< Back", 25, frame_newcharacter:GetTall() - 50, 100, 40, frame_newcharacter, function()
            frame_newcharacter:Close()
            CharacterNew:Remove()
            RunConsoleCommand("as_characters")
        end)
    end

    SectionLabel( "Name", 5, 5, scroll )

    local name = scroll:Add("DTextEntry")
    name:SetPlaceholderText("Enter your character's name.")
    name:SetValue("")
    name:SetSize( 480, 20 )
    name:SetPos(scroll:GetWide() / 2 - name:GetWide() / 2, 35 )

    local nameinfo = scroll:Add("DLabel")
    nameinfo:SetSize(480, 70)
    nameinfo:SetPos(scroll:GetWide() / 2 - nameinfo:GetWide() / 2, 50 )
    nameinfo:SetWrap(true)
    nameinfo:SetText("The name you enter will be displayed to other players on the game. This name cannot contain special characters or numbers. Please also make sure that your name is appropriate for everyone.\n\nYou will not be able to freely change your name after creation.")

    SectionLabel( "Appearance", 5, 140, scroll )

    local modellist = scroll:Add("DListView")
    modellist:SetSize(480, 150)
    modellist:SetPos( scroll:GetWide() / 2 - modellist:GetWide() / 2, 175)
    modellist:SetMultiSelect( false )
    modellist:AddColumn( "Clothes" )
    for k, v in SortedPairsByMemberValue(AS.CharacterModels, "name") do
        modellist:AddLine(v.name)
    end
    local _, selectedModel = table.Random(AS.CharacterModels)
    function modellist:OnRowSelected( _, row )
        selectedModel = FindModelByName( row:GetValue(1) )
        surface.PlaySound(UICUE.SELECT)
    end

    local modelinfo = scroll:Add("DLabel")
    modelinfo:SetSize(480, 65)
    modelinfo:SetPos(scroll:GetWide() / 2 - modelinfo:GetWide() / 2, 330 )
    modelinfo:SetWrap(true)
    modelinfo:SetText("Your selected appearance will be what you look like to other players. This will also be your default clothing when you are not wearing any armor. You can preview your appearance in the character panel to the right.\n\nYou will not be able to freely change your appearance after creation.")

    SectionLabel( "Class", 5, 420, scroll )

    local selectedClass = "mercenary"

    local classdesc = scroll:Add("DLabel")
    classdesc:SetSize(480, 100)
    classdesc:SetPos(scroll:GetWide() / 2 - classdesc:GetWide() / 2, 555 )
    classdesc:SetWrap(true)
    classdesc:SetText( "Selected Class: " .. translateClassNameID( selectedClass ) .. "\n\n" .. AS.Classes[selectedClass].desc )

    local classlist = scroll:Add("DListView")
    classlist:SetSize(480, 103)
    classlist:SetPos( scroll:GetWide() / 2 - classlist:GetWide() / 2, 450)
    classlist:SetMultiSelect( false )
    classlist:AddColumn( "Classes" )
    for k, v in SortedPairs(AS.Classes) do
        classlist:AddLine(v.name)
    end
    function classlist:OnRowSelected( _, row )
        selectedClass = translateClassNameID( row:GetValue(1) )
        surface.PlaySound(UICUE.SELECT)
        classdesc:SetText( "Selected Class: " .. translateClassNameID( selectedClass ) .. "\n\n" .. AS.Classes[selectedClass].desc )
    end

    local button = vgui.Create("DButton", frame_newcharacter)
    button:SetSize(200, 50)
    button:SetPos(frame_newcharacter:GetWide() / 2 - button:GetWide() / 2, frame_newcharacter:GetTall() - 55)
    button:SetFont("AftershockButtonSmall")
    button.DoClick = function()
        surface.PlaySound("buttons/button15.wav")
        frame_newcharacter:Close()
        CharacterNew:Remove()
        net.Start("as_characters_finishcharacter")
            net.WriteString(name:GetValue())
            net.WriteString(selectedModel)
            net.WriteString(selectedClass)
        net.SendToServer()
    end
    function button:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end
    function button:Think()
        if string.len(name:GetValue()) < SET.MinNameLength and button:IsEnabled() then
            button:SetEnabled( false )
            button:SetText("Enter a name.")
        elseif string.len(name:GetValue()) > SET.MaxNameLength and button:IsEnabled() then
            button:SetEnabled( false )
            button:SetText("Name is too long.")
        elseif string.len(name:GetValue()) >= SET.MinNameLength and string.len(name:GetValue()) <= SET.MaxNameLength and not button:IsEnabled() then
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
        function panel:Paint( w, h )
            local thickness = 1
            local gap = 0
            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawOutlinedRect( 0, 0, w, h, thickness)

            self.IntColor = self.IntColor or COLHUD_SECONDARY
            self.TxtColor = self.TxtColor or COLHUD_DEFAULT
            local fadeSpeed = 500

            if self:IsHovered() or selectedChar == v.pid then

                local col = self.IntColor:ToTable()
                local toCol = COLHUD_DEFAULT:ToTable()
                col[1] = math.Approach( col[1], toCol[1], FrameTime() * fadeSpeed )
                col[2] = math.Approach( col[2], toCol[2], FrameTime() * fadeSpeed )
                col[3] = math.Approach( col[3], toCol[3], FrameTime() * fadeSpeed )
                self.IntColor = Color( col[1], col[2], col[3], 255 )

                if not self.HoveredOnce then
                    self.HoveredOnce = true
                end
                surface.SetDrawColor( self.IntColor )

                local txtcol = self.TxtColor:ToTable()
                local txtToCol = COLHUD_SECONDARY:ToTable()
                txtcol[1] = math.Approach( txtcol[1], txtToCol[1], FrameTime() * fadeSpeed )
                txtcol[2] = math.Approach( txtcol[2], txtToCol[2], FrameTime() * fadeSpeed )
                txtcol[3] = math.Approach( txtcol[3], txtToCol[3], FrameTime() * fadeSpeed )
                self.TxtColor = Color( txtcol[1], txtcol[2], txtcol[3], 255 )

                self:SetColor( self.TxtColor )

            else

                local col = self.IntColor:ToTable()
                local toCol = COLHUD_SECONDARY:ToTable()
                col[1] = math.Approach( col[1], toCol[1], FrameTime() * fadeSpeed )
                col[2] = math.Approach( col[2], toCol[2], FrameTime() * fadeSpeed )
                col[3] = math.Approach( col[3], toCol[3], FrameTime() * fadeSpeed )
                self.IntColor = Color( col[1], col[2], col[3], 255 )

                if self.HoveredOnce then
                    self.HoveredOnce = false
                end
                surface.SetDrawColor( self.IntColor )

                local txtcol = self.TxtColor:ToTable()
                local txtToCol = COLHUD_DEFAULT:ToTable()
                txtcol[1] = math.Approach( txtcol[1], txtToCol[1], FrameTime() * fadeSpeed )
                txtcol[2] = math.Approach( txtcol[2], txtToCol[2], FrameTime() * fadeSpeed )
                txtcol[3] = math.Approach( txtcol[3], txtToCol[3], FrameTime() * fadeSpeed )
                self.TxtColor = Color( txtcol[1], txtcol[2], txtcol[3], 255 )

                self:SetColor( self.TxtColor )

            end
            surface.DrawRect( thickness + gap, thickness + gap, w - ((thickness + gap) * 2), h - ((thickness + gap) * 2) )
        end
        function panel:DoClick()
            selectedChar = v.pid
            surface.PlaySound(UICUE.SELECT)
        end

        CharacterIcon( v.model, 5, 5, 75, 75, panel, function() 
            panel.DoClick() 
        end,
        AS.Classes[v.class].color)

        local name = vgui.Create("DLabel", panel)
        name:SetPos( 85, 0 )
        name:SetFont("AftershockText")
        name:SetText(v.name)
        name:SizeToContents()

        local class = vgui.Create("DLabel", panel)
        class:SetPos( 85, 20 )
        class:SetFont("AftershockText")
        class:SetText( translateClassNameID( chardata[v.pid].class ) )
        class:SetColor( AS.Classes[ chardata[v.pid].class ].color )
        class:SizeToContents()

        local health = vgui.Create("DLabel", panel)
        health:SetPos( 85, 40 )
        health:SetFont("AftershockText")
        local hp = chardata[v.pid] and chardata[v.pid].health or "char?health"
        health:SetText("Health: " .. hp)
        health:SizeToContents()

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
    local xpos = 2
    local ypos = frame_characters:GetTall() - 60
    local width = 164
    local height = 58
    local function addSpace()
        xpos = xpos + width + 2
    end

    Button( "Select Character", xpos, ypos, width, height, frame_characters, function()
        frame_characters:Close()
        Character:Remove()
        net.Start("as_characters_loadcharacter")
            net.WriteUInt(selectedChar, NWSetting.UIDAmtBits)
        net.SendToServer()
    end)
    addSpace()

    if #characters >= SET.MaxCharacters then
        Button( "Max Characters", xpos, ypos, width, height, frame_characters, function() end)
    else
        Button( "New Character", xpos, ypos, width, height, frame_characters, function()
            frame_characters:Close()
            Character:Remove()
            AS.CharacterSelect.NewCharacter()
        end)
    end
    addSpace()

    Button( "Delete Character", xpos, ypos, width, height, frame_characters, function()
        Verify(function()
            net.Start("as_characters_deletecharacter")
                net.WriteUInt(selectedChar, NWSetting.UIDAmtBits)
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