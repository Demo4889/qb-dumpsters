local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-dumpsters:startdumpsterTimer')
AddEventHandler('qb-dumpsters:startdumpsterTimer', function(dumpster)
    startTimer(source, dumpster)
end)

RegisterServerEvent('qb-dumpsters:server:rewarditem')
AddEventHandler('qb-dumpsters:server:rewarditem', function(listKey)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = math.random(1, #Config.Items)
    for k,v in pairs(Config.Items) do
        if item == k then
            Player.Functions.AddItem(v, Config.ItemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v], 'add')
        end
    end

    if Config.AddtionalItem then
        local Luck = math.random(1, 8)
        local Odd = math.random(1, 8)
        if Luck == Odd then
            Player.Functions.AddItem(Config.AddItem, Config.AddItemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.AddItem], 'add')
        end
    end
end)

function startTimer(id, object)
    local timer = 10 * 60000

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            TriggerClientEvent('qb-dumpsters:removedumpster', id, object)
        end
    end
end