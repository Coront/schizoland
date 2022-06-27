SWEP.PrintName = "Defibrillator"
SWEP.Category = "Aftershock"
SWEP.Spawnable = false
SWEP.Base = "fas2_base_melee"
SWEP.Slot = 1

SWEP.ViewModelFOV = 60
SWEP.VM = "models/weapons/v_hands.mdl"
SWEP.WM = "models/weapons/w_defuser.mdl"
SWEP.ViewModel = "models/weapons/v_hands.mdl"
SWEP.WorldModel = "models/weapons/w_defuser.mdl"
SWEP.DrawWeaponInfoBox = false

SWEP.HoldType = "slam"
SWEP.RunHoldType = "slam"
SWEP.NoProficiency = true
SWEP.NoAttachmentMenu = true

SWEP.ASID = "wep_defib" --Aftershock item ID

SWEP.Sounds = {}
SWEP.FireModes = {"semi"}

SWEP.Anims = {}
SWEP.Anims.Draw = "idle"
SWEP.Anims.Idle = "idle"
SWEP.Anims.Holster = "idle"

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0

SWEP.Primary.Automatic = true
SWEP.Secondary.Automatic = true

SWEP.MaxCharges = 5
SWEP.ChargeWait = 2 --Time between charges

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()
	local tr = util.TraceLine({
		start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + ply:EyeAngles():Forward() * 100,
        filter = {ply},
	})
	local rag = tr.Entity
	
	if IsFirstTimePredicted() and tr.Hit and rag:IsRagdoll() and IsValid(rag.Owner) and self:GetCharges() >= 5 then
		if ( SERVER ) then
			self:SetNextPrimaryFire( CurTime() + 1 )

			if tobool(GetConVar("as_defibwait"):GetInt()) and CurTime() < (rag.Owner.NoDefib or 0) then
				ply:ChatPrint("This person was revived too recently.")
				return
			end

			self:SetCharges( 0 )

			local otherPly = rag.Owner
			otherPly.WasDefibbed = true
			otherPly:SetNWFloat( "NoCollideTimer", CurTime() + 3 )
			otherPly:Spawn()
			otherPly:SetPos( otherPly.LastDeathPos )
			otherPly:SetHealth( 15 )
			otherPly:ChatPrint("You were defibrillated!")
			otherPly:EmitSound( "ambient/energy/zap1.wav", 80 )
			otherPly.NoDefib = CurTime() + SET.DefibWait
			otherPly.WasDefibbed = false

			plogs.PlayerLog(ply, "Items", ply:NameID() .. " defibrillated " .. otherPly:Nickname(), {
				["Name"] 	= ply:Name(),
				["SteamID"]	= ply:SteamID(),
			})
		end
	end
end

function SWEP:SecondaryAttack()
	local ply = self:GetOwner()

	if IsFirstTimePredicted() and self:GetCharges() < 5 then
		if ( SERVER ) then
			self:SetCharges( self:GetCharges() + 1 )
			self:SetNextSecondaryFire( CurTime() + self.ChargeWait )
			ply:EmitSound( "ambient/energy/spark" .. math.random( 1, 6 ) .. ".wav", 60 )
		end
	end
end

function SWEP:SetCharges( int )
	self.Charges = int

	if ( SERVER ) then
		self:ResyncCharges()
	end
end

function SWEP:GetCharges()
	return self.Charges or 0
end

function SWEP:DrawHUD()
	local width, height = 150, 20
	local x, y = ScrW() / 2 - width / 2, ScrH() / 2 + 100

	surface.SetDrawColor( COLHUD_DEFAULT )
	surface.DrawOutlinedRect( x, y, width, height )
	surface.DrawRect( x + 2, y + 2, ((self:GetCharges() / self.MaxCharges) * width) - 4, height - 4)
	draw.SimpleTextOutlined( "Charges: " .. self:GetCharges() .. " / " .. self.MaxCharges, "TargetID", x + (width / 2), y + (height / 2) - 1, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
end

function SWEP:Holster()
    return true
end

if ( SERVER ) then

	util.AddNetworkString("as_defib_resync")

	function SWEP:ResyncCharges()
		net.Start("as_defib_resync")
			net.WriteEntity( self )
			net.WriteFloat( self:GetCharges() )
		net.Send( self:GetOwner() )
	end

elseif ( CLIENT ) then

	net.Receive( "as_defib_resync", function()
		local ent = net.ReadEntity()
		if not IsValid( ent ) then return end 
		ent:SetCharges( net.ReadFloat() )
	end)

end

--Overrides
function SWEP:Reload() end
function SWEP:Think() end