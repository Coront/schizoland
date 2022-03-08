-- ███╗   ███╗███████╗██╗     ███████╗███████╗
-- ████╗ ████║██╔════╝██║     ██╔════╝██╔════╝
-- ██╔████╔██║█████╗  ██║     █████╗  █████╗
-- ██║╚██╔╝██║██╔══╝  ██║     ██╔══╝  ██╔══╝
-- ██║ ╚═╝ ██║███████╗███████╗███████╗███████╗
-- ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝╚══════╝

AS.AddBaseItem("wep_knife", {
    name = "Knife",
    desc = "A small knife that has been sharpened recently. Useful for defending yourself against simple threats.",
    category = "weapon",
    model = "models/weapons/w_knife_t.mdl",
    wep = "weapon_knife",
    value = 5,
    weight = 0.5,
    class = "scavenger",
    craft = {
        ["misc_scrap"] = 15,
        ["misc_smallparts"] = 10,
        ["misc_chemical"] = 5,
    },
})

AS.AddBaseItem("wep_crowbar", {
    name = "Crowbar",
    desc = "A lengthy piece of metal, once used as a repair tool. Now, for ultimate destruction.",
    category = "weapon",
    model = "models/weapons/w_crowbar.mdl",
    wep = "weapon_crowbar",
    value = 10,
    weight = 1,
    class = "scavenger",
    craft = {
        ["misc_scrap"] = 25,
        ["misc_smallparts"] = 15,
        ["misc_chemical"] = 15,
    },
})

-- ██████╗ ██╗███████╗████████╗ ██████╗ ██╗     ███████╗
-- ██╔══██╗██║██╔════╝╚══██╔══╝██╔═══██╗██║     ██╔════╝
-- ██████╔╝██║███████╗   ██║   ██║   ██║██║     ███████╗
-- ██╔═══╝ ██║╚════██║   ██║   ██║   ██║██║     ╚════██║
-- ██║     ██║███████║   ██║   ╚██████╔╝███████╗███████║
-- ╚═╝     ╚═╝╚══════╝   ╚═╝    ╚═════╝ ╚══════╝╚══════╝

AS.AddBaseItem("wep_peashooter", {
    name = "Peashooter",
    desc = "A small pistol that holds 18 rounds and can shoot an above moderate rate. Deals less than average damage. Uses pistol ammo.",
    category = "weapon",
    model = "models/weapons/w_pistol.mdl",
    wep = "weapon_peashooter",
    value = 10,
    weight = 0.8,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 40,
        ["misc_smallparts"] = 50,
        ["misc_chemical"] = 35,
    },
})

AS.AddBaseItem("wep_p228", {
    name = "P228",
    desc = "A small pistol that holds 13 rounds and shoots at a moderate rate. Deals average damage. Uses pistol ammo.",
    category = "weapon",
    model = "models/weapons/w_pist_p228.mdl",
    value = 15,
    weight = 0.8,
    class = "engineer",
    craft = {
        ["misc_scrap"] = 60,
        ["misc_smallparts"] = 50,
        ["misc_chemical"] = 40,
    },
})

AS.AddBaseItem("wep_usp", {
    name = "USP",
    desc = "A small pistol that holds 18 rounds and shoots at a less than moderate rate. Deals average damage. Has the ability to attach a muzzle suppressor, which reduces recoil and improves accuracy, but lowers damage. Uses pistol ammo.",
    category = "weapon",
    model = "models/weapons/w_pist_usp.mdl",
    value = 15,
    weight = 1
})

AS.AddBaseItem("wep_glock", {
    name = "Glock-18",
    desc = "A small pistol that holds 19 rounds and has full-auto compatibility. Semi-auto shoots at a moderate rate, while full-auto shoots at an extremely fast rate. Deals slightly less than average damage. Uses pistol ammo.",
    category = "weapon",
    model = "models/weapons/w_pist_glock18.mdl",
    value = 15,
    weight = 0.9
})

