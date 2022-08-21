local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-dumpsters:server:rewarditem', function(dumpster)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local rItem = math.random(1, #Config.Items)
    local addItem = math.random(1, #Config.AdditionalItems)

    for _,item in pairs(Config.Items) do
        if _ == rItem then
            local itemReward = item
            print("rewarding random item", json.encode(itemReward))
            Player.Functions.AddItem(itemReward.item, itemReward.amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemReward.item], 'add')
        end
    end

    if Config.AddtionalItem then
        for _,items in pairs(Config.AdditionalItems) do
            if _ == addItem then
                local addItemReward = items
                print("additional item reward", json.encode(addItemReward))
                Player.Functions.AddItem(addItemReward.item, addItemReward.amount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[addItemReward.item], 'add')
            end
        end
    end

    startTimer(src, dumpster)
end)

function startTimer(id, object)
    local timer = 10 * 60000

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            TriggerClientEvent('qb-dumpsters:client:removedumpster', id, object)
        end
    end
end