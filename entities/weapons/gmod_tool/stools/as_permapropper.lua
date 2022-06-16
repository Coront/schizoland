TOOL.Category = "AS Tools"
TOOL.Name = "Perma Propper"

PERSISTER_DATABASECHECKED = PERSISTER_DATABASECHECKED or false

if ( CLIENT ) then
	language.Add( "Tool.as_permapropper.name", "Perma Propper" )
	language.Add( "Tool.as_permapropper.desc", "A permanent prop tool for Aftershock." )
	language.Add( "Tool.as_permapropper.0", "Left Click a prop or entity to persist it. Right Click to unpersist and delete. Reload will refresh all of the persisted props." )
end

-- ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗     █████╗ ███╗   ██╗██████╗     ████████╗ █████╗ ██████╗ ██╗     ███████╗
-- ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝    ██╔══██╗████╗  ██║██╔══██╗    ╚══██╔══╝██╔══██╗██╔══██╗██║     ██╔════╝
-- ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗      ███████║██╔██╗ ██║██║  ██║       ██║   ███████║██████╔╝██║     █████╗
-- ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝      ██╔══██║██║╚██╗██║██║  ██║       ██║   ██╔══██║██╔══██╗██║     ██╔══╝
-- ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗    ██║  ██║██║ ╚████║██████╔╝       ██║   ██║  ██║██████╔╝███████╗███████╗
-- ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝    ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝        ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝

if (SERVER) then

    function TOOL:CheckDatabase() --Checks to see if there's a schema in the database.
        sql.Query( "CREATE TABLE IF NOT EXISTS as_persists (map TEXT, data TEXT)" )
        PERSISTER_DATABASECHECKED = true
    end
    if not PERSISTER_DATABASECHECKED then TOOL:CheckDatabase() end

    function TOOL:FetchPersists() --Will return all of the current persists that have been detected.
        local Persists = {}
        for k, v in pairs( ents.GetAll() ) do
            if not v:GetNWBool( "Persisted", false ) then continue end
            Persists[#Persists + 1] = {
                owner = v:GetNWString( "PersistedOwner", "ERR_NONE" ),
                date = v:GetNWString( "PersistedDate", "ERR_NONE" ),
                entTable = duplicator.CopyEntTable( v ),
            }
            if v:GetClass() == "as_lootcontainer" then
                v.Inventory = {} --This just wipes the inventory so it doesn't accidentily save and load it when it's respawned.
            end
            if v:GetClass() == "as_staticspawn" then
                v.NextSpawn = nil
                v.PlyDisableDist = nil
            end
            if v:GetClass() == "prop_physics" then
                v.Owner = nil
            end
        end

        return Persists
    end

    function TOOL:SavePersists( ply ) --Will save all of the current persists to the database.
        local mapExists = sql.QueryValue("SELECT * FROM as_persists WHERE map = " .. SQLStr( game.GetMap() ))
        if not mapExists then
            sql.Query( "INSERT INTO as_persists VALUES ( " .. SQLStr( game.GetMap() ) .. ", " .. SQLStr( util.TableToJSON(self:FetchPersists(), true) ) .. " )" )
        else
            sql.Query( "UPDATE as_persists SET data = " .. SQLStr( util.TableToJSON(self:FetchPersists(), true) ) .. " WHERE map = " .. SQLStr( game.GetMap()) )
        end
    end

    function AS_LoadPersists() --Will load all of the persists from the database.
        --We'll clean up any old persists since we'll be loading new ones.
        for k, v in pairs( ents.GetAll() ) do
            if v:GetNWBool( "Persisted", false ) then v:Remove() end
        end

        --Now we'll start spawning them.
        local totalPersists = 0
        local persists = util.JSONToTable(sql.QueryValue( "SELECT data FROM as_persists WHERE map = " .. SQLStr( game.GetMap() ) ))
        for k, v in pairs( persists ) do
            local ent = duplicator.CreateEntityFromTable( nil, v.entTable )
            ent:SetNWBool( "NoObjectOwner", true )
            ent:SetNWBool( "Persisted", true ) 
            ent:SetNWString( "PersistedOwner", v.owner )
            ent:SetNWString( "PersistedDate", v.date )
            if v.entTable.DT then
                for k, v in pairs(v.entTable.DT) do
                    local name = "Set"..k
                    if ent[name] then
                        ent[name](ent, v )
                    end
                end
            end
            if ent:GetClass() == "as_staticspawn" then
                ent.NextSpawn = nil
                ent.PlyDisableDist = nil
            end

            local physobj = ent:GetPhysicsObject()
            if ent:GetClass() != "prop_physics" and IsValid(physobj) then --I will probably never have entities move, soooo
                physobj:EnableMotion( false )
            end

            ent:SetMoveType( MOVETYPE_NONE )

            totalPersists = totalPersists + 1
        end

        for k, v in pairs( player.GetAll() ) do
            ResyncAllContainerInventories( v )
        end

        return totalPersists
    end

