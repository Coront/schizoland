function CreateCommunity()
	if IsValid(frame_createcommunity) then frame_createcommunity:Close() end

	frame_createcommunity = vgui.Create("DFrame")
	frame_createcommunity:SetSize(300, 150)
    frame_createcommunity:Center()
    frame_createcommunity:MakePopup()
    frame_createcommunity:SetDraggable( false )
    frame_createcommunity:SetTitle( "" )
    frame_createcommunity:ShowCloseButton( false )
    frame_createcommunity.Paint = function(_,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, COLHUD_PRIMARY)
		draw.RoundedBox( 0, 5, 25, w - 10, h - 30, COLHUD_SECONDARY )
    end

	local closebutton = vgui.Create("DButton", frame_createcommunity)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_createcommunity:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_createcommunity) then
            frame_createcommunity:Close()
        end
    end

	local infotext = vgui.Create("DLabel", frame_createcommunity)
	infotext:SetText("Enter a community name and description.")
	infotext:SizeToContents()
	infotext:SetContentAlignment(5)
	infotext:SetPos( frame_createcommunity:GetWide() / 2 - infotext:GetWide() / 2, frame_createcommunity:GetTall() * 0.3)

    local entry = vgui.Create("DTextEntry", frame_createcommunity)
    entry:SetSize( 250, 20 )
    entry:SetPos( frame_createcommunity:GetWide() / 2 - entry:GetWide() / 2, 65)
    entry:SetPlaceholderText("Enter a name for your community.")

    local desc = vgui.Create("DTextEntry", frame_createcommunity)
    desc:SetSize( 250, 20 )
    desc:SetPos( frame_createcommunity:GetWide() / 2 - entry:GetWide() / 2, 85)
    desc:SetPlaceholderText("Enter a description (Can remain empty).")

	local accept = vgui.Create("DButton", frame_createcommunity)
    accept:SetSize(200, 20)
    accept:SetPos(frame_createcommunity:GetWide() / 2 - (accept:GetWide() / 2), (frame_createcommunity:GetTall() - accept:GetTall()) * 0.9)
    accept.DoClick = function()
        surface.PlaySound( UICUE.ACCEPT )
        net.Start("as_community_create")
            net.WriteString(entry:GetText())
            net.WriteString(desc:GetText())
        net.SendToServer()
		frame_createcommunity:Close()
    end
    accept.Think = function()
        if string.len(entry:GetValue()) < SET.MinNameLength and accept:IsEnabled() then
            accept:SetEnabled( false )
            accept:SetText("Enter a community name.")
        elseif string.len(entry:GetValue()) >= SET.MinNameLength and not accept:IsEnabled() then
            accept:SetEnabled( true )
            accept:SetText("Create Community")
        end
    end
end

function ChangeTitle( memberdata )
	if IsValid(frame_communitychangetitle) then frame_communitychangetitle:Close() end

	frame_communitychangetitle = vgui.Create("DFrame")
	frame_communitychangetitle:SetSize(300, 150)
    frame_communitychangetitle:Center()
    frame_communitychangetitle:MakePopup()
    frame_communitychangetitle:SetDraggable( false )
    frame_communitychangetitle:SetTitle( "" )
    frame_communitychangetitle:ShowCloseButton( false )
    frame_communitychangetitle.Paint = function(_,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, COLHUD_PRIMARY)
		draw.RoundedBox( 0, 5, 25, w - 10, h - 30, COLHUD_SECONDARY )
    end

	local closebutton = vgui.Create("DButton", frame_communitychangetitle)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_communitychangetitle:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_communitychangetitle) then
            frame_communitychangetitle:Close()
        end
    end

	local infotext = vgui.Create("DLabel", frame_communitychangetitle)
	infotext:SetText("Change " .. memberdata.name .. "'s title")
	infotext:SizeToContents()
	infotext:SetContentAlignment(5)
	infotext:SetPos( frame_communitychangetitle:GetWide() / 2 - infotext:GetWide() / 2, frame_communitychangetitle:GetTall() * 0.3)

    local entry = vgui.Create("DTextEntry", frame_communitychangetitle)
    entry:SetSize( 250, 20 )
    entry:SetPos( frame_communitychangetitle:GetWide() / 2 - entry:GetWide() / 2, 65)
    entry:SetPlaceholderText("Enter a new title")

	local accept = vgui.Create("DButton", frame_communitychangetitle)
    accept:SetSize(200, 20)
    accept:SetPos(frame_communitychangetitle:GetWide() / 2 - (accept:GetWide() / 2), (frame_communitychangetitle:GetTall() - accept:GetTall()) * 0.9)
    accept.DoClick = function()
        surface.PlaySound( UICUE.ACCEPT )
        net.Start( "as_community_changetitle" )
            net.WriteUInt( memberdata.pid, NWSetting.UIDAmtBits )
            net.WriteString( entry:GetText() )
        net.SendToServer()
		frame_communitychangetitle:Close()
    end
    accept.Think = function()
        if string.len(entry:GetValue()) < 1 and accept:IsEnabled() then
            accept:SetEnabled( false )
            accept:SetText("Enter a new title.")
        elseif string.len(entry:GetValue()) >= 1 and not accept:IsEnabled() then
            accept:SetEnabled( true )
            accept:SetText("Set Title")
        end
    end
