-- server.lua

local inventory = exports.ox_inventory
local lib = exports.ox_lib

RegisterNetEvent('yoda-oxyruns:exchangeDrugs')
AddEventHandler('yoda-oxyruns:exchangeDrugs', function(sellRandom, priceCocaine)
    local source = source
    local checkMoney = inventory:GetItem(source, 'cash', nil, true)
    
    if checkMoney and checkMoney >= priceCocaine then
        inventory:RemoveItem(source, 'cash', priceCocaine)
        inventory:AddItem(source, 'cocaine', sellRandom)
        TriggerClientEvent('yoda-oxyruns:giveDrugs', source)

        local nDrugs = inventory:GetItem(source, 'cocaine', nil, true)
        if nDrugs and nDrugs > 0 then
            TriggerClientEvent('yoda-oxyruns:startSellingAfterPurchase', source, Config.Price.priceCocaineSelling, nDrugs)
        end
    end
end)


RegisterNetEvent('yoda-oxyruns:verifyDrugs')
AddEventHandler('yoda-oxyruns:verifyDrugs', function(priceCocaine)
    local source = source
    local cocainePrice = priceCocaine
    local nDrugs = inventory:GetItem(source, 'cocaine', nil, true)

    if nDrugs == 0 then
        TriggerClientEvent('yoda-oxyruns:checkDrugs', source, false)
    else 
        TriggerClientEvent('yoda-oxyruns:startSelling', source, cocainePrice, nDrugs)
    end
end)


RegisterNetEvent('yoda-oxyruns:sellToBuyer')
AddEventHandler('yoda-oxyruns:sellToBuyer', function()
    local source = source
    local player = GetPlayerPed(source)
    local nDrugs = inventory:GetItem(source, 'cocaine', nil, true)

    if nDrugs and nDrugs > 0 then
        local amountToSell = math.random(1, math.min(3, nDrugs))
        local sellPrice = amountToSell * Config.Price.priceCocaineSelling

        inventory:RemoveItem(source, 'cocaine', amountToSell)
        inventory:AddItem(source, 'cash', sellPrice)
    end
end)
