AS.Craft = {}

AS_ClientConVar( "as_menu_craft_holdtoopen", "0", true, false )

function AS.Craft.Open()
    if not LocalPlayer():IsLoaded() then return end
    if not LocalPlayer():Alive() then return end
    if IsValid(frame_craft) then frame_craft:Close() end

    frame_craft = vgui.Create("DFrame")
    frame_craft:SetSize(600, 700)
    frame_craft:Center()
    frame_craft:MakePopup()
    frame_craft:SetDraggable( false )
    frame_craft:SetTitle( "Hand Crafting" )
    frame_craft:ShowCloseButton( false )
    frame_craft.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end
    if GetConVar("as_menu_craft_holdtoopen"):GetInt() > 0 then
        frame_craft.Think = function( self )
            if not input.IsButtonDown( input.GetKeyCode( GetConVarString("as_bind_craft") ) ) then
                self:Close()
            end
        end
    end

    local sheets = vgui.Create("DPropertySheet", frame_craft)
    sheets:SetPos(2, 25)
    sheets:SetFadeTime( 0 )
    sheets:SetSize( frame_craft:GetWide() - (sheets:GetX() * 2), frame_craft:GetTall() - (sheets:GetY() + 2 ))
    sheets.Paint = function( self, w, h ) 
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local closebutton = vgui.Create("DButton", frame_craft)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_craft:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_craft) then
            frame_craft:Close()
        end
    end

    sheets:AddSheet("Weapons", AS.Craft.BuildList(sheets, "weapon"), "icon16/gun.png")
    sheets:AddSheet("Armor", AS.Craft.BuildList(sheets, "armor"), "icon16/user.png")
    sheets:AddSheet("Ammo", AS.Craft.BuildList(sheets, "ammo"), "icon16/briefcase.png")
    sheets:AddSheet("Medical", AS.Craft.BuildList(sheets, "med"), "icon16/heart.png")
    sheets:AddSheet("Vehicle", AS.Craft.BuildList(sheets, "vehicle"), "icon16/car.png")
    sheets:AddSheet("Tool", AS.Craft.BuildList(sheets, "tool"), "icon16/wrench.png")
    sheets:AddSheet("Misc", AS.Craft.BuildList(sheets, "misc"), "icon16/cog.png")
end

