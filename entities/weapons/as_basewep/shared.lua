SWEP.PrintName = "AS_BaseWep"
SWEP.Category = "Aftershock"
SWEP.Spawnable = false
SWEP.UseHands = true
SWEP.DrawCrosshair = false

CreateClientConVar( "aswep_debug_reloading", "0", true, false ) --(Admin) Debug Reloading
CreateClientConVar( "aswep_scope_sensitivity", "50", true, false ) --Sensitivity multiplier for scopes

-- ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗     ██╗██████╗ ███████╗████████╗██████╗ ██╗███████╗██╗   ██╗██╗███╗   ██╗ ██████╗
-- ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝    ██╔╝██╔══██╗██╔════╝╚══██╔══╝██╔══██╗██║██╔════╝██║   ██║██║████╗  ██║██╔════╝
-- ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗  ██╔╝ ██████╔╝█████╗     ██║   ██████╔╝██║█████╗  ██║   ██║██║██╔██╗ ██║██║  ███╗
-- ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║ ██╔╝  ██╔══██╗██╔══╝     ██║   ██╔══██╗██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╗██║██║   ██║
-- ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝██╔╝   ██║  ██║███████╗   ██║   ██║  ██║██║███████╗ ╚████╔╝ ██║██║ ╚████║╚██████╔╝
-- ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝    ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚══════╝  ╚═══╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝

function SWEP:SetSpread( val )
    self.Spread = val
end

function SWEP:GetSpread()
    return self.Spread or 0
end

function SWEP:SetHolsteredState( bool )
    self.Holstered = bool
end

function SWEP:GetHolsteredState()
    return self.Holstered or false
end

function SWEP:ToggleHolsteredState()
    if not self:GetHolsteredState() then --We arent holstered, but we are going to holster.
        self:SetHolsteredState( true )
        self:SetHoldType( "normal" )
        self:PlaySequence( self.Anim.Holster )
        if SERVER then
            local viewmodel = self.Owner:GetViewModel()
            timer.Simple( viewmodel:SequenceDuration( viewmodel:LookupSequence( self.Anim.Holster ) ), function()
                if IsValid( self ) and self.Owner:Alive() then
                    self:PlaySequence( self.Anim.HolsterIdle )
                end
            end)
        end
    else
        self:SetHolsteredState( false )
        self:SetHoldType( self.HoldType )
        self:PlaySequence( self.Anim.Deploy )
    end
end

function SWEP:SetNextReload( time )
    self.NextReload = time
end

function SWEP:GetNextReload()
    return self.NextReload or 0
end

function SWEP:SetImpactDelay( time )
    self.NextImpact = time
end

function SWEP:GetImpactDelay()
    return self.NextImpact or 0
end

--  ██████╗██╗  ██╗███████╗ ██████╗██╗  ██╗███████╗
-- ██╔════╝██║  ██║██╔════╝██╔════╝██║ ██╔╝██╔════╝
-- ██║     ███████║█████╗  ██║     █████╔╝ ███████╗
-- ██║     ██╔══██║██╔══╝  ██║     ██╔═██╗ ╚════██║
-- ╚██████╗██║  ██║███████╗╚██████╗██║  ██╗███████║
--  ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝

function SWEP:CanReload()
    if CurTime() < self:GetNextReload() then return false end
    if self:Clip1() >= self.Primary.ClipSize then return false end --No reason to reload with a full magainze
    if self:Ammo1() == 0 then return false end --Cannot reload with no spare ammo
    return true
end

function SWEP:CanMeleeSwing()
    if CurTime() < self:GetNextReload() then return false end
    if self:GetHolsteredState() == true then return false end
    return true
end

function SWEP:CanShootGun()
    if CurTime() < self:GetNextReload() then return false end
    if self:Clip1() <= 0 then return false end
    return true
end

-- ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗ █████╗ ██╗     ██╗████████╗██╗   ██╗
-- ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔══██╗██║     ██║╚══██╔══╝╚██╗ ██╔╝
-- █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████║██║     ██║   ██║    ╚████╔╝
-- ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║██╔══██║██║     ██║   ██║     ╚██╔╝
-- ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║██║  ██║███████╗██║   ██║      ██║
-- ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚═╝   ╚═╝      ╚═╝

