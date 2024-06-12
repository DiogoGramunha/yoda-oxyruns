local Framework

local function getFramework()
    if Config.Framework == "ESX" then
        Framework = exports["es_extended"]:getSharedObject()
    else
        Framework = exports['qb-core']:GetCoreObject()

local npcloc = {}

local function GetNPCLoc(index)
    return NpcLoc[index]
end

local function CreateNPCLoc(index)
    if (NpcLoc[index]) then
        DeleteLocalNPC(index)
    end

    NpcLoc[index] = {}

    Model(Config.NPC.Model)

    local npc = CreatePed(1, Config.NPC.Model , Config.NPC.Location, false, true)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
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

local gotZone = false

local options = {
    {
        name = 'ox:option1',
        icon = 'fa-solid fa-car',
        label = 'Sell Drugs',
        onSelect = function()
            lib.notify(Config.Notify.NextPlace)
        end
    },
}
exports.ox_target:addModel(Config.NPC.Model, options)

Citizen.CreateThread(function()
    while true do
        local wait = 1000
        local ped = PlayerPedId()
        local pcoords = GetEntityCoords(ped)
        for i=1, 1 do
            local npcinfo = Config.NPC
            local coords = vector3(npcinfo.Location)
            local dist = #(pcoords - coords)
            local npc = GetNPCLoc(i)
            if dist < npcinfo.RenderDistance then
                if (GetNPCLoc(i) == nill) then
                    CreateNPCLoc(i)
                end
            else
                DeleteLocalNPC(i)
            end
        end
    Wait(wait)
    end
end)