end

function CreateRank()
	if IsValid(frame_communitycreaterank) then frame_communitycreaterank:Close() end

	frame_communitycreaterank = vgui.Create("DFrame")
	frame_communitycreaterank:SetSize(350, 275)
    frame_communitycreaterank:Center()
    frame_communitycreaterank:MakePopup()
    frame_communitycreaterank:SetDraggable( false )
    frame_communitycreaterank:SetTitle( "" )
    frame_communitycreaterank:ShowCloseButton( false )
    frame_communitycreaterank.Paint = function(_,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, COLHUD_PRIMARY)
		draw.RoundedBox( 0, 5, 25, w - 10, h - 30, COLHUD_SECONDARY )
    end

	local closebutton = vgui.Create("DButton", frame_communitycreaterank)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_communitycreaterank:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_communitycreaterank) then
            frame_communitycreaterank:Close()
        end
    end

    local entry = vgui.Create("DTextEntry", frame_communitycreaterank)
    entry:SetSize( 300, 20 )
    entry:SetPos( frame_communitycreaterank:GetWide() / 2 - entry:GetWide() / 2, 40)
    entry:SetPlaceholderText("Enter a rank name")

    local prohibited = vgui.Create("DListView", frame_communitycreaterank)
	prohibited:SetSize(140, 140)
	prohibited:SetPos(10, 80)
	prohibited:AddColumn("Prohibitions")
	for k, v in SortedPairs( SET.CommunitiesPerms ) do
		prohibited:AddLine( v.name )
	end
	prohibited.OnRowSelected = function( _, row, pnl )
		selectedPerm = pnl:GetColumnText(1)
		selectedRow = row
		unpermit = false
	end

	local permitted = vgui.Create("DListView", frame_communitycreaterank)
	permitted:SetSize(140, 140)
	permitted:SetPos(frame_communitycreaterank:GetWide() - (permitted:GetWide() + 10), 80)
	permitted:AddColumn("Permissions")
	permitted.OnRowSelected = function( _, row, pnl )
		selectedPerm = pnl:GetColumnText(1)
		selectedRow = row
		unpermit = true
	end

	local swap = vgui.Create("DButton", frame_communitycreaterank)
	swap:SetSize(35, 35)
	swap:SetPos(frame_communitycreaterank:GetWide() / 2 - swap:GetWide() / 2, 130)
	swap:SetText(">")
	swap:SetEnabled(false)
	swap.Think = function()
		if selectedPerm and not swap:IsEnabled() then
			swap:SetEnabled(true)
		end
		if unpermit and swap:GetText() != "<" then
			swap:SetText("<")
		end
		if not unpermit and swap:GetText() != ">" then
			swap:SetText(">")
		end
	end
	swap.DoClick = function()
		if selectedPerm and selectedRow then
			if not unpermit then --We are going to give permission
				prohibited:RemoveLine(selectedRow)
				permitted:AddLine(selectedPerm)
				selectedPerm = nil 
				selectedRow = nil 
				unpermit = nil
				swap:SetEnabled(false)
			else --We are going to revoke permission
				permitted:RemoveLine(selectedRow)
				prohibited:AddLine(selectedPerm)
				selectedPerm = nil 
				selectedRow = nil 
				unpermit = nil
				swap:SetEnabled(false)
			end
		end
	end

	local accept = vgui.Create("DButton", frame_communitycreaterank)
    accept:SetSize(200, 20)
    accept:SetPos(frame_communitycreaterank:GetWide() / 2 - (accept:GetWide() / 2), (frame_communitycreaterank:GetTall() - accept:GetTall()) * 0.93)
    accept.DoClick = function()
        local perms = {}
        for k, v in pairs( permitted:GetLines() ) do
            perms[ translatePermNameID(v:GetValue(1)) ] = true
        end
        surface.PlaySound( UICUE.ACCEPT )
        net.Start( "as_community_createrank" )
            net.WriteString( entry:GetText() )
            net.WriteTable( perms )
        net.SendToServer()
		frame_communitycreaterank:Close()
    end
    accept.Think = function()
        if string.len(entry:GetValue()) < 1 and accept:IsEnabled() then
            accept:SetEnabled( false )
            accept:SetText("Enter a rank name.")
        elseif string.len(entry:GetValue()) >= 1 and not accept:IsEnabled() then
            accept:SetEnabled( true )
            accept:SetText("Create Rank")
        end
    end