AS.AddBaseItem("wep_fiveseven", {
    name = "Five-Seven",
    desc = "A small pistol that holds 20 rounds and shoots at a moderate rate. Deals slightly above average damage. Uses pistol ammo.",
    category = "weapon",
    model = "models/weapons/w_pist_fiveseven.mdl",
    value = 15,
    weight = 1.1
})

AS.AddBaseItem("wep_magnum", {
    name = ".357 Magnum",
    desc = "A large magnum that holds 6 rounds and shoots at a slow rate. Deals above average damage. Uses pistol ammo.",
    category = "weapon",
    model = "models/weapons/w_357.mdl",
    value = 15,
    weight = 1.8
})

AS.AddBaseItem("wep_deagle", {
    name = ".50 AE Desert Eagle",
    desc = "A large and heavy handcannon that holds 7 rounds and shoots at a very slow rate. Deals a significant amount of damage. Uses pistol ammo.",
    category = "weapon",
    model = "models/weapons/w_pist_deagle.mdl",
    value = 15,
    weight = 2.1
})

-- ███████╗███╗   ███╗ ██████╗ ███████╗
-- ██╔════╝████╗ ████║██╔════╝ ██╔════╝
-- ███████╗██╔████╔██║██║  ███╗███████╗
-- ╚════██║██║╚██╔╝██║██║   ██║╚════██║
-- ███████║██║ ╚═╝ ██║╚██████╔╝███████║
-- ╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝

AS.AddBaseItem("wep_mp7", {
    name = "MP7",
    desc = "A medium sized SMG that holds 30 rounds and shoots fast. Deals below average damage. Uses SMG ammo.",
    category = "weapon",
    model = "models/weapons/w_smg1.mdl",
    value = 15,
    weight = 2
})

AS.AddBaseItem("wep_ump", {
    name = "UMP",
    desc = "A medium sized SMG that holds 25 rounds and shoots slightly less than fast. Deals average damage. Uses SMG ammo.",
    category = "weapon",
    model = "models/weapons/w_smg_ump45.mdl",
    value = 15,
    weight = 2
})

AS.AddBaseItem("wep_tmp", {
    name = "TMP",
    desc = "A medium sized SMG that holds 40 rounds and shoots very fast. Deals below average damage. Uses SMG ammo.",
    category = "weapon",
    model = "models/weapons/w_smg_tmp.mdl",
    value = 15,
    weight = 2.1
})

AS.AddBaseItem("wep_p90", {
    name = "P90",
    desc = "A large sized SMG that holds 50 rounds and shoots very fast. Deals below average damage. Uses SMG ammo.",
    category = "weapon",
    model = "models/weapons/w_smg_p90.mdl",
    value = 15,
    weight = 2.5
})

AS.AddBaseItem("wep_mp5", {
    name = "MP5",
    desc = "A medium sized SMG that holds 30 rounds and shoots fast. Deals average damage. Uses SMG ammo.",
    category = "weapon",
    model = "models/weapons/w_smg_mp5.mdl",
    wep = "weapon_mp5",
    value = 15,
    weight = 2.3
})

AS.AddBaseItem("wep_mac", {
    name = "Mac-10",
    desc = "A compact SMG that holds 30 rounds and shoots extremely fast. Deals less than average damage. Uses SMG ammo.",
    category = "weapon",
    model = "models/weapons/w_smg_mac10.mdl",
    wep = "weapon_mac10",
    value = 15,
    weight = 1.9
})

-- ██████╗ ██╗███████╗██╗     ███████╗███████╗
-- ██╔══██╗██║██╔════╝██║     ██╔════╝██╔════╝
-- ██████╔╝██║█████╗  ██║     █████╗  ███████╗
-- ██╔══██╗██║██╔══╝  ██║     ██╔══╝  ╚════██║
-- ██║  ██║██║██║     ███████╗███████╗███████║
-- ╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝╚══════╝╚══════╝

AS.AddBaseItem("wep_famas", {
    name = "Famas",
    desc = "A medium sized rifle that holds 25 rounds and shoots very fast. Deals average damage. Uses rifle ammo.",
    category = "weapon",
    model = "models/weapons/w_rif_famas.mdl",
    value = 15,
    weight = 2.4
})

