function GM:Move( ply, mv ) --I'm intentionally overriding this so we don't use gmod sandbox's movement.
    local scavbonus = ply:GetASClass() == "scavenger" and CLS.Scavenger.movespeedmult or 1
    local movespeed = (SKL.Movement + math.floor(ply:GetSkillLevel( "endurance" ) * SKL.Endurance.runspeed)) * scavbonus
    local sprintmovespeed = (SKL.SprintMovement + math.floor(ply:GetSkillLevel( "endurance" ) * SKL.Endurance.runspeed)) * scavbonus
    --Armor
    movespeed = ply:HasArmor() and AS.Items[ply:GetArmor()].armor["movemult"] and  (movespeed * AS.Items[ply:GetArmor()].armor["movemult"]) or movespeed
    sprintmovespeed = ply:HasArmor() and AS.Items[ply:GetArmor()].armor["movemult"] and (sprintmovespeed * AS.Items[ply:GetArmor()].armor["movemult"]) or sprintmovespeed
    --Adrenaline
    movespeed = ply:HasStatus( "adrenaline" ) and movespeed * 1.15 or movespeed
    sprintmovespeed = ply:HasStatus( "adrenaline" ) and sprintmovespeed * 1.15 or sprintmovespeed
    --Stunned
    movespeed = ply:HasStatus( "stunned" ) and movespeed * 0.4 or movespeed
    sprintmovespeed = ply:HasStatus( "stunned" ) and sprintmovespeed * 0.4 or sprintmovespeed

    ply:SetRunSpeed( sprintmovespeed )
    ply:SetWalkSpeed( movespeed )
    ply:SetSlowWalkSpeed( 75 )
    ply:SetDuckSpeed( 0.4 )
    ply:SetJumpPower( 225 )
    ply:SetViewOffset( Vector( 0, 0, 61 ) )
    ply:SetViewOffsetDucked( Vector( 0, 0, 35 ) )
end

hook.Add( "Think", "AS_Armor", function()
    for k, v in pairs( player.GetAll() ) do
        if not v:IsLoaded() then continue end --Ignore players who arent loaded???
        if not v:Alive() then continue end --This incase too
        if CurTime() < (v.NextArmorUpdate or 0) then continue end --Not their turn to update yet.
        if not v:HasArmor() then
            if (SERVER) and v:GetModel() != v:GetNWString( "as_referencemodel" ) then --This check make sures that a player's model is reset.
                v:SetModel( v:GetNWString( "as_referencemodel" ) )
            end
            continue 
        end
        v.NextArmorUpdate = CurTime() + 0.5 --Refresh time. We should always have a delay.

        local curmodel = string.lower( v:GetModel() )
        local armorid = v:GetArmor()
        local armorwep = v:GetArmorWep()

        if (armorwep.Model or armorwep.ModelOverride) and ( SERVER ) then
            local model = armorwep.Model or armorwep.ModelOverride and (armorwep.ModelOverride[v:GetNWString( "as_referencemodel" )] or armorwep.ModelOverride["default"])
            if curmodel != model then
                v:SetModel( model )
            end
        elseif armorwep.ArmorModel and ( CLIENT ) then
            if not v.ArmorOverlay then
                v.ArmorOverlay = ClientsideModel( armorwep.ArmorModel, RENDERGROUP_BOTH ) --We'll create a new model for overlayed models if it doesn't exist.
                v.ArmorOverlay:SetNoDraw( true )
            end
            
            if armorwep.BoneMerge then
                v.ArmorOverlay:SetParent( ent )
                v.ArmorOverlay:AddEffects( EF_BONEMERGE )
            end
        end
    end
end)

hook.Add( "KeyPress", "AS_Treatment", function( ply, key )
    if key != IN_USE then return end
    if not IsFirstTimePredicted() then return end
    if ply:GetASClass() != "scientist" then return end
    local tr = ply:TraceFromEyes( 80 )
    local ent = tr.Entity
    if not ent:IsPlayer() then return end
    if ent:Health() >= ent:GetMaxHealth() then return end
    if ply:HasStatus( "treatmentdelay" ) then if (CLIENT) then ply:ChatPrint("You must wait before treating again.") end return end

    local length = 5
    length = length - (ply:GetSkillLevel("treatment") * SKL.Treatment.deccooltime)
    ply:IncreaseSkillExperience( "treatment", SKL.Treatment.incamt )
    
    if SERVER then
        ent:EmitSound("items/medshot4.wav", 80, 100, 0.2)
        ply:AddStatus( "treatmentdelay", length )
        ply:ResyncStatuses()
        ply:AddToStatistic( "treatments", 1 )

        local treatlength = 1
        treatlength = treatlength + (ply:GetSkillLevel("treatment") * SKL.Treatment.inceffectlength)
        ent:AddStatus( "treatment", treatlength ) --This needs to be serverside because we as players dont see other player's effects.
        ent:ResyncStatuses()
    end
end)

hook.Add( "EntityEmitSound", "AS_TimeScaleSounds", function( t )
    local timeScale = GetConVar( "host_timescale" )

	local p = t.Pitch

	if ( game.GetTimeScale() ~= 1 ) then
		p = p * game.GetTimeScale()
	end

	if ( p ~= t.Pitch ) then
		t.Pitch = math.Clamp( p, 0, 255 )
	end

    return true
end )

hook.Add( "EntityEmitSound", "AS_NoConnectSound", function( tbl )
    if tbl.Entity:IsValid() and tbl.Entity:IsPlayer() and tbl.SoundName == "player/pl_drown1.wav" then return false end
end )