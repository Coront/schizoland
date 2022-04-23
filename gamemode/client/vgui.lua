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
    button.Paint = function(self, w, h)
        local thickness = 1
        local gap = 0
        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, thickness)
        if self:IsHovered() then
            surface.SetDrawColor( COLHUD_DEFAULT )
            button:SetColor( COLHUD_SECONDARY )
            if not self.HoveredOnce then
                surface.PlaySound( UICUE.HOVER )
                self.HoveredOnce = true
            end
        else
            if self.HoveredOnce then
                self.HoveredOnce = false
            end
            surface.SetDrawColor( COLHUD_SECONDARY )
            button:SetColor( COLHUD_DEFAULT )
        end
        surface.DrawRect( thickness + gap, thickness + gap, w - ((thickness + gap) * 2), h - ((thickness + gap) * 2) )
    end
end

function CharacterIcon( model, x, y, width, height, parent, callback )
	local Icon = vgui.Create( "DModelPanel", parent )
	Icon:SetPos(x, y)
	Icon:SetSize(width, height)
	Icon:SetFOV(5.6)
	Icon:SetModel(model)
    local eyepos = Icon.Entity:GetBonePosition(Icon.Entity:LookupBone("ValveBiped.Bip01_Head1")) or Vector(0,0,0)
	Icon:SetLookAt( eyepos )
	Icon:SetCamPos( eyepos - Vector(-120,0,-10) )
    Icon.Entity:SetEyeTarget(eyepos-Vector(0, -6, -2))
	Icon:SetAnimated( false )
    Icon.LayoutEntity = function() return end
    if callback then
        Icon.DoClick = function()
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
    button.DoClick = function()
        surface.PlaySound("buttons/button15.wav")
        callback()
    end
    button.Paint = function(_, w, h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end
end

function DefaultButton( text, x, y, width, height, parent, callback )
    local button = vgui.Create("DButton")
    if parent then button:SetParent(parent) end
    button:SetSize(width, height)
    button:SetPos(x, y)
    button:SetFont("AftershockButtonSmall")
    button:SetText( text )
    button.DoClick = function()
        surface.PlaySound("buttons/button15.wav")
        callback()
    end
end

function SectionLabel( text, x, y, parent )
    local label = vgui.Create("DLabel", parent)
    label:SetFont( "AftershockButton" )
    label:SetText(text)
    label:SetPos(x, y)
    label:SizeToContents()
end

function SmallLabel( text, x, y, parent )
    local label = vgui.Create("DLabel", parent)
    label:SetFont( "TargetID" )
    label:SetText(text)
    label:SetPos(x, y)
    label:SizeToContents()
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
end

function DefaultButton( text, x, y, width, height, parent, callback )
    local button = vgui.Create("DButton")
    if parent then button:SetParent(parent) end
    button:SetSize(width, height)
    button:SetPos(x, y)
    button:SetText( text )
    button.DoClick = function()
        surface.PlaySound("buttons/button15.wav")
        callback()
    end
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
    frame_verify.Paint = function(_,w,h)
		draw.RoundedBox( 8, 0, 0, w, h, COLHUD_PRIMARY)
    end

	local infotext = vgui.Create("DLabel", frame_verify)
	local txt = "Are you sure you want to do this?\n"
	if critical then txt = txt .. "THERE IS NO RETURNING FROM THIS!" end
	infotext:SetContentAlignment(5)
    infotext:SetText(txt)
    infotext:SizeToContents()
    infotext:SetPos( frame_verify:GetWide() / 2 - infotext:GetWide() / 2, frame_verify:GetTall() * 0.4)

	local yes = vgui.Create("DButton", frame_verify)
    yes:SetSize(100, 20)
    yes:SetPos(frame_verify:GetWide() * 0.075, (frame_verify:GetTall() - yes:GetTall()) * 0.9)
	yes:SetText("Yes")
    yes.DoClick = function()
        surface.PlaySound(UICUE.ACCEPT)
		if callback then
			callback()
		end
		frame_verify:Close()
    end

	local no = vgui.Create("DButton", frame_verify)
    no:SetSize(100, 20)
    no:SetPos((frame_verify:GetWide() - no:GetWide()) * 0.9, (frame_verify:GetTall() - yes:GetTall()) * 0.9)
	no:SetText("No")
    no.DoClick = function()
        surface.PlaySound(UICUE.DECLINE)
		frame_verify:Close()
    end
end

function VerifySlider( max, callback )
	if IsValid(frame_verifyslider) then frame_verifyslider:Close() end

	frame_verifyslider = vgui.Create("DFrame")
	frame_verifyslider:SetSize(300, 150)
    frame_verifyslider:Center()
    frame_verifyslider:MakePopup()
    frame_verifyslider:SetDraggable( false )
    frame_verifyslider:SetTitle( "" )
    frame_verifyslider:ShowCloseButton( false )
    frame_verifyslider.Paint = function(_,w,h)
		draw.RoundedBox( 8, 0, 0, w, h, COLHUD_PRIMARY)
    end

	local closebutton = vgui.Create("DButton", frame_verifyslider)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_verifyslider:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_verifyslider) then
            frame_verifyslider:Close()
        end
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
	slider:SetDark( true )

	local accept = vgui.Create("DButton", frame_verifyslider)
    accept:SetSize(100, 20)
    accept:SetPos(frame_verifyslider:GetWide() / 2 - (accept:GetWide() / 2), (frame_verifyslider:GetTall() - accept:GetTall()) * 0.9)
	accept:SetText("Accept")
    accept.DoClick = function()
        surface.PlaySound( UICUE.ACCEPT )
		if callback then
			callback( slider:GetValue() )
		end
		frame_verifyslider:Close()
    end
end