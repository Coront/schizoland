TOOL.Category = "AS Tools"
TOOL.Name = "ASNPC Spawner"

if ( CLIENT ) then
	language.Add( "Tool.as_asnpcspawner.name", "ASNPC Spawner" )
	language.Add( "Tool.as_asnpcspawner.desc", "Custom Mob Spawner" )
	language.Add( "Tool.as_asnpcspawner.0", "Left Click will spawn a custom mob." )
    language.Add( "undone_asnpc", "Undone ASNPC" )
end

local Entities = {
    {class = "npc_as_zombie", name = "Zombie"},
    {class = "npc_as_fastzombie", name = "Fast Zombie"},
    {class = "npc_as_poisonzombie", name = "Poison Zombie"},
    {class = "npc_as_antlion", name = "Antlion"},
    {class = "npc_as_antlionspitter", name = "Antlion Spitter"},
    {class = "npc_as_antlionguard", name = "Antlion Guard"},
    {class = "npc_as_hunter", name = "Hunter"},
    {class = "npc_as_bandit", name = "Bandit"},
    {class = "npc_as_raider", name = "Raider"},
    {class = "npc_as_raider_sniper", name = "Raider Sniper"},
    {class = "npc_as_soldier", name = "Soldier"},
    {class = "npc_as_super", name = "Super Soldier"},
}

TOOL.ClientConVar["NPC"] = Entities[1].class --NPC Base
--Stats
TOOL.ClientConVar["Name"] = "" --Name
TOOL.ClientConVar["Model"] = "" --Model
TOOL.ClientConVar["Health"] = 100 --Default Health
--Pathing
TOOL.ClientConVar["Guard"] = 0 --Guard spawn position
TOOL.ClientConVar["GuardForce"] = 0 --Force hold (never move, even with enemy)
--Relationship
TOOL.ClientConVar["Group"] = "" --Alliance Group
TOOL.ClientConVar["Friendly"] = 1 --Friendly to players
TOOL.ClientConVar["AttackAttackers"] = 1 --Attack All Attackers
TOOL.ClientConVar["Alert"] = 1 --Alert allies when attacked
--Loot
TOOL.ClientConVar["Items"] = 1 --Drop Items?

local function BoolToInt( bool )
	if bool then
		return 1
	else
		return 0
	end
end

function TOOL:LeftClick( trace )
    if CLIENT then return false end --False because silencing toolgun sound

    local class = self:GetClientInfo( "NPC" )
    local name = self:GetClientInfo( "Name" )
    local model = self:GetClientInfo( "Model" )
    local hp = self:GetClientInfo( "Health" )
    local group = self:GetClientInfo( "Group" )
    local guard = self:GetClientInfo( "Guard" )
    local guardf = self:GetClientInfo( "GuardForce" )
    local friendly = self:GetClientInfo( "Friendly" )
    local attackattackers = self:GetClientInfo( "AttackAttackers" )
    local alert = self:GetClientInfo( "Alert" )
    local items = self:GetClientInfo( "Items" )

    local ply = self:GetOwner()
    local ent = ents.Create(class)
    ent:SetPos( trace.HitPos + Vector(0, 0, 10) )
    ent:Spawn()

    if name != "" then
        ent:SetNWString("Name", name)
    end
    if model != "" then
        ent.Model = model
    end
    ent:SetHealth( hp )
    ent:SetMaxHealth( hp )
    if group != "" then
        ent.Group = group
    end
    ent.Guarding = tobool( guard )
    ent.GuardingForceHold = tobool( guardf )
    ent.Friendly = tobool( friendly )
    ent.AttackAllAttackers = tobool( attackattackers )
    if ent.AttackAllAttackers then
        ent.AttackAllAttackersTolerance = ent.AttackAllAttackersTolerance <= 0 and 1 or ent.AttackAllAttackersTolerance
    end
    if not tobool( alert ) then
        ent.CommunicateDistance = 1
    end
    if not tobool( items ) then
        ent.LootTable = nil
    end


    undo.Create("as_asnpcspawner")
        undo.AddEntity( ent )
        undo.SetPlayer( ply )
    undo.Finish()
    ply:AddCleanup( "as_asnpcspawner", ent )
end

function TOOL.BuildCPanel(panel)
	panel:AddControl("Header", {
		Text = "ASNPC Spawner",
		Description = "(Admin Only Tool) This tool allows staff members to create customized NPCs with unique values assigned to them to alter their main behavior."
	})

    panel:AddControl("Label", {
		Text = "Base Class"
	})

    class = vgui.Create("DComboBox", panel)
	class:SetSize( panel:GetWide(), 20 )
	class:SetValue( Entities[1].name )
	for k, v in pairs( Entities ) do
		class:AddChoice(v.name)
	end
    function class:OnSelect( panel, index, value )
        for k, v in pairs( Entities ) do
            if v.name == index then
                RunConsoleCommand( "as_asnpcspawner_npc", v.class )
                break
            end
        end
    end
	panel:AddItem(class)

    local name = vgui.Create("DTextEntry")
	name:SetUpdateOnType(true)
	name:SetEnterAllowed(true)
	name:SetConVar("as_asnpcspawner_Name")
	name:SetValue( GetConVarString("as_asnpcspawner_name") )
    name:SetPlaceholderText( "Name (Empty for Default)" )
	panel:AddItem( name )

    local group = vgui.Create("DTextEntry")
	group:SetUpdateOnType(true)
	group:SetEnterAllowed(true)
	group:SetConVar("as_asnpcspawner_group")
	group:SetValue( GetConVarString("as_asnpcspawner_group") )
    group:SetPlaceholderText( "Group (Empty for Default)" )
	panel:AddItem( group )

    local model = vgui.Create("DTextEntry")
	model:SetUpdateOnType(true)
	model:SetEnterAllowed(true)
	model:SetConVar("as_asnpcspawner_model")
	model:SetValue( GetConVarString("as_asnpcspawner_model") )
    model:SetPlaceholderText( "Model (Empty for Default)" )
	panel:AddItem( model )

    panel:AddControl("Slider", {
        Label = "Health", 
        Type = "Integer",
        Min = "1",
        Max = "100000",
        Command = "as_asnpcspawner_health"
	})

    panel:AddControl("CheckBox", {
		Label = "Guard Position",
		Command = "as_asnpcspawner_guard"
	})

    panel:AddControl("CheckBox", {
		Label = "Force Hold Position (Never Move)",
		Command = "as_asnpcspawner_guardforce"
	})

    panel:AddControl("CheckBox", {
		Label = "Friendly to Players",
		Command = "as_asnpcspawner_friendly"
	})

    panel:AddControl("CheckBox", {
		Label = "Attack all Attackers, regardless of relationship?",
		Command = "as_asnpcspawner_attackattackers"
	})

    panel:AddControl("CheckBox", {
		Label = "Alert when NPC allies are attacked",
		Command = "as_asnpcspawner_alert"
	})

    panel:AddControl("CheckBox", {
		Label = "Drop Items",
		Command = "as_asnpcspawner_items"
	})
end