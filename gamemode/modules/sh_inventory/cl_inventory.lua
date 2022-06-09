--I should probably note that this entire file is shitcoded, if you're looking at this im truly sorry lol

AS.Inventory = {}

-- ███╗   ███╗███████╗███╗   ██╗██╗   ██╗
-- ████╗ ████║██╔════╝████╗  ██║██║   ██║
-- ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
-- ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
-- ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
-- ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝

AS_ClientConVar( "as_menu_inventory_holdtoopen", "1", true, false )
AS_ClientConVar( "as_menu_inventory_singlepanel", "0", true, false )
AS_ClientConVar( "as_menu_inventory_itemiconsize", "60", true, false )

NextInventoryOpen = 0
function AS.Inventory.Open( tab, forcehold )
    if not LocalPlayer():IsLoaded() then return end
    if not LocalPlayer():Alive() then return end
    if CurTime() < NextInventoryOpen then return end
    if IsValid(frame_inventory) then frame_inventory:Close() end

    frame_inventory = vgui.Create("DFrame")
    frame_inventory:SetSize(900, 750)
    frame_inventory:Center()
    frame_inventory:MakePopup()
    frame_inventory:SetDraggable( false )
    frame_inventory:SetTitle( "" )
    frame_inventory:ShowCloseButton( false )
    function frame_inventory:Paint( w, h )
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetMaterial( Material("gui/aftershock/default.png") )
        surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
        surface.DrawTexturedRect( 0, 0, w, h )
    end
    if GetConVar("as_menu_inventory_holdtoopen"):GetInt() > 0 and not forcehold then
        frame_inventory.Think = function( self )
            if not input.IsButtonDown( input.GetKeyCode( GetConVarString("as_bind_inventory") ) ) 
            and not input.IsButtonDown( input.GetKeyCode( GetConVarString("as_bind_stats") ) ) 
            and not input.IsButtonDown( input.GetKeyCode( GetConVarString("as_bind_skills") ) ) 
            and not input.IsButtonDown( input.GetKeyCode( GetConVarString("as_bind_players") ) ) then
                self:Close()
            end
        end
    end

    local cbuttonsize = 24
    local closebutton = CreateCloseButton( frame_inventory, cbuttonsize, frame_inventory:GetWide() - cbuttonsize - 6, 3 )

    local x, y = 47, 31
    sheets = CreateSheetPanel( frame_inventory, frame_inventory:GetWide() - x - 56, frame_inventory:GetTall() - y - 45, x, y )

    sheets:AddSheet("Inventory", AS.Inventory.BuildInventory(), "icon16/box.png")
    sheets:AddSheet("Skills", AS.Inventory.BuildSkills(), "icon16/user.png")
    sheets:AddSheet("Community", AS.Inventory.BuildCommunity(), "icon16/vcard.png")
    sheets:AddSheet("Statistics", AS.Inventory.BuildStats(), "icon16/chart_line.png")
    sheets:AddSheet("Players", AS.Inventory.BuildPlayers(), "icon16/user_gray.png")
    --[[
    sheets:AddSheet("Missions", AS.Inventory.BuildMissions(), "icon16/map.png")
    ]]

    local nearvehicle = LocalPlayer():NearVehicle()
    if nearvehicle then
        local vehicleinv = DefaultButton( "Vehicle Inv", sheets:GetWide() - 248, 3, 80, 20, sheets, function()
            AS.Storage.Menu( nearvehicle )
            NextInventoryOpen = CurTime() + 0.1
            frame_inventory:Close()
        end)
    end

    local classes = DefaultButton( "Classes (" .. GetConVarString("as_bind_class") .. ")", sheets:GetWide() - 168, 3, 80, 20, sheets, function()
        AS.Class.Open()
        NextInventoryOpen = CurTime() + 0.1
        frame_inventory:Close()
    end)

    local crafting = DefaultButton( "Crafting (" .. GetConVarString("as_bind_craft") .. ")", sheets:GetWide() - 88, 3, 80, 20, sheets, function()
        AS.Craft.Open()
        NextInventoryOpen = CurTime() + 0.1
        frame_inventory:Close()
    end)

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

function AS.Inventory.BuildInventory()
    local inventory = vgui.Create("DPanel", sheets)
    inventory.Paint = function(_,w,h) end

