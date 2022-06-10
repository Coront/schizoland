-- This is sorta horrible

AddCSLuaFile()

local keypad_crack_time = CreateConVar("keypad_crack_time", "15", {FCVAR_ARCHIVE}, "Seconds for keypad cracker to crack keypad")

if SERVER then
	util.AddNetworkString("KeypadCracker_Hold")
	util.AddNetworkString("KeypadCracker_Sparks")
end

if CLIENT then
	SWEP.PrintName = "Keypad Cracker"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
end

SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.ViewModel = Model("models/weapons/v_c4.mdl")
SWEP.WorldModel = Model("models/weapons/w_c4.mdl")

SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.AnimPrefix = "python"
SWEP.ASID = "wep_keypadcracker"

SWEP.Sound = Sound("weapons/deagle/deagle-1.wav")

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.KeyCrackSound = Sound("buttons/blip2.wav")

SWEP.IdleStance = "slam"

function SWEP:Initialize()
	self:SetHoldType(self.IdleStance)

	if SERVER then
		net.Start("KeypadCracker_Hold")
			net.WriteEntity(self)
			net.WriteBit(true)
		net.Broadcast()

		self:SetCrackTime( keypad_crack_time:GetInt() )
	end
end	

function SWEP:SetupDataTables()
	self:NetworkVar( "Int", 0, "CrackTime" )
end

function SWEP:PrimaryAttack()
	if self.IsCracking or not IsValid(self.Owner) then return end

	local tr = self.Owner:GetEyeTrace()
	local ent = tr.Entity

	if IsValid(ent) and tr.HitPos:Distance(self.Owner:GetShootPos()) <= 75 and ent.IsKeypad then
		self.IsCracking = true
		self.StartCrack = CurTime()
		self.EndCrack = CurTime() + self:GetCrackTime()

		self:SetWeaponHoldType("pistol") -- TODO: Send as networked message for other clients to receive

		if SERVER then
			net.Start("KeypadCracker_Hold")
				net.WriteEntity(self)
				net.WriteBit(true)
			net.Broadcast()

			timer.Create("KeyCrackSounds: "..self:EntIndex(), 1, self:GetCrackTime(), function()
				if IsValid(self) and self.IsCracking then
					self:EmitSound(self.KeyCrackSound, 60, 110)
					
				end
			end)
		else
			self.Dots = self.Dots or ""
			
			local entindex = self:EntIndex()
			timer.Create("KeyCrackDots: "..entindex, 0.5, 0, function()
				if not IsValid(self) then
					timer.Destroy("KeyCrackDots: "..entindex)
				else
					local len = string.len(self.Dots)
					local dots = {[0] = ".", [1] = "..", [2]= "...", [3] = ""}

					self.Dots = dots[len]
				end
			end)
		end
	end
end

function SWEP:SecondaryAttack()
	return true
end

function SWEP:Holster()
	self.IsCracking = false

	if SERVER then
		timer.Destroy("KeyCrackSounds: "..self:EntIndex())
	else
		timer.Destroy("KeyCrackDots: "..self:EntIndex())
	end

	return true
end

function SWEP:Reload()
	return true
end

function SWEP:Succeed()
	self.IsCracking = false

	local tr = self.Owner:GetEyeTrace()
	local ent = tr.Entity
	self:SetWeaponHoldType(self.IdleStance)

	if SERVER and IsValid(ent) and tr.HitPos:Distance(self.Owner:GetShootPos()) <= 75 and ent.IsKeypad then
		ent:Process(true)

		net.Start("KeypadCracker_Hold")
			net.WriteEntity(self)
			net.WriteBit(true)
		net.Broadcast()

		net.Start("KeypadCracker_Sparks")
			net.WriteEntity(ent)
		net.Broadcast()
	end

	if SERVER then
		timer.Destroy("KeyCrackSounds: "..self:EntIndex())
	else
		timer.Destroy("KeyCrackDots: "..self:EntIndex())
	end
end