function SWEP:Initialize()
    self:SetHoldType( self.HoldType )
    if self.Melee then
        self:SetHolsteredState( false )
    end
end

function SWEP:Deploy()
    if self:GetHolsteredState() == false then
        self:PlaySequence( self.Anim.Deploy )
    end
    return true
end

function SWEP:PrimaryAttack()
    if self.Melee then
        self:MeleeSwing()
    else
        self:ShootGun()
    end
end

function SWEP:SecondaryAttack()
    --Will find something to fill this with, unsure as of now.
end

function SWEP:Reload()
    if self.Melee and not self.NoHolster then
        if CurTime() > self:GetNextReload() then
            self:ToggleHolsteredState()
            self:SetNextReload( CurTime() + 1 )
        end
    elseif not self.Melee then

        if not self:CanReload() then return end

        self.Owner:SetAnimation( PLAYER_RELOAD )
        if not self.ReloadOneByOne then
            local reloadtime = math.Clamp(self.Primary.ReloadTime * (1 - (self.Owner:GetSkillLevel( "weaponhandling" ) * SKL.WeaponHandling.reloadmultinc)), 0.2, 10)
            self:SetNextReload( CurTime() + reloadtime )
            if self.Primary.Reload then
                self:EmitSound( self.Primary.Reload )
            end
            self:PlaySequence( self.Anim.Reload )
            self.Owner:GetViewModel():SetPlaybackRate( 1 + (self.Owner:GetSkillLevel( "weaponhandling" ) * SKL.WeaponHandling.reloadmultinc) )
        else
            self:PlaySequence( self.Anim.Reload[1] )
            local reloadtime = math.Clamp(self.Primary.ReloadTime * (1 - (self.Owner:GetSkillLevel( "weaponhandling" ) * SKL.WeaponHandling.reloadmultinc)), 0.1, 10)
            self:SetNextReload( CurTime() + reloadtime )
            self.Owner:GetViewModel():SetPlaybackRate( 1 + (self.Owner:GetSkillLevel( "weaponhandling" ) * SKL.WeaponHandling.reloadmultinc) )
        end

    end
end

-- Melee Functions

function SWEP:MeleeSwing()
    if not self:CanMeleeSwing() then return end

    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    self:PlaySequence( self.Anim.Attack )
    if SERVER then
        local snd = istable( self.Primary.Sound ) and table.Random( self.Primary.Sound ) or self.Primary.Sound
        self.Owner:EmitSound( snd )
    end

    self:SetImpactDelay( CurTime() + self.Primary.ImpactDelay )

    self:SetNextPrimaryFire( CurTime() + self.Primary.Firerate )
    self:SetNextSecondaryFire( CurTime() + self.Primary.Firerate )
end

function SWEP:MeleeDamage()
    local trace = util.TraceLine( {
        start = self.Owner:GetShootPos(),
        endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Primary.Distance,
        filter = self.Owner,
        mask = MASK_SHOT_HULL
    } )

    if trace.Hit and not (trace.Entity:IsNextBot() or trace.Entity:IsPlayer() or trace.Entity:IsNPC()) then
        local snd = istable(self.Primary.Impact) and table.Random(self.Primary.Impact) or self.Primary.Impact
        self:EmitSound( snd )
    elseif trace.Hit and (trace.Entity:IsNextBot() or trace.Entity:IsPlayer() or trace.Entity:IsNPC()) then
        local snd = istable(self.Primary.ImpactFlesh) and table.Random(self.Primary.ImpactFlesh) or self.Primary.ImpactFlesh
        self:EmitSound( snd )
    end

    if (trace.Entity and IsValid( trace.Entity )) and (trace.Entity:IsNextBot() or trace.Entity:IsNPC() or trace.Entity:IsPlayer() or trace.Entity:Health() > 0) then

        local data = EffectData()
        data:SetOrigin( trace.HitPos )
        util.Effect( "BloodImpact", data )
        if SERVER then
            local dmginfo = DamageInfo()
            dmginfo:SetInflictor( self )
            dmginfo:SetAttacker( self.Owner )
            dmginfo:SetDamage( self.Primary.Damage )
            dmginfo:SetDamageForce( self.Owner:GetAimVector() )
            trace.Entity:TakeDamageInfo( dmginfo )
            local snd = istable(self.Primary.ImpactFlesh) and table.Random(self.Primary.ImpactFlesh) or self.Primary.ImpactFlesh
            self:EmitSound( snd )
        end
        self.Owner:IncreaseSkillExperience( "strength", SKL.Strength.incamt )

    end
