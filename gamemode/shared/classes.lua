function PlayerMeta:SetASClass( class )
    self.Class = class
end

function PlayerMeta:GetASClass()
    return self.Class
end

if (SERVER) then

    function PlayerChangeClass( ply, cmd, args )
        local class = args[1]
        if not AS.Classes[class] then return end
        if not ply:CanChangeClass( class ) then return end
        if SET.ClassChangeCost then
            for k, v in pairs( SET.ClassChangeCostTbl ) do
                ply:TakeItemFromInventory( k, v )
                ply:ResyncInventory()
            end
        end

        ply:SetASClass( class )
        ply:ResyncClass()
        ply:Spawn()
        ply:ChatPrint("You are now a " .. AS.Classes[class].name .. "." )

    end
    concommand.Add( "as_changeclass", PlayerChangeClass )

end

function PlayerMeta:CanChangeClass( class )
    if not SET.ClassChange then return false end --Class changing disabled
    if self:GetASClass() == class then return false end --Player already this current class
    if SET.ClassChangeCost then
        for k, v in pairs( SET.ClassChangeCostTbl ) do
            if not self:HasInInventory( k, v ) then
                return false
            end
        end
    end
    return true
end

function translateClassNameID( str )
    for k, v in pairs( AS.Classes ) do
        if k == str then
            return AS.Classes[k].name
        end
        if v.name == str then
            return k
        end
    end
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if ( SERVER ) then

    util.AddNetworkString("as_classes_syncclass")

    function PlayerMeta:ResyncClass()
        net.Start("as_classes_syncclass")
            net.WriteString(self:GetASClass())
        net.Send(self)
    end

elseif ( CLIENT ) then

    net.Receive("as_classes_syncclass", function()
        LocalPlayer():SetASClass( net.ReadString() )
    end)

end