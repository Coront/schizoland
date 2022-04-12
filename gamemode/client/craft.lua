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
    sheets:SetPos(10, 25)
    sheets:SetFadeTime( 0 )
    sheets:SetSize( frame_craft:GetWide() - (sheets:GetX() * 2), frame_craft:GetTall() - (sheets:GetY() + 10 ))
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

        local panel = itemlist:Add("DPanel")
        panel:SetSize( scroll_items:GetWide() - 35, 90 )
        function panel:Paint(w, h)
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        local icon = vgui.Create( "SpawnIcon", panel )
        icon:SetSize( 60, 60 )
        icon:SetPos( 5, panel:GetTall() / 2 - icon:GetTall() / 2 )
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

        if AS.Items[k].class then
            local classreq = vgui.Create("DLabel", panel)
            classreq:SetText( "Class needed to craft: " .. translateClassNameID(AS.Items[k].class) )
            classreq:SetContentAlignment(4)
            classreq:SizeToContents()
            classreq:SetPos( 100, 72 )
        end

        local scroll_reqs = vgui.Create("DScrollPanel", panel)
        scroll_reqs:SetSize( 125, 60 )
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
                    net.WriteInt( 1, 32 )
                net.SendToServer()
                frame_craft:Close()
            else
                VerifySlider( LocalPlayer():CanCraftAmount( k ), function( amt ) 
                    LocalPlayer():CraftItem( k, amt )
                    net.Start("as_crafting_craftitem")
                        net.WriteString( k )
                        net.WriteInt( amt, 32 )
                    net.SendToServer()
                    frame_craft:Close()
                end )
            end
        end
        function craft:DoRightClick()
            LocalPlayer():CraftItem( k, 1 )
            net.Start("as_crafting_craftitem")
                net.WriteString( k )
                net.WriteInt( 1, 32 )
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