-- Items Panel
    local itempanel = vgui.Create( "DPanel", inventory )
    itempanel:SetSize( 485, 450 )
    function itempanel:Paint(w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    local weightpanel = vgui.Create( "DPanel", itempanel )
    weightpanel:SetPos( 5, itempanel:GetTall() - 25 )
    weightpanel:SetSize( itempanel:GetWide() - (weightpanel:GetX() * 2), 20 )
    function weightpanel:Paint(w,h)
        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h )

        local col = COLHUD_DEFAULT:ToTable()
        surface.SetDrawColor( col[1], col[2], col[3], 150 )
        surface.DrawRect( 0, 0, (LocalPlayer():GetCarryWeight() / LocalPlayer():MaxCarryWeight()) * w, h )
    end

    local weightlbl = vgui.Create("DLabel", weightpanel)
    weightlbl:SetFont("TargetID")
    weightlbl:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
    weightlbl:SetContentAlignment( 3 )
    weightlbl:SizeToContents()
    weightlbl:SetPos( weightpanel:GetWide() / 2 - weightlbl:GetWide() / 2, 1 )
    if LocalPlayer():GetCarryWeight() <= LocalPlayer():MaxCarryWeight() then
        weightlbl:SetColor( Color( 255, 255, 255 ) )
    else
        weightlbl:SetColor( COLHUD_BAD )
    end

    local sheets_items = vgui.Create("DPropertySheet", itempanel)
    sheets_items:SetPos(0, 0)
    sheets_items:SetFadeTime( 0 )
    sheets_items:SetSize( sheets_items:GetParent():GetWide(), sheets_items:GetParent():GetTall() - (weightpanel:GetTall() + 5) )
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
            local size = GetConVar("as_menu_inventory_itemiconsize"):GetInt()
            panel:SetSize( size, size )

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
                elseif AS.Items[k].category == "tool" then
                    LocalPlayer():TakeItemFromInventory( k, 1 )
                    itemamtUpdate()
                    net.Start("as_inventory_dropitem")
                        net.WriteString( k )
                        net.WriteUInt( 1, NWSetting.ItemAmtBits )
                    net.SendToServer()
                elseif AS.Items[k].category == "vehicle" then
                    LocalPlayer():TakeItemFromInventory( k, 1 )
                    itemamtUpdate()
                    net.Start("as_inventory_dropitem")
                        net.WriteString( k )
                        net.WriteUInt( 1, NWSetting.ItemAmtBits )
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
                        net.WriteUInt( amt, NWSetting.ItemAmtBits )
                    net.SendToServer()
                end
                if AS.Items[k].category != "tool" and AS.Items[k].category != "vehicle" then
                    if not AS.Items[k].nodrop then
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
                    end
                else
                    options:AddOption("Deploy", function()
                        dropItem( k, 1 )
                    end)
                end
                --Destroy
                if AS.Items[k].craft then
                    local function destroyItem( item, amt )
                        LocalPlayer():TakeItemFromInventory( item, amt )
                        for k, v in pairs( CalculateItemSalvage(item, amt) ) do
                            LocalPlayer():AddItemToInventory( k, v )
                        end
                        itemamtUpdate()
                        net.Start("as_inventory_destroyitem")
                            net.WriteString( item )
                            net.WriteUInt( amt, NWSetting.ItemAmtBits )
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
            function panel:Paint( w, h )
                local col = info.color and info.color:ToTable() or COLHUD_PRIMARY:ToTable()
                surface.SetDrawColor( col[1], col[2], col[3], 50 )
                surface.DrawRect( 0, 0, w, h )

                if info.color then
                    surface.SetDrawColor( info.color )
                else
                    surface.SetDrawColor( COLHUD_PRIMARY )
                end
                surface.DrawOutlinedRect( 0, 0, w, h, 1 )
            end
        end

        return scroll_items
    end

    function BuildAllSheets()
        sheets_items:AddSheet("Weapons" .. LocalPlayer():CountCategoryAmount( "weapon" ), BuildItemList(sheets_items, "weapon"), "icon16/gun.png")
        sheets_items:AddSheet("Armor" .. LocalPlayer():CountCategoryAmount( "armor" ), BuildItemList(sheets_items, "armor"), "icon16/user.png")
        sheets_items:AddSheet("Ammo" .. LocalPlayer():CountCategoryAmount( "ammo" ), BuildItemList(sheets_items, "ammo"), "icon16/briefcase.png")
        sheets_items:AddSheet("Medical" .. LocalPlayer():CountCategoryAmount( "med" ), BuildItemList(sheets_items, "med"), "icon16/heart.png")
        sheets_items:AddSheet("Food" .. LocalPlayer():CountCategoryAmount( "food" ), BuildItemList(sheets_items, "food"), "icon16/cup.png")
        sheets_items:AddSheet("Vehicle" .. LocalPlayer():CountCategoryAmount( "vehicle" ), BuildItemList(sheets_items, "vehicle"), "icon16/car.png")
        sheets_items:AddSheet("Tool" .. LocalPlayer():CountCategoryAmount( "tool" ), BuildItemList(sheets_items, "tool"), "icon16/wrench.png")
        sheets_items:AddSheet("Misc" .. LocalPlayer():CountCategoryAmount( "misc" ), BuildItemList(sheets_items, "misc"), "icon16/cog.png")
    end

    if GetConVar("as_menu_inventory_singlepanel"):GetInt() < 1 then
        BuildAllSheets()
    else
        sheets_items:AddSheet("All", BuildItemList(sheets_items), "icon16/add.png")
    end

