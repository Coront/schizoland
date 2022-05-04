function PlayerMeta:SetASClass( class )
    self.Class = class
    if ( SERVER ) then
        self:ResyncClass()
    end
end

function PlayerMeta:GetASClass()
    return self.Class or "mercenary"
end

function PlayerMeta:CanChangeClass( class )
    if not tobool(GetConVar("as_classchange"):GetInt()) then return false end --Class changing disabled
    if self:GetASClass() == class then return false end --Player already this current class
    if tobool(GetConVar("as_classchangecost"):GetInt()) then
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
            net.WriteEntity(self)
            net.WriteString(self:GetASClass())
        net.Broadcast()
    end

    hook.Add( "Think", "AS_ResyncClasses", function()
        for k, v in pairs( player.GetAll() ) do
            if CurTime() < (v.NextClassResync or 0) then continue end
            v.NextClassResync = CurTime() + 10
            v:ResyncClass()
        end
    end)

elseif ( CLIENT ) then

    net.Receive("as_classes_syncclass", function()
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        ent:SetASClass( net.ReadString() )
    end)

end