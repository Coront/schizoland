AS.Inventory = {}

-- ███╗   ███╗███████╗███╗   ██╗██╗   ██╗
-- ████╗ ████║██╔════╝████╗  ██║██║   ██║
-- ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
-- ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
-- ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
-- ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝

CreateClientConVar( "as_menu_inventory_holdtoopen", "1", true, false )
CreateClientConVar( "as_menu_inventory_singlepanel", "0", true, false )

function AS.Inventory.Open( tab )
    if not LocalPlayer():IsLoaded() then return end
    if IsValid(frame_inventory) then frame_inventory:Close() end

    frame_inventory = vgui.Create("DFrame")
    frame_inventory:SetSize(1000, 600)
    frame_inventory:Center()
    frame_inventory:MakePopup()
    frame_inventory:SetDraggable( false )
    frame_inventory:SetTitle( "" )
    frame_inventory:ShowCloseButton( false )
    frame_inventory.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end
    if GetConVar("as_menu_inventory_holdtoopen"):GetInt() > 0 then
        frame_inventory.Think = function( self )
            if not input.IsButtonDown( input.GetKeyCode( GetConVarString("as_bind_inventory") ) ) and not input.IsButtonDown( input.GetKeyCode( GetConVarString("as_bind_stats") ) ) and not input.IsButtonDown( input.GetKeyCode( GetConVarString("as_bind_skills") ) ) and not input.IsButtonDown( input.GetKeyCode( GetConVarString("as_bind_missions") ) ) then
                self:Close()
            end
        end
    end

    local sheets = vgui.Create("DPropertySheet", frame_inventory)
    sheets:SetPos(5, 5)
    sheets:SetFadeTime( 0 )
    sheets:SetSize( frame_inventory:GetWide() - (sheets:GetX() * 2), frame_inventory:GetTall() - (sheets:GetY() * 2))
    sheets.Paint = function() end

    local closebutton = vgui.Create("DButton", frame_inventory)
    closebutton:SetSize( 25, 25 )
    closebutton:SetPos( frame_inventory:GetWide() - closebutton:GetWide(), 0)
    closebutton:SetFont("TargetID")
    closebutton:SetText("X")
    closebutton:SetColor( COLHUD_SECONDARY )
    closebutton.Paint = function( _, w, h ) end
    closebutton.DoClick = function()
        if IsValid(frame_inventory) then
            frame_inventory:Close()
        end
    end

    sheets:AddSheet("Inventory", AS.Inventory.BuildInventory(), "icon16/box.png")
    sheets:AddSheet("Skills", AS.Inventory.BuildSkills(), "icon16/user.png")
    sheets:AddSheet("Missions", AS.Inventory.BuildMissions(), "icon16/map.png")
    sheets:AddSheet("Statistics", AS.Inventory.BuildStats(), "icon16/chart_line.png")

    if tab then
        sheets:SetActiveTab( sheets:GetItems()[tab].Tab )
    end
end

-- ██████╗ ██╗   ██╗██╗██╗     ██████╗ ███████╗
-- ██╔══██╗██║   ██║██║██║     ██╔══██╗██╔════╝
-- ██████╔╝██║   ██║██║██║     ██║  ██║███████╗
-- ██╔══██╗██║   ██║██║██║     ██║  ██║╚════██║
-- ██████╔╝╚██████╔╝██║███████╗██████╔╝███████║
-- ╚═════╝  ╚═════╝ ╚═╝╚══════╝╚═════╝ ╚══════╝

