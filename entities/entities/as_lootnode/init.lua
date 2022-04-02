AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

util.AddNetworkString("as_lootnode_syncnewitem")
util.AddNetworkString("as_lootnode_syncskillinc")

function ENT:SetIndoor( bool )
    self.Indoor = bool
end

function ENT:GetIndoor()
    return self.Indoor or false
end

function ENT:SetResourceType( node )
    self.ResourceType = node
end

function ENT:SetScavengesLeft( num )
    self.ScavengesLeft = num
end

function ENT:GetResourceType()
    return self.ResourceType
end

function ENT:GetScavengesLeft()
    return self.ScavengesLeft
end

function ENT:RandomizeNode() --This will automatically select a type of resource node for us. It's basically scrap vs chems.
    local roll = math.random( 0, 10 )

    if roll <= 6 then
        self:SetResourceType( "Scrap" ) --Scrap wins
        self:SetScavengesLeft( math.random( NOD.ScrapMinScavs, NOD.ScrapMaxScavs ) ) --Amount of times a player can scavenge it before despawning.
    else
        self:SetResourceType( "Chemical" )
        self:SetScavengesLeft( math.random( NOD.ChemMinScavs, NOD.ChemMaxScavs ) )
    end

    return self:GetResourceType()
end

function ENT:Initialize()
    local resourcetype = self:RandomizeNode()
    local model
    if not self:GetIndoor() then
        if resourcetype == "Scrap" then
            _, model = table.Random( NOD.ScrapNodeModels )
        elseif resourcetype == "Chemical" then
            _, model = table.Random( NOD.ChemicalNodeModels )
        end
    else
        _, model = table.Random( NOD.ScrapNodeModelsIndoor )
    end
	self:SetModel( model )
    self:SetSkin( math.random( 0, self:SkinCount() ) )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
end

function ENT:GiveItemToPlayer( ply, item, amt )
    ply:AddItemToInventory( item, amt )
    net.Start("as_lootnode_syncnewitem")
        net.WriteString( item )
        net.WriteInt( amt, 32 )
    net.Send( ply )

    ply:ChatPrint( AS.Items[item].name .. " (" .. amt .. ") added to inventory." )
end

function ENT:DropItem( item, amt )
    local ent = ents.Create("as_baseitem")
    ent:SetItem( item )
    ent:SetAmount( amt )
    ent:SetSkin( AS.Items[item].skin or 0 )
    ent:SetPos( self:GetPos() + Vector( 0, 0, 50 ) )
    ent:Spawn()
    ent:PhysWake()
end

function ENT:IncreaseSalvageSkill( ply )
    ply:IncreaseSkillExperience( "salvaging", SKL.Salvaging.incamt )
    net.Start("as_lootnode_syncskillinc")
    net.Send( ply )
end

function ENT:Use( ply )
    local scavtime = NOD.BaseScavTime - (SKL.Salvaging.decsalvtime * ply:GetSkillLevel("salvaging"))
    if not (ply.Scavenging or false) then
        self:EmitSound( "ambient/levels/streetwar/building_rubble" .. math.random( 1, 5 ) .. ".wav" )
        ply.Scavenging = true
        ply:StartTimedEvent( scavtime, true, function()
            if not IsValid( self ) then return end
            ply.Scavenging = false
            self:SetScavengesLeft( self:GetScavengesLeft() - 1 )
            self:IncreaseSalvageSkill( ply )
            local roll = math.random( 0, 100 )
            if roll > (NOD.ScavengeChance + (SKL.Salvaging.incscavsuccess * ply:GetSkillLevel("salvaging"))) then return end --Player failed to find anything this time

            --Adding Resources to inventory.
            local scavbonus = ply:GetASClass() == "scavenger" and CLS.Scavenger.scavresinc or 0
            if self:GetResourceType() == "Scrap" then
                local item = "misc_scrap"
                if math.random( 1, 10 ) > 5 then
                    item = "misc_smallparts"
                end
                local amt = math.random( math.floor(NOD.ResBaseMin + (SKL.Salvaging.incminres * ply:GetSkillLevel("salvaging")) ) + scavbonus, math.floor(NOD.ResBaseMax + (SKL.Salvaging.incmaxres * ply:GetSkillLevel("salvaging")) ) + scavbonus )
                if ply:CanCarryItem( item, amt ) then
                    self:GiveItemToPlayer( ply, item, amt )
                else
                    self:DropItem( item, amt )
                end
            elseif self:GetResourceType() == "Chemical" then
                local item = "misc_chemical"
                local amt = math.random( math.floor(NOD.ResBaseMin + (SKL.Salvaging.incminres * ply:GetSkillLevel("salvaging")) ) + scavbonus, math.floor(NOD.ResBaseMax + (SKL.Salvaging.incmaxres * ply:GetSkillLevel("salvaging")) ) + scavbonus )
                if ply:CanCarryItem( item, amt ) then
                    self:GiveItemToPlayer( ply, item, amt )
                else
                    self:DropItem( item, amt )
                end
            end

            --Adding item to inventory if successful.
            local itemroll = math.random( 0, 100 )
            if itemroll < ( NOD.ItemChance + math.floor(SKL.Salvaging.incscavitem * ply:GetSkillLevel("salvaging")) ) then
                local scavitmsTotal = 0
				local scavitmsTbl = {}
				for k, v in pairs(NOD.ScavItems) do
					scavitmsTotal = scavitmsTotal + v
				end

				local current = 0
				for k,v in pairs(NOD.ScavItems) do
					scavitmsTbl[k] = {}
					scavitmsTbl[k].minimum = current
					scavitmsTbl[k].maximum = current + v
					current = current + v
				end
				local rndItem = math.random( 1, scavitmsTotal )
				for k, v in pairs(scavitmsTbl) do
					if rndItem > v.minimum and rndItem <= v.maximum then
						local id = AS.Items[k]
						if not id then AS.LuaError("Attempt to index an item that doesn't exist " .. k ) break end
						if ply:CanCarryItem( k, 1 ) then
                            self:GiveItemToPlayer( ply, k, 1 )
                        else
                            self:DropItem( k, 1 )
                        end
						break
					end
				end
            end

            ply:EmitSound( "fx/items/up/itm_ammunition_up0" .. math.random( 1, 3 ) .. ".wav" ) --CONTENTPACKREPLACE

            if self:GetScavengesLeft() <= 0 then
                self:Remove()
            end
        end)
    else
        ply.Scavenging = false
        ply:CancelTimedEvent()
    end
end