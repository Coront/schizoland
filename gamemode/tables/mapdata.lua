AS.Maps = {}
function AS.AddMapData( id, data )
    AS.Maps = AS.Maps or {}

    AS.Maps[id] = data
end

-- ███╗   ███╗ █████╗ ██████╗     ██████╗  █████╗ ████████╗ █████╗
-- ████╗ ████║██╔══██╗██╔══██╗    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
-- ██╔████╔██║███████║██████╔╝    ██║  ██║███████║   ██║   ███████║
-- ██║╚██╔╝██║██╔══██║██╔═══╝     ██║  ██║██╔══██║   ██║   ██╔══██║
-- ██║ ╚═╝ ██║██║  ██║██║         ██████╔╝██║  ██║   ██║   ██║  ██║
-- ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝         ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝

AS.AddMapData( "gm_flatgrass", {
    Load = {
        pos = Vector(1419.98, 1530.03, -12781.00), 
        ang = Angle(-12.18, -133.83, 0.00),
    },
    Spawns = {
        Vector(-823.49, -302.94, -12703.97),
        Vector(-823.49, -206.84, -12703.97),
        Vector(-637.62, -302.94, -12703.97),
        Vector(-637.62, -206.84, -12703.97),
    },
})

AS.AddMapData( "gm_devroom", {
    Load = {
        pos = Vector(-451.61, -475.97, 177.31),
        ang = Angle(12.78, 44.20),
    },
    Spawns = {
        Vector(-336.01, -336.75, 64.03),
    },
})

AS.AddMapData( "gm_aftermath_day_v1_0", {
    Load = {
        pos = Vector(2334.46, 8383.56, 145.10),
        ang = Angle(-5.39, 41.03),
    },
    Spawns = {
        Vector(471.66, 11727.58, 456.03),
        Vector(471.66, 11642.58, 456.03),
        Vector(471.66, 11572.58, 456.03),
        Vector(414.66, 11727.58, 456.03),
        Vector(414.66, 11642.58, 456.03),
        Vector(414.66, 11572.58, 456.03),
    },
})

AS.AddMapData( "gm_valley", {
    MobMult = 2,
    NodeMult = 2.2,
    Load = {
        pos = Vector(4606.78, 1728.85, -2245.67),
        ang = Angle(-11.15, -123.28),
    },
    Spawns = {
        Vector(-4508.03, -3881.11, 163.04),
        Vector(-4508.03, -3779.64, 163.04),
    },
})

AS.AddMapData( "gm_postnuke_beta_4", {
    Load = {
        pos = Vector(-1429.20, 1270.12, 590.14),
        ang = Angle(16.54, -48.93),
    },
    Spawns = {
        Vector(-1211.22, 406.15, 156.03),
        Vector(-1211.22, 342.85, 156.03),
        Vector(-1211.22, 286.12, 156.03),
    },
})

AS.AddMapData( "rp_cscdesert_v4b2", {
    MobMult = 1.5,
    NodeMult = 1.5,
    Load = {
        pos = Vector( 889.94, 4903.31, 558.71 ),
        ang = Angle( 9.68, 133.98 ),
    },
    Spawns = {
        Vector( -1192.67, 6215.72, 73.03 ),
        Vector( -1192.67, 6298.56, 73.03 ),
    },
})

AS.AddMapData( "r_postnukemetro_dry", {
    MobMult = 1.5,
    NodeMult = 2,
    Load = {
        pos = Vector(-1429.20, 1270.12, 590.14),
        ang = Angle(16.54, -48.93),
    },
    Spawns = {
        Vector( -1238.96, 418.22, 92.03 ),
        Vector( -1240.1, 344.57, 92.03 ),
        Vector( -1241.25, 270.15, 92.03 ),
        Vector( -1152.62, 268.78, 92.03 ),
        Vector( -1151.82, 320.43, 92.03 ),
        Vector( -1150.59, 399.83, 92.03 ),
    },
})

AS.AddMapData( "gm_disaster_v3_nodust", {
    MobMult = 1.4,
    NodeMult = 1.4,
    Load = {
        pos = Vector(-2286.38, 1584.63, -351.75),
        ang = Angle(8.16, -45.89),
    },
    Spawns = {
        Vector( -12651.86, 1255.97, -791.97 ),
        Vector( -12651.86, 1389.25, -791.97 ),
        Vector( -12768.82, 1389.25, -791.97 ),
        Vector( -12768.82, 1255.97, -791.97 ),
        Vector( -12855.82, 1255.97, -791.97 ),
        Vector( -12855.82, 1389.97, -791.97 ),
    },
})