end

-- ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗ █████╗ ██╗     ██╗████████╗██╗   ██╗
-- ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔══██╗██║     ██║╚══██╔══╝╚██╗ ██╔╝
-- █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████║██║     ██║   ██║    ╚████╔╝
-- ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║██╔══██║██║     ██║   ██║     ╚██╔╝
-- ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║██║  ██║███████╗██║   ██║      ██║
-- ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚═╝   ╚═╝      ╚═╝

function TOOL:ValidPersist(ent)
    if not IsValid(ent) or ent:IsWorld() then return false end
    if ent:IsPlayer() then return false end
    if ent:GetClass() == "prop_door_rotating" then return false end
    return true
end

function TOOL:LeftClick( trace )
    if not self:GetOwner():IsAdmin() then self:GetOwner():ChatPrint("You are not an admin.") return false end

    local ent = trace.Entity
    if not self:ValidPersist( ent ) then return false end

    ent:SetNWBool( "Persisted", true )
    ent:SetNWString( "PersistedOwner", self:GetOwner():Nick() )
    ent:SetNWString( "PersistedDate", os.date("%m/%d/%y - %I:%M %p", os.time()) )
    if SERVER then
        self:SavePersists()
    end
    if CLIENT then return true end
end

function TOOL:RightClick( trace )
    if not self:GetOwner():IsAdmin() then self:GetOwner():ChatPrint("You are not an admin.") return false end

    local ent = trace.Entity
    if CLIENT and ent:GetNWBool( "Persisted", false ) then return true end
    if SERVER and ent:GetNWBool( "Persisted", false ) then
        ent:SetNWBool( "Persisted", false )
        ent:Remove()
        self:SavePersists()
    end
end

function TOOL:Reload( trace )
    if not self:GetOwner():IsAdmin() then self:GetOwner():ChatPrint("You are not an admin.") return false end

    if SERVER then self:GetOwner():ChatPrint("Refreshing Persists...") AS_LoadPersists() end
end

function TOOL.BuildCPanel(panel)
	panel:AddControl("Header", {
		Text = "Perma Propper",
		Description = "(Admin Only Tool) This tool will make props or entities remain even after server cleanup or map change, so that contents don't have to be replaced. Avoid trying to persist NPCs or Vehicles, as the tool is only made with the intention of being used on Props and Entities."
	})

    panel:AddControl("Button", {
		Label = "Reload all Persists",
        Command = "as_persist_load",
	})
end

-- ██╗   ██╗██╗███████╗██╗   ██╗ █████╗ ██╗         ██╗███╗   ██╗██████╗ ██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
-- ██║   ██║██║██╔════╝██║   ██║██╔══██╗██║         ██║████╗  ██║██╔══██╗██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
-- ██║   ██║██║███████╗██║   ██║███████║██║         ██║██╔██╗ ██║██║  ██║██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║
-- ╚██╗ ██╔╝██║╚════██║██║   ██║██╔══██║██║         ██║██║╚██╗██║██║  ██║██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
--  ╚████╔╝ ██║███████║╚██████╔╝██║  ██║███████╗    ██║██║ ╚████║██████╔╝██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
--   ╚═══╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝    ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

