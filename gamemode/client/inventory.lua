function GM:OnSpawnMenuOpen() AS.Inventory.Open() end
function GM:OnSpawnMenuClose() if IsValid(frame_inventory) then frame_inventory:Close() end end

AS.Inventory = {}

InventoryOpen = false

-- ███╗   ███╗███████╗███╗   ██╗██╗   ██╗
-- ████╗ ████║██╔════╝████╗  ██║██║   ██║
-- ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
-- ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
-- ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
-- ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝

function AS.Inventory.Open()
    if InventoryOpen then return end
    InventoryOpen = true

    frame_inventory = vgui.Create("DFrame")
    frame_inventory:SetSize(800, 600)
    frame_inventory:Center()
    frame_inventory:MakePopup()
    frame_inventory:SetDraggable( false )
    frame_inventory:SetTitle( "" )
    frame_inventory:ShowCloseButton( true )
    frame_inventory.Paint = function(_,w,h)
        surface.SetDrawColor( COLHUD_DEFAULT )
        surface.DrawRect( 0, 0, w, h )
    end

    local sheets = vgui.Create("DPropertySheet", frame_inventory)
    sheets:SetPos(5, 5)
    sheets:SetSize( frame_inventory:GetWide() - (sheets:GetX() * 2), frame_inventory:GetTall() - (sheets:GetY() * 2))
    sheets.Paint = function() end

    sheets:AddSheet("Inventory", AS.Inventory.BuildInventory(), "icon16/box.png")
    sheets:AddSheet("Skills", AS.Inventory.BuildSkills(), "icon16/user.png")
    sheets:AddSheet("Missions", AS.Inventory.BuildMissions(), "icon16/map.png")
    sheets:AddSheet("Statistics", AS.Inventory.BuildStats(), "icon16/chart_line.png")

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

    local scroll_items = vgui.Create("DScrollPanel", inventory)
    scroll_items:SetPos(5, 5)
    scroll_items:SetSize(frame_inventory:GetWide() - 10, frame_inventory:GetTall() - 65)
    scroll_items.Paint = function(_,w,h)
        local col = COLHUD_DEFAULT:ToTable()
        surface.SetDrawColor(col[1] - 50, col[2] - 50, col[3] - 50, 255)
        surface.DrawRect(0, 0, w, h)
    end

    return inventory
end

function AS.Inventory.BuildSkills()
    local skills = vgui.Create("DPanel", sheet)
    skills.Paint = function() end

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