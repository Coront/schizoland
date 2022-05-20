TOOL.Category = "AS Tools"
TOOL.Name = "Power Linker"

if ( CLIENT ) then
	language.Add( "tool.as_powerlinker.name", "Power Linker" )
	language.Add( "tool.as_powerlinker.desc", "Link objects to conduct electricity." )
	language.Add( "tool.as_powerlinker.0", "Left Click a conductor to initalize a link. Right Click to clear an object of all links." )
	language.Add( "tool.as_powerlinker.1", "Left Click another conductor to establish the link." )
    language.Add( "undone_powerlink", "Undone Power Link" )
end

function TOOL:LeftClick( trace )
	local ply = self:GetOwner()

	if not trace.Entity:IsValid() then return end
	if not trace.Entity.AS_Conductor then return end --Only conductor objects work

	if ( CLIENT ) then return true end

	local objects = self:NumObjects()
	local phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )

	self:SetObject( objects + 1, trace.Entity, trace.HitPos, phys, trace.PhysicsBone, trace.HitNormal)
	self:SetStage( objects + 1 )

	if ( objects ) > 0 then
		local ent,		otherEnt		=	self:GetEnt( 1 ),		self:GetEnt( 2 )
		local entpos,	otherEntpos	=	self:GetPos( 1 ),		self:GetPos( 2 )
		local entlpos,	otherEntlpos	=	self:GetLocalPos( 1 ),	self:GetLocalPos( 2 )

		if ent == otherEnt then ply:ChatPrint("You cannot link an entity to itself.") self:ClearObjects() return end
		if otherEnt.PL and otherEnt.PL.NoInlet then ply:ChatPrint("This object cannot intake electricity.") self:ClearObjects() return end
		if entpos:Distance( otherEntpos ) > 400 then ply:ChatPrint("This link is too far!") self:ClearObjects() return end
		if ent:GetLinks()[otherEnt] or otherEnt:GetLinks()[ent] then ply:ChatPrint("These objects are already linked.") self:ClearObjects() return end

		local newconstraint, rope = constraint.Rope( ent, otherEnt, 0, 0, entlpos, otherEntlpos, (entpos - otherEntpos):Length(), 100, 0, 3, "cable/cable2", false )

		ent:EstablishLink( otherEnt )
		ent:UpdatePower()
		otherEnt:UpdatePower()
		self:ClearObjects()

		undo.Create("undone_powerlink")
			undo.AddEntity( newconstraint )
			if rope then undo.AddEntity( rope ) end

			undo.AddFunction( function( data, code )
				ent:DestroyLink( otherEnt )
				ent:UpdatePower()
				otherEnt:UpdatePower()
			end)
			undo.SetPlayer( ply )
		undo.Finish()

		ply:AddCleanup( "ropeconstraints", newconstraint )		
		ply:AddCleanup( "ropeconstraints", rope )
	end
end

if ( CLIENT ) then

	function TOOL:DrawHUD()
		local ply = self:GetOwner()
		local tr = ply:TraceFromEyes( 500 )

		if IsValid(tr.Entity) and (tr.Entity.AS_Conductor) then
			local elec = tr.Entity:GetPower()

			draw.SimpleTextOutlined( tr.Entity.PrintName .. " [" .. tr.Entity:EntIndex() .. "]", "TargetID", ScrW() / 2, ScrH() * 0.55, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
			draw.SimpleTextOutlined( "Current Electricity: " .. elec, "TargetID", ScrW() / 2, ScrH() * 0.57, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
		end
	end
end

function TOOL.BuildCPanel(panel)
	panel:AddControl("Header", {
		Text = "Power Linker",
		Description = "Work In Progress"
	})
end