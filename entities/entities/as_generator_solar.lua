AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "as_generator"
ENT.PrintName		= "Solar Panel"
ENT.Category		= "Aftershock"
ENT.Spawnable		= false

ENT.Model = "models/hunter/plates/plate1x2.mdl"
ENT.MaxHealth = 100 --Our health before being destroyed.
ENT.NoFuel = true --Don't need fuel.
ENT.Solar = true --Needs to trace the skybox to function.
ENT.Sound = "" --Passive loop sound we play
ENT.PowerProduced = 25 --The amount of potential electricity we will produce. Basically how much to make when turned on.

if ( SERVER ) then

    function ENT:Initialize()
        self:SetModel( self.Model )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetUseType( SIMPLE_USE )
        self:SetSolid( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetHealth( self.MaxHealth )
        self:SetMaxHealth( self.MaxHealth )
        self:SetMaterial( "models/tools/solar" )
    end

elseif ( CLIENT ) then

    function ENT:Draw()
        if LocalPlayer():GetPos():Distance(self:GetPos()) < GetConVar("as_entity_renderdist"):GetInt() then
            self:DrawModel()
            self:DrawShadow(true)
            if LocalPlayer():Alive() and self:GetObjectOwner() == LocalPlayer() and LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physgun" then
                render.DrawLine( self:GetPos(), self:GetPos() + self:GetAngles():Up() * 20, COLHUD_DEFAULT, true )
            end
        else
            self:DrawShadow(false)
        end
    end

end