end

-- Firearm Functions

function SWEP:ShootGun()
    if not self:CanShootGun() then return end

    local bullet = {}
    bullet.Attacker = self.Owner
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Damage = self.Primary.Damage
    bullet.Num = self.Primary.Bullets
    bullet.Spread = Vector( self:GetSpread(), self:GetSpread(), 0 )
    bullet.Tracer = 1
    bullet.Distance = 10000
    self.Owner:FireBullets( bullet )

    local snd = istable( self.Primary.Sound ) and table.Random( self.Primary.Sound ) or self.Primary.Sound
    self:EmitSound( snd )
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    self:PlaySequence( self.Anim.Attack ) 
    if IsFirstTimePredicted() then
        self.Owner:IncreaseSkillExperience( "weaponhandling", SKL.WeaponHandling.incamt )
    end
    if CLIENT and IsFirstTimePredicted() then
        self:Recoil()
    end

    self:SetNextPrimaryFire( CurTime() + self.Primary.Firerate )
    self:SetClip1( self:Clip1() - 1 )
end

function SWEP:Recoil()
    ang = LocalPlayer():EyeAngles()
    ang = ang + Angle( -self.Primary.RecoilVertical * (1 - ( SKL.WeaponHandling.recoilmultloss * self.Owner:GetSkillLevel( "weaponhandling" ) )), math.random( -self.Primary.RecoilHorizontal, self.Primary.RecoilHorizontal ) * (1 - ( SKL.WeaponHandling.recoilmultloss * self.Owner:GetSkillLevel( "weaponhandling" ) )), 0 )
    LocalPlayer():SetEyeAngles(ang)
end

-- ███████╗███████╗ ██████╗ ██╗   ██╗███████╗███╗   ██╗ ██████╗██╗███╗   ██╗ ██████╗
-- ██╔════╝██╔════╝██╔═══██╗██║   ██║██╔════╝████╗  ██║██╔════╝██║████╗  ██║██╔════╝
-- ███████╗█████╗  ██║   ██║██║   ██║█████╗  ██╔██╗ ██║██║     ██║██╔██╗ ██║██║  ███╗
-- ╚════██║██╔══╝  ██║▄▄ ██║██║   ██║██╔══╝  ██║╚██╗██║██║     ██║██║╚██╗██║██║   ██║
-- ███████║███████╗╚██████╔╝╚██████╔╝███████╗██║ ╚████║╚██████╗██║██║ ╚████║╚██████╔╝
-- ╚══════╝╚══════╝ ╚══▀▀═╝  ╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝╚═╝╚═╝  ╚═══╝ ╚═════╝