--Character Panel
    local characterpanel = vgui.Create( "DPanel", inventory )
    characterpanel:SetSize( sheets:GetWide() - (itempanel:GetWide() + 26), itempanel:GetTall() )
    characterpanel:SetPos( itempanel:GetWide() + 10, 0 )
    function characterpanel:Paint(w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
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
    function characterdisplay:DrawModel()
        self.Entity:DrawModel()
        local armorwep = LocalPlayer():GetArmorWep()
        if LocalPlayer().ArmorOverlay and LocalPlayer():HasArmor() and armorwep.ArmorModel then
            if not IsValid( self.Entity.ArmorOverlay ) then
                self.Entity.ArmorOverlay = ClientsideModel( armorwep.ArmorModel, RENDERGROUP_BOTH )
                self.Entity.ArmorOverlay:SetNoDraw( true )
            end

            if IsValid( self.Entity.ArmorOverlay ) then
                if armorwep.BoneMerge then --Bone merging
                    self.Entity.ArmorOverlay:SetParent( self.Entity )
                    self.Entity.ArmorOverlay:AddEffects( EF_BONEMERGE )
                end
                if armorwep.Scale or armorwep.ScaleFemale then
                    local scale = LocalPlayer():IsFemale() and armorwep.ScaleFemale or armorwep.Scale or 1
                    for i = 0, self.Entity.ArmorOverlay:GetBoneCount() do
                        self.Entity.ArmorOverlay:ManipulateBoneScale( i, Vector( scale, scale, scale ) )
                    end
                end
                self.Entity.ArmorOverlay:DrawModel()
            end
        end
    end
    function characterdisplay:Think()
        if realchars and realchars[selectedChar] and self:GetModel() != realchars[selectedChar].model then
            self:SetModel(realchars[selectedChar].model)
        end
    end

    local charname = vgui.Create("DLabel", characterpanel)
    charname:SetPos( 5, 5 )
    charname:SetFont("TargetID")
    charname:SetText( LocalPlayer():Nickname() )
    charname:SizeToContents()

    local class = vgui.Create("DLabel", characterpanel)
    class:SetPos( 5, 25 )
    class:SetFont("TargetID")
    class:SetText( translateClassNameID( LocalPlayer():GetASClass() ) )
    class:SetColor( AS.Classes[LocalPlayer():GetASClass()].color )
    class:SizeToContents()

    local hunger = vgui.Create("DPanel", characterpanel)
    hunger:SetPos( 15, characterpanel:GetTall() - 30)
    hunger:SetSize( 120, 10 )
    function hunger:Paint( w, h )
        local col = COLHUD_DEFAULT:ToTable()
        surface.SetDrawColor( col[1], col[2], col[3], 150 )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
        surface.DrawRect( 0, 0, (LocalPlayer():GetHunger() / LocalPlayer():GetMaxHunger()) * w, h )

        surface.SetDrawColor( COLHUD_GOOD )
        surface.DrawRect( ((w / LocalPlayer():GetMaxHunger()) * SAT.SatBuffs), 1, 1, h - 2)
    end

    local hungericon = vgui.Create("DPanel", characterdisplay)
    hungericon:SetPos( 3, characterpanel:GetTall() - 30 )
    hungericon:SetSize( 10, 10 )
    function hungericon:Paint( w, h )
        surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
        surface.SetMaterial( Material("icon16/cup.png") )
        surface.DrawTexturedRect( 0, 0, w, h )
    end

    local hungeramt = vgui.Create("DLabel", characterdisplay)
    hungeramt:SetPos( hungericon:GetWide() + hunger:GetWide() + 10, characterpanel:GetTall() - 33 )
    hungeramt:SetFont("TargetIDSmall")
    function hungeramt:Think()
        hungeramt:SetText( (LocalPlayer():GetHunger() / LocalPlayer():GetMaxHunger()) * 100 .. "%" )
        hungeramt:SizeToContents()
    end

    local thirst = vgui.Create("DPanel", characterdisplay)
    thirst:SetPos( 15, characterpanel:GetTall() - 15)
    thirst:SetSize( 120, 10 )
    function thirst:Paint( w, h )
        local col = COLHUD_DEFAULT:ToTable()
        surface.SetDrawColor( col[1], col[2], col[3], 150 )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
        surface.DrawRect( 0, 0, (LocalPlayer():GetThirst() / LocalPlayer():GetMaxThirst()) * w, h )

        surface.SetDrawColor( COLHUD_GOOD )
        surface.DrawRect( ((w / LocalPlayer():GetMaxThirst()) * SAT.SatBuffs), 1, 1, h - 2)
    end

    local thirsticon = vgui.Create("DPanel", characterdisplay)
    thirsticon:SetPos( 3, characterpanel:GetTall() - 15 )
    thirsticon:SetSize( 10, 10 )
    function thirsticon:Paint( w, h )
        surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
        surface.SetMaterial( Material("icon16/drink.png") )
        surface.DrawTexturedRect( 0, 0, w, h )
    end

    local thirstamt = vgui.Create("DLabel", characterdisplay)
    thirstamt:SetPos( thirsticon:GetWide() + thirst:GetWide() + 10, characterpanel:GetTall() - 18 )
    thirstamt:SetFont("TargetIDSmall")
    function thirstamt:Think()
        thirstamt:SetText( (LocalPlayer():GetThirst() / LocalPlayer():GetMaxThirst()) * 100 .. "%" )
        thirstamt:SizeToContents()
    end

--Weapons/Ammo Panel
    local weaponpanel = vgui.Create( "DPanel", inventory )
    weaponpanel:SetPos( 0, itempanel:GetTall() + 10 )
    weaponpanel:SetSize( sheets:GetWide() / 2, 175 )
    function weaponpanel:Paint(w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    local weaponscroll = vgui.Create( "DHorizontalScroller", weaponpanel )
    weaponscroll:SetSize( weaponscroll:GetParent():GetWide() - 5, weaponscroll:GetParent():GetTall() - 10 )
    weaponscroll:SetPos( 5, 5 )
    weaponscroll:SetOverlap( -3 )

    for k, v in SortedPairs( LocalPlayer():GetWeapons() ) do
        if not v.ASID then continue end --stupid method but it works, need to tie an id to the weapons
        if SET.DefaultWeapons[v:GetClass()] then continue end --Default weapons arent real get out of my walls
        if v.ASArmor then continue end

        local weaponinfopanel = vgui.Create("DPanel")
        weaponinfopanel:SetSize( 100, weaponscroll:GetTall() - (weaponscroll:GetY() * 2) )
        function weaponinfopanel:Paint(w,h)
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )

            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawOutlinedRect( 0, 0, w, h, 1 )
        end

        local weaponname = vgui.Create("DLabel", weaponinfopanel)
        weaponname:SetPos( 3, 3 )
        weaponname:SetFont("TargetIDSmall")
        weaponname:SetText( AS.Items[v.ASID].name )
        weaponname:SetSize( weaponinfopanel:GetWide(), 15 )

        local model = vgui.Create("SpawnIcon", weaponinfopanel)
        model:SetSize( weaponinfopanel:GetWide(), weaponinfopanel:GetWide() )
        model:SetPos( 0, weaponinfopanel:GetTall() / 2 - (model:GetTall() / 2) )
        model:SetModel( v.WM or v.WorldModel or "", AS.Items[v.ASID].skin or 0 )
        model:SetTooltip(AS.Items[v.ASID].name)

        DefaultButton( "Unequip", 3, weaponinfopanel:GetTall() - 12, weaponinfopanel:GetWide() - 6, 18, weaponinfopanel, function( self )
            if not LocalPlayer():CanUnequipItem( v.ASID ) then return end
            LocalPlayer():AddItemToInventory( v.ASID )
            self:GetParent():Remove()
            net.Start("as_inventory_unequipitem")
                net.WriteString( v.ASID )
            net.SendToServer()
        end)

        weaponscroll:AddPanel( weaponinfopanel )
    end

    for k, v in SortedPairs( LocalPlayer():GetAmmo() ) do
        local ammoid, itemid = game.GetAmmoID( k ), translateAmmoNameID( game.GetAmmoName( k ) )
        if not itemid then continue end --doesnt have any item information, not a real item please leave my walls

        local ammoinfopanel = vgui.Create("DPanel")
        ammoinfopanel:SetSize( 100, weaponscroll:GetTall() - (weaponscroll:GetY() * 2)  )
        function ammoinfopanel:Paint(w,h)
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )

            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawOutlinedRect( 0, 0, w, h, 1 )
        end

        local ammoname = vgui.Create("DLabel", ammoinfopanel)
        ammoname:SetPos( 3, 3 )
        ammoname:SetFont("TargetIDSmall")
        ammoname:SetText( AS.Items[itemid].name )
        ammoname:SetSize( ammoinfopanel:GetWide(), 15 )

        local model = vgui.Create("SpawnIcon", ammoinfopanel)
        model:SetSize( ammoinfopanel:GetWide(), ammoinfopanel:GetWide() )
        model:SetPos( 0, ammoinfopanel:GetTall() / 2 - (model:GetWide() / 2) )
        model:SetModel( AS.Items[itemid].model, AS.Items[itemid].skin or 0 )
        model:SetTooltip(AS.Items[itemid].name)

        local ammoamt = vgui.Create("DLabel", ammoinfopanel)
        ammoamt:SetPos( 1, model:GetY() + model:GetTall() )
        ammoamt:SetFont("TargetIDSmall")
        ammoamt:SetText( "x" .. v )
        ammoamt:SizeToContents()

        local amttopackage = math.floor(v / AS.Items[itemid].use.ammoamt)
        if amttopackage > 0 then
            DefaultButton( "Unequip", 3, ammoinfopanel:GetTall() - 12, ammoinfopanel:GetWide() - 6, 18, ammoinfopanel, function( self )
                VerifySlider( amttopackage, function( amt )
                    if not LocalPlayer():CanUnequipAmmo( itemid, amt ) then return end
                    LocalPlayer():AddItemToInventory( itemid, amt )
                    if IsValid(self:GetParent()) then
                        self:GetParent():Remove()
                    end
                    net.Start("as_inventory_unequipammo")
                        net.WriteString( itemid )
                        net.WriteUInt( amt, NWSetting.ItemAmtBits )
                    net.SendToServer()
                end)
            end)
        end

        weaponscroll:AddPanel( ammoinfopanel )
    end

    for k, v in SortedPairs( LocalPlayer():GetAttachmentInventory() ) do
        local itemid = v
        if not AS.Items[itemid] then continue end

        local atchinfopanel = vgui.Create("DPanel")
        atchinfopanel:SetSize( 100, weaponscroll:GetTall() - (weaponscroll:GetY() * 2)  )
        function atchinfopanel:Paint(w,h)
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )

            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawOutlinedRect( 0, 0, w, h, 1 )
        end

        local name = vgui.Create("DLabel", atchinfopanel)
        name:SetPos( 3, 3 )
        name:SetFont("TargetIDSmall")
        name:SetText( AS.Items[itemid].name )
        name:SetSize( atchinfopanel:GetWide(), 15 )

        local model = vgui.Create("SpawnIcon", atchinfopanel)
        model:SetSize( atchinfopanel:GetWide(), atchinfopanel:GetWide() )
        model:SetPos( 0, atchinfopanel:GetTall() / 2 - (model:GetWide() / 2) )
        model:SetModel( AS.Items[itemid].model, AS.Items[itemid].skin or 0 )
        model:SetTooltip(AS.Items[itemid].name)

        DefaultButton( "Unequip", 3, atchinfopanel:GetTall() - 12, atchinfopanel:GetWide() - 6, 18, atchinfopanel, function( self )
            if not LocalPlayer():CanUnequipItem( itemid ) then return end
            LocalPlayer():AddItemToInventory( itemid )
            self:GetParent():Remove()
            net.Start("as_inventory_unequipatch")
                net.WriteString( itemid )
            net.SendToServer()
        end)

        weaponscroll:AddPanel( atchinfopanel )
    end

