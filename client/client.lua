-- Configurações iniciais
local NpcLoc = {}
local Dealers = Config.Dealers
local sellRandom = math.random(1, 10)
local priceCocaine = Config.Price.cocaine

local cooldownActive = false
local cooldownTime = 0

local function StartCooldown()
    cooldownActive = true
    local delay = math.random(10, 15) * 60000
    cooldownTime = delay
end

local dealerCount = 0
for _ in pairs(Config.Dealers.cocaine) do
    dealerCount = dealerCount + 1
end

local currentDealerIndex = 1
local dealerKeys = {}
for key in pairs(Config.Dealers.cocaine) do
    table.insert(dealerKeys, key)
end

local function UpdateNPCPosition()
    local dealerKey = dealerKeys[currentDealerIndex]
    local dealer = Config.Dealers.cocaine[dealerKey]
    
    SetEntityCoords(ped, dealer.coordx, dealer.coordy, dealer.coordz, false, false, false, true)
    SetEntityHeading(ped, dealer.heading)

    exports.ox_target:updateBoxZone(npczone, {
        coords = vec3(dealer.coordx, dealer.coordy, dealer.coordz + 1),
    })

    currentDealerIndex = currentDealerIndex % dealerCount + 1
end

local function StartNPCUpdateTimer()
    if dealerCount > 1 then
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(10 * 60 * 1000)  -- 10 minutes
                UpdateNPCPosition()
            end
        end)
    end
end

Citizen.CreateThread(function()
    local model = GetHashKey('a_m_m_og_boss_01')
    RequestModel(model)
    local timeout = 10000
    local timer = 0
    while not HasModelLoaded(model) and timer < timeout do
        Citizen.Wait(10)
        timer = timer + 10
    end
    if not HasModelLoaded(model) then
        return
    end
    local initialDealer = Config.Dealers.cocaine[dealerKeys[currentDealerIndex]]
    ped = CreatePed(1, model, initialDealer.coordx, initialDealer.coordy, initialDealer.coordz, initialDealer.heading, false, false, 0)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedDiesWhenInjured(ped, false)
    SetPedCanPlayAmbientAnims(ped, false)
    SetPedCanRagdollFromPlayerImpact(ped, false)
    SetEntityInvincible(ped, true)

    npczone = exports.ox_target:addBoxZone({
        coords = vec3(initialDealer.coordx, initialDealer.coordy, initialDealer.coordz + 1),
        size = vec3(1.5, 1.5, 1.5),
        rotation = 90,
        debug = drawZones,
        options = {{
            name = 'yoda-oxyruns:buyCocaine',
            icon = 'fa-solid fa-cube',
            label = 'Buy Cocaine',
            onSelect = function()
                if cooldownActive then
                    exports.ox_lib:notify({ type = 'error', title = 'Oxy Runs', description = 'Wait '.. cooldownTime/60000 ..' minutes bro i need to get more drugs for you.' })
                else
                    print('TriggerServerEvent exchangeDrugs called')
                    TriggerServerEvent('yoda-oxyruns:exchangeDrugs', sellRandom, priceCocaine)
                    StartCooldown()
                end
            end
        }}
    })

    Citizen.Wait(10)

    StartNPCUpdateTimer()
end)

RegisterNetEvent('yoda-oxyruns:giveDrugs')
AddEventHandler('yoda-oxyruns:giveDrugs', function()
    local playerPed = PlayerPedId()
    local animDict = 'mp_common'
    local animName = 'givetake1_a'
    
    ClearPedTasks(playerPed)
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(0)
    end
    
    local cocaineBagped = CreateObject(GetHashKey("xm3_prop_xm3_bag_coke_01a"), 0, 0, 0, true, true, true)
    local cocaineBagplayerPed = CreateObject(GetHashKey("xm3_prop_xm3_bag_coke_01a"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(cocaineBagped, ped, GetPedBoneIndex(ped, 0x188E), 0.08, -0.06, -0.01, 96.0, 20.0, 180.0, true, true, false, true, 1, true)
    
    TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, 1000, 49, 0, false, false, false)
    TaskPlayAnim(playerPed, animDict, animName, 1.0, -1.0, 1000, 49, 0, false, false, false)
    Citizen.Wait(1000)
    DeleteObject(cocaineBagped)
    AttachEntityToEntity(cocaineBagplayerPed, playerPed, GetPedBoneIndex(playerPed, 0x188E), 0.08, -0.06, -0.01, 96.0, 20.0, 180.0, true, true, false, true, 1, true)
    Citizen.Wait(900)
    ClearPedTasks(playerPed)
    DeleteObject(cocaineBagplayerPed)

    TriggerServerEvent('yoda-oxyruns:verifyDrugs', priceCocaine)
end)

local function GetNPCLoc(index)
    return NpcLoc[index]
end

local function CreateNPCLoc(index)
    if (NpcLoc[index]) then
        DeleteLocalNPC(index)
    end

    NpcLoc[index] = {}

    Model('a_m_m_og_boss_01')

    local npc = CreatePed(5, 'a_m_m_og_boss_01' , Dealers.cocaine.coordx, Dealers.cocaine.coordy, Dealers.cocaine.coordz, 0, false, true)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetPedComponentVariation(npc, 3, 1, 4, 1) -- Shirt
    SetPedComponentVariation(npc, 4, 0, 0, 1) -- Pants
    SetPedComponentVariation(npc, 0, 0, 1, 0) -- Hat

    NpcLoc[index].npc = npc
end

local function DeleteLocalNPC(index)
    if (NpcLoc[index]) then 
        DeleteEntity(NpcLoc[index].npc)
        NpcLoc[index] = nil
    end 
end
