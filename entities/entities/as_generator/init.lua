AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "menu.lua" )
include( "shared.lua" )

function ENT:Use( ply )
    if (ply.Repairing or false) then
        ply.Repairing = false
        ply:CancelTimedEvent()
    else
        net.Start("as_generator_open")
            net.WriteEntity( self )
        net.Send( ply )
    end
end

function ENT:Repair( ply )
    local length = ( (self.MaxHealth - self:Health()) / 10 )

    ply.Repairing = true
    ply:StartTimedEvent( length, true, function()
        ply.Repairing = false
        
        self:SetHealth( self:GetMaxHealth() )
        ply:ChatPrint("You have finished repairing this generator.")
    end)
end

function ENT:OnTakeDamage( dmginfo )
    self:SetHealth( math.Clamp(self:Health() - dmginfo:GetDamage(), 0, self.MaxHealth) )

    if self:Health() <= 0 then
        if self:GetActiveState() then
            self:TogglePower()
        end
    end
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_generator_open")
util.AddNetworkString("as_generator_togglepower")
util.AddNetworkString("as_generator_addfuel")
util.AddNetworkString("as_generator_removefuel")
util.AddNetworkString("as_generator_repair")

net.Receive( "as_generator_togglepower", function( _, ply ) 
    local ent = net.ReadEntity()
    if ent.Base != "as_generator" then return end
    if ply:GetPos():Distance( ent:GetPos() ) > 300 then ply:ChatPrint("You are too far to toggle the state of this generator.") return end
    local state = ent:GetActiveState()

    if not state then
        if ent:Health() <= 0 then ply:ChatPrint("This generator is too damaged to function.") return end
        if not ent.NoFuel and ent:GetFuelAmount() <= 0 then ply:ChatPrint("There is no fuel.") return end
        ply:ChatPrint("You have turned on this generator.")
    else
        if ent:GetObjectOwner() != ply then ply:ChatPrint("You cannot turn off a generator that you do not own.") return end
        ply:ChatPrint("You have turned off this generator.")
    end
    ent:TogglePower()
end)

net.Receive( "as_generator_addfuel", function( _, ply )
    local ent = net.ReadEntity()
    if ent.Base != "as_generator" then return end
    local amt = net.ReadInt( 32 )
    if ply:GetPos():Distance( ent:GetPos() ) > 300 then ply:ChatPrint("You are too far to add fuel to this generator.") return end
    amt = math.Round(amt)
    if amt < 1 then amt = 1 end
    if amt > ply:GetInventory()[ent.Fuel] then amt = (ply:GetInventory()[ent.Fuel] or 0) end
    if amt == 0 then ply:ChatPrint("Nothing to add.") return end

    ply:ChatPrint("You've added " .. amt .. " " .. AS.Items[ent.Fuel].name .. "(s) to this generator for " .. math.Round( (ent.FuelLength * amt) / 60) .. " minutes.")
    ent:DepositFuel( ply, amt )
    ent:ResyncInfo()
end)

net.Receive( "as_generator_removefuel", function( _, ply )
    local ent = net.ReadEntity()
    if ent.Base != "as_generator" then return end
    local amt = net.ReadInt( 32 )
    if not ent:CanRemoveFuel( ply ) then ply:ChatPrint("You cannot withdraw fuel from a generator that you do not own.") return end
    if ply:GetPos():Distance( ent:GetPos() ) > 300 then ply:ChatPrint("You are too far to withdraw fuel from this generator.") return end
    amt = math.Round(amt)
    if amt < 1 then amt = 1 end
    if amt > ent:CalcFuelInput() then amt = ent:CalcFuelInput() end
    if amt == 0 then ply:ChatPrint("Nothing to withdraw.") ent:ResyncInfo() return end

    ply:ChatPrint("You withdrew " .. amt .. " " .. AS.Items[ent.Fuel].name .. "(s) from this generator.")
    ent:WithdrawFuel( ply, amt )
    ent:ResyncInfo()
end)

net.Receive( "as_generator_repair", function( _, ply )
    local ent = net.ReadEntity()
    if ent.Base != "as_generator" then return end

    if ent:Health() >= ent:GetMaxHealth() then ply:ChatPrint("This generator does not need to be repaired.") return end
    if ply:GetPos():Distance( ent:GetPos() ) > 300 then ply:ChatPrint("You are too far to repair this generator.") return end

    ply:ChatPrint("You have started repairing this generator.")
    ent:Repair( ply )
end)