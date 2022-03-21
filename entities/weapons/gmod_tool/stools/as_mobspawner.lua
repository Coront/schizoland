TOOL.Category = "AS Tools"
TOOL.Name = "Mobspawner Placer"

if ( CLIENT ) then
	language.Add( "Tool.as_mobspawner.name", "Mobspawner Placer" )
	language.Add( "Tool.as_mobspawner.desc", "Modification for the Aftershock map grids." )
	language.Add( "Tool.as_mobspawner.0", "Left Click will create a Mobspawner, Right Click will start a doorlink." )
    language.Add( "undone_mobspawner", "Undone Mobspawner" )
end

TOOL.ClientConVar["Distance"] = 1000
TOOL.ClientConVar["Nodes"] = 1
TOOL.ClientConVar["Mobs"] = 1
TOOL.ClientConVar["Events"] = 0
TOOL.ClientConVar["Indoor"] = 0

function TOOL:LeftClick( trace )
	if CLIENT then return true end

    local ply = self:GetOwner()
    local ent = ents.Create("as_mobspawner")
	ent:SetPos( trace.HitPos + Vector(0, 0, 10) )
	ent:Spawn()
	ent:GetPhysicsObject():EnableMotion(false)
	ent:SetMoveType(MOVETYPE_NONE)
	ent:SetNWInt( "Distance", self:GetClientNumber("Distance", 1000) )
	ent:SetNWBool( "Nodes", tobool(self:GetClientNumber("Nodes", 1)) )
	ent:SetNWBool( "Mobs", tobool(self:GetClientNumber("Mobs", 1)) )
	ent:SetNWBool( "Events", tobool(self:GetClientNumber("Events", 0)) )
	ent:SetNWBool( "Indoor", tobool(self:GetClientNumber("Indoor", 0)) )

	undo.Create("mobspawner")
		undo.AddEntity( ent )
		undo.SetPlayer( ply )
	undo.Finish()
	ply:AddCleanup( "as_mobspawner", ent )
end

function TOOL.BuildCPanel(panel)
	panel:AddControl("Header", {
		Text = "Mobspawner Placer",
		Description = "(Admin Only Tool) This tool is designed to allow the easy placement of mobspawners for Aftershock. If you are modifying an existing grid, please select 'Edit Current Grid', and then adjust as you like. If you are making a new one, you can just start placing mobspawners. Remember to save a grid once you are finished for it to properly update, and clear the entities as well."
	})

    panel:AddControl("Header", {
		Description = "Map Grid Management"
	})

    panel:AddControl("Button", {
		Label = "Edit Current Grid",
        Command = "as_grid_modify",
	})

    panel:AddControl("Button", {
		Label = "Save Grid",
        Command = "as_grid_save",
	})

    panel:AddControl("Button", {
		Label = "Clear Grid Entities",
        Command = "as_grid_clearent",
	})

    panel:AddControl("Header", {
		Description = "Mobspawner Settings"
	})

    panel:AddControl("Slider", {
        Label = "Spawning Distance",
        Type = "Integer",
        Min = "100",
        Max = "10000",
        Command = "as_mobspawner_Distance",
    })

    panel:AddControl("CheckBox", {
		Label = "Spawn Nodes",
        Command = "as_mobspawner_Nodes",
	})

    panel:AddControl("CheckBox", {
		Label = "Spawn NPCs",
        Command = "as_mobspawner_Mobs",
	})

    panel:AddControl("CheckBox", {
		Label = "Automated Event Location",
        Command = "as_mobspawner_Events",
	})

    panel:AddControl("CheckBox", {
		Label = "Indoor Location",
        Command = "as_mobspawner_Indoor",
	})
end