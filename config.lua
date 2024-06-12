Config = {}

Config.Framework = "ESX" -- QB or ESX

Config.NPC = {
    Model = 'a_m_m_og_boss_01',
    Location = vector3(-210.81, -1363.409, 30.258),
    RenderDistance = 35
}

Config.Notify = {
    NoSpace = {
        title = 'Chopshop',
        description = 'You don\'t have enough space.',
        type = 'error',
        position = 'top-right'
    },
    Error = {
        title = 'Chop Shop',
        description = 'Failed',
        type = 'error'
    },
    NextPlace = {
        title = 'Drug Runs',
        description = 'Go to the next place to sell the drugs',
        type = 'inform',
        duration = 5000,
        position = 'top-right'
    },
    YouCompletedTheJob = {
        title = 'Chopshop',
        description = 'You completed the job.',
        type = 'success',
        position = 'top-right'
    },
    CompleteAllParts = {
        title = 'Chopshop',
        description = 'You have to chop all parts before the body!',
        type = 'error',
        position = 'top-right'
    }
}