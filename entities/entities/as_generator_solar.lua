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
ENT.PotentialElectricity = 25 --The amount of potential electricity we will produce. Basically how much to make when turned on.

--Aftershock Powerlinking System
ENT.PL = {}
POWER = ENT.PL
POWER.NoInlet = true --We will not intake electricity by any means.

if ( CLIENT ) then

    function ENT:Draw()
        if LocalPlayer():GetPos():Distance(self:GetPos()) < GetConVar("as_entity_renderdist"):GetInt() then
            self:DrawModel()
            self:DrawShadow(true)
            if self:GetObjectOwner() == LocalPlayer() and LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physgun" then
                render.DrawLine( self:GetPos(), self:GetPos() + self:GetAngles():Up() * 20, COLHUD_DEFAULT, true )
            end
        else
            self:DrawShadow(false)
        end
    end

end