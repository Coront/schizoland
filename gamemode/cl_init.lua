--  ██████╗██╗     ██╗███████╗███╗   ██╗████████╗███████╗██╗██████╗ ███████╗    ██╗███╗   ██╗██╗████████╗██╗ █████╗ ██╗     ██╗███████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
-- ██╔════╝██║     ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝██║██╔══██╗██╔════╝    ██║████╗  ██║██║╚══██╔══╝██║██╔══██╗██║     ██║╚══███╔╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
-- ██║     ██║     ██║█████╗  ██╔██╗ ██║   ██║   ███████╗██║██║  ██║█████╗      ██║██╔██╗ ██║██║   ██║   ██║███████║██║     ██║  ███╔╝ ███████║   ██║   ██║██║   ██║██╔██╗ ██║
-- ██║     ██║     ██║██╔══╝  ██║╚██╗██║   ██║   ╚════██║██║██║  ██║██╔══╝      ██║██║╚██╗██║██║   ██║   ██║██╔══██║██║     ██║ ███╔╝  ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
-- ╚██████╗███████╗██║███████╗██║ ╚████║   ██║   ███████║██║██████╔╝███████╗    ██║██║ ╚████║██║   ██║   ██║██║  ██║███████╗██║███████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
--  ╚═════╝╚══════╝╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝╚═════╝ ╚══════╝    ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   ╚═╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

include("shared.lua")

for k, v in pairs( file.Find("aftershock/gamemode/client/*.lua", "LUA") ) do
	include("client/" .. v)
end

CreateClientConVar( "as_gameplay_verify", "1", true, false )

timer.Create( "as_autosave", 300, 0, function()
	if LocalPlayer():IsLoaded() then
		LocalPlayer():ChatPrint("Auto Saving...")
		LocalPlayer():ConCommand("as_save")
	end
end)

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

function GM:OnPlayerChat( ply, txt, team, dead )
	local tab = {}

	if ( IsValid( ply ) ) then
		table.insert( tab, COLHUD_DEFAULT )
		table.insert( tab, ply:Nickname() )
		table.insert( tab, color_white )
		table.insert( tab, ": " .. txt )
	else
		table.insert( tab, Color( 0, 180, 195 ) )
		table.insert( tab, txt )
	end

	chat.AddText( unpack(tab) )

	return true
end

COLHUD_DEFAULT = Color(GetConVar("as_hud_color_default_r"):GetInt(), GetConVar("as_hud_color_default_g"):GetInt(), GetConVar("as_hud_color_default_b"):GetInt(), 255) or Color(255,255,255,255)
COLHUD_GOOD = Color(GetConVar("as_hud_color_good_r"):GetInt(), GetConVar("as_hud_color_good_g"):GetInt(), GetConVar("as_hud_color_good_b"):GetInt(), 255) or Color(255,255,255,255)
COLHUD_BAD = Color(GetConVar("as_hud_color_bad_r"):GetInt(), GetConVar("as_hud_color_bad_g"):GetInt(), GetConVar("as_hud_color_bad_b"):GetInt(), 255) or Color(255,255,255,255)

surface.CreateFont( "AftershockTitle", {
    font 		= "TargetID",
	extended 	= false,
	size 		= 100,
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

surface.CreateFont( "AftershockHUD", {
    font 		= "TargetID",
	extended 	= false,
	size 		= 24,
	weight 		= 400,
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

surface.CreateFont( "AftershockHUDVerySmall", {
    font 		= "TargetID",
	extended 	= false,
	size 		= 11,
	weight 		= 400,
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