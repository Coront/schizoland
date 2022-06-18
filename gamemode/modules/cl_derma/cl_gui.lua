-- ███████╗ ██████╗ ███╗   ██╗████████╗███████╗
-- ██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝██╔════╝
-- █████╗  ██║   ██║██╔██╗ ██║   ██║   ███████╗
-- ██╔══╝  ██║   ██║██║╚██╗██║   ██║   ╚════██║
-- ██║     ╚██████╔╝██║ ╚████║   ██║   ███████║
-- ╚═╝      ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚══════╝

surface.CreateFont( "AftershockTitle", {
	font 		= "TargetID",
	extended 	= false,
	size 		= 102,
	weight 		= 1000,
	blursize 	= 0,
	scanlines 	= 0,
	antialias 	= false,
	underline 	= false,
	italic 		= false,
	strikeout 	= false,
	symbol 		= false,
	rotary 		= false,
	shadow 		= true,
	additive 	= false,
	outline 	= true,
})

surface.CreateFont( "AftershockButton", {
	font 		= "TargetID",
	extended 	= false,
	size 		= 30,
	weight 		= 1000,
	blursize 	= 0,
	scanlines 	= 0,
	antialias 	= true,
	underline 	= false,
	italic 		= false,
	strikeout 	= false,
	symbol 		= false,
	rotary 		= false,
	shadow 		= false,
	additive 	= false,
	outline 	= false,
})

surface.CreateFont( "AftershockButtonSmall", {
	font 		= "TargetID",
	extended 	= false,
	size 		= 21,
	weight 		= 1000,
	blursize 	= 0,
	scanlines 	= 0,
	antialias 	= true,
	underline 	= false,
	italic 		= false,
	strikeout 	= false,
	symbol 		= false,
	rotary 		= false,
	shadow 		= false,
	additive 	= false,
	outline 	= false,
})

surface.CreateFont( "AftershockText", {
	font 		= "TargetID",
	extended 	= false,
	size 		= 20,
	weight 		= 1000,
	blursize 	= 0,
	scanlines 	= 0,
	antialias 	= true,
	underline 	= false,
	italic 		= false,
	strikeout 	= false,
	symbol 		= false,
	rotary 		= false,
	shadow 		= false,
	additive 	= false,
	outline 	= false,
})

-- ██████╗ ███████╗██████╗ ███╗   ███╗ █████╗
-- ██╔══██╗██╔════╝██╔══██╗████╗ ████║██╔══██╗
-- ██║  ██║█████╗  ██████╔╝██╔████╔██║███████║
-- ██║  ██║██╔══╝  ██╔══██╗██║╚██╔╝██║██╔══██║
-- ██████╔╝███████╗██║  ██║██║ ╚═╝ ██║██║  ██║
-- ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝

function MainMenuButton( text, x, y, width, height, parent, callback )
    local button = vgui.Create("DButton", parent)
    button:SetSize(width, height)
    button:SetPos(x, y)
    button:SetFont("AftershockButton")
    button:SetText( text )
    button.DoClick = function()
        surface.PlaySound( UICUE.PRESS )
        callback()
    end
    button.HoveredOnce = false
    function button:Paint(w, h)
        local thickness = 1
        local gap = 0
        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, thickness)

        self.IntColor = self.IntColor or COLHUD_SECONDARY
        self.TxtColor = self.TxtColor or COLHUD_DEFAULT
        local fadeSpeed = 500

        if self:IsHovered() then

            local col = self.IntColor:ToTable()
            local toCol = COLHUD_DEFAULT:ToTable()
            col[1] = math.Approach( col[1], toCol[1], FrameTime() * fadeSpeed )
            col[2] = math.Approach( col[2], toCol[2], FrameTime() * fadeSpeed )
            col[3] = math.Approach( col[3], toCol[3], FrameTime() * fadeSpeed )
            self.IntColor = Color( col[1], col[2], col[3], 255 )

            if not self.HoveredOnce then
                surface.PlaySound( UICUE.HOVER )
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
end