end

function ModifyRankSelect()
    if IsValid(frame_communitymodifyrankselect) then frame_communitymodifyrankselect:Close() end

    frame_communitymodifyrankselect = vgui.Create("DFrame")
	frame_communitymodifyrankselect:SetSize(350, 275)
    frame_communitymodifyrankselect:Center()
    frame_communitymodifyrankselect:MakePopup()
    frame_communitymodifyrankselect:SetDraggable( false )
    frame_communitymodifyrankselect:SetTitle( "" )
    frame_communitymodifyrankselect:ShowCloseButton( false )
    frame_communitymodifyrankselect.Paint = function(_,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, COLHUD_PRIMARY)
		draw.RoundedBox( 0, 5, 25, w - 10, h - 30, COLHUD_SECONDARY )
    end

	local closebutton = vgui.Create("DButton", frame_communitymodifyrankselect)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_communitymodifyrankselect:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_communitymodifyrankselect) then
            frame_communitymodifyrankselect:Close()
        end
    end

    frame_communitymodifyrankselectloading = vgui.Create("DLabel", frame_communitymodifyrankselect)
	frame_communitymodifyrankselectloading:SetText( "Fetching Ranks List..." )
	frame_communitymodifyrankselectloading:SizeToContents()
	frame_communitymodifyrankselectloading:SetContentAlignment(5)
	frame_communitymodifyrankselectloading:SetPos( frame_communitymodifyrankselect:GetWide() / 2 - frame_communitymodifyrankselectloading:GetWide() / 2, frame_communitymodifyrankselect:GetTall() * 0.5)

    net.Start("as_community_requestranks")
        net.WriteBit( true )
    net.SendToServer()
end

net.Receive( "as_community_sendranksmodify", function()
    local tbl = net.ReadTable()

    if not IsValid(frame_communitymodifyrankselect) then return end

    frame_communitymodifyrankselectloading:Remove()

    local function translateRankNameID( name )
        for k, v in pairs( tbl ) do
            if v.name == name then
                return k
            end
        end
    end

    local selectedRank
    local selectedRankName

    local ranks = vgui.Create("DListView", frame_communitymodifyrankselect)
	ranks:SetSize(330, 205)
	ranks:SetPos(10, 30)
	ranks:AddColumn("Ranks")
	for k, v in SortedPairs( tbl ) do
        if v.nomodify then continue end
		ranks:AddLine( v.name )
	end
	ranks.OnRowSelected = function( _, row, pnl )
		selectedRank = translateRankNameID( pnl:GetColumnText(1) )
		selectedRankName = pnl:GetColumnText(1)
	end

    local accept = vgui.Create("DButton", frame_communitymodifyrankselect)
    accept:SetSize(330, 25)
    accept:SetPos(frame_communitymodifyrankselect:GetWide() / 2 - (accept:GetWide() / 2), 240)
    accept.DoClick = function()
        surface.PlaySound( UICUE.ACCEPT )
        ModifyRank( selectedRank )
		frame_communitymodifyrankselect:Close()
    end
    accept.Think = function()
        if not selectedRank and accept:IsEnabled() then
            accept:SetEnabled( false )
            accept:SetText("Select a rank.")
        elseif selectedRank and not accept:IsEnabled() then
            accept:SetEnabled( true )
        end

        if accept:IsEnabled() then
            accept:SetText("Modify " .. selectedRankName)
        end
    end
end)

