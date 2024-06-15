Config = {}

Config.Price = {
    cocaine = 400,
    weed = 150,
    meth = 600,
    priceCocaineSelling = 25,
}

Config.Dealers = {
    cocaine = {
        Model = 'a_m_m_og_boss_01',
        coordx = -1561.5404,
        coordy = -413.0152,
        coordz = 37.0961,
        heading = 180.9050,
        RenderDistance = 35
    },
    weed = {
        Model = 'a_m_m_og_boss_01',
        coordx = -1561.5404,
        coordy = -413.0152,
        coordz = 37.0961,
        heading = 180.9050,
        RenderDistance = 35
    },
    meth = {
        Model = 'a_m_m_og_boss_01',
        coordx = -1561.5404,
        coordy = -413.0152,
        coordz = 37.0961,
        heading = 180.9050,
        RenderDistance = 35
    }
}

Config.Buyers = {
    npc1 = {
        Model = 'a_m_m_og_boss_01',
        coordx = -1067.0746,
        coordy = -504.5410,
        coordz = 35.0798,
        heading = 25.4282,
        RenderDistance = 35
    },
    npc2 = {
        Model = 'a_m_m_og_boss_01',
        coordx = 54.5449,
        coordy = 163.6573,
        coordz = 103.7610,
        heading = 273.0411,
        RenderDistance = 35
    }
}

Config.Notify = {
    notEnoughDrugs = {
        title = 'Oxy Runs',
        description = 'You work is finished!',
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
        type = 'error'
    },
    buyerLocation = {
        title = 'Oxy Runs',
        description = 'A buyer was located for you!',
        duration = 10000,
        type = 'success'
    },
    sold = {
        title = 'Oxy Runs',
        description = 'You sold %d bags of cocaine for $%d.', bagsToSell, sellingPrice,
        duration = 10000,
        type = 'success'
    }
}