function CharacterIcon( model, x, y, width, height, parent, callback, bgcol )
    local bgpanel = vgui.Create("DPanel", parent)
    bgpanel:SetPos( x, y )
    bgpanel:SetSize( width, height )
    function bgpanel:Paint( w, h )
        bgcol = bgcol or COLHUD_DEFAULT

        local col = bgcol:ToTable()
        surface.SetDrawColor( col[1], col[2], col[3], 25 )
        surface.DrawRect( 0, 0, w, h )
    
        surface.SetDrawColor( col[1], col[2], col[3], col[4] )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

	local Icon = vgui.Create( "DModelPanel", bgpanel )
	Icon:SetPos( 1, 1 )
	Icon:SetSize(width - 2, height - 2)
	Icon:SetFOV(5.6)
	Icon:SetModel(model)
    local eyepos = IsValid( Icon.Entity ) and Icon.Entity:LookupBone("ValveBiped.Bip01_Head1") != nil and Icon.Entity:GetBonePosition(Icon.Entity:LookupBone("ValveBiped.Bip01_Head1")) or Vector(0,0,0)
	Icon:SetLookAt( eyepos )
	Icon:SetCamPos( eyepos - Vector(-120,0,-10) )
    Icon.Entity:SetEyeTarget(eyepos-Vector(0, -6, -2))
	Icon:SetAnimated( false )
    function Icon:LayoutEntity() end
    if callback then
        function Icon:DoClick() 
            callback()
        end
    end
end

function Button( text, x, y, width, height, parent, callback )
    local button = vgui.Create("DButton")
    if parent then button:SetParent(parent) end
    button:SetSize(width, height)
    button:SetPos(x, y)
    button:SetFont("AftershockButtonSmall")
    button:SetText( text )
    function button:DoClick()
        surface.PlaySound("buttons/button15.wav")
        callback()
    end
    function button:Paint(w, h)
        local thickness = 1
        local gap = 0
        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, thickness)

        self.IntColor = self.IntColor or COLHUD_SECONDARY
        self.TxtColor = self.TxtColor or COLHUD_DEFAULT
        local fadeSpeed = 500

        if self:IsHovered() then

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
end

function SectionLabel( text, x, y, parent )
    local label = vgui.Create("DLabel", parent)
    label:SetFont( "AftershockButton" )
    label:SetText(text)
    label:SetPos(x, y)
    label:SizeToContents()
end

function SmallLabel( text, x, y, parent, color )
    local label = vgui.Create("DLabel", parent)
    label:SetFont( "TargetID" )
    label:SetText(text)
    label:SetPos(x, y)
    label:SizeToContents()
    label:SetColor( color or Color( 255, 255, 255 ) )
end

function ValueSlider( text, x, y, min, max, parent, convar, color, decimals )
    local slider = vgui.Create("DNumSlider", parent)
    slider:SetPos( x, y )
    slider:SetSize( 300, 15 )
    slider:SetText("")
    slider:SetMin(min)
    slider:SetMax(max)
    slider:SetDecimals( decimals and 1 or 0 )
    slider:SetConVar( convar )

    local label = vgui.Create("DLabel", parent)
    label:SetText(text)
    label:SetPos(x, y)
    label:SizeToContents()
    label.Think = function()
        local setcolor = color == "good" and COLHUD_GOOD or color == "default" and COLHUD_DEFAULT or color == "bad" and COLHUD_BAD or Color(200, 200, 200)
        label:SetColor(setcolor)
    end
end

function ToggleButton( text, x, y, parent, convar )
    local checkbox = vgui.Create("DCheckBox", parent)
    checkbox:SetPos( x, y )
    checkbox:SetConVar( convar )

    local label = vgui.Create("DLabel", parent)
    label:SetText(text)
    label:SetPos(x + 20, y)
    label:SizeToContents()

    return checkbox
