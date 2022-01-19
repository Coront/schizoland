--  ██████╗██╗             ██╗███╗   ██╗██╗████████╗
-- ██╔════╝██║             ██║████╗  ██║██║╚══██╔══╝
-- ██║     ██║             ██║██╔██╗ ██║██║   ██║
-- ██║     ██║             ██║██║╚██╗██║██║   ██║
-- ╚██████╗███████╗███████╗██║██║ ╚████║██║   ██║
--  ╚═════╝╚══════╝╚══════╝╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝
-- Desc: Mainly initialization

include("shared.lua")

for k, v in pairs( file.Find("aftershock/gamemode/client/*.lua", "LUA") ) do
	include("client/" .. v)
end

timer.Create( "as_autosave", 300, 0, function()
	LocalPlayer():ChatPrint("Auto Saving...")
	LocalPlayer():ConCommand("as_save")
end)

function Verify( callback )
	if IsValid(frame_verify) then frame_verify:Close() end

	frame_verify = vgui.Create("DFrame")
	frame_verify:SetSize(300, 200)
    frame_verify:Center()
    frame_verify:MakePopup()
    frame_verify:SetDraggable( false )
    frame_verify:SetTitle( "" )
    frame_verify:ShowCloseButton( false )
    frame_verify.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawRect( 0, 0, w, h )
    end

	local infotext = vgui.Create("DLabel", frame_verify)
    infotext:SetText("Are you sure you want to do this?\n")
    infotext:SizeToContents()
	infotext:SetContentAlignment(5)
    infotext:SetPos( frame_verify:GetWide() / 2 - infotext:GetWide() / 2, frame_verify:GetTall() / 2.5)

	local yes = vgui.Create("DButton", frame_verify)
    yes:SetSize(100, 20)
    yes:SetPos(30, frame_verify:GetTall() * 0.8)
	yes:SetText("Yes")
    yes.DoClick = function()
        surface.PlaySound("buttons/button15.wav")
		if callback then
			callback()
		end
		frame_verify:Close()
    end

	local no = vgui.Create("DButton", frame_verify)
    no:SetSize(100, 20)
    no:SetPos((frame_verify:GetWide() - no:GetWide()) - 30, frame_verify:GetTall() * 0.8)
	no:SetText("No")
    no.DoClick = function()
        surface.PlaySound("buttons/button15.wav")
		frame_verify:Close()
    end
end

function VerifyAmount( callback )
	if IsValid(frame_verifyamount) then frame_verifyamount:Close() end

	frame_verifyamount = vgui.Create("DFrame")
	frame_verifyamount:SetSize(300, 200)
    frame_verifyamount:Center()
    frame_verifyamount:MakePopup()
    frame_verifyamount:SetDraggable( false )
    frame_verifyamount:SetTitle( "" )
    frame_verifyamount:ShowCloseButton( true )
    frame_verifyamount.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawRect( 0, 0, w, h )
    end

	local infotext = vgui.Create("DLabel", frame_verifyamount)
    infotext:SetText("Select an amount.\n")
    infotext:SizeToContents()
	infotext:SetContentAlignment(5)
    infotext:SetPos( frame_verifyamount:GetWide() / 2 - infotext:GetWide() / 2, frame_verifyamount:GetTall() / 2.5)

	local confirm = vgui.Create("DButton", frame_verifyamount)
    confirm:SetSize(100, 20)
    confirm:SetPos(30, frame_verifyamount:GetTall() * 0.8)
	confirm:SetText("Confirm")
    confirm.DoClick = function()
        surface.PlaySound("buttons/button15.wav")
		if callback then
			callback()
		end
		frame_verifyamount:Close()
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