function ModifyRank( rankid )
	if IsValid(frame_communitymodifyrank) then frame_communitymodifyrank:Close() end

	frame_communitymodifyrank = vgui.Create("DFrame")
	frame_communitymodifyrank:SetSize(350, 275)
    frame_communitymodifyrank:Center()
    frame_communitymodifyrank:MakePopup()
    frame_communitymodifyrank:SetDraggable( false )
    frame_communitymodifyrank:SetTitle( "" )
    frame_communitymodifyrank:ShowCloseButton( false )
    frame_communitymodifyrank.Paint = function(_,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, COLHUD_PRIMARY)
		draw.RoundedBox( 0, 5, 25, w - 10, h - 30, COLHUD_SECONDARY )
    end

	local closebutton = vgui.Create("DButton", frame_communitymodifyrank)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_communitymodifyrank:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_communitymodifyrank) then
            frame_communitymodifyrank:Close()
        end
    end

    local entry = vgui.Create("DTextEntry", frame_communitymodifyrank)
    entry:SetSize( 300, 20 )
    entry:SetPos( frame_communitymodifyrank:GetWide() / 2 - entry:GetWide() / 2, 40)
    entry:SetPlaceholderText("Enter a new rank name")

    local prohibited = vgui.Create("DListView", frame_communitymodifyrank)
	prohibited:SetSize(140, 140)
	prohibited:SetPos(10, 80)
	prohibited:AddColumn("Prohibitions")
	for k, v in SortedPairs( SET.CommunitiesPerms ) do
		prohibited:AddLine( v.name )
	end
	prohibited.OnRowSelected = function( _, row, pnl )
		selectedPerm = pnl:GetColumnText(1)
		selectedRow = row
		unpermit = false
	end

	local permitted = vgui.Create("DListView", frame_communitymodifyrank)
	permitted:SetSize(140, 140)
	permitted:SetPos(frame_communitymodifyrank:GetWide() - (permitted:GetWide() + 10), 80)
	permitted:AddColumn("Permissions")
	permitted.OnRowSelected = function( _, row, pnl )
		selectedPerm = pnl:GetColumnText(1)
		selectedRow = row
		unpermit = true
	end

	local swap = vgui.Create("DButton", frame_communitymodifyrank)
	swap:SetSize(35, 35)
	swap:SetPos(frame_communitymodifyrank:GetWide() / 2 - swap:GetWide() / 2, 130)
	swap:SetText(">")
	swap:SetEnabled(false)
	swap.Think = function()
		if selectedPerm and not swap:IsEnabled() then
			swap:SetEnabled(true)
		end
		if unpermit and swap:GetText() != "<" then
			swap:SetText("<")
		end
		if not unpermit and swap:GetText() != ">" then
			swap:SetText(">")
		end
	end
	swap.DoClick = function()
		if selectedPerm and selectedRow then
			if not unpermit then --We are going to give permission
				prohibited:RemoveLine(selectedRow)
				permitted:AddLine(selectedPerm)
				selectedPerm = nil 
				selectedRow = nil 
				unpermit = nil
				swap:SetEnabled(false)
			else --We are going to revoke permission
				permitted:RemoveLine(selectedRow)
				prohibited:AddLine(selectedPerm)
				selectedPerm = nil 
				selectedRow = nil 
				unpermit = nil
				swap:SetEnabled(false)
			end
		end
	end

	local accept = vgui.Create("DButton", frame_communitymodifyrank)
    accept:SetSize(200, 20)
    accept:SetPos(frame_communitymodifyrank:GetWide() / 2 - (accept:GetWide() / 2), (frame_communitymodifyrank:GetTall() - accept:GetTall()) * 0.93)
    accept.DoClick = function()
        local perms = {}
        for k, v in pairs( permitted:GetLines() ) do
            perms[ translatePermNameID(v:GetValue(1)) ] = true
        end
        surface.PlaySound( UICUE.ACCEPT )
        net.Start( "as_community_modifyrank" )
            net.WriteUInt( rankid, NWSetting.UIDAmtBits )
            net.WriteString( entry:GetText() )
            net.WriteTable( perms )
        net.SendToServer()
		frame_communitymodifyrank:Close()
    end
    accept.Think = function()
        if string.len(entry:GetValue()) < 1 and accept:IsEnabled() then
            accept:SetEnabled( false )
            accept:SetText("Enter a rank name.")
        elseif string.len(entry:GetValue()) >= 1 and not accept:IsEnabled() then
            accept:SetEnabled( true )
            accept:SetText("Update Rank")
        end
    end
