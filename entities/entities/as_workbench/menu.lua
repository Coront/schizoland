Workbench = Workbench or {}
local ent

function Workbench.Menu()
    ent = net.ReadEntity()
    if not IsValid(ent) then return end

    if IsValid(frame_workbench) then frame_workbench:Close() end

    frame_workbench = vgui.Create("DFrame")
    frame_workbench:SetSize(700, 500)
    frame_workbench:Center()
    frame_workbench:MakePopup()
    frame_workbench:SetDraggable( false )
    frame_workbench:SetTitle( "" )
    frame_workbench:ShowCloseButton( false )
    frame_workbench.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local closebutton = vgui.Create("DButton", frame_workbench)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_workbench:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_workbench) then
            frame_workbench:Close()
        end
    end

    local pickup = vgui.Create("DButton", frame_workbench)
    pickup:SetSize( 80, 20 )
    pickup:SetPos( 5, 3 )
    pickup:SetText("Pick Up")
    pickup:SetEnabled( false )
    pickup:SetTooltip("You are not the owner of this object.")
    if ent:PlayerCanPickUp( LocalPlayer() ) then
        pickup:SetEnabled( true )
        pickup:SetTooltip("Pickup the entity and place it in your inventory.")
    end
    pickup.DoClick = function()
        net.Start("as_tool_pickup")
            net.WriteEntity( ent )
        net.SendToServer()
        frame_workbench:Close()
    end

    local panel = vgui.Create("DPanel", frame_workbench)
    local x, y, space = 3, 25, 6
    panel:SetPos( x, y )
    panel:SetSize( frame_workbench:GetWide() - space, (frame_workbench:GetTall() - x) - y )
    panel.Paint = function( self, w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local scroll = vgui.Create("DScrollPanel", panel)
    scroll:SetSize( panel:GetWide(), 0 )
    scroll:Dock( FILL )
    scroll:DockMargin( 5, 5, 5, 5 )

    workbench_itemlist = vgui.Create( "DIconLayout", scroll )
    workbench_itemlist:SetSize( scroll:GetWide(), scroll:GetTall() )
    workbench_itemlist:SetSpaceY( 5 )
    workbench_itemlist:SetSpaceX( 5 )

    if ent.CraftTable["BaseClass"] then ent.CraftTable["BaseClass"] = nil end
    for k, v in SortedPairsByValue( ent.CraftTable ) do
        if not AS.Items[k] then continue end --Item doesnt exist
        if AS.Items[k] and not AS.Items[k].craft then AS.LuaError("Attempt to index crafting table from item with no craft table - " .. k) continue end --item exists but no craft table
        Workbench.BuildRecipe( k )
    end
end
net.Receive("as_workbench_open", Workbench.Menu)

function Workbench.BuildRecipe( itemid )
    local id = AS.Items[itemid]

    local isArmor = id.category == "armor" and true or false

    local item = workbench_itemlist:Add("DPanel")
    local height = isArmor and 240 or 90
    item:SetSize(workbench_itemlist:GetWide() - 25, height)
    function item:Paint(w, h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local itemname = id.name or item .. "?name"
    local itemdesc = id.desc or item .. "?desc"
    local itemreqs = ""
    for k2, v2 in pairs( id.craft ) do
        if not AS.Items[k2] then AS.LuaError("Attmept to index an item that doens't exist via crafting - " .. k2) return end
        itemreqs = itemreqs .. "\n" .. AS.Items[k2].name .. " (" .. v2 .. ")"
    end

    local icon = vgui.Create( "SpawnIcon", item )
    icon:SetSize( 60, 60 )
    local ypos = isArmor and 15 or item:GetTall() / 2 - icon:GetTall() / 2
    icon:SetPos( 5, ypos )
    icon:SetModel( id.model, id.skin or 0 )
    icon:SetTooltip( itemname .. "\n" .. itemdesc .. "\n\nRequirements:" .. itemreqs )

    local name = vgui.Create("DLabel", item)
    name:SetFont("TargetIDSmall")
    name:SetText( itemname )
    name:SetContentAlignment(4)
    name:SizeToContents()
    name:SetPos( 70, 10 )

    local scroll_desc = vgui.Create("DScrollPanel", item)
    scroll_desc:SetSize( 440, 55 )
    scroll_desc:SetPos( 85, 25 )

    local desc = vgui.Create("DLabel", scroll_desc)
    desc:SetText( itemdesc )
    desc:SetSize( scroll_desc:GetWide() - 15, scroll_desc:GetTall() )
    desc:SetWrap( true )
    desc:SetAutoStretchVertical( true )

    if isArmor then
        local armorpanel = vgui.Create("DPanel", item)
        armorpanel:SetPos( 5, 80 )
        armorpanel:SetSize( 405, 200 )
        function armorpanel:Paint() end

        local scroll_armorpanel = vgui.Create("DScrollPanel", armorpanel)
        scroll_armorpanel:SetSize( scroll_armorpanel:GetParent():GetWide(), scroll_armorpanel:GetParent():GetTall() )
        scroll_armorpanel.Paint = function() end

        for k2, v2 in pairs( id.armor ) do
            if not AS.DamageTypes[k2] then continue end

            local statbg = scroll_armorpanel:Add( "DPanel" )
            statbg:Dock( TOP )
            statbg:DockMargin( 5, 7, 5, 0 )
            statbg:SetSize( 0, 20 )
            local TTtext = AS.DamageTypes[k2].name .. ": " .. v2 .. "%"
            statbg:SetTooltip( TTtext )
            statbg.Paint = function(_,w,h)
                w = w - 65
                surface.SetDrawColor( COLHUD_SECONDARY )
                surface.DrawRect( 25, 0, w, h )
                
                surface.SetDrawColor( COLHUD_GOOD )
                local length = (v2 / 100) * w
                surface.DrawRect( 25, 0, length, h )
                
                local xpos = 31
                for i = 1, 46 do
                    
                    surface.SetDrawColor( COLHUD_PRIMARY )
                    surface.DrawRect( xpos, 0, 1, h )
                    xpos = xpos + 7
                end
            end

            local icon = vgui.Create("DImageButton", statbg)
            icon:SetPos( 5, 0 )
            icon:SetSize (16, 16)
            icon:SetImage( AS.DamageTypes[k2].icon )
            icon:SetColor(Color(255,255,255,255))

            local amt = vgui.Create("DLabel", statbg)
            amt:SetSize( 35, 20 )
            amt:SetPos( 325 + amt:GetWide(), 0 )
            amt:SetFont("TargetIDSmall")
            amt:SetText( v2 .. "%" )

        end
    end

    if id.class then
        local classreq = vgui.Create("DLabel", item)
        classreq:SetText( "Class needed to craft: " .. translateClassNameID(id.class) )
        classreq:SetContentAlignment(4)
        classreq:SizeToContents()
        classreq:SetPos( 100, item:GetTall() - (classreq:GetTall() + 5) )
    end

    local scroll_reqs = vgui.Create("DScrollPanel", item)
    local height = isArmor and 210 or 60
    scroll_reqs:SetSize( 125, height )
    scroll_reqs:SetPos( item:GetWide() - (scroll_reqs:GetWide() + 5), 5 )
    function scroll_reqs:Paint(w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local reqlist = vgui.Create("DIconLayout", scroll_reqs)
    reqlist:SetSize(scroll_reqs:GetWide(), scroll_reqs:GetTall())
    reqlist:SetSpaceY( 1 )
    reqlist:SetSpaceX( 0 )

    local function buildReqList( k2, v2 )
        if not AS.Items[k2] then AS.LuaError("Attmept to index an item that doens't exist via crafting - " .. k2) return end
        local panel = reqlist:Add("DPanel")
        panel:SetSize( reqlist:GetWide() - 16, 20 )
        function panel:Paint(w,h) end

        local name = vgui.Create("DLabel", panel)
        name:SetText( "(" .. v2 .. ") " .. AS.Items[k2].name )
        name:SetColor( Color( 0, 0, 0 ) )
        name:SetContentAlignment(4)
        name:SetX( 1 )
        name:SetSize(panel:GetWide() - 20, panel:GetTall())
        name:SetColor( Color( 255, 255, 255 ) )

        local silkicon = vgui.Create("DImage", panel)
        silkicon:SetSize(16, 16)
        silkicon:SetPos(panel:GetWide() - (silkicon:GetWide() + 2), 2)
        local silkimageicon = "icon16/cross.png"
        local paneltt = "You do not have enough " .. AS.Items[k2].name .. "(s) to craft this item.\n\nYou have: " .. LocalPlayer():GetItemCount( k2 ) .. "\nYou need: " .. v2 - LocalPlayer():GetItemCount( k2 )
        if LocalPlayer():HasInInventory( k2, v2 ) then
            silkimageicon = "icon16/tick.png"
            paneltt = "You have enough " .. AS.Items[k2].name .. "(s) to craft this item.\n\nYou have: " .. LocalPlayer():GetItemCount( k2 ) .. "\nAfter craft remaining: " .. LocalPlayer():GetItemCount( k2 ) - v2
        end
        silkicon:SetImage(silkimageicon)
        panel:SetTooltip(paneltt)
    end

    local craft = vgui.Create("DButton", item)
    craft:SetSize( 125, 20 )
    craft:SetPos( item:GetWide() - (craft:GetWide() + 5), item:GetTall() - (craft:GetTall() + 5) )
    local btntxt = LocalPlayer():CanCraftAmount( itemid ) > 0 and "Craft (" .. LocalPlayer():CanCraftAmount( itemid ) .. ")" or "Unable to craft"
    craft:SetText(btntxt)
    craft:SetEnabled( false )
    function craft:DoClick()
        VerifySlider( LocalPlayer():CanCraftAmount( itemid ), function( amt ) 
            LocalPlayer():CraftItem( itemid, amt )
            net.Start("as_workbench_craftitem")
                net.WriteEntity( ent )
                net.WriteString( itemid )
                net.WriteInt( amt, 32 )
            net.SendToServer()
            frame_workbench:Close()
        end )
    end
    function craft:DoRightClick()
        LocalPlayer():CraftItem( itemid, 1 )
        net.Start("as_workbench_craftitem")
            net.WriteEntity( ent )
            net.WriteString( itemid )
            net.WriteInt( 1, 32 )
        net.SendToServer()
        frame_workbench:Close()
    end

    if LocalPlayer():CanCraftItem( itemid ) then
        craft:SetEnabled( true )
    end

    if id.craft["misc_scrap"] then --Doing it this way because i want scrap, smallparts and chems to be listed first, then the rest of the items.
        buildReqList( "misc_scrap", id.craft["misc_scrap"])
    end
    if id.craft["misc_smallparts"] then
        buildReqList( "misc_smallparts", id.craft["misc_smallparts"])
    end
    if id.craft["misc_chemical"] then
        buildReqList( "misc_chemical", id.craft["misc_chemical"])
    end

    for k2, v2 in SortedPairs( id.craft ) do
        if k2 == "misc_scrap" or k2 == "misc_smallparts" or k2 == "misc_chemical" then continue end
        buildReqList( k2, v2 )
    end
end