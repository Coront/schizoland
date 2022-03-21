function PlayerMeta:SetClass( class )
    self.Class = class
end

function PlayerMeta:GetASClass()
    return self.Class
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