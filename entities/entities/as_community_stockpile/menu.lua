Stockpile = Stockpile or {}
local ent

function Stockpile.Open()
    ent = net.ReadEntity()
    
    
end
net.Receive("as_community_open", Stockpile.Open)