--Armor Panel
    local armorpanel = vgui.Create( "DPanel", inventory )
    armorpanel:SetPos( weaponpanel:GetWide() + 10, weaponpanel:GetY() )
    armorpanel:SetSize( sheets:GetWide() - (weaponpanel:GetWide() + 26), weaponpanel:GetTall() )
    function armorpanel:Paint(w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    local armor = vgui.Create( "DPanel", armorpanel )
    armor:SetPos( 5, 5 )
    armor:SetSize( 100, armorpanel:GetTall() - (armor:GetY() * 2) )
    function armor:Paint(w,h)
        surface.SetDrawColor( COLHUD_PRIMARY )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
    end

    local armorname = vgui.Create("DLabel", armor)
    armorname:SetPos( 3, 3 )
    armorname:SetFont("TargetIDSmall")
    armorname:SetText( "Clothes" )
    armorname:SetSize( armor:GetWide(), 15 )

    if LocalPlayer():HasArmor() then
        local curarmor = LocalPlayer():GetArmor()
        local curarmorwep = LocalPlayer():GetArmorWep()

        armorname:SetText( AS.Items[curarmor].name )

        local stats = vgui.Create( "DPanel", armorpanel )
        stats:SetPos( armor:GetWide() + 10, 5 )
        stats:SetSize( armorpanel:GetWide() - (stats:GetX() + 5), armorpanel:GetTall() - (stats:GetY() * 2) )
        function stats:Paint(w,h)
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )

            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawOutlinedRect( 0, 0, w, h, 1 )
        end

        local scroll_stats = vgui.Create("DScrollPanel", stats)
        scroll_stats:SetSize( scroll_stats:GetParent():GetWide(), scroll_stats:GetParent():GetTall() )
        scroll_stats.Paint = function() end

        local ypos = 10
        for k, v in pairs( AS.Items[curarmor].armor ) do
            if not AS.DamageTypes[k] then continue end

            local statbg = scroll_stats:Add( "DPanel" )
            statbg:SetPos( 0, ypos )
            statbg:SetSize( scroll_stats:GetWide(), 25 )
            local TTtext = AS.DamageTypes[k].name .. ": " .. v .. "%"
            statbg:SetTooltip( TTtext )
            statbg.Paint = function(_,w,h)
                w = w - 65
                surface.SetDrawColor( COLHUD_SECONDARY )
                surface.DrawRect( 25, 0, w, h )

                surface.SetDrawColor( COLHUD_GOOD )
                local length = (v / 100) * w
                surface.DrawRect( 25, 0, length, h )

                local xpos = 30
                for i = 1, 21 do
                    surface.SetDrawColor( COLHUD_PRIMARY )
                    surface.DrawRect( xpos, 0, 1, h )
                    xpos = xpos + 9
                end
            end

            local icon = vgui.Create("DImageButton", statbg)
            icon:SetPos( 5, 4 )
            icon:SetSize (16, 16)
            icon:SetImage( AS.DamageTypes[k].icon )
            icon:SetColor(Color(255,255,255,255))

            local amt = vgui.Create("DLabel", statbg)
            amt:SetSize( 35, 20 )
            amt:SetPos( 220, 3 )
            amt:SetFont("TargetIDSmall")
            amt:SetText( v .. "%" )

            ypos = ypos + 30
        end

        local armormodel = vgui.Create("SpawnIcon", armor)
        armormodel:SetSize( armor:GetWide(), armor:GetWide() )
        armormodel:SetPos( 0, armor:GetTall() / 2 - (armormodel:GetTall() / 2) )
        armormodel:SetModel( AS.Items[curarmor].model, AS.Items[curarmor].skin or 0 )
        armormodel:SetTooltip(AS.Items[curarmor].name)

        DefaultButton( "Unequip", 3, armor:GetTall() - 22, armor:GetWide() - 6, 18, armor, function( self )
            if not LocalPlayer():CanUnequipItem( curarmor ) then return end
            LocalPlayer():AddItemToInventory( curarmor )
            self:GetParent():Remove()
            stats:Remove()
            net.Start("as_inventory_unequipitem")
                net.WriteString( curarmor )
            net.SendToServer()
        end)
    end

    return inventory
