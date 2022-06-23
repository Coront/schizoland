AddCSLuaFile()

SWEP.PrintName = "Lockpick"
SWEP.Category = "Aftershock"
SWEP.Spawnable = false
SWEP.Base = "fas2_base_melee"
SWEP.Slot = 1

SWEP.ViewModelFOV = 60
SWEP.VM = "models/props_c17/TrapPropeller_Lever.mdl"
SWEP.WM = "models/props_c17/TrapPropeller_Lever.mdl"
SWEP.ViewModel = "models/props_c17/TrapPropeller_Lever.mdl"
SWEP.WorldModel = "models/props_c17/TrapPropeller_Lever.mdl"
SWEP.DrawWeaponInfoBox = false
SWEP.DrawCrosshair = true

SWEP.HoldType = "slam"
SWEP.RunHoldType = "slam"
SWEP.NoProficiency = true
SWEP.NoAttachmentMenu = true

SWEP.ASID = "wep_lockpick" --Aftershock item ID

SWEP.Sounds = {}
SWEP.FireModes = {"semi"}

SWEP.Anims = {}
SWEP.Anims.Draw = ""
SWEP.Anims.Idle = ""
SWEP.Anims.Holster = ""

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0

local lockpickEnts = {
	["prop_door_rotating"] = true,
	["func_door"] = true,
	["func_door_rotating"] = true,
}
local lockpickSounds = {
	"weapons/357/357_reload1.wav",
	"weapons/357/357_reload3.wav",
	"weapons/357/357_reload4.wav",
}
local lockpickTime = 15

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()
	local tr = util.TraceLine({
		start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + ply:EyeAngles():Forward() * 75,
        filter = {ply},
	})
	local door = tr.Entity

	if (SERVER) and IsFirstTimePredicted() and door and IsValid(door) and lockpickEnts[door:GetClass()] and not self:IsLockpicking() then
		self:StartLockpicking( door )

		local owner = IsValid(door:GetObjectOwner()) and door:GetObjectOwner():Nickname() or "none"
		plogs.PlayerLog(ply, "Items", ply:NameID() .. " started lockpicking door (" .. door:EntIndex() .. ") owned by " .. owner, {
			["Name"] 	= ply:Name(),
			["SteamID"]	= ply:SteamID(),
		})
	end
end

function SWEP:SetLockpickingState( bool )
	self.Lockpicking = bool

	if ( SERVER ) then
		self:ResyncState()
	end
end

function SWEP:GetLockpickingState()
	return self.Lockpicking or false
end

function SWEP:SetTargetDoor( ent )
	self.Door = ent
end

function SWEP:GetTargetDoor()
	return self.Door
end

function SWEP:ClearTargetDoor()
	self.Door = nil
end

function SWEP:SetSucceedTime( time )
	self.SucceedIn = time
	self.LockpickStart = CurTime()
end

function SWEP:GetSucceedTime()
	return self.SucceedIn or 0
end

function SWEP:ClearSucceedTime()
	self.SucceedIn = 0
end

function SWEP:StartLockpicking( door )
	self:SetLockpickingState( true )
	self:SetTargetDoor( door )
	self:SetSucceedTime( CurTime() + lockpickTime )

	if ( SERVER ) then
		self:ResyncTime()
	end
end

function SWEP:StopLockpicking()
	self:SetLockpickingState( false )
	self:ClearTargetDoor()
	self:ClearSucceedTime()

	if (SERVER) then
		self:ResyncState()
		self:ResyncTime()
	end
end

function SWEP:IsLockpicking()
	if self:GetLockpickingState() then return true end
	return false
end

function SWEP:LockpickSucceed()
	local door = self:GetTargetDoor()
	door:Fire( "unlock", "", 0 )
	door:EmitSound("doors/door_latch3.wav", 60, 100)

	self:StopLockpicking()
end

function SWEP:Think()
    if (SERVER) and self:IsLockpicking() then
		local ply = self:GetOwner()
		local tr = util.TraceLine({
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:EyeAngles():Forward() * 75,
			filter = {ply},
		})

		if tr.Entity != self:GetTargetDoor() then
			self:StopLockpicking()
		end

		if ( SERVER ) then
			if CurTime() > (self.NextLockpickSound or 0) then
				self.NextLockpickSound = CurTime() + 1.5
				local snd = table.Random( lockpickSounds, 30, 90 )
				ply:EmitSound( snd )
			end
			if CurTime() > self:GetSucceedTime() and IsValid( self:GetTargetDoor() ) then
				self:LockpickSucceed()
			end
		end
	end
end

if ( CLIENT ) then
	function SWEP:DrawHUD()
		if CurTime() < self:GetSucceedTime() then
			local r = math.Clamp((CurTime() - self.LockpickStart) / (self:GetSucceedTime() - self.LockpickStart), 0, 1)
			local width, height = 150, 15

			local col = COLHUD_DEFAULT:ToTable()
			surface.SetDrawColor( col[1], col[2], col[3], 255 )
			surface.DrawOutlinedRect( ScrW() / 2 - width / 2, ScrH() / 2 + 20, width, height, 1 )

			surface.SetDrawColor( col[1], col[2], col[3], 255 )
			surface.DrawRect( ScrW() / 2 - width / 2 + 2, ScrH() / 2 + 22, r * width - 4, height - 4, 1 )
		end
	end
end

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if ( SERVER ) then

	util.AddNetworkString("as_lockpick_resync")
	util.AddNetworkString("as_lockpick_resynctime")

	function SWEP:ResyncState()
		net.Start("as_lockpick_resync")
			net.WriteEntity( self )
			net.WriteBit( self:GetLockpickingState() )
		net.Send( self:GetOwner() )
	end

	function SWEP:ResyncTime()
		net.Start("as_lockpick_resynctime")
			net.WriteEntity( self )
			net.WriteFloat( self:GetSucceedTime() )
		net.Send( self:GetOwner() )
	end

elseif ( CLIENT ) then

	net.Receive( "as_lockpick_resync", function()
		local ent = net.ReadEntity()
		local state = tobool( net.ReadBit() )
		ent:SetLockpickingState( state )
	end )

	net.Receive( "as_lockpick_resynctime", function()
		local ent = net.ReadEntity()
		local endlock = net.ReadFloat()

		ent:SetSucceedTime( endlock )
	end)

end

--Overrides
function SWEP:SecondaryAttack() end
function SWEP:Reload() end
function SWEP:Holster()
    return true
end