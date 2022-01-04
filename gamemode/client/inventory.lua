--Skills Tab
function GM:OnSpawnMenuOpen() 
    AS.Inventory.Open( 2 )
end

function GM:OnSpawnMenuClose() 
    if IsValid(frame_inventory) then 
        frame_inventory:Close() 
    end 
end

--Inventory Tab
function GM:ScoreboardShow() 
    AS.Inventory.Open( 1 )
end

function GM:ScoreboardHide() 
    if IsValid(frame_inventory) then 
        frame_inventory:Close() 
    end 
end

--Missions Tab
function GM:OnContextMenuOpen()
    AS.Inventory.Open( 3 )
end

function GM:OnContextMenuClose()
    if IsValid(frame_inventory) then
        frame_inventory:Close()
    end
end

AS.Inventory = {}

InventoryOpen = false

-- ███╗   ███╗███████╗███╗   ██╗██╗   ██╗
-- ████╗ ████║██╔════╝████╗  ██║██║   ██║
-- ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
-- ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
-- ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
-- ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝

function AS.Inventory.Open( tab )
    if IsValid(frame_inventory) then frame_inventory:Close() end

    frame_inventory = vgui.Create("DFrame")
    frame_inventory:SetSize(800, 600)
    frame_inventory:Center()
    frame_inventory:MakePopup()
    frame_inventory:SetDraggable( false )
    frame_inventory:SetTitle( "" )
    frame_inventory:ShowCloseButton( false )
    frame_inventory.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawRect( 0, 0, w, h )
    end

    local sheets = vgui.Create("DPropertySheet", frame_inventory)
    sheets:SetPos(5, 5)
    sheets:SetFadeTime( 0 )
    sheets:SetSize( frame_inventory:GetWide() - (sheets:GetX() * 2), frame_inventory:GetTall() - (sheets:GetY() * 2))
    sheets.Paint = function() end

    sheets:AddSheet("Inventory", AS.Inventory.BuildInventory(), "icon16/box.png")
    sheets:AddSheet("Skills", AS.Inventory.BuildSkills(), "icon16/user.png")
    sheets:AddSheet("Missions", AS.Inventory.BuildMissions(), "icon16/map.png")
    sheets:AddSheet("Statistics", AS.Inventory.BuildStats(), "icon16/chart_line.png")

    if tab then
        sheets:SetActiveTab( sheets:GetItems()[tab].Tab )
    end

    function frame_inventory:OnClose()
        InventoryOpen = false
    end
end

-- ██████╗ ██╗   ██╗██╗██╗     ██████╗ ███████╗
-- ██╔══██╗██║   ██║██║██║     ██╔══██╗██╔════╝
-- ██████╔╝██║   ██║██║██║     ██║  ██║███████╗
-- ██╔══██╗██║   ██║██║██║     ██║  ██║╚════██║
-- ██████╔╝╚██████╔╝██║███████╗██████╔╝███████║
-- ╚═════╝  ╚═════╝ ╚═╝╚══════╝╚═════╝ ╚══════╝