end

function DeleteRank()
    if IsValid(frame_communitydeleterank) then frame_communitydeleterank:Close() end

    frame_communitydeleterank = vgui.Create("DFrame")
	frame_communitydeleterank:SetSize(350, 275)
    frame_communitydeleterank:Center()
    frame_communitydeleterank:MakePopup()
    frame_communitydeleterank:SetDraggable( false )
    frame_communitydeleterank:SetTitle( "" )
    frame_communitydeleterank:ShowCloseButton( false )
    frame_communitydeleterank.Paint = function(_,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, COLHUD_PRIMARY)
		draw.RoundedBox( 0, 5, 25, w - 10, h - 30, COLHUD_SECONDARY )
    end

	local closebutton = vgui.Create("DButton", frame_communitydeleterank)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_communitydeleterank:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_communitydeleterank) then
            frame_communitydeleterank:Close()
        end
    end

    frame_communitydeleterankloading = vgui.Create("DLabel", frame_communitydeleterank)
	frame_communitydeleterankloading:SetText( "Fetching Ranks List..." )
	frame_communitydeleterankloading:SizeToContents()
	frame_communitydeleterankloading:SetContentAlignment(5)
	frame_communitydeleterankloading:SetPos( frame_communitydeleterank:GetWide() / 2 - frame_communitydeleterankloading:GetWide() / 2, frame_communitydeleterank:GetTall() * 0.5)

    net.Start("as_community_requestranks")
        net.WriteBit( false )
    net.SendToServer()
end

net.Receive( "as_community_sendranks", function()
    local tbl = net.ReadTable()

    if not IsValid(frame_communitydeleterank) then return end

    frame_communitydeleterankloading:Remove()

    local function translateRankNameID( name )
        for k, v in pairs( tbl ) do
            if v.name == name then
                return k
            end
        end
    end

    local selectedRank
    local selectedRankName

    local ranks = vgui.Create("DListView", frame_communitydeleterank)
	ranks:SetSize(330, 205)
	ranks:SetPos(10, 30)
	ranks:AddColumn("Ranks")
	for k, v in SortedPairs( tbl ) do
        if v.nodelete then continue end
		ranks:AddLine( v.name )
	end
	ranks.OnRowSelected = function( _, row, pnl )
		selectedRank = translateRankNameID( pnl:GetColumnText(1) )
		selectedRankName = pnl:GetColumnText(1)
	end

    local accept = vgui.Create("DButton", frame_communitydeleterank)
    accept:SetSize(330, 25)
    accept:SetPos(frame_communitydeleterank:GetWide() / 2 - (accept:GetWide() / 2), 240)
    accept.DoClick = function()
        surface.PlaySound( UICUE.ACCEPT )
        net.Start( "as_community_deleterank" )
            net.WriteUInt( selectedRank, NWSetting.UIDAmtBits )
        net.SendToServer()
		frame_communitydeleterank:Close()
    end
    accept.Think = function()
        if not selectedRank and accept:IsEnabled() then
            accept:SetEnabled( false )
            accept:SetText("Select a rank.")
        elseif selectedRank and not accept:IsEnabled() then
            accept:SetEnabled( true )
        end

        if accept:IsEnabled() then
            accept:SetText("Delete " .. selectedRankName)
        end
    end
end)

