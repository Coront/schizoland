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

TOOL.ClientConVar["NPC"] = "" --NPC Base
--Stats
TOOL.ClientConVar["Name"] = "" --Name
TOOL.ClientConVar["Model"] = "" --Model
TOOL.ClientConVar["Health"] = 100 --Default Health
--Pathing
TOOL.ClientConVar["Guard"] = 0 --Guard spawn position
TOOL.ClientConVar["GuardForce"] = 0 --Force hold (never move, even with enemy)
--Relationship
TOOL.ClientConVar["Group"] = "custom" --Alliance Group
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

function TOOL:LeftClick()
    if CLIENT then return false end --False because silencing toolgun sound

    local class = self:GetClientInfo( "NPC" )

    local ply = self:GetOwner()
    local ent = ents.Create(class)
    ent:SetPos( trace.HitPos + Vector(0, 0, 10) )
    ent:Spawn()

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
	class:SetValue("Test")
	for k, v in pairs( Entities ) do
		class:AddChoice(v.name)
	end
    function class:OnSelect( panel, index, value )
        for k, v in pairs( Entities ) do
            if v.name == value then
                --do this
                break
            end
        end
    end
	panel:AddItem(class)
end