end

function DefaultButton( text, x, y, width, height, parent, callback )
    local button = vgui.Create("DButton")
    if parent then button:SetParent(parent) end
    button:SetSize(width, height)
    button:SetPos(x, y)
    button:SetText( text )
    function button:DoClick()
        surface.PlaySound("buttons/button15.wav")
        callback( self )
    end
    function button:Paint( w, h )
        if self:IsEnabled() then
            if self:IsHovered() then
                surface.SetDrawColor( COLHUD_DEFAULT )
                self:SetColor( COLHUD_SECONDARY )
            else
                surface.SetDrawColor( COLHUD_SECONDARY )
                self:SetColor( COLHUD_DEFAULT )
            end
        else
            surface.SetDrawColor( Color( 60, 60, 60 ) )
            self:SetColor( COLHUD_BAD )
        end
        surface.DrawRect( 0, 0, w, h )

        if self:IsEnabled() then
            surface.SetDrawColor( COLHUD_DEFAULT )
        else
            surface.SetDrawColor( COLHUD_BAD )
        end
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    return button
end

function KeyBind( text, x, y, parent, convar )
    local binder = vgui.Create("DBinder", parent)
    binder:SetSize( 100, 20 )
    binder:SetPos( x, y )
    binder:SetValue( input.GetKeyCode(GetConVarString(convar)) )
    function binder:OnChange( button )
        if GetKeyName( button ) == "MOUSE1" or GetKeyName( button ) == "MOUSE2" or GetKeyName( button ) == "MOUSE3" or GetKeyName( button ) == "MWHEELUP" or GetKeyName( button ) == "MWHEELDOWN" or GetKeyName( button ) == "`" then 
            LocalPlayer():ChatPrint("You cannot bind to '" .. GetKeyName( button ) .. "', as it may cause confliction issues.")
            button = 0
            binder:SetValue( button )
            return
        end 
        RunConsoleCommand( convar, GetKeyName(button) )
    end

    local label = vgui.Create("DLabel", parent)
    label:SetText(text)
    label:SetPos(x + 110, y + 2)
    label:SizeToContents()
end

function ToggleButtonFunction( text, x, y, parent, startvalue, callback )
    startvalue = startvalue or false

    local checkbox = vgui.Create("DCheckBox", parent)
    checkbox:SetPos( x, y )
    checkbox:SetValue( startvalue )
    function checkbox:OnChange( bool )
        bool = ToConValue( bool )
        callback( bool )
    end

    local label = vgui.Create("DLabel", parent)
    label:SetText(text)
    label:SetPos(x + 20, y)
    label:SizeToContents()
end

function Verify( callback, critical ) --Critical is for some actions that are absolutely permanent that players should be foreced to acknowledge, like deleting your character.
	critical = critical or false
	if tobool(GetConVar("as_gameplay_verify"):GetInt()) == false and not critical then 
		if callback then 
			callback() 
		end 
		return 
	end

	if IsValid(frame_verify) then frame_verify:Close() end

	frame_verify = vgui.Create("DFrame")
	frame_verify:SetSize(300, 150)
    frame_verify:Center()
    frame_verify:MakePopup()
    frame_verify:SetDraggable( false )
    frame_verify:SetTitle( "" )
    frame_verify:ShowCloseButton( false )
    function frame_verify:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

	local infotext = vgui.Create("DLabel", frame_verify)
	local txt = "Are you sure you want to do this?\n"
	if critical then txt = txt .. "THERE IS NO RETURNING FROM THIS!" end
	infotext:SetContentAlignment(5)
    infotext:SetText(txt)
    infotext:SizeToContents()
    infotext:SetPos( frame_verify:GetWide() / 2 - infotext:GetWide() / 2, frame_verify:GetTall() * 0.4)

    local width, height, space = 100, 20, 25
    DefaultButton( "Yes", space, frame_verify:GetTall() - 35, width, height, frame_verify, function()
		if callback then
			callback()
		end
		frame_verify:Close()
    end)

    DefaultButton( "No", frame_verify:GetWide() - width - space, frame_verify:GetTall() - 35, width, height, frame_verify, function()
		frame_verify:Close()
    end)