net.Receive( "as_community_inviteplayer_sendrequest", function()
    local inviter = net.ReadEntity()

    if IsValid(frame_communityinvite) then frame_communityinvite:Close() end

	frame_communityinvite = vgui.Create("DFrame")
	frame_communityinvite:SetSize(300, 150)
    frame_communityinvite:Center()
    frame_communityinvite:MakePopup()
    frame_communityinvite:SetDraggable( false )
    frame_communityinvite:SetTitle( "" )
    frame_communityinvite:ShowCloseButton( false )
    frame_communityinvite.Paint = function(_,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, COLHUD_PRIMARY)
		draw.RoundedBox( 0, 5, 5, w - 10, h - 10, COLHUD_SECONDARY )
    end

	local infotext = vgui.Create("DLabel", frame_communityinvite)
	infotext:SetText( inviter:Nickname() .. " has invited you to join " .. inviter:GetCommunityName() .. ".")
	infotext:SizeToContents()
	infotext:SetContentAlignment(5)
	infotext:SetPos( frame_communityinvite:GetWide() / 2 - infotext:GetWide() / 2, frame_communityinvite:GetTall() * 0.4)

	local accept = vgui.Create("DButton", frame_communityinvite)
    accept:SetText( "Accept" )
    accept:SetSize(120, 20)
    accept:SetPos( 15, (frame_communityinvite:GetTall() - accept:GetTall()) * 0.8)
    accept.DoClick = function()
        surface.PlaySound( UICUE.ACCEPT )
		frame_communityinvite:Close()
        net.Start("as_community_inviteplayer_acceptrequest")
            net.WriteEntity( inviter )
        net.SendToServer()
    end

    local decline = vgui.Create("DButton", frame_communityinvite)
    decline:SetText( "Decline" )
    decline:SetSize(120, 20)
    decline:SetPos( frame_communityinvite:GetWide() - decline:GetWide() - 15, (frame_communityinvite:GetTall() - decline:GetTall()) * 0.8)
    decline.DoClick = function()
        surface.PlaySound( UICUE.DECLINE )
		frame_communityinvite:Close()
        net.Start("as_community_inviteplayer_declinerequest")
            net.WriteEntity( inviter )
        net.SendToServer()
    end
end)

function UpdateDescription()
    if IsValid(frame_communityupdatedesc) then frame_communityupdatedesc:Close() end

    frame_communityupdatedesc = vgui.Create("DFrame")
	frame_communityupdatedesc:SetSize(210, 245)
    frame_communityupdatedesc:Center()
    frame_communityupdatedesc:MakePopup()
    frame_communityupdatedesc:SetDraggable( false )
    frame_communityupdatedesc:SetTitle( "" )
    frame_communityupdatedesc:ShowCloseButton( false )
    frame_communityupdatedesc.Paint = function(_,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, COLHUD_PRIMARY)
		draw.RoundedBox( 0, 5, 25, w - 10, h - 30, COLHUD_SECONDARY )
    end

	local closebutton = vgui.Create("DButton", frame_communityupdatedesc)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_communityupdatedesc:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_communityupdatedesc) then
            frame_communityupdatedesc:Close()
        end
    end

    local entry = vgui.Create("DTextEntry", frame_communityupdatedesc)
    entry:SetSize( 190, 180 )
    entry:SetPos( frame_communityupdatedesc:GetWide() / 2 - entry:GetWide() / 2, 30)
    entry:SetPlaceholderText("New community description")
    entry:SetMultiline( true )

    local accept = vgui.Create("DButton", frame_communityupdatedesc)
    accept:SetText( "Update Description" )
    accept:SetSize(190, 20)
    accept:SetPos( frame_communityupdatedesc:GetWide() / 2 - accept:GetWide() / 2, 215 )
    accept.DoClick = function()
        surface.PlaySound( UICUE.ACCEPT )
		frame_communityupdatedesc:Close()
        net.Start("as_community_updatedescription")
            net.WriteString( entry:GetText() )
        net.SendToServer()
    end
end