--[[

--This isnt finished, trying to make a function that builds an item individually.

function AS.Inventory.BuildItem( parent, id, amt )
    local Info = AS.Items[id]
    local itemName = Info.name or "name?" .. id
    local itemDesc = Info.desc or "desc?" .. id
    local itemModel = Info.model or "model?" .. id
    local itemSkin = Info.skin or 0
    local itemWeight = Info.weight or 0
    local ToolTip = v > 1 and itemName .. "\n" .. itemDesc .. "\nWeight: " .. itemWeight .. " [" .. (isnumber(itemWeight) and Weight * amt or "w?") .. "]" or itemName .. "\n" .. itemDesc .. "\nWeight: " .. itemWeight

    local itempanel = vgui.Create("SpawnIcon", parent)
    itempanel:SetModel( itemModel, itemSkin or 0 )
    itempanel:SetTooltip( ToolTip )
    function itempanel:Paint = function( w, h )
        if info.color then
            surface.SetDrawColor( info.color )
        else
            surface.SetDrawColor( COLHUD_PRIMARY )
        end
        surface.DrawRect( 0, 0, w, h )
    end
end
]]

function AS.Inventory.BuildInventory()
    local inventory = vgui.Create("DPanel", sheets)
    inventory.Paint = function(_,w,h) end

