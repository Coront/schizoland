Workbench = Workbench or {}
local ent

function Workbench.Menu()
    ent = net.ReadEntity()
    if not IsValid(ent) then return end

    if IsValid(frame_workbench) then frame_workbench:Close() end

    frame_workbench = vgui.Create("DFrame")
    frame_workbench:SetSize(650, 600)
    frame_workbench:Center()
    frame_workbench:MakePopup()
    frame_workbench:SetDraggable( false )
    frame_workbench:SetTitle( "" )
    frame_workbench:ShowCloseButton( false )
    function frame_workbench:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetMaterial( Material("gui/aftershock/default.png") )
        surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
        surface.DrawTexturedRect( 0, 0, w, h )
    end

    local cbuttonsize = 18
    local closebutton = CreateCloseButton( frame_workbench, cbuttonsize, frame_workbench:GetWide() - cbuttonsize - 5, 3 )

    if ent:IsObjectOwnable() then
        local pickup = vgui.Create("DButton", frame_workbench)
        pickup:SetSize( 80, 20 )
        pickup:SetPos( 2, 1 )
        pickup:SetText("Pick Up")
        pickup:SetEnabled( false )
        pickup:SetTooltip("You are not the owner of this object.")
        if ent:PlayerCanPickUp( LocalPlayer() ) then
            pickup:SetEnabled( true )
            pickup:SetTooltip("Pickup the object and place it in your inventory.")
        end
        function pickup:DoClick()
            net.Start("as_tool_pickup")
                net.WriteEntity( ent )
            net.SendToServer()
            frame_workbench:Close()
        end
    end

    local panel = vgui.Create("DPanel", frame_workbench)
    local x, y, space = 34, 25, 73
    panel:SetPos( x, y )
    panel:SetSize( frame_workbench:GetWide() - space, (frame_workbench:GetTall() - x) - y - 1 )
    function panel:Paint( w, h ) end

    local scroll = vgui.Create("DScrollPanel", panel)
    scroll:SetSize( panel:GetWide(), panel:GetTall() )

    workbench_itemlist = vgui.Create( "DIconLayout", scroll )
    workbench_itemlist:SetSize( scroll:GetWide(), scroll:GetTall() )
    workbench_itemlist:SetSpaceY( 2 )
    workbench_itemlist:SetSpaceX( 0 )

    if ent.CraftTable["BaseClass"] then ent.CraftTable["BaseClass"] = nil end
    for k, v in SortedPairsByValue( ent.CraftTable ) do
        if not AS.Items[k] then continue end --Item doesnt exist
        if AS.Items[k] and not AS.Items[k].craft then AS.LuaError("Attempt to index crafting table from item with no craft table - " .. k) continue end --item exists but no craft table
        Workbench.BuildRecipe( workbench_itemlist, k )
    end
end
net.Receive("as_workbench_open", Workbench.Menu)

function Workbench.BuildRecipe( parent, itemid )
    local id = AS.Items[itemid]

    local isArmor = id.category == "armor" and true or false

    local item = parent:Add("DPanel")
    local height = isArmor and 240 or 110
    item:SetSize(parent:GetWide() - 15, height)
    function item:Paint(w, h)
        local col = COLHUD_PRIMARY:ToTable()
        surface.SetDrawColor( col[1], col[2], col[3], 100 )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    local itemname = id.name or item .. "?name"
    local itemdesc = id.desc or item .. "?desc"
    local itemweight = id.weight or item .. "?weight"
    local itemreqs = ""
    for k2, v2 in pairs( id.craft ) do
        if not AS.Items[k2] then AS.LuaError("Attmept to index an item that doens't exist via crafting - " .. k2) return end
        itemreqs = itemreqs .. "\n" .. AS.Items[k2].name .. " (" .. v2 .. ")"
    end

    local iconpanel = vgui.Create( "DPanel", item )
    iconpanel:SetSize( 60, 60 )
    local ypos = isArmor and 15 or item:GetTall() / 2 - iconpanel:GetTall() / 2
    iconpanel:SetPos( 5, ypos )
    function iconpanel:Paint( w, h )
        local col = id.color and id.color:ToTable() or COLHUD_PRIMARY:ToTable()
        surface.SetDrawColor( col[1], col[2], col[3], 50 )
        surface.DrawRect( 0, 0, w, h )

        if id.color then
            surface.SetDrawColor( id.color )
        else
            surface.SetDrawColor( COLHUD_PRIMARY )
        end
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    local icon = vgui.Create( "SpawnIcon", iconpanel )
    icon:SetSize( iconpanel:GetWide(), iconpanel:GetTall() )
    icon:SetModel( id.model, id.skin or 0 )
    icon:SetTooltip( itemname .. "\n" .. itemdesc .. "\n\nRequirements:" .. itemreqs )

    local name = vgui.Create("DLabel", item)
    name:SetFont("TargetIDSmall")
    name:SetText( itemname )
    name:SetContentAlignment(4)
    name:SizeToContents()
    name:SetPos( 85, 10 )

    local scroll_desc = vgui.Create("DScrollPanel", item)
    scroll_desc:SetSize( 320, 60 )
    scroll_desc:SetPos( 100, 25 )

    local desc = vgui.Create("DLabel", scroll_desc)
    desc:SetText( itemdesc )
    desc:SetSize( scroll_desc:GetWide() - 15, scroll_desc:GetTall() )
    desc:SetWrap( true )
    desc:SetAutoStretchVertical( true )

    local weight = vgui.Create("DLabel", item)
    weight:SetText( "Weight: " .. itemweight )
    weight:SetContentAlignment(4)
    weight:SizeToContents()
    weight:SetPos( 85, item:GetTall() - 20 )

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
            statbg:DockMargin( 5, 3, 5, 0 )
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
            icon:SetPos( 3, 2 )
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
        classreq:SetPos( 240, item:GetTall() - (classreq:GetTall() + 7) )
        if LocalPlayer():GetASClass() == id.class then
            classreq:SetColor( COLHUD_GOOD )
        else
            classreq:SetColor( COLHUD_BAD )
        end
    end

    local scroll_reqs = vgui.Create("DScrollPanel", item)
    local height = isArmor and 210 or 80
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
        function panel:Paint(w,h)
            if (SET.RawResources[k2] and v2 != 0 or not SET.RawResources[k2]) and not LocalPlayer():HasInInventory( k2, v2 ) then
                surface.SetDrawColor( COLHUD_BAD )
                surface.DrawRect( 0, 0, w, h )
            end
        end

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
        if SET.RawResources[k2] and v2 == 0 or LocalPlayer():HasInInventory( k2, v2 ) then
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
                net.WriteUInt( amt, NWSetting.ItemCraftBits )
            net.SendToServer()
            frame_workbench:Close()
        end )
    end
    function craft:DoRightClick()
        LocalPlayer():CraftItem( itemid, 1 )
        net.Start("as_workbench_craftitem")
            net.WriteEntity( ent )
            net.WriteString( itemid )
            net.WriteUInt( 1, NWSetting.ItemCraftBits )
        net.SendToServer()
        frame_workbench:Close()
    end
    function craft:Paint( w, h )
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