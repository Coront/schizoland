SWEP.PrintName = "Admin Defib"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
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

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()
	local tr = util.TraceLine({
		start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + ply:EyeAngles():Forward() * 100,
        filter = {ply},
	})
	local rag = tr.Entity
	
	if IsFirstTimePredicted() and tr.Hit and rag:IsRagdoll() and IsValid(rag.Owner) then
		if ( SERVER ) then
			self:SetNextPrimaryFire( CurTime() + 0.1 )

			local otherPly = rag.Owner
			otherPly.WasDefibbed = true
			otherPly:SetNWFloat( "NoCollideTimer", CurTime() + 5 )
			otherPly:Spawn()
			otherPly:SetPos( otherPly.LastDeathPos )
			otherPly:SetHealth( 15 )
			otherPly:ChatPrint("You were defibrillated!")
			otherPly:EmitSound( "ambient/energy/zap1.wav", 80 )
			otherPly.WasDefibbed = false

			plogs.PlayerLog(ply, "Items", ply:NameID() .. " admin defibrillated " .. otherPly:Nickname(), {
				["Name"] 	= ply:Name(),
				["SteamID"]	= ply:SteamID(),
			})
		end
	end
end

function SWEP:DrawHUD()
	local width, height = 150, 20
	local x, y = ScrW() / 2 - width / 2, ScrH() / 2 + 100
	draw.SimpleTextOutlined( "(Admin) Left Click to Defib", "TargetID", x + (width / 2), y + (height / 2) - 1, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
end

function SWEP:Holster()
    return true
end

--Overrides
function SWEP:Reload() end
function SWEP:Think() end