end

function AS.Inventory.BuildSkills()
    local skills = vgui.Create("DPanel", sheet)
    skills.Paint = function() end

    local scroll_skills = vgui.Create("DScrollPanel", skills)
    scroll_skills:SetSize( sheets:GetWide() - 15, sheets:GetTall() - 40 )
    scroll_skills.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)
    end

    local ypos = 5
    for k, v in SortedPairs( AS.Skills ) do
        local itempanel = scroll_skills:Add( "DPanel" )
        itempanel:SetPos( 5, ypos )
        itempanel:SetSize( scroll_skills:GetWide() - 25, 100 )
        itempanel.Paint = function(_,w,h)
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
            --Bar Background
            surface.SetDrawColor( COLHUD_SECONDARY )
            local width, height = (w - (5 * 2)), 20
            surface.DrawRect( (w - width) - 5, (h - height) - 5, width, height )
            --Bar
            surface.SetDrawColor( COLHUD_TERTIARY )
            local ply = LocalPlayer()
            local curxp = ply:GetSkillExperience( k ) --ply:GetSkillExperience( k ) - ExpForLevel( k, ply:GetSkillLevel( k ) - 1 )
            local nextxp = ExpForLevel( k, ply:GetSkillLevel( k ) ) --ExpForLevel( k, ply:GetSkillLevel( k ) + 1 ) - ExpForLevel( k, ply:GetSkillLevel( k ))
            if ply:GetSkillLevel( k ) > 1 then
                curxp = ply:GetSkillExperience( k ) - ExpForLevel( k, ply:GetSkillLevel( k ) - 1 )
                nextxp = ExpForLevel( k, ply:GetSkillLevel( k ) + 1 ) - ExpForLevel( k, ply:GetSkillLevel( k ) )
            end
            surface.DrawRect( (w - width) - 5, (h - height) - 5, math.Clamp( (curxp / nextxp) * width, 0, width), height)
        end

        local skillname = vgui.Create("DLabel", itempanel)
        skillname:SetPos( 5, 5 )
        skillname:SetFont("TargetID")
        skillname:SetText( v.name )
        skillname:SizeToContents()

        local scroll_desc = vgui.Create("DScrollPanel", itempanel)
        scroll_desc:SetPos( 20, 22 )
        scroll_desc:SetSize( itempanel:GetWide() - 30, 35 )

        local desc = vgui.Create("DLabel", scroll_desc)
        desc:SetText( v.desc )
        desc:SetSize( scroll_desc:GetWide() - 15, scroll_desc:GetTall() )
        desc:SetWrap( true )
        desc:SetAutoStretchVertical( true )

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

        ypos = ypos + itempanel:GetTall() + 5
    end

    return skills
end

function AS.Inventory.BuildMissions()
    local missions = vgui.Create("DPanel", sheet)
    missions.Paint = function() end

    local wip = vgui.Create("DLabel", missions)
    wip:SetPos( 5, 5 )
    wip:SetFont("TargetID")
    wip:SetText( "Work In Progress" )
    wip:SizeToContents()

    return missions
end

function AS.Inventory.BuildStats()
    local stats = vgui.Create("DPanel", sheet)
    stats.Paint = function() end

    local scroll_stats = vgui.Create("DScrollPanel", stats)
    scroll_stats:SetSize( sheets:GetWide(), sheets:GetTall() )
    scroll_stats.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)
    end

    local xpos, ypos, statx, col, col2 = 5, 3, 300, Color( 220, 220, 220 ), Color( 160, 160, 160 )
    local curcol = col
    local function AddStat( name, value )
        SmallLabel( name, xpos, ypos, scroll_stats, curcol )
        SmallLabel( value, xpos + statx, ypos, scroll_stats, curcol )
        ypos = ypos + 20
        if curcol == col then curcol = col2 elseif curcol == col2 then curcol = col end
    end
    local function addSpace() ypos = ypos + 20 end

    AddStat( "Playtime", LocalPlayer():GetPlaytimeHourMin() )
    AddStat( "Deaths", LocalPlayer():GetStat("deaths") )
    AddStat( "Players Killed", LocalPlayer():GetStat("kills_player") )
    AddStat( "Enemies Killed", LocalPlayer():GetStat("kills_npc") )
    AddStat( "Nodes Scavenged", LocalPlayer():GetStat("scavenges") )
    AddStat( "Nodes Depleted", LocalPlayer():GetStat("depletions") )
    AddStat( "Scrap from scavenging", LocalPlayer():GetStat("scrap") )
    AddStat( "Small Parts from scavenging", LocalPlayer():GetStat("smallparts") )
    AddStat( "Chemicals from scavenging", LocalPlayer():GetStat("chemicals") )
    AddStat( "Items from scavenging", LocalPlayer():GetStat("items") )
    AddStat( "Items Used", LocalPlayer():GetStat("item_uses") )
    AddStat( "Items Salvaged", LocalPlayer():GetStat("item_salvage") )
    AddStat( "Items Crafted", LocalPlayer():GetStat("item_craft") )
    AddStat( "Antlion Mounds Destroyed", LocalPlayer():GetStat("mounds") )

    return stats
