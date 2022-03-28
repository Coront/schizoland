-- ██████╗ ███████╗██████╗ ███╗   ███╗██╗███████╗███████╗██╗ ██████╗ ███╗   ██╗███████╗
-- ██╔══██╗██╔════╝██╔══██╗████╗ ████║██║██╔════╝██╔════╝██║██╔═══██╗████╗  ██║██╔════╝
-- ██████╔╝█████╗  ██████╔╝██╔████╔██║██║███████╗███████╗██║██║   ██║██╔██╗ ██║███████╗
-- ██╔═══╝ ██╔══╝  ██╔══██╗██║╚██╔╝██║██║╚════██║╚════██║██║██║   ██║██║╚██╗██║╚════██║
-- ██║     ███████╗██║  ██║██║ ╚═╝ ██║██║███████║███████║██║╚██████╔╝██║ ╚████║███████║
-- ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
-- Desc: I usually throw base permissions in here.

function GM:PlayerNoClip( ply, state )
    if ply:IsAdmin() then return true else return false end
end

function GM:PhysgunPickup( ply, ent )
    if ply:IsAdmin() then return true end
    if not PERM.Physgunable[ent:GetClass()] then return false end
    ent:SetCollisionGroup( COLLISION_GROUP_WEAPON )

    return true
end

function GM:PhysgunDrop( ply, ent )
    ent:SetCollisionGroup( COLLISION_GROUP_NONE )
    local physobj = ent:GetPhysicsObject()
    if physobj and IsValid( physobj ) then
        ent:GetPhysicsObject():SetVelocity( Vector( 0, 0, 0 ) )
    end
end

function GM:PlayerCanSeePlayersChat( text, team, listener, speaker )
    if speaker and IsValid(speaker) then
        if listener:GetPos():Distance(speaker:GetPos()) > 1000 or not listener:IsLoaded() then --Player is too far to see this person's text.
            return false 
        end
    end

    return true
end

function GM:PlayerCanHearPlayersVoice( listener, speaker )
    if listener:GetPos():Distance(speaker:GetPos()) > 1500 or not listener:IsLoaded() then --Player is too far to hear this person's voice.
        return false
    end

    return true, true
end

function GM:PlayerShouldTaunt( ply, act )
    ply:PrintMessage( HUD_PRINTCONSOLE, "Acting/Taunting has been disabled.")
    return false
end

hook.Add("StartCommand", "AS_CrouchJumpSpamBlock", function(ply, cmd)
    if not ply:OnGround() and ply:Crouching() and ply:GetMoveType() ~= MOVETYPE_NOCLIP and ply:WaterLevel() < 2 then
        local buttons = cmd:GetButtons()
        cmd:SetButtons(bit.bor(IN_DUCK, buttons))
    end
end)

--Serverside Permissions
if SERVER then

    function GM:PlayerSpawnProp( ply, model )
        local TotalProps = 0
        for k, v in pairs( ents.FindByClass("prop_physics") ) do
            if v.Owner == ply then
                TotalProps = TotalProps + 1
            end
        end
        if TotalProps > PERM.MaxProps and not ply:IsAdmin() then ply:ChatPrint("You have reached the prop limit.") ply:SendLua("surface.PlaySound('" .. UICUE.DECLINE .. "')") return false end
        if PERM.PropBlacklist[model] then ply:ChatPrint("This prop is blacklisted.") return false end

        return true
    end

    function GM:PlayerSpawnedProp( ply, model, ent )
        if not ply:IsAdmin() then
            ent:SetCollisionGroup( COLLISION_GROUP_WEAPON )
            ent:GetPhysicsObject():EnableMotion( false )
            ent:SetRenderMode( RENDERMODE_TRANSCOLOR )
            ent:SetColor( Color( 255, 255, 255, 230 ) )
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

    hook.Add("EntityTakeDamage", "AS_PropDamageBlock", function( target, dmginfo)
        --This prevents both getting damaged by props and crushed by them
        --if target:IsPlayer() and (dmginfo:GetInflictor():GetClass() == "prop_physics" or (dmginfo:GetInflictor():GetClass() == "worldspawn" and not dmginfo:IsFallDamage())) then dmginfo:SetDamage( 0 ) end
    end)

end