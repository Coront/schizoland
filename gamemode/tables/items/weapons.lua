-- ███╗   ███╗███████╗██╗     ███████╗███████╗
-- ████╗ ████║██╔════╝██║     ██╔════╝██╔════╝
-- ██╔████╔██║█████╗  ██║     █████╗  █████╗
-- ██║╚██╔╝██║██╔══╝  ██║     ██╔══╝  ██╔══╝
-- ██║ ╚═╝ ██║███████╗███████╗███████╗███████╗
-- ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝╚══════╝

AS.AddBaseItem("melee_branch", {
    name = "Branch",
    desc = "A tree branch.",
    model = "models/gibs/furniture_gibs/furniture_vanity01a_gib03.mdl",
    value = 0,
    weight = 1,
    nodrop = true,
    notrade = true,
})

-- ██████╗  █████╗ ███╗   ██╗ ██████╗ ███████╗██████╗
-- ██╔══██╗██╔══██╗████╗  ██║██╔════╝ ██╔════╝██╔══██╗
-- ██████╔╝███████║██╔██╗ ██║██║  ███╗█████╗  ██║  ██║
-- ██╔══██╗██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██║  ██║
-- ██║  ██║██║  ██║██║ ╚████║╚██████╔╝███████╗██████╔╝
-- ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚═════╝

AS.AddBaseItem("gun_peashooter", {
    name = "Peashooter",
    desc = "An old and rusty pistol.",
    model = "models/weapons/w_pistol.mdl",
    value = 0,
    weight = 1,
    nodrop = true,
    notrade = true,
    guninfo = {
        Damage = 12, --Damage the gun will deal per shot.
        Firerate = 60/180, --How fast the weapon shoots.
        Automatic = false, --Can the player hold to do continuous fire?
        Bullets = 1, --How many bullets are fired per shot.
        AmmoUsage = 1, --How much ammo is consumed from the magazine per shot.
        Ammo = "Pistol", --Ammo that is used (reference the hl2 ammo list).
        Magazine = 12, --How much a magazine for the gun will hold.
        Spread = 0.012, --Default spread
        SpreadC = 0.008, --Spread while crouching
        Force = 0.8, --Bullet force
        Recoil = 0.5, --Weapon Recoil
        Sound = "Weapon_AK47.Single", --Sound played while firing
        EmptySound = "weapons/pistol/pistol_empty.wav", --Sound played when dryfiring.
    },
})

AS.AddBaseItem("gun_ak", {
    name = "Assault Rifle",
    desc = "An fully-automatic assault rifle. Useful for close and medium ranged combat.",
    model = "models/weapons/w_pistol.mdl",
    value = 0,
    weight = 1,
    nodrop = true,
    notrade = true,
    guninfo = {
        Damage = 23,
        Firerate = 60/640,
        Automatic = false,
        Bullets = 1,
        AmmoUsage = 1,
        Ammo = "AR2",
        Magazine = 12,
        Spread = 0.012,
        SpreadC = 0.008,
        Force = 0.8,
        Recoil = 0.5,
        Sound = "Weapon_AK47.Single",
        EmptySound = "weapons/pistol/pistol_empty.wav",
    }
})