-- Items Panel
    local itempanel = vgui.Create( "DPanel", inventory )
    itempanel:SetSize( 665, 554 )
    itempanel:Dock( LEFT )
    itempanel:DockMargin( 0, 0, 0, 0 )
    function itempanel:Paint(w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local weightlbl = vgui.Create("DLabel", itempanel)
    weightlbl:SetFont("TargetID")
    weightlbl:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
    weightlbl:SetContentAlignment( 3 )
    weightlbl:SizeToContents()
    weightlbl:SetPos( 5, 3 )

    local sheets_items = vgui.Create("DPropertySheet", itempanel)
    sheets_items:SetPos(0, 25)
    sheets_items:SetFadeTime( 0 )
    sheets_items:SetSize( sheets_items:GetParent():GetWide(), sheets_items:GetParent():GetTall() - sheets_items:GetPos() )
    sheets_items.Paint = function() end

    function BuildItemList( parent, category )
        local scroll_items = vgui.Create("DScrollPanel", parent)
        scroll_items:SetSize( scroll_items:GetParent():GetWide(), 0 )
        scroll_items.Paint = function() end

        local itemlist = vgui.Create("DIconLayout", scroll_items)
        itemlist:SetSize(scroll_items:GetWide() - 10, scroll_items:GetTall())
        itemlist:SetSpaceY( 5 )
        itemlist:SetSpaceX( 5 )

        for k, v in SortedPairs( LocalPlayer():GetInventory() ) do
            local info = AS.Items[k]
            if category then
                if info.category != category then continue end
            end
            local name = info.name or "name?" .. k
            local desc = info.desc or "desc?" .. k
            local weight = info.weight or "weight?" .. k

            local panel = itemlist:Add("SpawnIcon")
            panel:SetSize( 60, 60 )

            local itemamt = vgui.Create("DLabel", panel)
            itemamt:SetFont("TargetID")
            itemamt:SetText( v )
            itemamt:SetContentAlignment( 3 )
            itemamt:SizeToContents()
            itemamt:SetPos( (panel:GetWide() - itemamt:GetWide()) - 2, panel:GetTall() - itemamt:GetTall() )
            local function itemamtUpdate()
                if LocalPlayer():GetInventory()[k] then
                    if IsValid( itemamt ) and IsValid( weightlbl ) then
                        itemamt:SetText( LocalPlayer():GetInventory()[k] )
                        itemamt:SizeToContents()
                        itemamt:SetPos( (panel:GetWide() - itemamt:GetWide()) - 2, panel:GetTall() - itemamt:GetTall() )
                        weightlbl:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
                        weightlbl:SizeToContents()
                    end
                else
                    if IsValid( panel ) and IsValid( weightlbl ) then
                        panel:Remove()
                        weightlbl:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
                        weightlbl:SizeToContents()
                    end
                end
            end

            panel:SetModel( AS.Items[k].model, AS.Items[k].skin or 0 )
            local TTtext = v > 1 and name .. "\n" .. desc .. "\nWeight: " .. weight .. " [" .. (isnumber(weight) and weight * v or "w?") .. "]" or name .. "\n" .. desc .. "\nWeight: " .. weight
            panel:SetTooltip(TTtext)
            panel.DoClick = function()
                if AS.Items[k].use then
                    if not LocalPlayer():CanUseItem( k ) then return end
                    LocalPlayer():TakeItemFromInventory( k, 1 )
                    itemamtUpdate()
                    net.Start("as_inventory_useitem")
                        net.WriteString( k )
                    net.SendToServer()
                elseif AS.Items[k].wep then
                    if not LocalPlayer():CanEquipItem( k ) then return end
                    LocalPlayer():TakeItemFromInventory( k, 1 )
                    itemamtUpdate()
                    net.Start("as_inventory_equipitem")
                        net.WriteString( k )
                    net.SendToServer()
                end
            end
            panel.DoRightClick = function()
                local options = vgui.Create("DMenu")
                --Use
                if AS.Items[k].use then
                    options:AddOption("Use", function()
                        if not LocalPlayer():CanUseItem( k ) then return end
                        LocalPlayer():TakeItemFromInventory( k, 1 )
                        itemamtUpdate()
                        net.Start("as_inventory_useitem")
                            net.WriteString( k )
                        net.SendToServer()
                    end)
                end
                --Equip
                if AS.Items[k].wep then
                    options:AddOption("Equip", function()
                        if not LocalPlayer():CanEquipItem( k ) then return end
                        LocalPlayer():TakeItemFromInventory( k, 1 )
                        itemamtUpdate()
                        net.Start("as_inventory_equipitem")
                            net.WriteString( k )
                        net.SendToServer()
                    end)
                end
                --Drop
                local function dropItem( item, amt )
                    LocalPlayer():TakeItemFromInventory( item, amt )
                    itemamtUpdate()
                    net.Start("as_inventory_dropitem")
                        net.WriteString( item )
                        net.WriteInt( amt, 32 )
                    net.SendToServer()
                end
                if v > 1 then
                    options:AddOption("Drop 1", function()
                        dropItem( k, 1 )
                    end)
                    options:AddOption("Drop X", function()
                        VerifySlider( LocalPlayer():GetInventory()[k], function( amt )
                            dropItem( k, amt )
                        end )
                    end)
                end
                options:AddOption("Drop All", function()
                    dropItem( k, v )
                end)
                --Destroy
                if AS.Items[k].salvage then
                    local function destroyItem( item, amt )
                        LocalPlayer():TakeItemFromInventory( item, amt )
                        if AS.Items[item].salvage then
                            for k, v in pairs( AS.Items[item].salvage ) do
                                LocalPlayer():AddItemToInventory( k, v )
                            end
                        end
                        itemamtUpdate()
                        net.Start("as_inventory_destroyitem")
                            net.WriteString( item )
                            net.WriteInt( amt, 32 )
                        net.SendToServer()
                    end
                    if v > 1 then
                        options:AddOption("Salvage 1", function()
                            Verify( function() 
                                destroyItem( k, 1 )
                            end )
                        end)
                        options:AddOption("Salvage X", function()
                            VerifySlider( LocalPlayer():GetInventory()[k], function( amt )
                                destroyItem( k, amt )
                            end )
                        end)
                    end
                    options:AddOption("Salvage All", function()
                        Verify( function() 
                            destroyItem( k, v )
                        end )
                    end)
                end
                options:Open()
                function options:Think()
                    if not IsValid( frame_inventory ) then options:Hide() end
                end
            end
            panel.Paint = function(self,w,h)
                if info.color then
                    surface.SetDrawColor( info.color )
                else
                    surface.SetDrawColor( COLHUD_PRIMARY )
                end
                surface.DrawRect( 0, 0, w, h )
            end
        end

        return scroll_items
    end

    function BuildAllSheets()
        sheets_items:AddSheet("Weapons", BuildItemList(sheets_items, "weapon"), "icon16/gun.png")
        sheets_items:AddSheet("Armor", BuildItemList(sheets_items, "armor"), "icon16/user.png")
        sheets_items:AddSheet("Ammo", BuildItemList(sheets_items, "ammo"), "icon16/briefcase.png")
        sheets_items:AddSheet("Medical", BuildItemList(sheets_items, "med"), "icon16/heart.png")
        sheets_items:AddSheet("Food", BuildItemList(sheets_items, "food"), "icon16/cup.png")
        sheets_items:AddSheet("Vehicle", BuildItemList(sheets_items, "vehicle"), "icon16/car.png")
        sheets_items:AddSheet("Tool", BuildItemList(sheets_items, "tool"), "icon16/wrench.png")
        sheets_items:AddSheet("Misc", BuildItemList(sheets_items, "misc"), "icon16/cog.png")
        sheets_items:AddSheet("All", BuildItemList(sheets_items), "icon16/basket.png")
    end

    if GetConVar("as_menu_inventory_singlepanel"):GetInt() < 1 then
        BuildAllSheets()
    else
        sheets_items:AddSheet("All", BuildItemList(sheets_items), "icon16/basket.png")
    end

--Character Panel
    local characterpanel = vgui.Create( "DPanel", inventory )
    characterpanel:SetSize( 300, 434 )
    characterpanel:Dock( RIGHT )
    characterpanel:DockMargin( 5, 0, 0, 120 )
    function characterpanel:Paint(w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local characterdisplay = vgui.Create( "DModelPanel", characterpanel )
    characterdisplay:SetSize( characterpanel:GetWide(), characterpanel:GetTall() )
    characterdisplay:SetFOV( 22 )
    characterdisplay:SetModel(LocalPlayer():GetModel())
    local eyepos = characterdisplay.Entity:GetBonePosition(characterdisplay.Entity:LookupBone("ValveBiped.Bip01_Head1")) or Vector(0,0,0)
    eyepos:Add(Vector(0,0,-23))
	characterdisplay:SetLookAt( eyepos )
    characterdisplay:SetCamPos( eyepos - Vector(-140,0,-10) )
    characterdisplay.Angles = Angle( 0, 70, 90 )
    function characterdisplay:DragMousePress()
        self.PressX, self.PressY = gui.MousePos()
        self.Pressed = true
    end
    function characterdisplay:DragMouseRelease()
        self.Pressed = false
    end
    function characterdisplay:LayoutEntity( Entity )
        Entity:SetEyeTarget(Entity:GetForward() * 20 + Entity:GetUp() * 70)
        if ( self.Pressed ) then
            local mx, my = gui.MousePos()
            self.Angles = self.Angles - Angle( 0, ( self.PressX or mx ) - mx, 0 )

            self.PressX, self.PressY = gui.MousePos()
        end
        Entity:SetPos(Vector(0,0,5))
        Entity:SetAngles( self.Angles + Angle(0,-100,-90) )
    end
    function characterdisplay:Think()
        if realchars and realchars[selectedChar] and self:GetModel() != realchars[selectedChar].model then
            self:SetModel(realchars[selectedChar].model)
        end
    end

    local charname = vgui.Create("DLabel", characterdisplay)
    charname:SetPos( 5, 5 )
    charname:SetFont("TargetID")
    charname:SetText( LocalPlayer():Nickname() )
    charname:SizeToContents()

    local class = vgui.Create("DLabel", characterdisplay)
    class:SetPos( 5, 25 )
    class:SetFont("TargetID")
    class:SetText( translateClassNameID( LocalPlayer():GetASClass() ) )
    class:SetColor( AS.Classes[LocalPlayer():GetASClass()].color )
    class:SizeToContents()

--Weapons/Ammo Panel
    local weaponpanel = vgui.Create( "DPanel", inventory )
    weaponpanel:SetPos( 674, 440 )
    weaponpanel:SetSize( 300, 115 )
    function weaponpanel:Paint(w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local weaponscroll = vgui.Create( "DHorizontalScroller", weaponpanel )
    weaponscroll:SetSize( weaponscroll:GetParent():GetWide() - 5, weaponscroll:GetParent():GetTall() - 5 )
    weaponscroll:SetPos( 2, 2 )
    weaponscroll:SetOverlap( -2 )

    for k, v in SortedPairs( LocalPlayer():GetWeapons() ) do
        if SET.DefaultWeapons[v:GetClass()] then continue end --Default weapons arent real get out of my walls
        if not v.ASID then continue end --stupid method but it works, need to tie an id to the weapons

        local weaponinfopanel = vgui.Create("DPanel")
        weaponinfopanel:SetSize( 70, weaponscroll:GetTall() )
        function weaponinfopanel:Paint(w,h)
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        local weaponname = vgui.Create("DLabel", weaponinfopanel)
        weaponname:SetPos( 0, 0 )
        weaponname:SetFont("TargetIDSmall")
        weaponname:SetText( AS.Items[v.ASID].name )
        weaponname:SizeToContents()

        local model = vgui.Create("SpawnIcon", weaponinfopanel)
        model:SetPos( 0, 15 )
        model:SetSize( weaponinfopanel:GetWide(), weaponinfopanel:GetWide() )
        model:SetModel( AS.Items[v.ASID].model, AS.Items[v.ASID].skin or 0 )
        model:SetTooltip(AS.Items[v.ASID].name)

        local unequipwep = vgui.Create("DButton", weaponinfopanel)
        unequipwep:SetSize( weaponinfopanel:GetWide() - 2, 18  )
        unequipwep:SetPos( 1, weaponinfopanel:GetTall() - unequipwep:GetTall() - 2)
        unequipwep:SetText("Unequip")
        function unequipwep:DoClick()
            if not LocalPlayer():CanUnequipItem( v.ASID ) then return end
            LocalPlayer():AddItemToInventory( v.ASID )
            self:GetParent():Remove()
            net.Start("as_inventory_unequipitem")
                net.WriteString( v.ASID )
            net.SendToServer()
        end

        weaponscroll:AddPanel( weaponinfopanel )
    end

    for k, v in SortedPairs( LocalPlayer():GetAmmo() ) do
        local ammoid, itemid = game.GetAmmoID( k ), translateAmmoNameID( game.GetAmmoName( k ) )
        if not itemid then continue end --doesnt have any item information, not a real item please leave my walls

        local ammoinfopanel = vgui.Create("DPanel")
        ammoinfopanel:SetSize( 70, weaponscroll:GetTall() )
        function ammoinfopanel:Paint(w,h)
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        local ammoname = vgui.Create("DLabel", ammoinfopanel)
        ammoname:SetPos( 0, 0 )
        ammoname:SetFont("TargetIDSmall")
        ammoname:SetText( AS.Items[itemid].name )
        ammoname:SizeToContents()

        local model = vgui.Create("SpawnIcon", ammoinfopanel)
        model:SetPos( 0, 15 )
        model:SetSize( ammoinfopanel:GetWide(), ammoinfopanel:GetWide() )
        model:SetModel( AS.Items[itemid].model, AS.Items[itemid].skin or 0 )
        model:SetTooltip(AS.Items[itemid].name)

        local ammoamt = vgui.Create("DLabel", ammoinfopanel)
        ammoamt:SetPos( 0, 75 )
        ammoamt:SetFont("TargetIDSmall")
        ammoamt:SetText( "x" .. v )
        ammoamt:SizeToContents()

        local amttopackage = math.floor(v / AS.Items[itemid].use.ammoamt)
        if amttopackage > 0 then
            local unequipammo = vgui.Create("DButton", ammoinfopanel)
            unequipammo:SetSize( ammoinfopanel:GetWide() - 2, 18  )
            unequipammo:SetPos( 1, ammoinfopanel:GetTall() - unequipammo:GetTall() - 2)
            unequipammo:SetText("Unequip")
            function unequipammo:DoClick()
                VerifySlider( amttopackage, function( amt )
                    LocalPlayer():AddItemToInventory( itemid, amt )
                    self:GetParent():Remove()
                    net.Start("as_inventory_unequipammo")
                        net.WriteString( itemid )
                        net.WriteInt( amt, 32 )
                    net.SendToServer()
                end)
            end
        end

        weaponscroll:AddPanel( ammoinfopanel )
    end

    return inventory
end

function AS.Inventory.BuildSkills()
    local skills = vgui.Create("DPanel", sheet)
    skills.Paint = function() end

    local scroll_skills = vgui.Create("DScrollPanel", skills)
    scroll_skills:SetSize( 774, 0 )
    scroll_skills:Dock( FILL )
    scroll_skills:DockMargin( 0, 0, 0, 0 )
    scroll_skills.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)
    end

    for k, v in SortedPairs( AS.Skills ) do
        local itempanel = scroll_skills:Add( "DPanel" )
        itempanel:Dock( TOP )
        itempanel:DockMargin( 5, 5, 5, 0 )
        itempanel:SetSize( 0, 100 )
        itempanel.Paint = function(_,w,h)
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
            --Bar Background
            surface.SetDrawColor( COLHUD_SECONDARY )
            local width, height = (w - (5 * 2)), 20
            surface.DrawRect( (w - width) - 5, (h - height) - 5, width, height )
            --Bar
            surface.SetDrawColor( COLHUD_TERTIARY )
            surface.DrawRect( (w - width) - 5, (h - height) - 5, (LocalPlayer():GetSkillExperience( k ) / LocalPlayer():ExpToLevelSkill( k )) * 740, 20)
        end

        local skillname = vgui.Create("DLabel", itempanel)
        skillname:SetPos( 5, 5 )
        skillname:SetFont("TargetID")
        skillname:SetText( v.name )
        skillname:SizeToContents()

        local skilldesc = vgui.Create("DLabel", itempanel)
        skilldesc:SetPos( 20, 22 )
        skilldesc:SetFont("TargetIDSmall")
        skilldesc:SetText( v.desc )
        skilldesc:SizeToContents()

        local skilllevel = vgui.Create("DLabel", itempanel)
        skilllevel:SetPos( 5, 55 )
        skilllevel:SetFont("TargetID")
        skilllevel:SetText( "Level " .. LocalPlayer():GetSkillLevel( k ) .. " / " .. AS.Skills[k].max )
        skilllevel:SizeToContents()

        local experience = vgui.Create("DLabel", itempanel)
        experience:SetPos( 8, 76 )
        experience:SetFont("TargetID")
        experience:SetText( LocalPlayer():GetSkillExperience( k ) .. " / " .. LocalPlayer():ExpToLevelSkill( k ) )
        experience:SizeToContents()
        function experience:Think()
            if self:GetText() != LocalPlayer():GetSkillExperience( k ) .. " / " .. LocalPlayer():ExpToLevelSkill( k ) then
                self:SetText( LocalPlayer():GetSkillExperience( k ) .. " / " .. LocalPlayer():ExpToLevelSkill( k ) )
                self:SizeToContents()
            end
        end
    end

    return skills
end

function AS.Inventory.BuildMissions()
    local missions = vgui.Create("DPanel", sheet)
    missions.Paint = function() end

    return missions
end

function AS.Inventory.BuildStats()
    local stats = vgui.Create("DPanel", sheet)
    stats.Paint = function() end

    local scroll_stats = vgui.Create("DScrollPanel", stats)
    scroll_stats:SetSize( 774, 0 )
    scroll_stats:Dock( FILL )
    scroll_stats:DockMargin( 0, 0, 0, 0 )
    scroll_stats.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)
    end

    SmallLabel( "Playtime", 5, 0, scroll_stats )
    SmallLabel( LocalPlayer():GetPlaytimeHourMin(), 200, 0, scroll_stats )

    return stats
end