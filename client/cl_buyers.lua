local NpcBuyers = Config.Buyers
local priceCocaineSelling = Config.Price.priceCocaineSelling

local function CreateBuyerNPC()
    local buyerIndex = math.random(1, 2)
    local buyer = NpcBuyers["npc" .. buyerIndex]

    if buyer then
        local buyerPed = CreatePed(1, GetHashKey(buyer.Model), buyer.coordx, buyer.coordy, buyer.coordz, buyer.heading, false, true)
        FreezeEntityPosition(buyerPed, true)
        SetEntityInvincible(buyerPed, true)
        SetBlockingOfNonTemporaryEvents(buyerPed, true)

        local buyerZone = exports.ox_target:addBoxZone({
            coords = vec3(buyer.coordx, buyer.coordy, buyer.coordz + 1),
            size = vec3(1.5, 1.5, 1.5),
            rotation = 90,
            debug = drawZones,
            options = {{
                name = 'yoda-oxyruns:sellToBuyer',
                icon = 'fa-solid fa-cube',
                label = 'Sell Cocaine',
                onSelect = function()
                    TriggerServerEvent('yoda-oxyruns:sellToBuyer')
                end
            }}
        })

        return buyerPed, buyerZone
    end
end

RegisterNetEvent('yoda-oxyruns:startSelling')
AddEventHandler('yoda-oxyruns:startSelling', function(priceCocaine, nDrugs) 
    local buyerPed, buyerZone = CreateBuyerNPC()

    if buyerPed and buyerZone then
        exports.ox_lib:notify(buyerLocation)
    end
end)

Citizen.CreateThread(function()
    local model1 = GetHashKey(Config.Buyers.npc1.Model)
    local model2 = GetHashKey(Config.Buyers.npc2.Model)
    RequestModel(model1)
    RequestModel(model2)
    while not HasModelLoaded(model1) or not HasModelLoaded(model2) do
        Citizen.Wait(10)
    end
end)