end

function AS.Inventory.BuildCommunity()
    communitypanel = vgui.Create("DPanel", sheet)
    communitypanel:SetSize( sheets:GetWide(), sheets:GetTall() )
    communitypanel.Paint = function( _, w, h ) end

    local txt = not LocalPlayer():InCommunity() and "You are not in a community." or "Loading Community..."

    communitypanel_loading = vgui.Create("DLabel", communitypanel)
	communitypanel_loading:SetText( txt )
	communitypanel_loading:SetFont("TargetID")
	communitypanel_loading:SizeToContents()
	communitypanel_loading:SetPos( communitypanel:GetWide() / 2 - communitypanel_loading:GetWide() / 2, 250 )

    if LocalPlayer():InCommunity() then

        net.Start("as_community_requestdata") --We'll fetch their community data.
        net.SendToServer()

    else

        local width, height = 200, 25
        local x, y = communitypanel:GetWide() / 2 - (width / 2), 300
        DefaultButton( "Create a new community", x, y, width, height, communitypanel, function()
            CreateCommunity()
            frame_inventory:Close()
        end)

        y = y + height + 5
        DefaultButton( "Search existing communities", x, y, width, height, communitypanel, function()
            CommunitySearchWindow()
            frame_inventory:Close()
        end)

    end

    return communitypanel
end
net.Receive("as_community_senddata", function() 
    AS.Inventory.LoadCommunity( net.ReadTable(), net.ReadTable() )
end)

function AS.Inventory.LoadCommunity( communitydata, memberdata )
    if not IsValid( communitypanel ) then return end
    if IsValid( communitypanel_loading ) then communitypanel_loading:Remove() end

    local myPerms = communitydata.ranks[LocalPlayer():GetRank()].permissions

    local cname = vgui.Create("DLabel", communitypanel)
    cname:SetFont( "Trebuchet24" )
    cname:SetText( communitydata.name )
    cname:SetPos( 5, 0 )
    cname:SizeToContents()
    cname:SetColor( Color( 255, 255, 255) )

    local creator = vgui.Create("DLabel", communitypanel)
    creator:SetFont( "TargetIDSmall" )
    creator:SetText( "Created by " .. communitydata.creator .. ", " .. table.Count(memberdata) .. " / " .. SET.MaxMembers .. " current member(s)" )
    creator:SetPos( 5, 23 )
    creator:SizeToContents()
    creator:SetColor( Color( 255, 255, 255) )

    local width, height = 270, 30
    local x, y = 510, 40

    if myPerms["admin"] then
        DefaultButton( "Update Community Description", x, y, width, height, communitypanel, function()
            UpdateDescription()
            frame_inventory:Close()
        end)
        y = y + height + 20

        DefaultButton( "Create a Rank", x, y, width, height, communitypanel, function()
            CreateRank()
            frame_inventory:Close()
        end)
        y = y + height + 1

        DefaultButton( "Modify a Rank", x, y, width, height, communitypanel, function()
            ModifyRankSelect()
            frame_inventory:Close()
        end)
        y = y + height + 1
    
        DefaultButton( "Delete a Rank", x, y, width, height, communitypanel, function()
            DeleteRank()
            frame_inventory:Close()
        end)
        y = y + height + 20
    end

    if myPerms["admin"] or myPerms["locker"] then
        DefaultButton( "Deploy Locker", x, y, width, height, communitypanel, function()
            net.Start("as_community_deploylocker")
            net.SendToServer()
        end)
        y = y + height + 1
    end

    if myPerms["admin"] or myPerms["stockpile"] then
        DefaultButton( "Deploy Stockpile", x, y, width, height, communitypanel, function()
            net.Start("as_community_deploystockpile")
            net.SendToServer()
        end)
        y = y + height + 20
    end

    DefaultButton( "Leave Community", x, y, width, height, communitypanel, function()
        frame_inventory:Close()
        Verify( function()
            net.Start( "as_community_leave" )
            net.SendToServer()
        end, true)
    end)
    y = y + height + 1

    if myPerms["admin"] then
        DefaultButton( "Disband Community", x, y, width, height, communitypanel, function()
            frame_inventory:Close()
            Verify( function()
                net.Start( "as_community_delete" )
                net.SendToServer()
            end, true)
        end)
        y = y + height + 20
    end

    DefaultButton( "Search other communities", x, y, width, height, communitypanel, function()
        CommunitySearchWindow()
        frame_inventory:Close()
    end)
    y = y + height + 1

    local descpanel = vgui.Create("DPanel", communitypanel)
    descpanel:SetPos( 510, 460 )
    descpanel:SetSize( 270, 194 )
    function descpanel:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

    local desc = vgui.Create("DLabel", descpanel)
    desc:SetPos( 5, 5 )
    desc:SetSize( descpanel:GetWide() - 10, descpanel:GetTall() - 10)
    desc:SetFont("TargetIDSmall")
    desc:SetText( communitydata.desc )
    desc:SetWrap( true )
    desc:SetAutoStretchVertical( true )

    local csheets = vgui.Create("DPropertySheet", communitypanel)
    csheets:SetPos( 0, 40 )
    csheets:SetSize( csheets:GetParent():GetWide() - 290, csheets:GetParent():GetTall() - 75 )
    csheets:SetFadeTime( 0 )
    function csheets:Paint( w, h )
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect( 0, 0, w, h )
    end

