AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/Combine_Helicopter/helicopter_bomb01.mdl" )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
    self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

function ENT:Think()
    self.DisableSpawners = false

    for k, v in pairs( player.GetAll() ) do
        if not v:IsLoaded() then continue end
        if not v:Alive() then continue end
        if v:IsDeveloping() then continue end

        if v:GetPos():Distance(self:GetPos()) <= self:GetZoneDistance() then
            self.DisableSpawners = true
            break
        end
    end

    for k, v in pairs( ents.FindByClass("as_staticspawn") ) do
        if self.DisableSpawners then
            v.Disabled = true
        else
            v.Disabled = false
        end
    end

    for k, v in pairs( ents.FindByClass("prop_physics*") ) do
        if v:GetPos():Distance( self:GetPos() ) >= self:GetZoneDistance() then continue end
        if not IsValid(v:GetObjectOwner()) and v.MapProp or v:GetNWBool( "Persisted", false ) then continue end
        v:GetObjectOwner():ChatPrint("You prop has been removed as it is too close to the occupation zone.")
        v:Remove()
    end
end

hook.Add( "EntityTakeDamage", "as_staticspawners_timerpush", function( ent, dmg )
    --This hook will basically tell the timers to fully reset if one of the NPCs were to take damage. This is so they aren't respawning unreasonably quick.
    if not ent:IsNextBot() then return end
    if ent:GetClass() != "npc_as_raider" and ent:GetClass() != "npc_as_raider_sniper" then return end
    if not ent.StaticSpawned then return end

    for k, v in pairs( ents.FindByClass( "as_staticspawn" ) ) do --Pushing the respawn timer for the NPCs
        v:SetNextSpawn( CurTime() + 4800 )
    end

    for k, v in pairs( ents.FindByClass( "as_lootcontainer" ) ) do --Pushing the respawn timer for the weapon loot container.
        if v:GetContainer() == "gunbox" then
            v:SetNextGeneration( CurTime() + AS.Loot[v:GetContainer()].generation.time )
        end
    end
end)