function CommunitySearchWindow()
    if IsValid(frame_communitysearch) then frame_communitysearch:Close() end

    frame_communitysearch = vgui.Create("DFrame")
	frame_communitysearch:SetSize(700, 600)
    frame_communitysearch:Center()
    frame_communitysearch:MakePopup()
    frame_communitysearch:SetDraggable( false )
    frame_communitysearch:SetTitle( "Community Search Window" )
    frame_communitysearch:ShowCloseButton( false )
    frame_communitysearch.Paint = function(_,w,h)
		draw.RoundedBox( 0, 0, 0, w, h, COLHUD_PRIMARY)
		draw.RoundedBox( 0, 5, 25, w - 10, h - 30, COLHUD_SECONDARY )
    end

    local closebutton = vgui.Create("DButton", frame_communitysearch)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_communitysearch:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_communitysearch) then
            frame_communitysearch:Close()
        end
    end

    local entry = vgui.Create("DTextEntry", frame_communitysearch)
    entry:SetSize( 500, 20 )
    entry:SetPos( frame_communitysearch:GetWide() / 2 - entry:GetWide() / 2, 30)
    entry:SetPlaceholderText("Search a community by name, and press enter for results.")
    function entry:OnEnter()
        frame_communitysearch_loading = vgui.Create("DLabel", frame_communitysearch)
        frame_communitysearch_loading:SetFont( "TargetID" )
        frame_communitysearch_loading:SetText("Fetching Communities...")
        frame_communitysearch_loading:SizeToContents()
        frame_communitysearch_loading:SetPos(frame_communitysearch:GetWide() / 2 - frame_communitysearch_loading:GetWide() / 2, 300)

        if IsValid(communities) then
            communities:Remove()
        end

        net.Start("as_community_requestcommunitiesbyname")
            net.WriteString(entry:GetText())
        net.SendToServer()
    end
end

net.Receive( "as_community_sendcommunities", function()
    local community = net.ReadTable()

    if not IsValid(frame_communitysearch) then return end
    frame_communitysearch_loading:Remove()

    communities = vgui.Create("DPanel", frame_communitysearch)
    communities:SetPos( 5, 55 )
    communities:SetSize( frame_communitysearch:GetWide() - (communities:GetX() + 5), frame_communitysearch:GetTall() - (communities:GetY() + 5) )
    function communities:Paint() end

    local scroll_communities = vgui.Create("DScrollPanel", communities)
    scroll_communities:SetSize( communities:GetWide(), communities:GetTall() )
    scroll_communities.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)
    end

    local xpos, ypos = 5, 0
    for k, v in pairs(community) do
        local panel = vgui.Create("DPanel", scroll_communities)
        panel:SetPos( xpos, ypos )
        panel:SetSize( scroll_communities:GetWide() - 25, 75 )
        function panel:Paint( w, h )
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        local name = vgui.Create("DLabel", panel)
        name:SetFont( "TargetID" )
        name:SetText( v.name )
        name:SetPos( 5, 5 )
        name:SizeToContents()

        local creator = vgui.Create("DLabel", panel)
        creator:SetFont( "TargetIDSmall" )
        creator:SetText( "Created by: " .. v.creator )
        creator:SizeToContents()
        creator:SetPos( 5, panel:GetTall() - creator:GetTall() - 5 )

        local width, height = 80, 20
        DefaultButton( "View", panel:GetWide() - (width + 5), 5, width, height, panel, function()
            frame_communitysearch:Close()
            net.Start("as_community_requestlookup")
                net.WriteUInt( k, NWSetting.UIDAmtBits )
            net.SendToServer()
        end)

        DefaultButton( "Offer Alliance", panel:GetWide() - (width + 5), 30, width, height, panel, function()
            frame_communitysearch:Close()
            net.Start("as_community_ally")
                net.WriteUInt( k, NWSetting.UIDAmtBits )
            net.SendToServer()
        end)

        DefaultButton( "Declare War", panel:GetWide() - (width + 5), 50, width, height, panel, function()
            frame_communitysearch:Close()
            net.Start("as_community_war")
                net.WriteUInt( k, NWSetting.UIDAmtBits )
            net.SendToServer()
        end)

        ypos = ypos + panel:GetTall() + 5
    end
end)