--Members
    local members = vgui.Create("DPanel", members)
    members:SetSize( csheets:GetWide() - 15, csheets:GetTall() - 35 )
    function members:Paint() end

    local scroll_members = vgui.Create("DScrollPanel", members)
    scroll_members:SetSize( members:GetWide(), members:GetTall() )
    scroll_members.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)
    end

    local xpos, ypos = 5, 5

    for k, v in pairs( memberdata ) do
        local panel = vgui.Create("DPanel", scroll_members)
        panel:SetPos( xpos, ypos )
        panel:SetSize( 490, 100 )
        function panel:Paint( w, h )
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        CharacterIcon( v.model, 5, 5, panel:GetTall() - 10, panel:GetTall() - 10, panel, nil, AS.Classes[v.class].color )

        local name = vgui.Create("DLabel", panel)
        name:SetFont( "TargetID" )
        name:SetText( v.name .. " (" .. (AS.Classes[v.class].name or "") .. ")" )
        name:SetPos( 100, 5 )
        name:SizeToContents()
        name:SetColor( AS.Classes[v.class].color )

        local rank = vgui.Create("DLabel", panel)
        rank:SetFont( "TargetID" )
        rank:SetText( "Rank: " .. v.rank )
        rank:SetPos( 100, 25 )
        rank:SizeToContents()

        local title = vgui.Create("DLabel", panel)
        title:SetFont( "TargetID" )
        title:SetText( "Title: " .. v.title )
        title:SetPos( 100, 45 )
        title:SizeToContents()

        local laston = vgui.Create("DLabel", panel)
        laston:SetFont( "TargetID" )
        laston:SetText( "Last on: " .. v.laston )
        laston:SetPos( 100, 80 )
        laston:SizeToContents()

        local width, height = 100, 20
        local x, y = panel:GetWide() - width - 10, 5

        if myPerms["admin"] or myPerms["title"] then
            DefaultButton( "Change Title", x, y, width, height, panel, function()
                ChangeTitle( v )
            end)
            y = y + height + 1
        end

        if myPerms["admin"] then
            DefaultButton( "Change Rank", x, y, width, height, panel, function()
                local Menu = DermaMenu()
                for k2, v2 in pairs( communitydata.ranks ) do
                    Menu:AddOption( v2.name, function()
                        net.Start("as_community_changerank")
                            net.WriteUInt( k2, NWSetting.UIDAmtBits )
                            net.WriteUInt( v.pid, NWSetting.UIDAmtBits )
                        net.SendToServer()
                    end)
                end
                Menu:Open()
            end)
            y = y + height + 30
        end

        if myPerms["admin"] or myPerms["kick"] then
            DefaultButton( "Kick", x, y, width, height, panel, function()
                net.Start("as_community_kickplayer")
                    net.WriteUInt( v.pid, NWSetting.UIDAmtBits )
                net.SendToServer()
                frame_inventory:Close()
            end)
            y = y + height + 1
        end

        ypos = ypos + panel:GetTall() + 5
    end

    csheets:AddSheet("Members", members, "icon16/user.png")