hook.Add( "PreDrawHalos", "AS_Persists_Indicator", function()
    if not LocalPlayer():IsAdmin() or IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() != "gmod_tool" then return end
    if not LocalPlayer():IsLoaded() then return end
    if not LocalPlayer():IsDeveloping() then return end

    local numpers = {}
    for k, v in pairs( ents.GetAll() ) do
        if not v:GetNWBool( "Persisted", false ) then continue end
        numpers[#numpers + 1] = v
    end

    if #numpers > 0 then
        halo.Add( numpers, COLHUD_DEFAULT, 1, 1, 1, true, true )
    end
end)

hook.Add( "HUDPaint", "AS_Persists_Info", function()
    if not LocalPlayer():IsAdmin() or IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() != "gmod_tool" then return end
    if not LocalPlayer():IsLoaded() then return end
    if not LocalPlayer():IsDeveloping() then return end

    local trace = util.TraceLine({
        start = LocalPlayer():GetShootPos(),
        endpos = LocalPlayer():GetShootPos() + (LocalPlayer():GetAimVector() * 10000),
        filter = LocalPlayer(),
    })

    if trace.Entity and trace.Entity:GetNWBool( "Persisted", false ) then
        draw.DrawText( "Object: " .. trace.Entity:GetClass(), "TargetID", ScrW() * 0.5, ScrH() * 0.524, COLHUD_DEFAULT, TEXT_ALIGN_CENTER )
        draw.DrawText( "Placer: " .. trace.Entity:GetNWString( "PersistedOwner", "ERR_NONE" ), "TargetID", ScrW() * 0.5, ScrH() * 0.54, COLHUD_DEFAULT, TEXT_ALIGN_CENTER )
        draw.DrawText( "Date: " .. trace.Entity:GetNWString( "PersistedDate", "ERR_NONE" ), "TargetID", ScrW() * 0.5, ScrH() * 0.556, COLHUD_DEFAULT, TEXT_ALIGN_CENTER )
    end
end)

--  ██████╗ ██████╗      ██╗███████╗ ██████╗████████╗    ██╗      ██████╗  █████╗ ██████╗ ██╗███╗   ██╗ ██████╗
-- ██╔═══██╗██╔══██╗     ██║██╔════╝██╔════╝╚══██╔══╝    ██║     ██╔═══██╗██╔══██╗██╔══██╗██║████╗  ██║██╔════╝
-- ██║   ██║██████╔╝     ██║█████╗  ██║        ██║       ██║     ██║   ██║███████║██║  ██║██║██╔██╗ ██║██║  ███╗
-- ██║   ██║██╔══██╗██   ██║██╔══╝  ██║        ██║       ██║     ██║   ██║██╔══██║██║  ██║██║██║╚██╗██║██║   ██║
-- ╚██████╔╝██████╔╝╚█████╔╝███████╗╚██████╗   ██║       ███████╗╚██████╔╝██║  ██║██████╔╝██║██║ ╚████║╚██████╔╝
--  ╚═════╝ ╚═════╝  ╚════╝ ╚══════╝ ╚═════╝   ╚═╝       ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝

if (SERVER) then
    hook.Add( "InitPostEntity", "AS_Persists_Spawn", function()
        timer.Simple( 5, function() --COOL
            local dataExists = sql.QueryValue( "SELECT * FROM as_persists WHERE map = " .. SQLStr(game.GetMap()) )
            if not dataExists then
                MsgC( Color(255,0,55), "[AS] There is no persist data for " .. game.GetMap() .. ", meaning the map likely doesn't have any perma propped contents.\n" )
            else
                MsgC( Color(0,0,255), "[AS] Loading persist data for " .. game.GetMap() .. "...\n" )
                local totalpersists = AS_LoadPersists()
                MsgC( Color(0,0,255), "[AS] Finished placing persists! Total of " .. totalpersists .. " object(s).\n" )
            end
        end)
    end)

    hook.Add( "PostCleanupMap", "AS_Persists_Spawn", function()
        local dataExists = sql.QueryValue( "SELECT * FROM as_persists WHERE map = " .. SQLStr(game.GetMap()) )
        if dataExists then
            AS_LoadPersists()
        end
    end)
end