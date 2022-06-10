SWEP.PrintName = "Breaching Charge"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "fas2_base_melee"
SWEP.Slot = 1

SWEP.ViewModelFOV = 60
SWEP.VM = "models/weapons/v_slam.mdl"
SWEP.WM = "models/weapons/w_slam.mdl"
SWEP.ViewModel = "models/weapons/v_slam.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.DrawWeaponInfoBox = false

SWEP.HoldType = "slam"
SWEP.RunHoldType = "slam"
SWEP.NoProficiency = true
SWEP.NoAttachmentMenu = true

SWEP.ASID = "wep_breach" --Aftershock item ID

SWEP.Sounds = {}
SWEP.FireModes = {"semi"}

SWEP.Anims = {}
SWEP.Anims.Draw = "tripmine_draw"
SWEP.Anims.Idle = "tripmine_idle"
SWEP.Anims.Holster = "tripmine_idle"

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0

SWEP.DefaultCrosshair = true
SWEP.NoAmmo = true

SWEP.Charging = false
SWEP.Throwing = 0

local breachEnts = {
	["prop_door_rotating"] = true,
}

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()
	local tr = util.TraceLine({
		start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + ply:EyeAngles():Forward() * 75,
        filter = {ply},
	})
	local door = tr.Entity

	if IsFirstTimePredicted() and tr.Hit and breachEnts[door:GetClass()] then
		if ( SERVER ) then
			ply:StripWeapon( "weapon_breach" )
			door:EmitSound( "weapons/c4/c4_plant.wav", 80, 120 )

			local ent = ents.Create("ent_breach")
			ent:SetPos( tr.HitPos )
			ent:SetAngles( door:GetAngles() + Angle( 90, 0, 0 ) )
			ent:Spawn()
			ent:SetDoor( door )
			ent.Deployer = ply
		end
	end
end

function SWEP:SecondaryAttack()
    --This wont do anything
end

function SWEP:Think()
    --
end

function SWEP:Holster()
    return true
end

--Overrides
function SWEP:Reload() end
function SWEP:DrawHUD() end