--Invite
    if myPerms["admin"] or myPerms["invite"] then
        local invite = vgui.Create("DPanel", invite)
        invite:SetSize( csheets:GetWide() - 15, csheets:GetTall() - 35 )
        function invite:Paint() end

        local scroll_invite = vgui.Create("DScrollPanel", invite)
        scroll_invite:SetSize( invite:GetWide(), invite:GetTall() )
        scroll_invite.Paint = function(_,w,h)
            surface.SetDrawColor( COLHUD_SECONDARY )
            surface.DrawRect(0, 0, w, h)
        end

        local xpos, ypos = 5, 5

        for k, v in pairs( player.GetAll() ) do
            if v:InCommunity() then continue end
            if not v:IsLoaded() then continue end

            local panel = vgui.Create("DPanel", scroll_invite)
            panel:SetPos( xpos, ypos )
            panel:SetSize( 490, 100 )
            function panel:Paint( w, h )
                surface.SetDrawColor( COLHUD_PRIMARY )
                surface.DrawRect( 0, 0, w, h )
            end

            local name = vgui.Create("DLabel", panel)
            name:SetFont( "TargetID" )
            name:SetText( v:Nickname() .. " (" .. (AS.Classes[v:GetASClass()].name or "") .. ")" )
            name:SetPos( 100, 5 )
            name:SizeToContents()
            name:SetColor( AS.Classes[v:GetASClass()].color )

            CharacterIcon( v:GetModel(), 5, 5, panel:GetTall() - 10, panel:GetTall() - 10, panel, nil, AS.Classes[v:GetASClass()].color )

            local width, height = 100, 20
            local x, y = panel:GetWide() - width - 10, 5

            DefaultButton( "Invite", x, y, width, height, panel, function()
                panel:Remove()
                net.Start( "as_community_inviteplayer" )
                    net.WriteEntity( v )
                net.SendToServer()
            end)

            ypos = ypos + panel:GetTall() + 5
        end

        csheets:AddSheet("Invite Players", invite, "icon16/add.png")
    end

    --Allies
    local allies = vgui.Create("DPanel", allies)
    allies:SetSize( csheets:GetWide() - 15, csheets:GetTall() - 35 )
    function allies:Paint() end

    local scroll_allies = vgui.Create("DScrollPanel", allies)
    scroll_allies:SetSize( allies:GetWide(), allies:GetTall() )
    scroll_allies.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)
    end

    local xpos, ypos = 5, 5

    for k, v in pairs( communitydata.allies ) do
        local panel = vgui.Create("DPanel", scroll_allies)
        panel:SetPos( xpos, ypos )
        panel:SetSize( 490, 40 )
        function panel:Paint( w, h )
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        local info = vgui.Create("DLabel", panel)
        info:SetFont( "TargetID" )
        info:SetText( v.name or "CID: " .. k )
        info:SetPos( 5, 10 )
        info:SizeToContents()

        if myPerms["admin"] or myPerms["ally"] then
            local bheight, bwidth = 20, 100
            DefaultButton( "End Alliance", panel:GetWide() - bwidth - 10, 10, bwidth, bheight, panel, function()
                panel:Remove()
                net.Start( "as_community_endally" )
                    net.WriteUInt( k, NWSetting.UIDAmtBits )
                net.SendToServer()
            end)
        end

        ypos = ypos + panel:GetTall() + 5
    end

    csheets:AddSheet("Alliances", allies, "icon16/flag_green.png")

    --Wars
    local wars = vgui.Create("DPanel", wars)
    wars:SetSize( csheets:GetWide() - 15, csheets:GetTall() - 35 )
    function wars:Paint() end

    local scroll_wars = vgui.Create("DScrollPanel", wars)
    scroll_wars:SetSize( wars:GetWide(), wars:GetTall() )
    scroll_wars.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)
    end

    local xpos, ypos = 5, 5

    for k, v in pairs( communitydata.wars ) do
        local panel = vgui.Create("DPanel", scroll_wars)
        panel:SetPos( xpos, ypos )
        panel:SetSize( 490, 40 )
        function panel:Paint( w, h )
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        local info = vgui.Create("DLabel", panel)
        info:SetFont( "TargetID" )
        info:SetText( v.name or "CID: " .. k )
        info:SetPos( 5, 10 )
        info:SizeToContents()

        if myPerms["admin"] or myPerms["war"] then
            local bheight, bwidth = 20, 100
            DefaultButton( "Cancel War", panel:GetWide() - bwidth - 10, 10, bwidth, bheight, panel, function()
                panel:Remove()
                net.Start( "as_community_endwarrequest" )
                    net.WriteUInt( k, NWSetting.UIDAmtBits )
                net.SendToServer()
            end)
        end

        ypos = ypos + panel:GetTall() + 5
    end

    csheets:AddSheet("Wars", wars, "icon16/flag_red.png")

    --Pending
    local pending = vgui.Create("DPanel", pending)
    pending:SetSize( csheets:GetWide() - 15, csheets:GetTall() - 35 )
    function pending:Paint() end

    local scroll_pending = vgui.Create("DScrollPanel", pending)
    scroll_pending:SetSize( pending:GetWide(), pending:GetTall() )
    scroll_pending.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)
    end

    local xpos, ypos = 5, 5

    for k, v in pairs( communitydata.pending ) do
        local diplotype = v.type

        local panel = vgui.Create("DPanel", scroll_pending)
        panel:SetPos( xpos, ypos )
        panel:SetSize( 490, 100 )
        function panel:Paint( w, h )
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        local diplo = vgui.Create("DLabel", panel)
        diplo:SetFont( "TargetIDSmall" )
        diplo:SetText( "Diplomacy: " .. diplotype )
        diplo:SetPos( 5, 5 )
        diplo:SizeToContents()

        local info = vgui.Create("DLabel", panel)
        info:SetFont( "TargetIDSmall" )
        local txt = v.info.text or "UKN_ERROR, NO DIPLOMACY?"
        info:SetText( txt )
        info:SetPos( 15, 25 )
        info:SizeToContents()

        if myPerms["admin"] or (diplotype == "war" and myPerms["war"]) or (diplotype == "ally" and myPerms["ally"]) then
            local bheight, bwidth = 20, 100
            DefaultButton( "Accept", 5, panel:GetTall() - bheight - 5, bwidth, bheight, panel, function()
                panel:Remove()
                net.Start("as_community_acceptdiplomacy")
                    net.WriteUInt( k, NWSetting.UIDAmtBits )
                net.SendToServer()
            end)

            DefaultButton( "Decline", bwidth + 10, panel:GetTall() - bheight - 5, bwidth, bheight, panel, function()
                panel:Remove()
                net.Start("as_community_declinediplomacy")
                    net.WriteUInt( k, NWSetting.UIDAmtBits )
                net.SendToServer()
            end)
        end

        ypos = ypos + panel:GetTall() + 5
    end

    csheets:AddSheet("Diplomacies", pending, "icon16/script.png")
end

function AS.Inventory.BuildPlayers()
    local players = vgui.Create("DPanel", sheet)
    players.Paint = function() end

    local scroll_players = vgui.Create("DScrollPanel", players)
    scroll_players:SetSize( sheets:GetWide() - 15, sheets:GetTall() )
    scroll_players.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)
    end

    local xpos, ypos = 5, 5

    for k, v in pairs( player.GetAll() ) do
        if not IsValid(v) then continue end
        if not v:IsLoaded() then continue end

        local panel = vgui.Create("DPanel", scroll_players)
        panel:SetPos( xpos, ypos )
        panel:SetSize( scroll_players:GetWide() - (xpos * 2), 100 )
        function panel:Paint( w, h )
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        CharacterIcon( v:GetModel(), 5, 5, panel:GetTall() - 10, panel:GetTall() - 10, panel, nil, AS.Classes[v:GetASClass()].color )

        local name = vgui.Create("DLabel", panel)
        name:SetFont( "TargetID" )
        name:SetText( v:Nickname() .. " (" .. (AS.Classes[v:GetASClass()].name or "") .. ")" )
        name:SetPos( 100, 5 )
        name:SizeToContents()
        name:SetColor( AS.Classes[v:GetASClass()].color )

        local community = vgui.Create("DLabel", panel)
        community:SetFont( "TargetID" )
        community:SetText( v:GetCommunityName() )
        community:SetPos( 100, 25 )
        community:SizeToContents()

        local title = vgui.Create("DLabel", panel)
        title:SetFont( "TargetID" )
        title:SetText( v:GetTitle() )
        title:SetPos( 100, 45 )
        title:SizeToContents()

        local ping = vgui.Create("DLabel", panel)
        ping:SetFont( "TargetID" )
        ping:SetText( "Ping: " .. v:Ping() .. " m/s" )
        ping:SetPos( 100, 80 )
        ping:SizeToContents()
        ping:SetColor( Color( 0, 185, 200) )
        function ping:Think()
            ping:SetText( "Ping: " .. v:Ping() .. " m/s" )
        end

        if LocalPlayer():IsAdmin() then
            local width, height = 150, 20
            DefaultButton( "View Inventory (Admin)", panel:GetWide() - width - 5, panel:GetTall() - height - 5, width, height, panel, function()
                net.Start("as_admin_inventory_request")
                    net.WriteEntity( v )
                net.SendToServer()
            end)
        end

        ypos = ypos + panel:GetTall() + 5
    end

    return players
end