end

function VerifySlider( max, callback )
	if IsValid(frame_verifyslider) then frame_verifyslider:Close() end

	frame_verifyslider = vgui.Create("DFrame")
	frame_verifyslider:SetSize(300, 150)
    frame_verifyslider:Center()
    frame_verifyslider:MakePopup()
    frame_verifyslider:SetDraggable( false )
    frame_verifyslider:SetTitle( "" )
    frame_verifyslider:ShowCloseButton( true )
    function frame_verifyslider:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

	local infotext = vgui.Create("DLabel", frame_verifyslider)
	infotext:SetText("Select an amount.")
	infotext:SizeToContents()
	infotext:SetContentAlignment(5)
	infotext:SetPos( frame_verifyslider:GetWide() / 2 - infotext:GetWide() / 2, frame_verifyslider:GetTall() * 0.3)

	local slider = vgui.Create("DNumSlider", frame_verifyslider)
	slider:SetSize( 250, 20 )
	slider:SetPos( frame_verifyslider:GetWide() / 2 - (slider:GetWide() / 2), frame_verifyslider:GetTall() / 2 - (slider:GetTall() / 2) )
	slider:SetText( "Amount" )
	slider:SetValue( 1 )
	slider:SetMin( 1 )
	slider:SetMax( max )
	slider:SetDecimals( 0 )
	slider:SetDark( false )

    local width, height = 150, 20
    DefaultButton( "Accept", frame_verifyslider:GetWide() / 2 - (width / 2), frame_verifyslider:GetTall() - height - 15, width, height, frame_verifyslider, function()
		if callback then
			callback( math.Round( slider:GetValue() ) )
		end
		frame_verifyslider:Close()
    end)
end

function ResPack()
	if IsValid(frame_respack) then frame_respack:Close() end

	frame_respack = vgui.Create("DFrame")
	frame_respack:SetSize(300, 200)
    frame_respack:Center()
    frame_respack:MakePopup()
    frame_respack:SetDraggable( false )
    frame_respack:SetTitle( "" )
    frame_respack:ShowCloseButton( true )
    function frame_respack:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

	local infotext = vgui.Create("DLabel", frame_respack)
	infotext:SetText("Select an amount to drop.")
	infotext:SizeToContents()
	infotext:SetContentAlignment(5)
	infotext:SetPos( frame_respack:GetWide() / 2 - infotext:GetWide() / 2, 40)

	local scrap = vgui.Create("DNumSlider", frame_respack)
	scrap:SetSize( 250, 20 )
	scrap:SetPos( frame_respack:GetWide() / 2 - (scrap:GetWide() / 2), 75 )
	scrap:SetText( "Scrap" )
	scrap:SetValue( 0 )
	scrap:SetMin( 0 )
	scrap:SetMax( LocalPlayer():GetInventory()["misc_scrap"] )
	scrap:SetDecimals( 0 )
	scrap:SetDark( false )

    local sp = vgui.Create("DNumSlider", frame_respack)
	sp:SetSize( 250, 20 )
	sp:SetPos( frame_respack:GetWide() / 2 - (sp:GetWide() / 2), 100 )
	sp:SetText( "Small Parts" )
	sp:SetValue( 0 )
	sp:SetMin( 0 )
	sp:SetMax( LocalPlayer():GetInventory()["misc_smallparts"] )
	sp:SetDecimals( 0 )
	sp:SetDark( false )

    local chem = vgui.Create("DNumSlider", frame_respack)
	chem:SetSize( 250, 20 )
	chem:SetPos( frame_respack:GetWide() / 2 - (chem:GetWide() / 2), 125 )
	chem:SetText( "Chemicals" )
	chem:SetValue( 0 )
	chem:SetMin( 0 )
	chem:SetMax( LocalPlayer():GetInventory()["misc_chemical"] )
	chem:SetDecimals( 0 )
	chem:SetDark( false )

    local width, height = 150, 20
    DefaultButton( "Accept", frame_respack:GetWide() / 2 - (width / 2), frame_respack:GetTall() - height - 15, width, height, frame_respack, function()
        net.Start("as_inventory_droprespack")
            net.WriteUInt( scrap:GetValue(), NWSetting.ItemAmtBits )
            net.WriteUInt( sp:GetValue(), NWSetting.ItemAmtBits )
            net.WriteUInt( chem:GetValue(), NWSetting.ItemAmtBits )
        net.SendToServer()
		frame_respack:Close()
    end)
