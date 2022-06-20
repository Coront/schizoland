AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Use( ply )
    net.Start( "as_miner_open" )
        net.WriteEntity( self )
    net.Send( ply )
end

function ENT:OnTakeDamage( dmginfo )
    self:SetHealth( math.Clamp(self:Health() - dmginfo:GetDamage(), 0, self.MaxHealth) )

    if self:Health() <= 0 then
        if self:GetActiveState() then
            self:TogglePower()
            self:DisableOperation()
        end
    end
end

function ENT:EnableOperation()
    self:EmitSound("ambient/machines/thumper_startup1.wav")
    self:ResetSequence( self:LookupSequence("idle") )
    self:SetPlaybackRate( 1 )
end

function ENT:DisableOperation()
    self:EmitSound("ambient/machines/thumper_shutdown1.wav")
    self:SetPlaybackRate( 0 )
end

function ENT:Repair( ply )
    local length = ( (self.MaxHealth - self:Health()) / 10 )

    ply.Repairing = true
    ply:StartTimedEvent( length, true, function()
        ply.Repairing = false
        
        self:SetHealth( self:GetMaxHealth() )
        ply:ChatPrint("You have finished repairing this miner.")
    end)
end