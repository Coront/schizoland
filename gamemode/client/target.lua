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
    local trace = ply:TraceFromEyes( 3500 )
    local ent = trace.Entity
    if ent and (ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer()) then
        ply:SetActiveTarget( trace.Entity )
        ply:SetActiveTargetLength( CurTime() + 3 )
        ply:SetInitialTargetLength( CurTime() )
    end

    if not IsValid(ply:GetActiveTarget()) or ply:GetActiveTarget() and CurTime() > ply:GetActiveTargetLength() then
        ply:ClearActiveTarget()
    end
end)