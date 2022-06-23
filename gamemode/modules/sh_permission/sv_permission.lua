function isPropBlacklisted( model )
    for k, v in pairs( PERM.PropBlacklist ) do
        if string.lower(k) == string.lower(model) then
            return true
        end
    end

    for k, v in pairs( PERM.PropBlacklistDirectory ) do
        if string.find( string.lower(model), string.lower(v) ) then
            return true
        end
    end

    return false
end

function GM:PlayerSpawnProp( ply, model )
    if not ply:IsAdmin() and tobool(GetConVar("as_nosandbox"):GetInt()) then ply:ChatPrint("No Sandboxing is enabled. You cannot do this.") return false end

    for k, v in pairs( ents.FindByClass("as_staticspawn_zone") ) do
        if v:GetPos():Distance( ply:GetPos() ) <= v:GetZoneDistance() then
            ply:ChatPrint("You cannot spawn props while inside an occupation zone.")
            return false 
        end
    end

    local TotalProps = 0
    for k, v in pairs( ents.FindByClass("prop_physics") ) do
        if v.Owner == ply then
            TotalProps = TotalProps + 1
        end
    end
    if TotalProps > PERM.MaxProps and not ply:IsAdmin() then ply:ChatPrint("You have reached the prop limit.") ply:SendLua("surface.PlaySound('" .. UICUE.DECLINE .. "')") return false end
    if isPropBlacklisted( model ) and not ply:IsAdmin() then ply:ChatPrint( model .. " is blacklisted.") return false end

    return true
end

function GM:PlayerSpawnedProp( ply, model, ent )
    if isPropBlacklisted( model ) and not ply:IsAdmin() then ply:ChatPrint( model .. " is blacklisted.") ent:Remove() return end
    local TotalProps = 0
    for k, v in pairs( ents.FindByClass("prop_physics") ) do
        if v.Owner == ply then
            TotalProps = TotalProps + 1
        end
    end
    if TotalProps > PERM.MaxProps then ply:ChatPrint("You have reached the prop limit.") ent:Remove() return end
    ent:SetObjectOwner( ply )
    if not ply:IsAdmin() and not ent.AdvDupe2 then
        ent:SetCollisionGroup( COLLISION_GROUP_WORLD )
        ent:GetPhysicsObject():EnableMotion( false )
        ent:SetRenderMode( RENDERMODE_TRANSCOLOR )
        ent:SetColor( Color( 255, 255, 255, 230 ) )
        ent:SetModelScale( 1 )
        ent.Owner = ply
        ent.NewSpawn = true
    end
end

function GM:OnPhysgunPickup( ply, ent )
    if ent.NewSpawn then
        ent:SetColor( Color( 255, 255, 255, 255 ) )
        ent.NewSpawn = false
    end
end

function GM:CanPlayerUnfreeze( ply, ent, phys )
    if ply:IsAdmin() then return true end
    if ent:GetNWBool( "NoObjectOwner", false ) then return false end -- can have no owner
    if ent:GetPos():Distance(ply:GetPos()) > 2000 then return false end -- too far
    if ent:GetObjectOwner() != ply or ent.Owner and IsValid(ent.Owner) and ent.Owner != ply then return false end -- not owner
    ent:SetCollisionGroup( COLLISION_GROUP_WORLD )

    return true
end

function GM:PlayerSpawnEffect( ply, model )
    if ply:IsAdmin() then return true else ply:ChatPrint("Effect Spawning is disabled.") return false end
end

function GM:PlayerSpawnNPC( ply, npc, weapon )
    if ply:IsAdmin() then return true else ply:ChatPrint("NPC Spawning is disabled.") return false end
end

function GM:PlayerSpawnRagdoll( ply, model )
    if ply:IsAdmin() then return true else ply:ChatPrint("Ragdoll Spawning is disabled.") return false end
end

function GM:PlayerSpawnSENT( ply, class )
    if ply:IsAdmin() then return true else ply:ChatPrint("Entity Spawning is disabled.") return false end
end

function GM:PlayerSpawnSWEP( ply, weapon, info )
    if ply:IsAdmin() then return true else ply:ChatPrint("Weapon Spawning is disabled.") return false end
end

function GM:PlayerGiveSWEP( ply, weapon, info )
    if ply:IsAdmin() then return true else ply:ChatPrint("Weapon Spawning is disabled.") return false end
end

function GM:PlayerSpawnVehicle( ply, model, name, info )
    if ply:IsAdmin() then return true else ply:ChatPrint("Vehicle Spawning is disabled.") return false end
end

function GM:PlayerSpray( ply )
    return true
end

hook.Add("EntityTakeDamage", "AS_PropDamageBlock", function( target, dmginfo)
    if IsValid(dmginfo:GetInflictor()) and dmginfo:GetInflictor():GetClass() == "prop_physics" then dmginfo:SetDamage( 0 ) end
    if IsValid(dmginfo:GetInflictor()) and dmginfo:GetInflictor():GetClass() == "prop_vehicle_jeep" then dmginfo:SetDamage( 0 ) end
    if dmginfo:GetDamageType() == DMG_CRUSH then dmginfo:SetDamage( 0 ) end
end)

hook.Add("EntityTakeDamage", "AS_PvE", function( target, dmginfo )
    if not tobool(GetConVar("as_pve"):GetInt()) then return end
    if target:IsPlayer() and IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():IsPlayer() then 
        dmginfo:GetAttacker():ChatPrint("PvE Only is enabled. You cannot deal damage to other players.")
        dmginfo:SetDamage( 0 )
    end
end)