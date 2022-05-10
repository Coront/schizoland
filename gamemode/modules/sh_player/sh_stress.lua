function PlayerMeta:SetStress( time )
    self.Stress = time
end

function PlayerMeta:GetStress()
    return self.Stress or 0
end

function PlayerMeta:UpdateStress( length )
    self:SetStress( CurTime() + length )
end

function PlayerMeta:ClearStress()
    self:SetStress( 0 )
end

function PlayerMeta:InCombat()
    if self:GetStress() > CurTime() then return true end
    return false
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if ( SERVER ) then

    util.AddNetworkString("as_syncstress")

    function PlayerMeta:ResyncStress()
        net.Start("as_syncstress")
            net.WriteDouble(self:GetStress())
        net.Send(self)
    end

elseif ( CLIENT ) then

    net.Receive("as_syncstress", function()
        local length = net.ReadDouble()
        LocalPlayer():SetStress( length )
    end)

end