AS.AddMapData( "gm_fork", {
    MobMult = 3,
    NodeMult = 3,
    Load = {
        pos = Vector( -3215.54, 9997.07, -8408.79 ),
        ang = Angle( -5.10, -72.40 ),
    },
    Spawns = {
        Vector( 10445.4, 15283.21, -9127.98 ),
        Vector( 10366.07, 15283.55, -9127.98 ),
        Vector( 10265.07, 15283.98, -9127.98 ),
        Vector( 10264.62, 15179.34, -9127.98 ),
        Vector( 10368.68, 15178.9, -9127.98 ),
        Vector( 10470.94, 15178.46, -9127.98 ),
        Vector( 10470.55, 15088.29, -9127.98 ),
        Vector( 10356.55, 15088.78, -9127.98 ),
        Vector( 10248.32, 15089.25, -9127.98 ),
    },
})

AS.AddMapData( "rp_mojave_v3_p", {
    MobMult = 1.4,
    NodeMult = 1.3,
    Load = {
        pos = Vector( 2326.97, -7895.65, 64.11 ),
        ang = Angle( -3.17, 105.31 ),
    },
    Spawns = {
        Vector( 1620.69, -15744.76, 1.03 ),
        Vector( 1795.36, -15746.36, 1.03 ),
        Vector( 1968.79, -15747.95, 1.03 ),
        Vector( 1622.04, -15598.64, 1.03 ),
        Vector( 1794.56, -15600.22, 1.03 ),
        Vector( 1966.36, -15601.79, 1.03 )
    },
})

AS.AddMapData( "rp_ineu_pass_v1e", {
    MobMult = 1,
    NodeMult = 1,
    Load = {
        pos = Vector( 3222.72, -4956.93, 13.75 ),
        ang = Angle( -4.23, 165.66 ),
    },
    Spawns = {
        Vector( 7399.53, -9890.19, 108.64 ),
        Vector( 7306.52, -9902.23, 104.18 ),
        Vector( 7209.92, -9914.73, 106.39 ),
        Vector( 7196.1, -9807.93, 119.9 ),
        Vector( 7307.03, -9793.58, 117.81 ),
        Vector( 7416.81, -9752.25, 126.99 ),
        Vector( 7419.65, -9650.47, 137.38 ),
        Vector( 7318.82, -9656.64, 126.78 ),
        Vector( 7174.22, -9645.87, 139.22 ),
    },
})

AS.AddMapData( "rp_asheville", {
    MobMult = 1,
    NodeMult = 1,
    Load = {
        pos = Vector( 216.93, 984.71, 64.03 ),
        ang = Angle( -6.86, 33.18 ),
    },
    Spawns = {
        Vector( -12176.71, 9140.83, -47.97 ),
        Vector( -12175.29, 9057.9, -47.97 ),
        Vector( -12173.9, 8975.86, -47.97 ),
        Vector( -12094.57, 8977.21, -47.97 ),
        Vector( -12095.95, 9057.96, -47.97 ),
        Vector( -12097.41, 9143.29, -47.97 ),
        Vector( -11865.57, 9228.52, -47.97 ),
        Vector( -11919.29, 9059.3, -47.97 ),
        Vector( -11885.28, 8856.76, -47.97 ),
    },
})

AS.AddMapData( "rp_outercanals_p", {
    MobMult = 1,
    NodeMult = 1.2,
    Load = {
        pos = Vector( -2382.87, -1225.47, -163.88 ),
        ang = Angle( -2.87, 21.49 ),
    },
    Spawns = {
        Vector( -12680.85, -1004.35, 0.03 ),
        Vector( -12763.67, -1001.28, 0.03 ),
        Vector( -12854.18, -1000.37, 0.03 ),
        Vector( -12850.3, -912.28, 0.03 ),
        Vector( -12764.34, -913.06, 0.03 ),
        Vector( -12681.79, -912.88, 0.03 )
    },
})

AS.AddMapData( "rp_pripyat_p", {
    MobMult = 1,
    NodeMult = 1,
    Load = {
        pos = Vector( 112.37, -5886, 503.35 ),
        ang = Angle( 7.39, 113.18 ),
    },
    Spawns = {
        Vector( -1857, -12714.61, 47 ),
        Vector( -1948.69, -12714.61, 47 ),
        Vector( -1857, -12617.27, 47 ),
        Vector( -1948.69, -12617.27, 47 ),
        Vector( -1857, -12500.27, 47 ),
        Vector( -1948.69, -12500.27, 47 ),
    },
})