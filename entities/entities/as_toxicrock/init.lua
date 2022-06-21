AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_wasteland/rockgranite03a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
end

function ENT:Think()
	for k, v in pairs( player.GetAll() ) do
		if not v:IsLoaded() then continue end
		if not v:Alive() then continue end
		if v:GetPos():Distance(self:GetPos()) > self:GetToxicDistance() then continue end
		if (v.NextToxTick or 0) > CurTime() then continue end

		local dist = v:GetPos():Distance(self:GetPos())
		local perc = Lerp( dist / self:GetToxicDistance(), 0, 1 )
		local toxamt = math.ceil( self:GetToxicAmt() * (1 - perc) )

		if v:HasArmor() then
			toxamt = math.Clamp( toxamt - AS.Items[v:GetArmor()].armor[DMG_RADIATION], 0, 100 )
		end

		if toxamt > 0 then
			v:AddToxic( toxamt )
			v:SendLua( "surface.PlaySound('player/geiger" .. math.random( 1, 3 ) .. ".wav')" )
			v.NextToxTick = CurTime() + 1
		end
	end
end