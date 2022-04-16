AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Antlion Mound"
ENT.Category = "Aftershock - Automated Events"
ENT.Spawnable = true 

if ( SERVER ) then

    function ENT:Initialize()
        self:SetModel( "models/props_wasteland/antlionhill.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:SetUseType(SIMPLE_USE)
        self:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
        self:GetPhysicsObject():EnableMotion( false )
        local trace = util.TraceLine({
            start = self:GetPos(),
            endpos = (self:GetPos()) + Vector( 0, 0, -9999 ),
            filter = {self},
        })
        self:SetPos( trace.HitPos )

        self.NormalPos = trace.HitPos
        self.RespawnDelay = 600
        self.ZAmount = -600
        self.CurZAmount = -400
        self.Item = "misc_egg" --Item obtained from harvesting
        self.ItemAmt = math.random( 1, 2 ) --Maximum times this can be harvested
        self.ItemTime = 15 --Time it takes to harvest
        self.ShowHealth = true
        self.NPCS = {
            ["npc_as_antlion"] = 6,
        }

        self:SetHealth( 4000 )
        self:SetMaxHealth( 4000 )
        self:SetNextSound( CurTime() + 1 )
        self:SetNextNPCSpawn( CurTime() + 5 )
        self.ActiveNPCS = {}
    end

    function ENT:Use( ply )
        if self.ItemAmt <= 0 then return end

        if self.Item and AS.Items[self.Item] then
            if not (ply.Scavenging or false) then
                ply.Scavenging = true
                self:EmitSound( "ambient/levels/streetwar/building_rubble" .. math.random( 1, 5 ) .. ".wav" )
                ply:StartTimedEvent( self.ItemTime, true, function()
                    if not IsValid(self) then return end
                    if self.ItemAmt <= 0 then ply:ChatPrint("There is nothing left to harvest.") return end
                    self.ItemAmt = self.ItemAmt - 1
                    ply:AddItemToInventory( self.Item, 1 )
                    ply:ResyncInventory()
                    ply:ChatPrint( AS.Items[self.Item].name .. " (1) added to inventory." )
                end)
            else
                ply.Scavenging = false
                ply:CancelTimedEvent()
            end
        else
            AS.LuaError("Attempt to reference a non-existant item at event_mound - " .. self.Item)
            ply:SendLua("AS.LuaError('Attempt to reference a non-existant item at event_mound - " .. self.Item .. "')")
        end
    end

    function ENT:OnTakeDamage( dmg )
        self:SetHealth( self:Health() - dmg:GetDamage() )

        if self:Health() <= 0 then
            self:Destroy()
        end
    end

    function ENT:Destroy()
        self.Destroyed = true
        self:EmitSound( "ambient/machines/wall_crash1.wav", 100, 80, 1 )
    end

    function ENT:CanSpawnNPCS()
        for k, v in pairs( player.GetAll() ) do
            if not v:IsLoaded() then continue end
            if not IsValid(v) or not v:Alive() then continue end
            if not v:IsDeveloping() then continue end

            if v:GetPos():Distance(self:GetPos()) < 2000 then return false end
        end
        return true
    end

    function ENT:SpawnNPCS()
        if not self:CanSpawnNPCS() then return end

        local pos = self:GetPos()
        for k, v in pairs( self.NPCS ) do --Loop though the NPC table
            local current = 0
            for k2, v2 in pairs( self.ActiveNPCS ) do
                if not IsValid(v2) then continue end
                current = current + 1
            end
            local numToSpawn = v - current
            if numToSpawn <= 0 then return end --No reason to continue, none to spawn.

            for i = 1, numToSpawn do --Spawn the amount of NPCs.
                local x, y = math.random(-500, 500), math.random(-500, 500)
                if math.abs(x) < 200 then --Random math stuff to force the npc to be atleast 100 units away (to stop them from spawning stuck)
                    local dice = math.random( 0, 1 )
                    x = dice == 1 and 200 or -200
                end
                if math.abs(y) < 200 then
                    local dice = math.random( 0, 1 )
                    y = dice == 1 and 200 or -200
                end

                local spawnPos = pos + Vector( x, y, 200 )
                local tr = util.TraceLine({
                    start = spawnPos,
                    endpos = spawnPos + Vector( 0, 0, -9999 )
                })

                local npc = ents.Create(k)
                npc:SetPos( tr.HitPos )
                npc:Spawn()
                self.ActiveNPCS[#self.ActiveNPCS + 1] = npc
            end
        end
    end

    function ENT:SetNextNPCSpawn( time )
        self.NPCSpawn = time
    end

    function ENT:GetNextNPCSpawn()
        return self.NPCSpawn or 0
    end

    function ENT:SetNextSound( time )
        self.NextSound = time
    end

    function ENT:GetNextSound()
        return self.NextSound or 0
    end

    function ENT:Think()
        if CurTime() > self:GetNextNPCSpawn() then
            self:SetNextNPCSpawn( CurTime() + self.RespawnDelay )
            self:SpawnNPCS()
        end

        if CurTime() > self:GetNextSound() then
            self:SetNextSound( CurTime() + 15 )
            self:EmitSound("npc/antlion/idle" .. math.random( 1, 5 ) .. ".wav")
        end

        if not (self.Destroyed or false) and self:Health() > 0 and self.CurZAmount < 0 then
            self.CurZAmount = math.Approach(self.CurZAmount, 0, 2)
            self:SetPos( self.NormalPos + Vector( 0, 0, self.CurZAmount ) )
        end

        if (self.Destroyed) then
            self.CurZAmount = math.Approach(self.CurZAmount, self.ZAmount, -2)
            self:SetPos( self.NormalPos + Vector( 0, 0, self.CurZAmount ) )
            if self.CurZAmount <= self.ZAmount then
                self:Remove()
            end
        end

        self:NextThink( CurTime() + 0.01 )
        return true
    end

end