end

function SimplePanel( parent, width, height, x, y, color )
    local panel = vgui.Create("DPanel", parent)
    panel:SetPos( x, y )
    panel:SetSize( width, height )
    panel.Paint = function( _, w, h )
        surface.SetDrawColor( color or Color(255, 255, 255) )
        surface.DrawRect( 0, 0, w, h )
    end

    return panel
end

function SimpleLabel( parent, text, x, y, font )
    font = font or "DermaDefault"
    local label = vgui.Create("DLabel", parent )
    label:SetPos( x, y )
    label:SetFont( font )
    label:SetText( text )
    label:SizeToContents()

    return label
end

function SimpleSpawnIcon( parent, model, size, x, y, tooltip, callback )
    local spawnicon = vgui.Create("SpawnIcon", parent )
    spawnicon:SetModel( model )
    spawnicon:SetPos( x, y )
    spawnicon:SetSize( size, size )
    spawnicon:SetTooltip( tooltip )
    spawnicon.DoClick = function()
        if callback then
            surface.PlaySound("buttons/button15.wav")
            callback()
        end
    end

    return spawnicon
end

function SimpleItemIcon( parent, item, size, x, y, tooltip, callback )
    local spawnicon = vgui.Create("SpawnIcon", parent )
    spawnicon:SetModel( AS.Items[item].model )
    spawnicon:SetSkin( AS.Items[item].skin or 0 )
    spawnicon:SetPos( x, y )
    spawnicon:SetSize( size, size )
    spawnicon:SetTooltip( tooltip )
    spawnicon.DoClick = function()
        if callback then
            surface.PlaySound("buttons/button15.wav")
            callback()
        end
    end

    return spawnicon
end

function SimpleTextEntry( parent, phtext, sizex, sizey, x, y, callback )
    local entry = vgui.Create("DTextEntry", parent)
    entry:SetPlaceholderText( phtext )
    entry:SetSize( sizex, sizey )
    entry:SetPos( x, y )
    entry.OnEnter = function( self, text )
        if callback then
            callback( text )
        end
    end

    return entry
end

function SimpleButton( parent, text, width, height, x, y, callback )
    local button = vgui.Create("DButton", parent)
    button:SetSize(width, height)
    button:SetPos(x, y)
    button:SetText( text )
    button.DoClick = function()
        surface.PlaySound("buttons/button15.wav")
        callback()
    end

    return button
end

function SimpleScroll( parent, width, height, x, y, color )
    local scroll = vgui.Create("DScrollPanel", parent)
    scroll:SetSize( width, height )
    scroll:SetPos( x, y )
    scroll.Paint = function( _, w, h )
        surface.SetDrawColor( color or Color( 255, 255, 255 ) )
        surface.DrawRect( 0, 0, w, h )
    end

    return scroll
end

