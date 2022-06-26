AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "menu.lua" )
include( "shared.lua" )

function ENT:SelectSchedule()
	self:SetSchedule(SCHED_IDLE_STAND)
end

function ENT:Use( ply )
    net.Start( "as_grub_open" )
        net.WriteEntity( self )
    net.Send( ply )
end

function ENT:Die()
    if (self.Dead or false) then return end
    self.Dead = true

    local owner = self:GetObjectOwner()
    owner:RemoveToolFromCache( "tool_grub" ) --Remove this object from the player's cache, so it's gone forever.
    self:EmitSound( "npc/antlion_grub/squashed.wav" )

    local deathdoll = ents.Create("prop_ragdoll")
    deathdoll:SetModel( "models/antlion_grub_squashed.mdl" )
    deathdoll:SetPos( self:GetPos() )
    deathdoll:SetAngles( self:GetAngles() )
    deathdoll:Spawn()
    deathdoll:SetCollisionGroup( COLLISION_GROUP_DEBRIS )

    timer.Simple( 15, function()
        if IsValid( deathdoll ) then
            deathdoll:Remove()
        end
    end)

    local ent = ents.Create("as_grub_nugget")
    ent:SetPos( self:GetPos() + Vector( 0, 0, 20 ) )
    ent:Spawn()
    local amt = (AS.Items["tool_grub"].craft["misc_chemical"] * 0.6) + (self:GetInventory()["misc_chemical"] or 0)
    ent:SetAmount( amt )
    ent:SetModelScale( 2 + (amt * 0.005) )
    ent:Activate()

    self:Remove()
end

function ENT:OnTakeDamage( dmginfo )
    self:SetHealth( math.Clamp(self:Health() - dmginfo:GetDamage(), 0, self.MaxHealth) )

    if self:Health() <= 0 then
        self:Die()
    end
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString("as_grub_open")
util.AddNetworkString("as_grub_takeitems")

net.Receive( "as_grub_takeitems", function( _, ply ) 
    local ent = net.ReadEntity()
    if ent:GetClass() != "as_grub" and ent:GetClass() != "as_grub_large" and ent:GetClass() != "as_grub_king" then return end

    if ply:GetPos():Distance(ent:GetPos()) >= 300 then ply:ChatPrint("You are too far to collect from this grub.") return end
    if table.Count(ent:GetInventory()) <= 0 then return end
    if ent:GetObjectOwner() != ply and ent:Health() > 0 then ply:ChatPrint("Only the owner can take from this grub, unless it is killed.") return end

    local taketbl = {}
    for k, v in pairs( ent:GetInventory() ) do
        ent:PlayerTakeItem( ply, k, v )
        taketbl[AS.Items[k].name] = v
    end

    ply:ResyncInventory()
    ent:Resync()

    ply:ChatPrint("You have taken everything from this grub:")
    for k, v in pairs( taketbl ) do
        ply:ChatPrint( k .. " (" .. v .. ")" )
    end
end)