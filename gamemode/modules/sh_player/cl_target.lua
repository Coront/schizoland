--This file is just used as a way for players to draw their target on the hud. You probably won't find something you're looking for in here unless
--you're trying to adjust the HUD.

function PlayerMeta:SetActiveTarget( ent )
    self.Target = ent
end

function PlayerMeta:ClearActiveTarget()
    self.Target = nil
end

function PlayerMeta:GetActiveTarget()
    return self.Target or nil
end

function PlayerMeta:SetInitialTargetLength( time )
    self.InitialLoss = time
end

function PlayerMeta:GetInitialTargetLength()
    return self.InitialLoss
end

function PlayerMeta:SetActiveTargetLength( time )
    self.TargetLoss = time
end

function PlayerMeta:GetActiveTargetLength()
    return self.TargetLoss or 0
end

hook.Add("Think", "AS_TargetID", function()
    local ply = LocalPlayer()
    local wep = ply:GetActiveWeapon()
    local dist = wep and wep.dt and wep.dt.Status and wep.dt.Status == FAS_STAT_ADS and 12000 or 1000
    local trace = util.TraceLine({
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + (ply:GetAimVector() * dist),
        filter = ply,
        mask = MASK_SHOT
    })
    local ent = trace.Entity
    local ignoreEnts = {
        ["prop_door_rotating"] = true,
        ["func_breakable"] = true,
        ["func_breakable_surf"] = true,
    }
    if IsValid(ent) and not ignoreEnts[ent:GetClass()] and (ent:Health() > 0 or ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) then
        if ent:IsPlayer() and ent:GetMoveType() == MOVETYPE_NOCLIP then return end
        ply:SetActiveTarget( trace.Entity )
        ply:SetActiveTargetLength( CurTime() + 3 )
        ply:SetInitialTargetLength( CurTime() )
    end

    if not IsValid(ply:GetActiveTarget()) or ply:GetActiveTarget() and CurTime() > ply:GetActiveTargetLength() then
        ply:ClearActiveTarget()
    end
end)