net.Receive( "as_community_sendlookup", function()
    local cid = net.ReadUInt( NWSetting.UIDAmtBits )
    local commdata = net.ReadTable()
    local memberdata = net.ReadTable()
    commdata = util.JSONToTable(commdata.data)

    frame_communityview = vgui.Create("DFrame")
	frame_communityview:SetSize(700, 600)
    frame_communityview:Center()
    frame_communityview:MakePopup()
    frame_communityview:SetDraggable( false )
    frame_communityview:SetTitle( "" )
    frame_communityview:ShowCloseButton( false )
    function frame_communityview:Paint( w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetMaterial( Material("gui/aftershock/default.png") )
        surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
        surface.DrawTexturedRect( 0, 0, w, h )
    end

    local cbuttonsize = 18
    local closebutton = CreateCloseButton( frame_communityview, cbuttonsize, frame_communityview:GetWide() - cbuttonsize - 6, 3 )

    local x, y = 34, 25
    commviewsheets = CreateSheetPanel( frame_communityview, frame_communityview:GetWide() - x - 42, frame_communityview:GetTall() - y - 35, x, y )
    function commviewsheets:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    commviewsheets:AddSheet("Members", CommunityViewMembers( commviewsheets, memberdata ), "icon16/user.png")
    commviewsheets:AddSheet("Allies", CommunityViewAllies( commviewsheets, commdata.allies ), "icon16/flag_green.png")
    commviewsheets:AddSheet("Wars", CommunityViewWars( commviewsheets, commdata.wars ), "icon16/flag_red.png")
end)

function CommunityViewMembers( parent, data )
    local panel = vgui.Create("DPanel")
    panel:SetSize( parent:GetWide(), parent:GetTall())
    function panel:Paint( w, h ) end

    local scroll_members = vgui.Create( "DScrollPanel", panel )
    scroll_members:SetSize( panel:GetWide(), panel:GetTall() )
    function panel:Paint( w, h ) end

    local ypos = 0

    for k, v in pairs( data ) do
        local member = vgui.Create( "DPanel", scroll_members )
        member:SetPos( 0, ypos )
        member:SetSize( scroll_members:GetWide(), 100 )
        function member:Paint( w, h )
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        CharacterIcon( v.model, 5, 5, member:GetTall() - 10, member:GetTall() - 10, member, nil, AS.Classes[v.class].color )

        local name = vgui.Create("DLabel", member)
        name:SetFont( "TargetID" )
        name:SetText( v.name .. " (" .. (AS.Classes[v.class].name or "") .. ")" )
        name:SetPos( 100, 5 )
        name:SizeToContents()
        name:SetColor( AS.Classes[v.class].color )

        local title = vgui.Create("DLabel", member)
        title:SetFont( "TargetID" )
        title:SetText( "Title: " .. v.title )
        title:SetPos( 100, 25 )
        title:SizeToContents()

        local laston = vgui.Create("DLabel", member)
        laston:SetFont( "TargetID" )
        laston:SetText( "Last on: " .. v.laston )
        laston:SetPos( 100, 80 )
        laston:SizeToContents()

        ypos = ypos + member:GetTall() + 5
    end

    return panel
end

function CommunityViewAllies( parent, data )
    local panel = vgui.Create("DPanel")
    panel:SetSize( parent:GetWide(), parent:GetTall())
    function panel:Paint( w, h ) end

    local scroll_allies = vgui.Create( "DScrollPanel", panel )
    scroll_allies:SetSize( panel:GetWide(), panel:GetTall() )
    function panel:Paint( w, h ) end

    local ypos = 0

    for k, v in pairs( data ) do
        local ally = vgui.Create( "DPanel", scroll_allies )
        ally:SetPos( 0, ypos )
        ally:SetSize( scroll_allies:GetWide(), 30 )
        function ally:Paint( w, h )
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        local name = vgui.Create("DLabel", ally)
        name:SetFont( "TargetID" )
        name:SetText( v.name )
        name:SetPos( 5, 5 )
        name:SizeToContents()

        ypos = ypos + ally:GetTall() + 5
    end

    return panel
end

function CommunityViewWars( parent, data )
    local panel = vgui.Create("DPanel")
    panel:SetSize( parent:GetWide(), parent:GetTall())
    function panel:Paint( w, h ) end

    local scroll_wars = vgui.Create( "DScrollPanel", panel )
    scroll_wars:SetSize( panel:GetWide(), panel:GetTall() )
    function panel:Paint( w, h ) end

    local ypos = 0

    for k, v in pairs( data ) do
        local ally = vgui.Create( "DPanel", scroll_wars )
        ally:SetPos( 0, ypos )
        ally:SetSize( scroll_wars:GetWide(), 30 )
        function ally:Paint( w, h )
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        local name = vgui.Create("DLabel", ally)
        name:SetFont( "TargetID" )
        name:SetText( v.name )
        name:SetPos( 5, 5 )
        name:SizeToContents()

        ypos = ypos + ally:GetTall() + 5
    end

    return panel
end