function AS.Craft.BuildList( parent, category )
    local scroll_items = vgui.Create("DScrollPanel", parent)
    scroll_items:SetSize( scroll_items:GetParent():GetWide(), 0 )
    scroll_items.Paint = function() end

    local itemlist = vgui.Create("DIconLayout", scroll_items)
    itemlist:SetSize(scroll_items:GetWide() - 10, scroll_items:GetTall())
    itemlist:SetSpaceY( 5 )
    itemlist:SetSpaceX( 5 )

    for k, v in SortedPairsByMemberValue( AS.Items, "name" ) do
        if v.hidden then continue end
        if not v.craft then continue end
        if v.category != category then continue end

        local itemname = v.name or k .. "?name"
        local itemdesc = v.desc or k .. "?desc"
        local itemreqs = ""
        for k2, v2 in pairs( v.craft ) do
            if not AS.Items[k2] then AS.LuaError("Attmept to index an item that doens't exist via crafting - " .. k2) return end
            itemreqs = itemreqs .. "\n" .. AS.Items[k2].name .. " (" .. v2 .. ")"
        end

        local isArmor = category == "armor" and true or false

        local panel = itemlist:Add("DPanel")
        local height = isArmor and 240 or 90
        panel:SetSize( scroll_items:GetWide() - 35, height )
        function panel:Paint(w, h)
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        local icon = vgui.Create( "SpawnIcon", panel )
        icon:SetSize( 60, 60 )
        local ypos = isArmor and 15 or panel:GetTall() / 2 - icon:GetTall() / 2
        icon:SetPos( 5, ypos )
        icon:SetModel( v.model, v.skin or 0 )
        icon:SetTooltip( itemname .. "\n" .. itemdesc .. "\n\nRequirements:" .. itemreqs )

        local name = vgui.Create("DLabel", panel)
        name:SetFont("TargetIDSmall")
        name:SetText( itemname )
        name:SetContentAlignment(4)
        name:SizeToContents()
        name:SetPos( 70, 10 )

        local scroll_desc = vgui.Create("DScrollPanel", panel)
        scroll_desc:SetSize( 325, 45 )
        scroll_desc:SetPos( 85, 25 )

        local desc = vgui.Create("DLabel", scroll_desc)
        desc:SetText( itemdesc )
        desc:SetSize( scroll_desc:GetWide() - 15, scroll_desc:GetTall() )
        desc:SetWrap( true )
        desc:SetAutoStretchVertical( true )

        if isArmor then
            local armorpanel = vgui.Create("DPanel", panel)
            armorpanel:SetPos( 5, 80 )
            armorpanel:SetSize( 405, 200 )
            function armorpanel:Paint() end

            local scroll_armorpanel = vgui.Create("DScrollPanel", armorpanel)
            scroll_armorpanel:SetSize( scroll_armorpanel:GetParent():GetWide(), scroll_armorpanel:GetParent():GetTall() )
            scroll_armorpanel.Paint = function() end

            for k2, v2 in pairs( AS.Items[k].armor ) do
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

        if AS.Items[k].class then
            local classreq = vgui.Create("DLabel", panel)
            classreq:SetText( "Class needed to craft: " .. translateClassNameID(AS.Items[k].class) )
            classreq:SetContentAlignment(4)
            classreq:SizeToContents()
            classreq:SetPos( 100, panel:GetTall() - (classreq:GetTall() + 5) )
            if LocalPlayer():GetASClass() == AS.Items[k].class then
                classreq:SetColor( COLHUD_GOOD )
            else
                classreq:SetColor( COLHUD_BAD )
            end
        end

        local scroll_reqs = vgui.Create("DScrollPanel", panel)
        local height = isArmor and 210 or 60
        scroll_reqs:SetSize( 125, height )
        scroll_reqs:SetPos( panel:GetWide() - (scroll_reqs:GetWide() + 5), 5 )
        function scroll_reqs:Paint(w,h)
            surface.SetDrawColor( COLHUD_SECONDARY )
            surface.DrawRect( 0, 0, w, h )
        end

        local reqlist = vgui.Create("DIconLayout", scroll_reqs)
        reqlist:SetSize(scroll_reqs:GetWide(), scroll_reqs:GetTall())
        reqlist:SetSpaceY( 1 )
        reqlist:SetSpaceX( 0 )

        local craft = vgui.Create("DButton", panel)
        craft:SetSize( 125, 20 )
        craft:SetPos( panel:GetWide() - (craft:GetWide() + 5), panel:GetTall() - (craft:GetTall() + 5) )
        local btntxt = LocalPlayer():CanCraftAmount( k ) > 0 and "Craft (" .. LocalPlayer():CanCraftAmount( k ) .. ")" or "Unable to craft"
        craft:SetText(btntxt)
        craft:SetEnabled( false )
        function craft:DoClick()
            if AS.Items[k].category == "tool" then
                LocalPlayer():CraftItem( k, 1 )
                net.Start("as_crafting_craftitem")
                    net.WriteString( k )
                    net.WriteUInt( 1, NWSetting.ItemCraftBits )
                net.SendToServer()
                frame_craft:Close()
            else
                VerifySlider( LocalPlayer():CanCraftAmount( k ), function( amt ) 
                    LocalPlayer():CraftItem( k, amt )
                    net.Start("as_crafting_craftitem")
                        net.WriteString( k )
                        net.WriteUInt( amt, NWSetting.ItemCraftBits )
                    net.SendToServer()
                    frame_craft:Close()
                end )
            end
        end
        function craft:DoRightClick()
            LocalPlayer():CraftItem( k, 1 )
            net.Start("as_crafting_craftitem")
                net.WriteString( k )
                net.WriteUInt( 1, NWSetting.ItemCraftBits )
            net.SendToServer()
            frame_craft:Close()
        end

        if LocalPlayer():CanCraftItem( k ) then
            craft:SetEnabled( true )
        end

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

        if v.craft["misc_scrap"] then --Doing it this way because i want scrap, smallparts and chems to be listed first, then the rest of the items.
            buildReqList( "misc_scrap", v.craft["misc_scrap"])
        end
        if v.craft["misc_smallparts"] then
            buildReqList( "misc_smallparts", v.craft["misc_smallparts"])
        end
        if v.craft["misc_chemical"] then
            buildReqList( "misc_chemical", v.craft["misc_chemical"])
        end

        for k2, v2 in SortedPairs( v.craft ) do
            if k2 == "misc_scrap" or k2 == "misc_smallparts" or k2 == "misc_chemical" then continue end
            buildReqList( k2, v2 )
        end
    end

    return scroll_items
end