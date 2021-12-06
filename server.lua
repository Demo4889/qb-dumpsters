local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-dumpsters:startdumpsterTimer')
AddEventHandler('qb-dumpsters:startdumpsterTimer', function(dumpster)
    startTimer(source, dumpster)
end)

RegisterServerEvent('qb-dumpsters:server:rewarditem')
AddEventHandler('qb-dumpsters:server:rewarditem', function(listKey)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    for i = 1, #Config.Items, 1 do
        local item = Config.Items[math.random(1, #Config.Items)]
        Player.Functions.AddItem(item, math.random(3, 5))
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
    end
    local Luck = math.random(1, 8)
    local Odd = math.random(1, 8)
    if Luck == Odd then
        local random = math.random(1, 3)
        Player.Functions.AddItem("rubber", random)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["rubber"], 'add')
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