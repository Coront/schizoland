AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "menu.lua" )
include( "shared.lua" )

function ENT:Use( ply )
    if (ply.Pruning or false) then
        ply.Pruning = false
        ply:CancelTimedEvent()
    else
        net.Start("as_plant_open")
            net.WriteEntity( self )
        net.Send( ply )
    end
end

function ENT:Prune( ply )
    local length = ( (self.PruneMax - self.PruneAmount) / 10 )
    if self:HasObjectOwner() then
        length = length * (1 - (self:GetObjectOwner():GetSkillLevel("farming") * SKL.Farming.decprunetime))
    end
    
    ply.Pruning = true
    ply:StartTimedEvent( length, true, function()
        ply.Pruning = false
        
        self:SetPruneAmount( self.PruneMax )
        self:ResyncPrune()
        ply:ChatPrint("You have finished pruning this plant.")
    end)
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_plant_resyncprune")
util.AddNetworkString("as_plant_open")
util.AddNetworkString("as_plant_prune")

net.Receive( "as_plant_prune", function( _, ply )
    local ent = net.ReadEntity()
    if ent.Base != "as_plant" then return end
    if ply:GetPos():Distance(ent:GetPos()) > 300 then ply:ChatPrint("You're too far.") return end

    if ply:GetASClass() != "cultivator" then ply:ChatPrint( "You must be a cultivator to prune this!" ) return end
    if not ent:CanPrune( ply ) then return end

    ply:ChatPrint("You have started pruning this plant.")
    ent:Prune( ply )
end)