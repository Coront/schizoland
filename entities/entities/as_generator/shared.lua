ENT.Type 			= "anim"
ENT.Base 			= "base_entity"
ENT.PrintName		= "Generator"
ENT.Author			= "Tampy"
ENT.Purpose			= "A generator. It produces power."
ENT.Category		= "Aftershock"
ENT.Spawnable		= false
ENT.AS_OwnableObject = true
ENT.AS_Conductor = true
ENT.AS_Generator = true

function ENT:SetActiveState( bool )
    self.Active = bool
end

function ENT:GetActiveState()
    return self.Active or false
end

function ENT:TogglePower()
    if self:GetActiveState() then
        if ( SERVER ) then
            self:StopSound( self.Sound )
        end
        self:SetActiveState( false )
    else
        if ( SERVER ) then
            self:EmitSound( self.Sound )
        end
        self:SetActiveState( true )
    end
    self:UpdatePower()
end

function ENT:SetFuelAmount( amt )
    self.CurrentFuel = amt
end

function ENT:GetFuelAmount()
    return self.CurrentFuel or 0
end

function ENT:AddFuelAmount( amt )
    amt = math.Round( amt )
    self:SetFuelAmount( self:GetFuelAmount() + amt )
end

function ENT:RemoveFuelAmount( amt )
    amt = self:GetFuelAmount() - math.Round(amt)
    if amt < 0 then amt = 0 end --no negatives
    self:SetFuelAmount( amt )
end

function ENT:DepositFuel( ply, amt )
    ply:TakeItemFromInventory( self.Fuel, amt )
    self:AddFuelAmount( (self.FuelLength * amt) )
end

function ENT:WithdrawFuel( ply, amt )
    self:RemoveFuelAmount( (self.FuelLength * amt) )
    ply:AddItemToInventory( self.Fuel, amt, true )
end

function ENT:CanRemoveFuel( ply )
    if self:GetObjectOwner() == ply then return true end
    return false
end

function ENT:CalcFuelInput()
    local amt = 0
    amt = math.floor( self:GetFuelAmount() / self.FuelLength )
    return amt
end

function ENT:Initialize()
    if ( SERVER ) then
        self:SetModel( self.Model )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetUseType( SIMPLE_USE )
        self:SetSolid( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )

        self:SetHealth( self.MaxHealth )
        self:SetMaxHealth( self.MaxHealth )
    end
end

function ENT:Think()
    if self:GetActiveState() then --While on
        if not self.NoFuel and CurTime() > (self.NextFuelLoss or 0) then
            self.NextFuelLoss = CurTime() + 1

            self:RemoveFuelAmount( 1 )
            if self:GetFuelAmount() <= 0 then
                self:TogglePower()
            end
        end
        if self.Solar then
            local tr = util.TraceLine({
                start = self:GetPos(),
                endpos = self:GetPos() + self:GetAngles():Up() * 999999, --stfu
                filter = self,
                mask = MASK_SOLID_BRUSHONLY,
            })
            if tr.MatType != MAT_DEFAULT then
                self:TogglePower()
            end
        end
    end
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

function ENT:Resync()
    if ( SERVER ) then
        local fuel = self:GetFuelAmount()
        local state = self:GetActiveState()

        net.Start("as_generator_sync")
            net.WriteEntity( self )
            net.WriteUInt( fuel, 16 )
            net.WriteBool( state )
        net.Broadcast()
    elseif ( CLIENT ) then
        net.Start("as_generator_requestsync")
            net.WriteEntity( self )
        net.SendToServer()
    end
end

if ( SERVER ) then

    util.AddNetworkString("as_generator_sync")
    util.AddNetworkString("as_generator_requestsync")

    net.Receive( "as_generator_requestsync", function( _, ply )
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end

        local fuel = ent:GetFuelAmount()
        local state = ent:GetActiveState()

        net.Start("as_generator_sync")
            net.WriteEntity( ent )
            net.WriteUInt( fuel, 16 )
            net.WriteBool( state )
        net.Send( ply )
    end)

else

    net.Receive( "as_generator_resync", function()
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end

        local amt = net.ReadUInt( 16 )
        local state = net.ReadBool()

        if isfunction( ent.SetFuelAmount ) then
            ent:SetFuelAmount( amt )
        end
        if isfunction( ent.SetActiveState ) then
            ent:SetActiveState( state )
        end
    end)

    function ENT:Think()
        if CurTime() > (self:GetCreationTime() + NWSetting.PostCreationDelay) and CurTime() > (self.NextResync or 0) then
            self:Resync()
            self.NextResync = CurTime() + NWSetting.EntUpdateLength
        end
    end

end