function AS.Inventory.BuildInventory()
    local inventory = vgui.Create("DPanel", sheet)
    inventory.Paint = function() end

    --Items
    local scroll_items = vgui.Create("DScrollPanel", inventory)
    scroll_items:SetSize( 500, 0 )
    scroll_items:Dock( LEFT )
    scroll_items:DockMargin( 0, 0, 0, 0 )
    scroll_items.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_SECONDARY )
        surface.DrawRect(0, 0, w, h)
    end

    local weight = vgui.Create("DLabel", scroll_items)
    weight:SetFont("TargetID")
    weight:SetText( "Weight: " .. LocalPlayer():GetCarryWeight() .. " / " .. LocalPlayer():MaxCarryWeight() )
    weight:SetContentAlignment( 3 )
    weight:SizeToContents()
    weight:SetPos( 5, 3 )

    local itemlist = vgui.Create("DIconLayout", scroll_items)
    itemlist:SetPos( 5, 25 )
    itemlist:SetSize( scroll_items:GetWide() - 10, scroll_items:GetTall() - 30)
    itemlist:SetSpaceY( 5 )
    itemlist:SetSpaceX( 5 )

    for k, v in SortedPairs( LocalPlayer():GetInventory() ) do
        local panel = itemlist:Add("DButton")
        panel:SetSize( 60, 60 )
        panel:SetText("")
        local info = AS.Items[k]
        local name = info.name or "name?" .. k
        local desc = info.desc or "desc?" .. k
        local weight = info.weight or "weight?" .. k
        local TTtext = v > 1 and name .. "\n" .. desc .. "\nWeight: " .. weight .. " [" .. (isnumber(weight) and weight * v or "w?") .. "]" or name .. "\n" .. desc .. "\nWeight: " .. weight
        panel:SetTooltip(TTtext)
        panel.DoClick = function()
            LocalPlayer():ChatPrint("useditem")
        end
        panel.DoRightClick = function()
            local options = vgui.Create("DMenu")
            --Use
            options:AddOption("Use", function()
                LocalPlayer():ChatPrint("useditem")
            end)
            --Drop
            local function dropItem( item, amt )
                LocalPlayer():TakeItemFromInventory( item, amt )
                net.Start("as_inventory_dropitem")
                    net.WriteString( item )
                    net.WriteInt( amt, 32 )
                net.SendToServer()
            end
            options:AddOption("Drop 1", function()
                dropItem( k, 1 )
            end)
            options:AddOption("Drop X", function()
                LocalPlayer():ChatPrint("droppeditem = x")
                --[[
                    local function callback( amt )
                        dropItem( item, amt )
                    end
                    VerifyAmount( callback )
                ]]
            end)
            options:AddOption("Drop All", function()
                dropItem( k, v )
            end)
            --Destroy
            options:AddOption("Destroy 1", function()
                LocalPlayer():ChatPrint("destroyeditem")
            end)
            options:AddOption("Destroy X", function()
                LocalPlayer():ChatPrint("destroyeditem")
            end)
            options:AddOption("Destroy All", function()
                LocalPlayer():ChatPrint("destroyeditem")
            end)
            options:Open()
            function options:Think()
                if not IsValid( frame_inventory ) then options:Hide() end
            end
        end
        panel.Paint = function(self,w,h)
            surface.SetDrawColor( COLHUD_PRIMARY )
            surface.DrawRect( 0, 0, w, h )
        end

        local image = vgui.Create("DImage", panel)
        image:SetSize(panel:GetWide(), panel:GetTall())
        local model = info and "spawnicons/" .. string.Replace( info.model, ".mdl", ".png" ) or ""
        image:SetImage( model )

        local itemamt = vgui.Create("DLabel", panel)
        itemamt:SetFont("TargetID")
        itemamt:SetText( v )
        itemamt:SetContentAlignment( 3 )
        itemamt:SizeToContents()
        itemamt:SetPos( (panel:GetWide() - itemamt:GetWide()) - 2, panel:GetTall() - itemamt:GetTall() )
    end

    --Character and info
    local characterdisplay = vgui.Create( "DModelPanel", inventory )
    characterdisplay:SetSize( 265, 0 )
    characterdisplay:Dock( RIGHT )
    characterdisplay:DockMargin( 5, 0, 0, 0 )
    characterdisplay:SetFOV( 17 )
    characterdisplay:SetModel(LocalPlayer():GetModel())
    local eyepos = characterdisplay.Entity:GetBonePosition(characterdisplay.Entity:LookupBone("ValveBiped.Bip01_Head1")) or Vector(0,0,0)
    eyepos:Add(Vector(0,0,-20))
	characterdisplay:SetLookAt( eyepos )
    characterdisplay:SetCamPos( eyepos - Vector(-150,0,0) )
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

    local exp = vgui.Create("DLabel", characterdisplay)
    exp:SetPos( 0, 525 )
    exp:SetFont("TargetID")
    exp:SetText( "Experience: " .. LocalPlayer():GetExperience() .. " / " .. LocalPlayer():ExpToLevel() )
    exp:SizeToContents()

    local expbg = vgui.Create("DPanel", characterdisplay)
    expbg:SetSize( characterdisplay:GetWide(), 10 )
    expbg:SetPos( 0, 544 )
    function expbg:Paint(w, h)
        surface.SetDrawColor( AS.Colors.Secondary )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )
        surface.SetDrawColor( AS.Colors.Tertiary )
        surface.DrawRect( 1, 1, ( (LocalPlayer():GetExperience() - CalcExpForLevel(LocalPlayer():GetLevel() - 1)) / (LocalPlayer():ExpToLevel() - CalcExpForLevel(LocalPlayer():GetLevel() - 1)) ) * 263, h - 2 )
    end

    local name = vgui.Create("DLabel", characterdisplay)
    name:SetPos( 0, 0 )
    name:SetFont("TargetID")
    name:SetText( LocalPlayer():Nickname() )
    name:SizeToContents()

    local level = vgui.Create("DLabel", characterdisplay)
    level:SetPos( 0, 20 )
    level:SetFont("TargetID")
    level:SetText( "Level " .. LocalPlayer():GetLevel() )
    level:SizeToContents()

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
            surface.SetDrawColor( COLHUD_DEFAULT )
            surface.DrawRect( 0, 0, w, h )
        end

        local skillname = vgui.Create("DLabel", itempanel)
        skillname:SetPos( 5, 5 )
        skillname:SetFont("TargetID")
        skillname:SetText( v.name )
        skillname:SizeToContents()
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

    return stats
end