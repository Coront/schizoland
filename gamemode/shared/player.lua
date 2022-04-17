function PlayerMeta:IsFemale()
    if string.find( self:GetNW2String( "as_referencemodel" ), "female" ) then
        return true 
    end
    return false
end

hook.Add( "Think", "AS_Armor", function()
    for k, v in pairs( player.GetAll() ) do
        if not v:IsLoaded() then continue end --Ignore players who arent loaded???
        if not v:Alive() then continue end --This incase too
        if CurTime() < (v.NextArmorUpdate or 0) then continue end --Not their turn to update yet.
        if not v:HasArmor() then
            if (SERVER) and v:GetModel() != v:GetNW2String( "as_referencemodel" ) then --This check make sures that a player's model is reset.
                v:SetModel( v:GetNW2String( "as_referencemodel" ) )
            end
            continue 
        end
        v.NextArmorUpdate = CurTime() + 0.5 --Refresh time. We should always have a delay.

        local curmodel = string.lower( v:GetModel() )
        local armorid = v:GetArmor()
        local armorwep = v:GetArmorWep()

        if (armorwep.Model or armorwep.ModelOverride) and ( SERVER ) then
            local model = armorwep.Model or armorwep.ModelOverride and (armorwep.ModelOverride[v:GetNW2String( "as_referencemodel" )] or armorwep.ModelOverride["default"])
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

        local treatlength = 1
        treatlength = treatlength + (ply:GetSkillLevel("treatment") * SKL.Treatment.inceffectlength)
        ent:AddStatus( "treatment", treatlength ) --This needs to be serverside because we as players dont see other player's effects.
        ent:ResyncStatuses()
    end
end)

if ( CLIENT ) then

    hook.Add("PostDrawTranslucentRenderables", "AS_ArmorOverlay", function()
        for k, v in pairs( player.GetAll() ) do
            if not v:IsLoaded() then continue end
            if not v:Alive() then continue end
            if not v:HasArmor() then v.HideDefault = false v.LastArmorModel = nil continue end
            if v:HasArmor() and not v:GetArmorWep().ArmorModel then continue end

            local armorwep = v:GetArmorWep()
            if not IsValid( v.ArmorOverlay ) then --We'll create a new client model if they don't have one.
                v.ArmorOverlay = ClientsideModel( armorwep.ArmorModel, RENDERGROUP_BOTH )
                v.ArmorOverlay:SetNoDraw( true )
            end
            
            if v.ArmorOverlay:GetModel() != armorwep.ArmorModel then
                v.ArmorOverlay:SetModel( armorwep.ArmorModel )
                v.LastArmorModel = armorwep.ArmorModel
            end
            
            if armorwep.HideDefault then
                v.HideDefault = true
            else
                v.HideDefault = false
            end
            
            if IsValid( v.ArmorOverlay ) then
                if armorwep.BoneMerge then --Bone merging
                    v.ArmorOverlay:SetParent( v )
                    v.ArmorOverlay:AddEffects( EF_BONEMERGE )
                end
                if armorwep.Scale or armorwep.ScaleFemale then
                    local scale = v:IsFemale() and armorwep.ScaleFemale or armorwep.Scale or 1
                    for i = 0, v.ArmorOverlay:GetBoneCount() do
                        v.ArmorOverlay:ManipulateBoneScale( i, Vector( scale, scale, scale ) )
                    end
                end
                v.ArmorOverlay:DrawModel()
            end
        end
    end)

    hook.Add("PrePlayerDraw", "AS_PlayerHide", function( ply )
        if ply:GetMoveType() == MOVETYPE_NOCLIP and not LocalPlayer():IsDeveloping() then return true end
        if ply.HideDefault then
            ply:SetMaterial( "Models/effects/vol_light001" )
        else
            ply:SetMaterial( "" )
        end
    end)

    hook.Add("HUDPaint", "AS_Treatment", function()
        if LocalPlayer():GetASClass() != "scientist" then return end
        local tr = LocalPlayer():TraceFromEyes( 80 )
        local ent = tr.Entity
        if not ent:IsPlayer() then return end
        if ent:Health() >= ent:GetMaxHealth() then return end

        local pos = (ent:GetPos() + ent:OBBCenter()):ToScreen()
        local txt = "Press [" .. string.upper(KEYBIND_USE) .. "] to treat wounds."
        draw.SimpleTextOutlined( txt, "TargetID", pos.x, pos.y, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
    end)

    hook.Add("CalcView", "AS_PlayerRagdollCamera", function( ply,pos, angle, lastfov, znear, zfar )
        if LocalPlayer():Alive() then return end --Not neccessary if player is alive.

        local doll = ply:GetRagdollEntity()
        if not IsValid(doll) then return end

        local bone = doll:LookupBone( "ValveBiped.Bip01_Head1" )
        local newpos, newang = doll:GetBonePosition( bone )

        newang:RotateAroundAxis( newang:Forward(), 270 )
        newang:RotateAroundAxis( newang:Right(), 270 )

        newpos = newpos + 6 * newang:Forward()

        local view = {
            origin = newpos,
            angles = newang,
            fov = lastfov,
            znear = 1,
        }

        return view
    end)
end
