SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.HoldType = "normal"

SWEP.Slot = 9
SWEP.SlotPos = 1
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"

SWEP.ASArmor = true

hook.Add( "PlayerFootstep", "AS_ArmorFootstep", function( ply, pos, foot, sound, volume, rf )
    if ply:HasArmor() then
        local armor = ply:GetArmorWep()
        if armor.Footsteps and (not armor.FootstepsSprinting or armor.FootstepsSprinting and ply:IsSprinting()) then
            local snd = table.Random(armor.Footsteps)
            if SERVER then
                ply:EmitSound( snd, 70, 100, volume, CHAN_STATIC )
            end
            return true
        end
    end
end )