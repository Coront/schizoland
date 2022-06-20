AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Coalition Canister"
ENT.Category = "Aftershock - Event Spawner"
ENT.Spawnable = true 

if ( SERVER ) then

    function ENT:Initialize()
        self.NPCSpawned = false
        self:StartCanister()

        self.NPCS = { --Modify this table if you need to change NPC values.
            ["npc_as_soldier"] = 4, --Key is NPC, Value is amount
            ["npc_as_scout"] = 1,
            ["npc_as_super"] = 1,
            ["npc_as_hunter"] = 2,
        }
    end

    
    function ENT:SetNPCSpawnTime( time )
        self.NPCSpawnTime = time
    end

    function ENT:GetNPCSpawnTime()
        return self.NPCSpawnTime
    end

    function ENT:StartCanister()
        local ang = Angle( math.random(-90, -60), math.random( 0, 180 ), 0 )
        local flightTime = 10
        self.canister = ents.Create("env_headcrabcanister")
        self.canister:SetPos( self:GetPos() )
        self.canister:SetAngles( ang )
        self.canister:SetKeyValue( "HeadcrabType", 0 )
        self.canister:SetKeyValue( "HeadcrabCount", 0 )
        self.canister:SetKeyValue( "FlightSpeed", 5000 )
        self.canister:SetKeyValue( "FlightTime", 10 )
        self.canister:SetKeyValue( "StartingHeight", 1000 )
        self.canister:SetKeyValue( "Damage", 500 )
        self.canister:SetKeyValue( "DamageRadius", 1000 )
        self.canister:SetKeyValue( "SmokeLifetime", 10 )
        self.canister:Spawn()
        self.canister:Activate()
        self.canister:Fire( "FireCanister" )

        self:SetNPCSpawnTime( CurTime() + (flightTime + 3) )
        self.DespawnTime = CurTime() + 1800 --30 minutes
    end

    function ENT:SpawnNPCS()
        local pos = self:GetPos()
        local toAng = self:GetAngles()

        for k, v in pairs( self.NPCS ) do --Loop though the NPC table
            for i = 1, v do --Spawn the amount of NPCs.
                local npc = ents.Create(k)
                npc:SetPos( pos + toAng:Forward() * 350 + Vector( 0, 0, 150 ) )
                npc:Spawn()

                toAng = toAng + Angle( 0, 70, 0 )
            end
        end

        --We're also going to swap the canister to a new entity. This will be the entity that player's will be able to salvage for resources.
        local pos = self.canister:GetPos()
        local ang = self.canister:GetAngles()
        self.canister:Remove()
        local ent = ents.Create("as_lootnode")
        ent:SetPos( pos )
        ent:SetAngles( ang )
        ent:Spawn()
        ent:SetModel("models/props_combine/headcrabcannister01b.mdl")
        ent:SetResourceType("Canister")
        ent:SetScavengesLeft( math.random( 15, 25 ) )
        ent:GetPhysicsObject():EnableMotion( false )
        ent:SetSequence( ent:LookupSequence("idle_open") )

        self:Remove()
    end

    function ENT:Think()
        if CurTime() >= self:GetNPCSpawnTime() and not (self.NPCSpawned) then
            self.NPCSpawned = true 
            self:SpawnNPCS()
        end
    end
else

    function ENT:Draw() --This will just hide the error.
        return
    end

end