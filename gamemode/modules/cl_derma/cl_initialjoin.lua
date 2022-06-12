CreateClientConVar("as_acknowledgerules", "0", true, true)

function FirstJoinMenu()
    if IsValid(frame_firstjoinverify) then frame_firstjoinverify:Close() end
    if tobool(GetConVar("as_acknowledgerules"):GetInt()) then return end

    frame_firstjoinverify = vgui.Create("DFrame")
    frame_firstjoinverify:SetSize( 500, 400 )
    frame_firstjoinverify:Center()
    frame_firstjoinverify:MakePopup()
    frame_firstjoinverify:SetDraggable( false )
    frame_firstjoinverify:SetTitle( "" )
    frame_firstjoinverify:ShowCloseButton( false )
    function frame_firstjoinverify:Paint( w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    local scroll = vgui.Create("DScrollPanel", frame_firstjoinverify)
    scroll:SetPos( 5, 5 )
    scroll:SetSize( frame_firstjoinverify:GetWide() - 10, frame_firstjoinverify:GetTall() - 50 )
    function scroll:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

local lg = [[
Welcome to Aftershock! Please read this before continuing, as it will only ever appear once!

Aftershock is a semi-serious roleplay gamemode built off of PostNukeRP's concept. This server, while being heavily customized and built off its own base, still has rules in place that all players are required to follow.

Here is a quick rundown of the basic rules:
- Do not initiate random deathmatch (RDM) with other players without a valid reason.
- Treat other players with respect.
- Harassment will not be tolerated.
- Do not abuse bugs or exploits.
- Use of clientside scripts or cheats is forbidden.
- Trading in-game items for real-world contents will result in a permanent ban.
- Do not disconnect from active situations.

These rules do NOT represent all of the rules. This is to just to help players quickly jump into the game. We ask that you at some point educate yourself on all of the rules. There is a link below if you wish to do that at this moment. You may also access the rules by typing /rules in chat.
]]

    local text = vgui.Create("DLabel", scroll)
    text:SetText( lg )
    text:SetPos( 10, 10 )
    text:SetWide( scroll:GetWide() - 35 )
    text:SetWrap( true )
    text:SetAutoStretchVertical( true )

    local link = vgui.Create("DLabelURL", scroll)
    link:SetText( "Open Rules" )
    link:SetURL( GAMEMODE.Rules )
    link:SetPos( 10, scroll:GetTall() - 90 )
    link:SetSize( 100, 20 )
    link:SetColor( COLHUD_DEFAULT )

    local toggle = ToggleButton( "I understand the rules.", 10, scroll:GetTall() - 25, scroll, "as_acknowledgerules" )

    local button = vgui.Create("DButton", frame_firstjoinverify)
    button:SetPos( 5, scroll:GetTall() + 10 )
    button:SetSize( scroll:GetWide(), 25 )
    button:SetText( "Please read the message and check the box to continue." )
    button:SetEnabled( false )
    function button:DoClick()
        surface.PlaySound("buttons/button15.wav")
        frame_firstjoinverify:Close()
        RunConsoleCommand("as_spawnmenu")
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
    function button:Think()
        if tobool(GetConVar("as_acknowledgerules"):GetInt()) and not self:IsEnabled() then
            self:SetEnabled( true )
            self:SetText("Close and Start Playing")
        elseif self:IsEnabled() and not tobool(GetConVar("as_acknowledgerules"):GetInt()) then
            self:SetEnabled( false )
            self:SetText( "Please read the message and check the box to continue." )
        end
    end
end
concommand.Add( "as_firstjoinmenu", FirstJoinMenu )