function SWEP:PlaySequence( sequence )
    local anim = sequence
    local viewmodel = self.Owner:GetViewModel()
    local tblcheck = istable(anim) and sequence[math.Round(util.SharedRandom( "wepanimtoplay", 1, #sequence, 0 ))] or anim
    viewmodel:SendViewModelMatchingSequence( viewmodel:LookupSequence( tblcheck ) )
end

-- ███╗   ███╗██╗███████╗ ██████╗
-- ████╗ ████║██║██╔════╝██╔════╝
-- ██╔████╔██║██║███████╗██║
-- ██║╚██╔╝██║██║╚════██║██║
-- ██║ ╚═╝ ██║██║███████║╚██████╗
-- ╚═╝     ╚═╝╚═╝╚══════╝ ╚═════╝

function SWEP:Think()
    if self.Melee then

        local impactdelay = self:GetImpactDelay()
        if impactdelay ~= 0 and CurTime() >= impactdelay then
            self:MeleeDamage()
            self:SetImpactDelay( 0 )
        end

    else

        --Weapon Spread
        if not self.Owner:Crouching() then
            if self:GetSpread() != self.Primary.Spread then
                self:SetSpread( self.Primary.Spread )
            end
        else
            if self.Owner:IsOnGround() and self:GetSpread() != self.Primary.SpreadC then
                self:SetSpread( self.Primary.SpreadC )
            end
        end
        if (self.Zoomed or false) and self:GetSpread() != self.Primary.SpreadC * 0.5 and self.Owner:IsOnGround() then
            self:SetSpread( self.Primary.SpreadC * 0.2 )
        end
        if not self.Owner:IsOnGround() then
            if self:GetSpread() != self.Primary.Spread * 10 then
                self:SetSpread( self.Primary.Spread * 10 )
            end
        end

        --Reloading
        if CurTime() > self:GetNextReload() and self:GetNextReload() != 0 then
            if not self.ReloadOneByOne then
                self:SetNextReload( 0 )
                local ammoMissing = self.Primary.ClipSize - self:Clip1()
                if self:Ammo1() >= ammoMissing then
                    self.Owner:SetAmmo( self:Ammo1() - ammoMissing, self:GetPrimaryAmmoType() )
                    self:SetClip1( self:Clip1() + ammoMissing )
                elseif self:Ammo1() < ammoMissing then
                    self:SetClip1( self:Clip1() + self:Ammo1() )
                    self.Owner:SetAmmo( 0, self:GetPrimaryAmmoType() )
                end
            else
                if self:Clip1() >= self.Primary.ClipSize or self:Ammo1() <= 0 or not self.Owner:KeyDown( IN_RELOAD ) then
                    self:PlaySequence( self.Anim.Reload[3] )
                    self:SetNextReload( 0 )
                else
                    local reloadtime = math.Clamp(self.Primary.InsertReloadTime * (1 - (self.Owner:GetSkillLevel( "weaponhandling" ) * SKL.WeaponHandling.reloadmultinc)), 0.1, 10)
                    self:PlaySequence( self.Anim.Reload[2] )
                    self:SetClip1( self:Clip1() + 1 )
                    self.Owner:SetAmmo( self:Ammo1() - 1, self:GetPrimaryAmmoType())
                    self:SetNextReload( CurTime() + reloadtime )
                    if self.Primary.Reload then
                        self:EmitSound( self.Primary.Reload )
                    end
                end
            end
        end

    end
end

CreateClientConVar( "as_hud_crosshair_weaponcrosshair", "1", true, false ) --Use Weapon Crosshairs
CreateClientConVar( "as_hud_crosshair_weaponcrosshair_centerdot", "1", true, false ) --Center Dot
CreateClientConVar( "as_hud_crosshair_weaponcrosshair_centerdot_size", "1", true, false ) --Center Dot Size
CreateClientConVar( "as_hud_crosshair_weaponcrosshair_shadow", "1", true, false ) --Shadow
CreateClientConVar( "as_hud_crosshair_weaponcrosshair_length", "20", true, false ) --Weapon Crosshair Length
CreateClientConVar( "as_hud_crosshair_weaponcrosshair_width", "2", true, false ) --Weapon Crosshair Width
CreateClientConVar( "as_hud_ammo", 1, true, false ) --Show Ammo
CreateClientConVar( "as_hud_ammo_background", 1, true, false ) --Show Ammo Background
CreateClientConVar( "as_hud_ammo_xadd", 0, true, false ) --Ammo Offset X
CreateClientConVar( "as_hud_ammo_yadd", 0, true, false ) --Ammo Offset Y

function SWEP:DrawHUD()
    if CLIENT then
        local hud = tobool(GetConVar("as_hud"):GetInt())

        local crosshair = tobool(GetConVar("as_hud_crosshair"):GetInt())
        local crosshairwep = tobool(GetConVar("as_hud_crosshair_weaponcrosshair"):GetInt())
        if hud and crosshair and crosshairwep and not self.DefaultCrosshair and CurTime() > self:GetNextReload() then
            local centerdot = tobool(GetConVar("as_hud_crosshair_weaponcrosshair_centerdot"):GetInt())
            local centerdotsize = GetConVar("as_hud_crosshair_weaponcrosshair_centerdot_size"):GetInt()
            local length = GetConVar("as_hud_crosshair_weaponcrosshair_length"):GetInt()
            local width = GetConVar("as_hud_crosshair_weaponcrosshair_width"):GetInt()
            local shadow = tobool(GetConVar("as_hud_crosshair_weaponcrosshair_shadow"):GetInt())
            local x = ( self:GetSpread() * 100 ) * 8
            local y = ( self:GetSpread() * 100 ) * 8
            local scw = ScrW()
            local sch = ScrH()

            --Crosshair Shadow
            if shadow then
                surface.SetDrawColor( Color( 0, 0, 0 ) )
                if centerdot then
                    surface.DrawRect( (ScrW() / 2) - (centerdotsize / 2) + 1, (ScrH() / 2) - (centerdotsize / 2) + 1, centerdotsize, centerdotsize )
                end
                surface.DrawRect( math.floor((scw / 2) - x - length) + 1, math.floor((sch / 2) - (width / 2)) + 1, length, width) --Left
                surface.DrawRect( math.floor((scw / 2) + x) + 1, math.floor((sch / 2) - (width / 2)) + 1, length, width) --Right
                surface.DrawRect( math.floor((scw / 2) - (width / 2)) + 1, math.floor((sch / 2) - y - length) + 1, width, length) --Top
                surface.DrawRect( math.floor((scw / 2) - (width / 2)) + 1, math.floor((sch / 2) + y) + 1, width, length) --Bottom
            end

            --Actual Crosshair
            surface.SetDrawColor( COLHUD_DEFAULT )
            if centerdot then
                surface.DrawRect( (ScrW() / 2) - math.ceil(centerdotsize / 2), (ScrH() / 2) - math.ceil(centerdotsize / 2), centerdotsize, centerdotsize )
            end
            surface.DrawRect( math.floor((scw / 2) - x - length), math.floor((sch / 2) - (width / 2)), length, width) --Left
            surface.DrawRect( math.floor((scw / 2) + x), math.floor((sch / 2) - (width / 2)), length, width) --Right
            surface.DrawRect( math.floor((scw / 2) - (width / 2)), math.floor((sch / 2) - y - length), width, length) --Top
            surface.DrawRect( math.floor((scw / 2) - (width / 2)), math.floor((sch / 2) + y), width, length) --Bottom
        end

        local ammo = tobool(GetConVar("as_hud_ammo"):GetInt())
        if hud and ammo and not self.NoAmmo then
            local xpos = GetConVar("as_hud_ammo_xadd"):GetInt()
            local ypos = GetConVar("as_hud_ammo_yadd"):GetInt()
            local background = tobool(GetConVar("as_hud_ammo_background"):GetInt())
            if background then
                local width = 150
                local height = 50
                surface.SetDrawColor( Color( 0, 0, 0, 100) )
                surface.DrawRect( (math.Clamp(ScrW() * 0.87 + xpos, 0, ScrW() - width)), (math.Clamp((ScrH() * 0.91) + ypos, 0, ScrH() - height)), width, height )
                surface.SetDrawColor( COLHUD_DEFAULT )
                surface.DrawOutlinedRect( (math.Clamp(ScrW() * 0.87 + xpos, 0, ScrW() - width)), (math.Clamp((ScrH() * 0.91) + ypos, 0, ScrH() - height)), width, height )
            end

            draw.SimpleTextOutlined(self:Clip1() .. "/" .. self:GetMaxClip1(), "AftershockHUD", ScrW() * 0.871 + xpos, ScrH() * 0.91 + ypos, COLHUD_DEFAULT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0,0,0))
            draw.SimpleTextOutlined(AS.Items[translateAmmoNameID(game.GetAmmoName( self:GetPrimaryAmmoType() ))].name .. ": " .. self:Ammo1(), "TargetIDSmall", ScrW() * 0.871 + xpos, ScrH() * 0.955 + ypos, COLHUD_DEFAULT, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0))
        end

        local debugreload = tobool(GetConVar("aswep_debug_reloading"):GetInt())
        if LocalPlayer():IsAdmin() and not self.Melee and debugreload then
            if CurTime() < self:GetNextReload() then
                local width = 100
                local height = 10
                surface.DrawOutlinedRect( (ScrW() / 2) - (width / 2), (ScrH() / 2) + 50, width, height )
                surface.DrawRect( (ScrW() / 2) - (width / 2) + 2, (ScrH() / 2) + 52, ( math.Clamp((self:GetNextReload() - CurTime()) / self.Primary.ReloadTime, 0, 1) * ( width - 4 )), height - 4 )
            end
        end

    end
end

function SWEP:DrawWorldModel( flags )
    if CLIENT then

        if not self:GetHolsteredState() then --This will just hide melee weapons when they're holstered.
            self:DrawModel( flags )
        end

    end
end