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
		local ent,		outlet		=	self:GetEnt( 1 ),		self:GetEnt( 2 )
		local entpos,	outletpos	=	self:GetPos( 1 ),		self:GetPos( 2 )
		local entlpos,	outletlpos	=	self:GetLocalPos( 1 ),	self:GetLocalPos( 2 )

		if ent == outlet then ply:ChatPrint("You cannot link an entity to itself.") self:ClearObjects() return end
		if outlet.PL and outlet.PL.NoInlet then ply:ChatPrint("This object cannot intake electricity.") self:ClearObjects() return end
		if entpos:Distance( outletpos ) > 400 then ply:ChatPrint("This link is too far!") self:ClearObjects() return end

		local newconstraint, rope = constraint.Rope( ent, outlet, 0, 0, entlpos, outletlpos, (entpos - outletpos):Length(), 100, 0, 3, "cable/cable2", false )

		ent:AddObjectToOutlet( outlet )
		outlet:AddObjectToInlet( ent )
		self:ClearObjects()

		undo.Create("undone_powerlink")
			undo.AddEntity( newconstraint )
			if rope then undo.AddEntity( rope ) end

			undo.AddFunction( function( data, code ) 
				ent:RemoveObjectFromOutlet( outlet )
				outlet:RemoveObjectFromInlet( ent )
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
			local ptbl = tr.Entity.PL or {}
			local elec = ptbl.Electricity or 0

			draw.SimpleTextOutlined( tr.Entity.PrintName .. " [" .. tr.Entity:EntIndex() .. "]", "TargetID", ScrW() / 2, ScrH() * 0.55, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
			draw.SimpleTextOutlined( "Current Electricity: " .. elec, "TargetID", ScrW() / 2, ScrH() * 0.57, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )

			if tr.Entity:HasInlets() then
				local inlets = {}
				for k, v in pairs( tr.Entity:GetInletTable() ) do
					if not IsValid(k) then tr.Entity.PL.Inlets[k] = nil continue end
					inlets[k.PrintName .. " [" .. k:EntIndex() .. "]"] = v
				end

				local x, y = ScrW() * 0.4, ScrH() * 0.6
				draw.SimpleTextOutlined( "Inlets:", "TargetID", x, y, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
				for k, v in pairs(inlets) do
					y = y + 20
					draw.SimpleTextOutlined( k, "TargetID", x, y, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
				end
			end

			if tr.Entity:HasOutlets() then
				local outlets = {}
				for k, v in pairs( tr.Entity:GetOutletTable() ) do
					if not IsValid(k) then tr.Entity.PL.Outlets[k] = nil continue end
					outlets[k.PrintName .. " [" .. k:EntIndex() .. "]"] = v
				end

				local x, y = ScrW() * 0.6, ScrH() * 0.6
				draw.SimpleTextOutlined( "Outlets:", "TargetID", x, y, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
				for k, v in pairs(outlets) do
					y = y + 20
					draw.SimpleTextOutlined( k, "TargetID", x, y, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
				end
			end
		end
	end

	hook.Add("PreDrawHalos", "AS_PowerLinker", function()
		if not LocalPlayer():Alive() then return end
		if not LocalPlayer():IsLoaded() then return end
		if LocalPlayer():GetActiveWeapon():GetClass() != "gmod_tool" then return end
		local halos = {}
		local col = COLHUD_DEFAULT
		for k, v in pairs( ents.GetAll() ) do
			if not v.AS_Conductor then continue end --skip everything not a conductor

			local trace = util.TraceLine({
				start = LocalPlayer():GetShootPos(),
				endpos = LocalPlayer():GetShootPos() + (LocalPlayer():GetAimVector() * 500),
				filter = LocalPlayer(),
			})

			if trace.Entity != v then continue end
			halos[#halos + 1] = v
		end

		halo.Add( halos, col, 5, 5, 1, true, false )
	end)

end

function TOOL.BuildCPanel(panel)
	panel:AddControl("Header", {
		Text = "Power Linker",
		Description = "This tool allows players to initialize and establish electricity links between one or more entities, allowing them to power the object. Order in which this tool DOES matter. The first entity you select will initialize an outlet for it. The second entity will establish it, adding the first object to it's inlet table and the second object to the first object's outlet table."
	})
end