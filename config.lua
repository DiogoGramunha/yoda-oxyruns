Config = {}

Config.Cooldown = {
    npc = { -- Cooldown between deliveries, min and max in minutes
        max = 1,
        min = 3,
    },
    delivery = { -- Cooldown between new job, min and max in minutes
        max = 10,
        min = 15,
    }
}

Config.Price = {
    cocaine = 400,
    weed = 150,
    meth = 600,
    priceCocaineSelling = 25,
}

Config.Dealers = {
    cocaine = {
        npc1 = {
            coordx = -1561.5404,
            coordy = -413.0152,
            coordz = 37.0961,
            heading = 180.9050,
            RenderDistance = 35
        },
        --[[ npc2 = {
            coordx = xcoord,
            coordy = ycoord,
            coordz = zcoord,
            heading = headingcoord,
            RenderDistance = 35,
        }, ]]
    },
}

Config.Models = {
    "a_m_m_hillbilly_02",
    "a_m_m_salton_04",
    "a_m_m_polynesian_01",
    "a_m_m_polynesian_01",
    "a_m_m_salton_02",
    "a_m_m_salton_03",
    "a_m_m_skater_01",
    "a_m_m_soucent_04",
    "a_m_m_soucent_03",
    "a_m_m_skidrow_01",
    "a_m_m_socenlat_01",
    "a_m_m_soucent_01",
    "a_m_o_beach_01",
    "a_m_o_soucent_03",
    "a_m_o_tramp_01",
    "a_m_o_soucent_02",
    "a_m_o_salton_01",
    "a_f_m_skidrow_01",
    "a_f_m_tourist_01",
    "a_f_m_trampbeac_01",
    "a_f_o_indian_01",
    "a_f_y_clubcust_02",
    "a_f_y_hipster_02",
    "a_f_y_rurmeth_01"
}

Config.Buyers = {
    npc1 = {
        coordx = -1067.0746,
        coordy = -504.5410,
        coordz = 35.0798,
        heading = 25.4282,
        RenderDistance = 35
    },
    npc2 = {
        coordx = 54.5449,
        coordy = 163.6573,
        coordz = 103.7610,
        heading = 273.0411,
        RenderDistance = 35
    },
    npc3 = {
        coordx = 167.4547,
        coordy = -1248.3344,
        coordz = 28.1984,
        heading = 78.3712,
        RenderDistance = 35
    },
    npc4 = {
        coordx = -324.8175,
        coordy = -1356.3646,
        coordz = 30.2957,
        heading = 99.2964,
        RenderDistance = 35
    },
    npc5 = {
        coordx = -1995.7758,
        coordy = -504.8550,
        coordz = 11.0130,
        heading = 238.6174,
        RenderDistance = 35
    },
    npc6 = {
        coordx = -3102.0952,
        coordy = 367.3326,
        coordz = 6.1191,
        heading = 147.8980,
        RenderDistance = 35
    },
    npc7 = {
        coordx = -1690.8997,
        coordy = -431.7747,
        coordz = 41.3730,
        heading = 246.4736,
        RenderDistance = 35
    },
    npc8 = {
        coordx = -1496.6851,
        coordy = -318.3724,
        coordz = 45.9418,
        heading = 126.6329,
        RenderDistance = 35
    },
    npc9 = {
        coordx = -1336.2859,
        coordy = -226.7334,
        coordz = 41.9637,
        heading = 297.6121,
        RenderDistance = 35
    },
    npc10 = {
        coordx = -297.0966,
        coordy = 303.4752,
        coordz = 89.7184,
        heading = 0.0307,
        RenderDistance = 35
    },
    npc11 = {
        coordx = -497.5015,
        coordy = 79.3391,
        coordz = 54.9189,
        heading = 80.6300,
        RenderDistance = 35
    },
    npc12 = {
        coordx = -594.6409,
        coordy = 179.6907,
        coordz = 64.3169,
        heading = 170.0314,
        RenderDistance = 35
    },
    npc13 = {
        coordx = 59.7535,
        coordy = -41.5417,
        coordz = 68.2935,
        heading = 253.3634,
        RenderDistance = 35
    }
}


Config.Notify = {
    dealFailed = {
        title = 'Oxy Runs',
        description = 'Your drugs are a shit, get out of here!',
        duration = 10000,
        type = 'error'
    },
    notEnoughMoney = {
        title = 'Oxy Runs',
        description = 'You are broke!',
        duration = 10000,
        type = 'error'
    },
    StartJob = {
        title = 'Oxy Runs',
        description = 'Start delivering the packages to the right persons!',
        duration = 10000,
        type = 'info'
    },
    buyerLocation = {
        title = 'Oxy Runs',
        description = 'A buyer was located for you!',
        duration = 10000,
        type = 'success'
    }
}
