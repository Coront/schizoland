Thirdperson = {}
Thirdperson.Enabled = false

AS_ClientConVar( "as_thirdperson_distance", "40", true, false )
AS_ClientConVar( "as_thirdperson_side", "15", true, false )
AS_ClientConVar( "as_thirdperson_up", "5", true, false )

hook.Add( "CalcView", "AS_Thirdperson", function( ply, pos, angles, lastfov )
    if not Thirdperson.Enabled then return end
    if not ply:Alive() then return end

    local dist, side, up = math.Clamp( GetConVar("as_thirdperson_distance"):GetInt(), -20, 200 ), math.Clamp( GetConVar("as_thirdperson_side"):GetInt(), -40, 40 ), math.Clamp( GetConVar("as_thirdperson_up"):GetInt(), -20, 40 )

    local view = {
		origin = pos + (angles:Up() * up) + (angles:Forward() * -dist) + (angles:Right() * side),
		angles = angles,
		fov = lastfov,
        znear = 1,
		drawviewer = true
	}

    local trace = util.TraceHull({
        mins = Vector( -2, -2, -2 ),
        maxs = Vector( 2, 2, 2 ),
        start = ply:GetShootPos(), 
        endpos = view.origin,
        filter = ply,
        mask = MASK_SOLID
    })

    if trace.Hit then
        view.origin = trace.HitPos + ( ply:GetShootPos() - trace.HitPos ):GetNormal()
    end

	return view
end)

concommand.Add("as_thirdperson", function()
    if Thirdperson.Enabled then
        Thirdperson.Enabled = false 
    else
        Thirdperson.Enabled = true
    end
end)