function SimpleIconLayout( parent, width, height, x, y, color )
    local list = vgui.Create("DIconLayout", parent)
    list:SetPos( x, y )
    list:SetSize( width, height )
    list:SetSpaceY( 5 )
    list:SetSpaceX( 5 )
    list.Paint = function( _, w, h )
        surface.SetDrawColor( color or Color( 255, 255, 255, 255 ) )
        surface.DrawRect( 0, 0, w, h )
    end

    return list
end

function SimpleLayoutPanel( parent, width, height, x, y, color )
    local panel = parent:Add("DPanel")
    panel:SetPos( x, y )
    panel:SetSize( width, height )
    panel.Paint = function( _, w, h )
        surface.SetDrawColor( color or Color(255, 255, 255) )
        surface.DrawRect( 0, 0, w, h )
    end

    return panel
end

function SimpleSlider( parent, text, width, height, x, y, min, max, decimal )
    local slider = vgui.Create( "DNumSlider", parent )
    slider:SetPos( x, y )
    slider:SetSize( width, height )
    slider:SetText( text )
    slider:SetMin( min )
    slider:SetMax( max )
    slider:SetValue( 0 )
    slider:SetDecimals( decimal and 1 or 0 )

    return slider
end

function SimpleWang( parent, width, height, x, y, min, max, decimal )
    local wang = vgui.Create( "DNumberWang", parent )
    wang:SetPos( x, y )
    wang:SetSize( width, height )
    wang:SetMin( min )
    wang:SetMax( max )
    wang:SetValue( 1 )
    wang:SetDecimals( decimal and 1 or 0 )
    wang.Think = function( self )
        if self:GetValue() > self:GetMax() then
            self:SetValue( self:GetMax() )
        end
        if self:GetValue() < self:GetMin() then
            self:SetValue( self:GetMin() )
        end
    end

    return wang
end

-- ███╗   ██╗███████╗██╗    ██╗    ██████╗ ███████╗██████╗ ███╗   ███╗ █████╗
-- ████╗  ██║██╔════╝██║    ██║    ██╔══██╗██╔════╝██╔══██╗████╗ ████║██╔══██╗
-- ██╔██╗ ██║█████╗  ██║ █╗ ██║    ██║  ██║█████╗  ██████╔╝██╔████╔██║███████║
-- ██║╚██╗██║██╔══╝  ██║███╗██║    ██║  ██║██╔══╝  ██╔══██╗██║╚██╔╝██║██╔══██║
-- ██║ ╚████║███████╗╚███╔███╔╝    ██████╔╝███████╗██║  ██║██║ ╚═╝ ██║██║  ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚══╝╚══╝     ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝

function CreateCloseButton( parent, size, x, y )
    local button = vgui.Create("DButton", parent)
    button:SetSize( size, size )
    button:SetPos( x, y )
    button:SetFont("TargetID")
    button:SetText("")
    function button:Paint( w, h )
        surface.SetMaterial( Material("gui/aftershock/button/close.png") )
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.DrawTexturedRect( 0, 0, w, h )
    end
    function button:DoClick()
        if IsValid(button:GetParent()) then
            button:GetParent():Close()
        end
    end

    return button
end

function CreateSheetPanel( parent, width, height, x, y, color )
    color = color or Color( 255, 255, 255, 0 )

    local sheet = vgui.Create("DPropertySheet", parent)
    sheet:SetPos( x, y )
    sheet:SetFadeTime( 0.2 )
    sheet:SetSize( width, height )
    function sheet:Paint( w, h )
        surface.SetDrawColor( color )
        surface.DrawRect( 0, 0, w, h )
    end

    return sheet
end
function AddSheet( parent, name, icon, child )
    parent:AddSheet(name, child, icon)
end

function CreateComboBox( parent, width, height, x, y, placeholder, options )
    local combo = vgui.Create("DComboBox", parent)
    combo:SetPos( x, y )
    combo:SetSize( width, height )
    combo:SetValue( placeholder )
    function combo:OnSelect( self, index, value )
        options[index]()
    end

    for k, v in pairs( options ) do
        combo:AddChoice( k )
    end
end