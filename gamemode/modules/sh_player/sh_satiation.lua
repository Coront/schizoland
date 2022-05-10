function PlayerMeta:SetHunger( amt )
    amt = amt and math.Round(amt) or 0
    self.Hunger = amt
end

function PlayerMeta:SetThirst( amt )
    amt = amt and math.Round(amt) or 0
    self.Thirst = amt
end

function PlayerMeta:GetHunger( amt )
    return self.Hunger or 0
end

function PlayerMeta:GetThirst( amt )
    return self.Thirst or 0
end

function PlayerMeta:GetMaxHunger()
    return 100
end

function PlayerMeta:GetMaxThirst()
    return 100
end

function PlayerMeta:AddHunger( amt )
    amt = amt and math.Round( amt ) or 0
    self:SetHunger( math.Clamp(self:GetHunger() + amt, 0, self:GetMaxHunger()) )
end

function PlayerMeta:AddThirst( amt )
    amt = amt and math.Round( amt ) or 0
    self:SetThirst( math.Clamp(self:GetThirst() + amt, 0, self:GetMaxThirst()) )
end

function PlayerMeta:TakeHunger( amt )
    amt = amt and math.Round( amt ) or 0
    self:SetHunger( math.Clamp(self:GetHunger() - amt, 0, self:GetMaxHunger()) )
end

function PlayerMeta:TakeThirst( amt )
    amt = amt and math.Round( amt ) or 0
    self:SetThirst( math.Clamp(self:GetThirst() - amt, 0, self:GetMaxThirst()) )
end

hook.Add( "Think", "AS_SatiationUpdate", function()
    if not tobool(GetConVar("as_satiation"):GetInt()) then return end

    for k, v in pairs(player.GetAll()) do
        if not v:IsLoaded() then continue end --We skip players who arent loaded for this check.
        if CLIENT and v != LocalPlayer() then continue end --This will make it so that while clientside, it will not update information for everyone, just the local player specifically.

        v.NextHungerUpdate = v.NextHungerUpdate or CurTime() + SAT.HungerUpdate
        v.NextThirstUpdate = v.NextThirstUpdate or CurTime() + SAT.ThirstUpdate
        local hungerupdate = v.NextHungerUpdate
        local thirstupdate = v.NextThirstUpdate

        if CurTime() > hungerupdate then
            if v:GetHunger() > 0 then
                v:SetHunger( math.Clamp(v:GetHunger() - SAT.HungerLoss, 0, v:GetMaxHunger()) )
            else
                if SERVER then
                    v:TakeDamage( SAT.StarveDamage )
                end
            end
            v.NextHungerUpdate = CurTime() + SAT.HungerUpdate
        end

        if CurTime() > thirstupdate then
            if v:GetThirst() > 0 then
                v:SetThirst( math.Clamp(v:GetThirst() - SAT.ThirstLoss, 0, v:GetMaxThirst()) )
            else
                if SERVER then
                    v:TakeDamage( SAT.DehydratedDamage )
                end
            end
            v.NextThirstUpdate = CurTime() + SAT.ThirstUpdate
        end
    end
end)

-- ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝

hook.Add( "KeyPress", "AS_DrinkWater", function( ply, key )
    if key == IN_USE and ply:WaterLevel() == 1 then
        local waterdrinkdelay = 0.5

        ply.NextWaterDrink = ply.NextWaterDrink or CurTime() + waterdrinkdelay
        if CurTime() > ply.NextWaterDrink and ply:GetThirst() < 100 then
            local length = ply.Status and ply.Status["poison"] and (ply.Status["poison"].time - CurTime()) + 5 or 5
            ply:AddStatus( "poison", length )
            ply:AddThirst( 10 )
            ply.NextWaterDrink = CurTime() + waterdrinkdelay
            if SERVER then
                ply:EmitSound( "npc/barnacle/barnacle_gulp1.wav" )
            end
        end
    end
end)

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if SERVER then

    util.AddNetworkString("as_syncsatiation")

    function PlayerMeta:ResyncSatiation()
        net.Start("as_syncsatiation")
            net.WriteUInt( self:GetHunger(), 8 )
            net.WriteUInt( self:GetThirst(), 8 )
        net.Send(self)
    end
    concommand.Add("as_resyncsatiation", function(ply) ply:ResyncSatiation() end)

elseif CLIENT then

    net.Receive("as_syncsatiation", function()
        local hunger = net.ReadUInt( 8 )
        local thirst = net.ReadUInt( 8 )
    
        LocalPlayer():SetHunger( hunger )
        LocalPlayer():SetThirst( thirst )
    end)

end