AS.AddBaseItem("wep_sg552", {
    name = "SG 552",
    desc = "An average sized rifle that holds 30 rounds and shoots at a moderate rate. Deals slightly above average damage. Has an attached scope for sighting. Uses rifle ammo.",
    category = "weapon",
    model = "models/weapons/w_rif_sg552.mdl",
    value = 15,
    weight = 2.5
})

AS.AddBaseItem("wep_galil", {
    name = "IMI Galil",
    desc = "An average sized rifle that holds 30 rounds and shoots at an above moderate rate. Deals slightly above average damage. Uses rifle ammo.",
    category = "weapon",
    model = "models/weapons/w_rif_galil.mdl",
    value = 15,
    weight = 2.7
})

AS.AddBaseItem("wep_aug", {
    name = "Steyr AUG",
    desc = "An average sized rifle that holds 30 rounds and shoots at a moderate rate. Deals slightly above average damage. Has an attached scope for sighting. Uses rifle ammo.",
    category = "weapon",
    model = "models/weapons/w_rif_aug.mdl",
    value = 15,
    weight = 2.7
})

AS.AddBaseItem("wep_m4a1", {
    name = "M4A1",
    desc = "An average sized rifle that holds 30 rounds and shoots at an above moderate rate. Deals slightly above average damage. Uses rifle ammo.",
    category = "weapon",
    model = "models/weapons/w_rif_m4a1.mdl",
    wep = "weapon_m4a1",
    value = 15,
    weight = 2.6
})

AS.AddBaseItem("wep_ak47", {
    name = "AK-47",
    desc = "An average sized rifle that holds 30 rounds and shoots at a moderate rate. Deals above average damage. Uses rifle ammo.",
    category = "weapon",
    model = "models/weapons/w_rif_ak47.mdl",
    value = 15,
    weight = 2.7
})

AS.AddBaseItem("wep_pulserifle", {
    name = "Pulse Rifle",
    desc = "A large rifle that holds 30 shots per charge and shoots at an above moderate rate. Deals above average damage. Uses pulse charges.",
    category = "weapon",
    model = "models/weapons/w_irifle.mdl",
    wep = "weapon_pulserifle",
    value = 15,
    weight = 3
})

-- ███████╗██╗  ██╗ ██████╗ ████████╗ ██████╗ ██╗   ██╗███╗   ██╗███████╗
-- ██╔════╝██║  ██║██╔═══██╗╚══██╔══╝██╔════╝ ██║   ██║████╗  ██║██╔════╝
-- ███████╗███████║██║   ██║   ██║   ██║  ███╗██║   ██║██╔██╗ ██║███████╗
-- ╚════██║██╔══██║██║   ██║   ██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
-- ███████║██║  ██║╚██████╔╝   ██║   ╚██████╔╝╚██████╔╝██║ ╚████║███████║
-- ╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝

AS.AddBaseItem("wep_m3super", {
    name = "M3 Super 90",
    desc = "A large shotgun that holds 8 rounds and shoots at a pump-action rate. Deals significant amounts of damage. Uses shotgun ammo.",
    category = "weapon",
    model = "models/weapons/w_shot_m3super90.mdl",
    wep = "weapon_m3super",
    value = 15,
    weight = 2.9
})

AS.AddBaseItem("wep_spas", {
    name = "SPAS-12",
    desc = "A large shotgun that holds 8 rounds and shoots very fast. Deals large amounts of damage. Uses shotgun ammo.",
    category = "weapon",
    model = "models/weapons/w_shotgun.mdl",
    wep = "weapon_spas",
    value = 15,
    weight = 2.8
})

AS.AddBaseItem("wep_xm1014", {
    name = "XM1014",
    desc = "A large shotgun that holds 8 rounds and shoots at a moderate rate. Deals significant amounts of damage. Uses shotgun ammo.",
    category = "weapon",
    model = "models/weapons/w_shot_xm1014.mdl",
    wep = "weapon_xm",
    value = 15,
    weight = 2.9
})

