function PlayerMeta:SetToxic( int )
    self.Toxic = int

    if ( SERVER ) then
        self:ResyncToxic()
    elseif ( CLIENT ) then
        showtoxic = CurTime() + 5
    end
end

function PlayerMeta:GetToxic()
    return self.Toxic or 0
end

function PlayerMeta:AddToxic( int )
    local toxic = self:GetToxic()
    toxic = math.Clamp( toxic + int, 0, SET.MaxToxicity )
    self:SetToxic( toxic )
end

function PlayerMeta:RemoveToxic( int )
    local toxic = self:GetToxic()
    toxic = math.Clamp( toxic - int, 0, SET.MaxToxicity )
    self:SetToxic( toxic )
end

function PlayerMeta:GetMaxToxic()
    return SET.MaxToxicity or 1000
end

function PlayerMeta:SetToxicated( str )
    self.Toxicated = str
end

function PlayerMeta:GetToxicated()
    return self.Toxicated
end

function PlayerMeta:ClearToxicated()
    self.Toxicated = nil
end

function PlayerMeta:IsToxicated()
    if self:GetToxicated() then return true, self:GetToxicated() end
    return false
end

-- ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝

if ( SERVER ) then

    hook.Add( "Think", "AS_Toxicity", function()
        for k, v in pairs( player.GetAll() ) do
            if not v:IsLoaded() then continue end
            if not v:Alive() then continue end

            local toxic = v:GetToxic()
            local toxicated, type = v:IsToxicated()

            if toxicated and toxic < SET.ToxicDebuff then
                if type == "light" then
                    v:ChatPrint("You are no longer lightly toxicated.")
                end
                if type == "heavy" then
                    v:ChatPrint("You are no longer severely toxicated.")
                end
                v:ClearToxicated()
            end

            if toxic >= SET.ToxicDebuff and toxic < SET.ToxicDebuffHeavy and v:GetToxicated() != "light" then
                v:SetToxicated( "light" )
                v:ChatPrint("You are now suffering from light toxicity.")
            elseif toxic >= SET.ToxicDebuffHeavy and v:GetToxicated() != "heavy" then
                v:SetToxicated( "heavy" )
                v:ChatPrint("You are now suffering from severe toxicity.")
            end

            if toxic >= SET.MaxToxicity then
                v:Kill()
                v:SetToxic( SET.MaxToxicity - 100 )
            end

        end
    end)

    hook.Add("Think", "AS_ToxicityDamage", function()
        for k, v in pairs( player.GetAll() ) do
            if not v:IsLoaded() then continue end
            if not v:Alive() then continue end
            if v:GetToxic() < 900 then continue end
            if v:Health() <= 15 then continue end
            if CurTime() < (v.NextToxicUpdate or 0) then continue end

            v:SetHealth( math.Clamp( v:Health() - 5, 15, v:GetMaxHealth() ) )

            v.NextToxicUpdate = CurTime() + 5
        end
    end)

end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if ( SERVER ) then

    util.AddNetworkString("as_toxic_resync")

    function PlayerMeta:ResyncToxic()
        net.Start( "as_toxic_resync" )
            net.WriteUInt( self:GetToxic(), NWSetting.ToxicBits )
        net.Send( self )
    end

elseif ( CLIENT ) then

    net.Receive( "as_toxic_resync", function()
        local toxic = net.ReadUInt( NWSetting.ToxicBits )
        LocalPlayer():SetToxic( toxic )
    end)

end