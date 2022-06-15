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
    if ent:GetNWBool( "NoObjectOwner", false ) then return false end -- can have no owner
    if ent:GetPos():Distance(ply:GetPos()) > 2000 then return false end -- too far
    if ent:GetObjectOwner() != ply or ent.Owner and IsValid(ent.Owner) and ent.Owner != ply then return false end -- not owner
    ent:SetCollisionGroup( COLLISION_GROUP_WORLD )

    return true
end

function GM:PhysgunDrop( ply, ent )
    if not ply:IsAdmin() then
        ent:SetCollisionGroup( COLLISION_GROUP_NONE )
        local physobj = ent:GetPhysicsObject()
        if physobj and IsValid( physobj ) then
            ent:GetPhysicsObject():SetVelocity( Vector( 0, 0, 0 ) )
        end
    end
end

function GM:GravGunPunt( ply, ent )
    if ply:IsAdmin() then
        return true
    end
    return false
end

function GM:PlayerCanSeePlayersChat( text, team, listener, speaker )
    if tobool(GetConVar("as_alltalk"):GetInt()) and listener:IsLoaded() then return true end

    if speaker and IsValid(speaker) then
        if listener:GetPos():Distance(speaker:GetPos()) > PERM.ChatDistance or not listener:IsLoaded() then --Player is too far to see this person's text.
            return false 
        end
    end

    return true
end

function GM:PlayerCanHearPlayersVoice( listener, speaker )
    if tobool(GetConVar("as_alltalk"):GetInt()) and listener:IsLoaded() then return true, false end

    if listener:GetPos():Distance(speaker:GetPos()) > PERM.VoiceDistance or not listener:IsLoaded() then --Player is too far to hear this person's voice.
        return false
    end

    return true, true
end

function GM:CanTool( ply, tr, toolname, tool, button )
    if ply:IsAdmin() then return true end
    if SERVER and tobool(GetConVar("as_nosandbox"):GetInt()) then ply:ChatPrint("No Sandboxing is enabled. You cannot do this.") return false end
    if not PERM.ToolWhitelist[toolname] then return false end
    if tr.HitWorld and (toolname == "advdupe2" or toolname == "keypad_willox") then return true end
    if tr.Entity:GetObjectOwner() != ply then return false end
    return true
end

function GM:CanProperty( ply, property, ent )
    if not ply:IsAdmin() then return false end
    return true
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

hook.Add("ShouldCollide", "AS_PlayerCollisions", function( ent1, ent2 )
    if ent1:IsPlayer() and ent2:IsPlayer() and (ent1:GetMoveType() == MOVETYPE_NOCLIP or not tobool(GetConVar("as_collisions"):GetInt())) then
        return false
    end
end)