-- ██╗     ███╗   ███╗ ██████╗ ███████╗
-- ██║     ████╗ ████║██╔════╝ ██╔════╝
-- ██║     ██╔████╔██║██║  ███╗███████╗
-- ██║     ██║╚██╔╝██║██║   ██║╚════██║
-- ███████╗██║ ╚═╝ ██║╚██████╔╝███████║
-- ╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝

AS.AddBaseItem("wep_m249", {
    name = "M249",
    desc = "A very heavy light machine gun that holds 100 rounds and shoots very fast. Deals average damage. Uses rifle ammo.",
    category = "weapon",
    model = "models/weapons/w_mach_m249para.mdl",
    wep = "weapon_m249",
    value = 15,
    weight = 4
})

-- ███████╗███╗   ██╗██╗██████╗ ███████╗██████╗ ███████╗
-- ██╔════╝████╗  ██║██║██╔══██╗██╔════╝██╔══██╗██╔════╝
-- ███████╗██╔██╗ ██║██║██████╔╝█████╗  ██████╔╝███████╗
-- ╚════██║██║╚██╗██║██║██╔═══╝ ██╔══╝  ██╔══██╗╚════██║
-- ███████║██║ ╚████║██║██║     ███████╗██║  ██║███████║
-- ╚══════╝╚═╝  ╚═══╝╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝

AS.AddBaseItem("wep_scout", {
    name = "Scout",
    desc = "A very light sniper rifle that holds 10 rounds and shoots at a bolt-action rate. Deals above average damage. Has an attached scope for sighting. Uses sniper ammo.",
    category = "weapon",
    model = "models/weapons/w_snip_scout.mdl",
    wep = "weapon_scout",
    value = 15,
    weight = 2.6
})

AS.AddBaseItem("wep_g3sg1", {
    name = "G3SG1",
    desc = "A heavy sniper rifle that holds 10 rounds and shoots at a slow rate. Deals above average damage. Has an attached scope for sighting. Uses sniper ammo.",
    category = "weapon",
    model = "models/weapons/w_snip_g3sg1.mdl",
    value = 15,
    weight = 3.1
})

AS.AddBaseItem("wep_sg550", {
    name = "SG-550",
    desc = "A heavy sniper rifle that holds 20 rounds and shoots at a medium rate. Deals average damage. Has an attached scope for sighting. Uses sniper ammo.",
    category = "weapon",
    model = "models/weapons/w_snip_g3sg1.mdl",
    value = 15,
    weight = 3
})

AS.AddBaseItem("wep_awp", {
    name = "AWP",
    desc = "A very rare and heavy sniper rifle that holds 10 rounds and shoots at very slow bolt-action rate. Deals significant amounts of damage. Uses sniper ammo.",
    category = "weapon",
    model = "models/weapons/w_snip_awp.mdl",
    wep = "weapon_awp",
    value = 15,
    weight = 3.9
})

-- ███╗   ███╗██╗███████╗ ██████╗
-- ████╗ ████║██║██╔════╝██╔════╝
-- ██╔████╔██║██║███████╗██║
-- ██║╚██╔╝██║██║╚════██║██║
-- ██║ ╚═╝ ██║██║███████║╚██████╗
-- ╚═╝     ╚═╝╚═╝╚══════╝ ╚═════╝

AS.AddBaseItem("wep_grenade", {
    name = "Grenade",
    desc = "A high-explosive grenade that has a fuse of around 3 seconds after being thrown.",
    category = "weapon",
    model = "models/weapons/w_grenade.mdl",
    value = 15,
    weight = 1
})

AS.AddBaseItem("wep_breach", {
    name = "Breaching Charge",
    desc = "A charge that contains explosives, strong enough to bust through doors. Useful to place on Antlion nests if you prefer to save time.",
    category = "weapon",
    model = "models/weapons/w_slam.mdl",
    value = 15,
    weight = 1
})