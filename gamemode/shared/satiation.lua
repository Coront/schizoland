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

function PlayerMeta:AddHunger( amt )
    amt = amt and math.Round( amt ) or 0
    self:SetHunger( self:GetHunger() + amt )
end

function PlayerMeta:AddThirst( amt )
    amt = amt and math.Round( amt ) or 0
    self:SetThirst( self:GetThirst() + amt )
end

function PlayerMeta:TakeHunger( amt )
    amt = amt and math.Round( amt ) or 0
    self:SetHunger( self:GetHunger() - amt )
end

function PlayerMeta:TakeThirst( amt )
    amt = amt and math.Round( amt ) or 0
    self:SetThirst( self:GetThirst() - amt)
end

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
            net.WriteInt( self:GetHunger(), 32 )
            net.WriteInt( self:GetThirst(), 32 )
        net.Send(self)
    end
    concommand.Add("as_resyncsatiation", function(ply) ply:ResyncSatiation() end)

elseif CLIENT then

    function SatiationSync()
        local hunger = net.ReadInt( 32 )
        local thirst = net.ReadInt( 32 )

        LocalPlayer():SetHunger( hunger )
        LocalPlayer():SetThirst( thirst )
    end
    net.Receive("as_syncsatiation", SatiationSync)

end