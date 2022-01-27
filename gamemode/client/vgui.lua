function MainMenuButton( text, x, y, width, height, parent, callback )
    local button = vgui.Create("DButton", parent)
    button:SetSize(width, height)
    button:SetPos(x, y)
    button:SetFont("AftershockButton")
    button:SetText( text )
    button:SetColor( COLHUD_SECONDARY )
    button.DoClick = function()
        surface.PlaySound("buttons/button15.wav")
        callback()
    end
    button.Paint = function(self, w, h)
        local thickness = 1
        local gap = 1
        surface.SetDrawColor( COLHUD_TERTIARY )
        surface.DrawOutlinedRect( 0, 0, w, h, thickness)
        if self:IsHovered() then
            surface.SetDrawColor( COLHUD_TERTIARY )
        else
            surface.SetDrawColor( COLHUD_DEFAULT )
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

function SectionLabel( text, x, y, parent )
    local label = vgui.Create("DLabel", parent)
    label:SetFont( "AftershockButton" )
    label:SetText(text)
    label:SetPos(x, y)
    label:SizeToContents()
end

function SmallLabel( text, x, y, parent )
    local label = vgui.Create("DLabel", parent)
    label:SetFont( "AftershockText" )
    label:SetText(text)
    label:SetPos(x, y)
    label:SizeToContents()
end

function ValueSlider( text, x, y, min, max, parent, convar, color )
    local slider = vgui.Create("DNumSlider", parent)
    slider:SetPos( x, y )
    slider:SetSize( 300, 15 )
    slider:SetText("")
    slider:SetMin(min)
    slider:SetMax(max)
    slider:SetDecimals( 0 )
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