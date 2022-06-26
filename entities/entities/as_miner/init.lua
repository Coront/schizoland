AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "menu.lua" )
include( "shared.lua" )

function ENT:Use( ply )
    net.Start( "as_miner_open" )
        net.WriteEntity( self )
    net.Send( ply )
end

function ENT:OnTakeDamage( dmginfo )
    self:SetHealth( math.Clamp(self:Health() - dmginfo:GetDamage(), 0, self.MaxHealth) )

    if self:Health() <= 0 then
        if self:GetActiveState() then
            self:TogglePower()
            self:DisableOperation()
        end
    end
end

function ENT:EnableOperation()
    self:EmitSound("ambient/machines/thumper_startup1.wav")
    self:ResetSequence( self:LookupSequence("idle") )
    self:SetPlaybackRate( 1 )
end

function ENT:DisableOperation()
    self:EmitSound("ambient/machines/thumper_shutdown1.wav")
    self:SetPlaybackRate( 0 )
end

function ENT:Repair( ply )
    local length = ( (self.MaxHealth - self:Health()) / 10 )

    ply.Repairing = true
    ply:StartTimedEvent( length, true, function()
        ply.Repairing = false
        
        self:SetHealth( self:GetMaxHealth() )
        ply:ChatPrint("You have finished repairing this miner.")
    end)
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_miner_open")
util.AddNetworkString("as_miner_togglepower")
util.AddNetworkString("as_miner_repair")
util.AddNetworkString("as_miner_takeitems")

net.Receive( "as_miner_togglepower", function( _, ply ) 
    local ent = net.ReadEntity()
    if ent:GetClass() != "as_miner" and ent:GetClass() != "as_miner_large" then return end
    if ply:GetPos():Distance( ent:GetPos() ) > 300 then ply:ChatPrint("You are too far to toggle the state of this miner.") return end
    if ply:GetASClass() != "scavenger" then ply:ChatPrint("You must be a scavenger to manage this miner.") return end
    local state = ent:GetActiveState()

    if not state then
        if ent:Health() <= 0 then ply:ChatPrint("This miner is too damaged to function.") return end
        if not ent:CanMine() then ply:ChatPrint("The miner cannot detect any earth below it.") return end
        ent:EnableOperation()
        ply:ChatPrint("You have turned on this miner.")
    else
        if ent:GetObjectOwner() != ply then ply:ChatPrint("You cannot turn off a miner that you do not own.") return end
        ent:DisableOperation()
        ply:ChatPrint("You have turned off this miner.")
    end
    ent:TogglePower()
end)

net.Receive( "as_miner_repair", function( _, ply )
    local ent = net.ReadEntity()
    if ent:GetClass() != "as_miner" and ent:GetClass() != "as_miner_large" then return end

    if ent:Health() >= ent:GetMaxHealth() then ply:ChatPrint("This miner does not need to be repaired.") return end
    if ply:GetPos():Distance( ent:GetPos() ) > 300 then ply:ChatPrint("You are too far to repair this miner.") return end

    ply:ChatPrint("You have started repairing this miner.")
    ent:Repair( ply )
end)

net.Receive( "as_miner_takeitems", function( _, ply ) 
    local ent = net.ReadEntity()
    if ent:GetClass() != "as_miner" and ent:GetClass() != "as_miner_large" then return end

    if ply:GetPos():Distance(ent:GetPos()) >= 300 then ply:ChatPrint("You are too far to collect from this miner.") return end
    if table.Count(ent:GetInventory()) <= 0 then return end
    if ent:GetObjectOwner() != ply and ent:Health() > 0 then ply:ChatPrint("Only the owner can take from this miner, unless it is destroyed.") return end

    local taketbl = {}
    for k, v in pairs( ent:GetInventory() ) do
        ent:PlayerTakeItem( ply, k, v )
        taketbl[AS.Items[k].name] = v
    end

    ent:Resync()
    ply:ResyncInventory()

    ply:ChatPrint("You have taken everything from this miner:")
    for k, v in pairs( taketbl ) do
        ply:ChatPrint( k .. " (" .. v .. ")" )
    end
end)