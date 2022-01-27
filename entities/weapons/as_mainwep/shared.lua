SWEP.PrintName = "AS BaseWep"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.UseHands = true
SWEP.DrawCrosshair = false

-- ██╗███╗   ██╗███████╗ ██████╗ ██████╗ ███╗   ███╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
-- ██║████╗  ██║██╔════╝██╔═══██╗██╔══██╗████╗ ████║██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
-- ██║██╔██╗ ██║█████╗  ██║   ██║██████╔╝██╔████╔██║███████║   ██║   ██║██║   ██║██╔██╗ ██║
-- ██║██║╚██╗██║██╔══╝  ██║   ██║██╔══██╗██║╚██╔╝██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
-- ██║██║ ╚████║██║     ╚██████╔╝██║  ██║██║ ╚═╝ ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
-- ╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 50
SWEP.ViewModel = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"

info = SWEP.Primary
info.Damage = 24
info.Firerate = 60/640
info.Automatic = true
info.Bullets = 1
info.AmmoUsage = 1
info.Ammo = "AR2"
info.Magazine = 30
info.Spread = 0.012
info.SpreadC = 0.008
info.Force = 2
info.Recoil = 0.9
info.Sound = "Weapon_AK47.Single"
info.EmptySound = "weapons/pistol/pistol_empty.wav"

-- ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗ █████╗ ██╗     ██╗████████╗██╗   ██╗
-- ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔══██╗██║     ██║╚══██╔══╝╚██╗ ██╔╝
-- █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████║██║     ██║   ██║    ╚████╔╝
-- ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║██╔══██║██║     ██║   ██║     ╚██╔╝
-- ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║██║  ██║███████╗██║   ██║      ██║
-- ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚═╝   ╚═╝      ╚═╝

function SWEP:Initialize()
    self:SetWeaponHoldType( self.HoldType )
    self:SetClip1( 0 )
end

function SWEP:Deploy()
    self:SetWeaponHoldType( self.HoldType )
    self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
end

function SWEP:SetSpread( amt )
    amt = amt or 0.01
    self.CurrentSpread = amt
end

function SWEP:GetSpread()
    return self.CurrentSpread or 0
end

function SWEP:Think()
    --Spread
    spread = info.Spread

    if self.Owner:Crouching() and self.Owner:IsOnGround() then
        spread = info.SpreadC
    end

    if not self.Owner:IsOnGround() and self.Owner:GetMoveType() != MOVETYPE_NOCLIP then
        spread = spread * 10
    end

    self:SetSpread( spread )
end

function SWEP:PrimaryAttack()
    if not self:CanShoot() then return end
    self:Shoot()
end

function SWEP:CanShoot()
    if CurTime() < self:GetNextPrimaryFire() then return false end --Guns have fire rates.
    if self:Clip1() < 1 then self:EmitSound( info.EmptySound ) self:SetNextPrimaryFire( CurTime() + 1 ) return false end --A gun needs ammo to shoot, right?
    return true
end

function SWEP:Shoot()
    local bullet = {}
    bullet.Attacker = self.Owner
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Damage = info.Damage
    bullet.Num = info.Bullets
    bullet.Spread = Vector( self:GetSpread(), self:GetSpread(), 0 )
    bullet.Force = info.Force
    bullet.Tracer = 0
    bullet.Distance = 8000

    --We'll fire a bullet. Will shoot the actual bullet, make a flash, play the animations and sounds.
    self.Owner:FireBullets( bullet )
    self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
    self:EmitSound( info.Sound )
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    self:RecoilWeapon()

    --A player has to lose a bullet whenever they fire.
    self:SetClip1( self:Clip1() - info.AmmoUsage )
    self:SetNextPrimaryFire( CurTime() + info.Firerate )
end

function SWEP:RecoilWeapon()
    --self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -info.Recoil, 0, 0) )
end

function SWEP:CanReload()
    if self:IsReloading() then return false end --Already reloading???
    if self:Clip1() >= info.Magazine then return false end --Why reload with a full mag?
    if self:Ammo1() <= 0 then return false end --No spare ammo.
    return true
end

function SWEP:Reload()
    if not self:CanReload() then return end
    self.Reloading = CurTime() + self.Owner:GetViewModel():SequenceDuration()
    self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
    self.Owner:SetAnimation( PLAYER_RELOAD )
    self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )

    if self:Ammo1() > (info.Magazine - self:Clip1()) then
        self.Owner:SetAmmo( self:Ammo1() - (info.Magazine - self:Clip1()), info.Ammo )
        self:SetClip1( info.Magazine )
    elseif self:Ammo1() < (info.Magazine - self:Clip1()) then
        local ammoleft = self:Ammo1()
        self.Owner:SetAmmo( self:Ammo1() - self:Ammo1(), info.Ammo )
        self:SetClip1( self:Clip1() + ammoleft )
    end
end

function SWEP:IsReloading()
    return CurTime() < (self.Reloading or 0) and true or false
end

--[[
function SWEP:DrawHUD()
    local x = ( ( self:GetSpread() + 0.01 ) / 0.01 ) * 8
    local y = ( ( self:GetSpread() + 0.01 ) / 0.01 ) * 8 - 6
    if CLIENT then
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.DrawLine( ScrW() / 2 - x, ScrH() / 2, ScrW() / 2 - y, ScrH() / 2 )
        surface.DrawLine( ScrW() / 2 + x, ScrH() / 2, ScrW() / 2 + y, ScrH() / 2 )
        surface.DrawLine( ScrW() / 2, ScrH() / 2 - x, ScrW() / 2, ScrH() / 2 - y )
        surface.DrawLine( ScrW() / 2, ScrH() / 2 + x, ScrW() / 2, ScrH() / 2 + y )
        surface.SetDrawColor( 100, 100, 100, 255 )
        surface.DrawLine( ScrW() / 2 - x, ScrH() / 2 + 1, ScrW() / 2 - y, ScrH() / 2 + 1 )
        surface.DrawLine( ScrW() / 2 + x, ScrH() / 2 + 1, ScrW() / 2 + y, ScrH() / 2 + 1 )
        surface.DrawLine( ScrW() / 2 + 1, ScrH() / 2 - x, ScrW() / 2 + 1, ScrH() / 2 - y )
        surface.DrawLine( ScrW() / 2 + 1, ScrH() / 2 + x, ScrW() / 2 + 1, ScrH() / 2 + y )
    end
end
]]

function SWEP:SecondaryAttack() end