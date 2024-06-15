local inventory = exports.ox_inventory
local lib = exports.ox_lib

RegisterNetEvent('yoda-oxyruns:exchangeDrugs')
AddEventHandler('yoda-oxyruns:exchangeDrugs', function(sellRandom, priceCocaine)
    print('exchangeDrugs event received on server')

    local source = source
    local checkMoney = ox_inventory:GetItem(source, 'cash', nil, true)
    
    if checkMoney then
        print('Player has money')
    else
        print('Player does not have money')
    end
    
    if checkMoney and checkMoney >= priceCocaine then
        print('Player has enough money')
        ox_inventory:RemoveItem(source, 'cash', priceCocaine)
        ox_inventory:AddItem(source, 'cocaine', sellRandom)
        print('Triggering client event giveDrugs')
        TriggerClientEvent('yoda-oxyruns:giveDrugs', source)
        lib:notify({ type = 'success', text = 'Job started' })
    else
        print('Not enough money')
        lib:notify({ type = 'error', text = 'Not enough cash' })
    end
end)

RegisterNetEvent('yoda-oxyruns:verifyDrugs')
AddEventHandler('yoda-oxyruns:verifyDrugs', function(priceCocaine)
    local cacainePrice = priceCocaine
    local nDrugs = inventory:GetItem(source, 'cocaine', nil, true)

    if nDrugs == 0 then
        lib:notify(notEnoughDrugs)
    else 
        TriggerClientEvent('yoda-oxyruns:startSelling', function(priceCocaine, nDrugs))
    end
end)

RegisterNetEvent('yoda-oxyruns:sellToBuyer')
AddEventHandler('yoda-oxyruns:sellToBuyer', function()
    local nDrugs = inventory:GetItem(source, 'cocaine', nil, true)

    if nDrugs and nDrugs > 0 then
        local bugToSell = math.random(1, math.min(3, nDrugs))
        local sellingPrice = math.random(1, priceCocaineSelling.value) * bagsToSell

        inventory:RemoveItem(source, 'cocaine', bagsToSell)
        inventory:AddItem(source, 'cash', sellingPrice)

        lib:notify()
    else
        lib:notify()
end)