function SWEP:Fail()
	self.IsCracking = false

	self:SetWeaponHoldType(self.IdleStance)

	if SERVER then
		net.Start("KeypadCracker_Hold")
			net.WriteEntity(self)
			net.WriteBit(true)
		net.Broadcast()

		timer.Destroy("KeyCrackSounds: "..self:EntIndex())
	else
		timer.Destroy("KeyCrackDots: "..self:EntIndex())
	end
end

function SWEP:Think()
	if not self.StartCrack then
		self.StartCrack = 0
		self.EndCrack = 0
	end

	if self.IsCracking and IsValid(self.Owner) then
		local tr = self.Owner:GetEyeTrace()

		if not IsValid(tr.Entity) or tr.HitPos:Distance(self.Owner:GetShootPos()) > 75 or not tr.Entity.IsKeypad then
			self:Fail()
		elseif self.EndCrack <= CurTime() then
			self:Succeed()
		end
	else
		self.StartCrack = 0
		self.EndCrack = 0
	end
	
	self:NextThink(CurTime())
	return true
end

if(CLIENT) then
	SWEP.BoxColor = Color(10, 10, 10, 100)

	surface.CreateFont("KeypadCrack", {
		font = "Trebuchet",
		size = 18,
		weight = 600,
	})

	function SWEP:DrawHUD()
		if self.IsCracking then
			if not self.StartCrack then
				self.StartCrack = CurTime()
				self.EndCrack = CurTime() + self:GetCrackTime()
			end
			local frac = math.Clamp((CurTime() - self.StartCrack) / (self.EndCrack - self.StartCrack), 0, 1) -- Between 0 and 1 (a fraction omg segregation)

			local width, height = 150, 15

			local col = COLHUD_DEFAULT:ToTable()
			surface.SetDrawColor( col[1], col[2], col[3], 255 )
			surface.DrawOutlinedRect( ScrW() / 2 - width / 2, ScrH() / 2 + 20, width, height, 1 )

			surface.SetDrawColor( col[1], col[2], col[3], 255 )
			surface.DrawRect( ScrW() / 2 - width / 2 + 2, ScrH() / 2 + 22, frac * width - 4, height - 4, 1 )
		end
	end
	
	SWEP.DownAngle = Angle(-10, 0, 0)
	
	SWEP.LowerPercent = 1
	SWEP.SwayScale = 0
	
	function SWEP:GetViewModelPosition(pos, ang)
		if self.IsCracking then
			local delta = FrameTime() * 3.5
			self.LowerPercent = math.Clamp(self.LowerPercent - delta, 0, 1)
		else
			local delta = FrameTime() * 5
			self.LowerPercent = math.Clamp(self.LowerPercent + delta, 0, 1)
		end
		
		ang:RotateAroundAxis(ang:Forward(), self.DownAngle.p * self.LowerPercent)
		ang:RotateAroundAxis(ang:Right(), self.DownAngle.p * self.LowerPercent)

		return self.BaseClass.GetViewModelPosition(self, pos, ang)
	end

	net.Receive("KeypadCracker_Hold", function()
		local ent = net.ReadEntity()
		local state = (net.ReadBit() == 1)

		if IsValid(ent) and ent:IsWeapon() and ent:GetClass():lower() == "keypad_cracker" and not game.SinglePlayer() and ent.SetWeaponHoldType then
			if not state then
				ent:SetWeaponHoldType(ent.IdleStance)
				ent.IsCracking = false
			else
				ent:SetWeaponHoldType("pistol")
				ent.IsCracking = true
			end
		end
	end)
	
	net.Receive("KeypadCracker_Sparks", function()
		local ent = net.ReadEntity()
		
		if IsValid(ent) then
			local vPoint = ent:GetPos()
			local effect = EffectData()
			effect:SetStart(vPoint)
			effect:SetOrigin(vPoint)
			effect:SetEntity(ent)
			effect:SetScale(2)
			util.Effect("cball_bounce", effect)
			
			ent:EmitSound("buttons/combine_button7.wav", 100, 100)
		end
	end)
end