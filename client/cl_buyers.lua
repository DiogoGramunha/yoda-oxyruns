-- cl_buyers.lua

local NpcBuyers = Config.Buyers
local priceCocaineSelling = Config.Price.priceCocaineSelling


local currentBuyerPed = nil
local currentBuyerZone = nil
local currentBlip = nil
local lastBuyerIndex = nil

local cooldown = Config.Cooldown

local function CleanUpBuyer()
    if currentBuyerZone then
        exports.ox_target:removeZone(currentBuyerZone)
        currentBuyerZone = nil
    end
    if currentBlip then
        RemoveBlip(currentBlip)
        currentBlip = nil
    end
    if currentBuyerPed then
        Wait(10000)
        currentBuyerPed = nil
    end
end

local function CreateBuyerNPC()
    if currentBuyerPed then
        return
    end

    local buyerIndex

    repeat
        buyerIndex = math.random(1, 13)
    until buyerIndex ~= lastBuyerIndex

    lastBuyerIndex = buyerIndex

    local buyer = NpcBuyers["npc" .. buyerIndex]
    
    if buyer then
        CleanUpBuyer()

        local npcModels = Config.Models

        local model = npcModels[math.random(1, #npcModels)]
        local modelHash = GetHashKey(model)

        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(10)
        end

        currentBuyerPed = CreatePed(1, modelHash, buyer.coordx, buyer.coordy, buyer.coordz, buyer.heading, false, true)
        FreezeEntityPosition(currentBuyerPed, true)
        SetEntityInvincible(currentBuyerPed, true)
        SetBlockingOfNonTemporaryEvents(currentBuyerPed, true)

        currentBlip = AddBlipForCoord(buyer.coordx, buyer.coordy, buyer.coordz)
        SetBlipSprite(currentBlip, 1)
        SetBlipDisplay(currentBlip, 4)
        SetBlipScale(currentBlip, 1.0)
        SetBlipColour(currentBlip, 1)
        SetBlipAsShortRange(currentBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Cocaine Buyer")
        EndTextCommandSetBlipName(currentBlip)

        currentBuyerZone = exports.ox_target:addBoxZone({
            coords = vec3(buyer.coordx, buyer.coordy, buyer.coordz + 1),
            size = vec3(1.5, 1.5, 1.5),
            rotation = 90,
            debug = drawZones,
            options = {{
                name = 'yoda-oxyruns:sellToBuyer',
                icon = 'fa-solid fa-cube',
                label = 'Sell Cocaine',
                onSelect = function()
                    local success = math.random() < 0.7 -- 70% of chance to sell de drugs
                    if success then
                        TriggerServerEvent('yoda-oxyruns:sellToBuyer')
                        TriggerEvent('yoda-oxyruns:sellDrugsAnim')
                    else
                        exports.ox_lib:notify(Config.Notify.dealFailed)
                        exports['ps-dispatch']:DrugSale()
                        CleanUpBuyer()
                        CreateBuyerWithDelay()
                        TaskWanderStandard(currentBuyerPed)
                    end
                end
            }}
        })

        return currentBuyerPed, currentBuyerZone, currentBlip
    end
end

RegisterNetEvent('yoda-oxyruns:sellDrugsAnim')
AddEventHandler('yoda-oxyruns:sellDrugsAnim', function()
    local playerPed = PlayerPedId()
    local ped = currentBuyerPed
    local animDict = 'mp_common'
    local animName = 'givetake1_a'
    
    ClearPedTasks(playerPed)
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(0)
    end
    
    local cocaineBagped = CreateObject(GetHashKey("xm3_prop_xm3_bag_coke_01a"), 0, 0, 0, true, true, true)
    local cocaineBagplayerPed = CreateObject(GetHashKey("xm3_prop_xm3_bag_coke_01a"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(cocaineBagplayerPed, playerPed, GetPedBoneIndex(playerPed, 0x188E), 0.08, -0.06, -0.01, 96.0, 20.0, 180.0, true, true, false, true, 1, true)
    
    TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, 1000, 49, 0, false, false, false)
    TaskPlayAnim(playerPed, animDict, animName, 1.0, -1.0, 1000, 49, 0, false, false, false)
    Citizen.Wait(1000)
    DeleteObject(cocaineBagplayerPed)
    
    AttachEntityToEntity(cocaineBagped, ped, GetPedBoneIndex(ped, 0x188E), 0.08, -0.06, -0.01, 96.0, 20.0, 180.0, true, true, false, true, 1, true)
    Citizen.Wait(900)
    ClearPedTasks(ped)
    DeleteObject(cocaineBagped)
    FreezeEntityPosition(ped, false)

    TaskWanderStandard(ped)

    CleanUpBuyer()

    TriggerServerEvent('yoda-oxyruns:verifyDrugs', priceCocaineSelling)

    Wait(70000)
end)

RegisterNetEvent('yoda-oxyruns:checkDrugs')
AddEventHandler('yoda-oxyruns:checkDrugs', function(hasDrugs)
    if not hasDrugs then
        CleanUpBuyer()
    end
end)

RegisterNetEvent('yoda-oxyruns:startSelling')
AddEventHandler('yoda-oxyruns:startSelling', function(priceCocaine, nDrugs)
    CreateBuyerWithDelay()
end)

RegisterNetEvent('yoda-oxyruns:startSellingAfterPurchase')
AddEventHandler('yoda-oxyruns:startSellingAfterPurchase', function(priceCocaine, nDrugs)
    CreateBuyerWithDelay()
end)

function CreateBuyerWithDelay()
    local delay = math.random(cooldown.npc.min, cooldown.npc.max) * 60000
    Citizen.SetTimeout(delay, function()
        local buyerPed, buyerZone, blip = CreateBuyerNPC()
        if buyerPed and buyerZone then
            exports.ox_lib:notify(Config.Notify.buyerLocation)
        end
    end)
end

Citizen.CreateThread(function()
    local model1 = GetHashKey(Config.Buyers.npc1.Model)
    local model2 = GetHashKey(Config.Buyers.npc2.Model)
    RequestModel(model1)
    RequestModel(model2)
    while not HasModelLoaded(model1) or not HasModelLoaded(model2) do
        Citizen.Wait(10)
    end
end)
