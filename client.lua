local QBCore = exports['qb-core']:GetCoreObject()

local searched = {3423423424}
local canSearch = true

CreateThread(function()
    if Config.UseTarget then
        exports['qb-target']:AddTargetModel(Config.Dumpsters, {
            options = {
                {
                    type = "client",
                    icon = "fas fa-dumpster",
                    event = "qb-dumpsters:client:targetDumpster",
                    label = Config.Language.dumplabel,
                    targeticon = "fas fa-magnifying-glass",
                }
            },
            distance = 1.5,
        })
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dumpsterFound = false

        for i = 1, #Config.Dumpsters do
            local dumpster = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, GetHashKey(Config.Dumpsters[i]), false, false, false)
            local dumpPos = GetEntityCoords(dumpster)
            local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, dumpPos.x, dumpPos.y, dumpPos.z, true)
            local playerPed = PlayerPedId()
            if dist < 1.8 and canSearch then
                sleep = 3
                if not Config.UseTarget then
                    QBCore.Functions.DrawText3D(dumpPos.x, dumpPos.y, dumpPos.z + 1.0, Config.Language.search)
                    if IsControlJustReleased(0, 54) then
                        for i = 1, #searched do
                            if searched[i] == dumpster then
                                dumpsterFound = true
                            end

                            if i == #searched and dumpsterFound then
                                QBCore.Functions.Notify(Config.Language.alreadysearched, 'error', 3000)
                            elseif i == #searched and not dumpsterFound then
                                canSearch = false
                                QBCore.Functions.Progressbar('searching_dumpster', Config.Language.searching, (Config.SearchTime * 1000), false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "amb@prop_human_bum_bin@base",
                                    anim = 'base'
                                }, {}, {}, function()
                                    canSearch = true
                                    table.insert(searched, dumpster)
                                    TriggerServerEvent('qb-dumpsters:server:rewarditem', dumpster)
                                    ClearPedTasks(ped)
                                end, function()
                                    canSearch = true
                                    QBCore.Functions.Notify(Config.Language.stopsearch, 'error', 3000)
                                    ClearPedTasks(ped)
                                end)
                            end
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('qb-dumpsters:client:targetDumpster', function()
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    local dumpsterFound = false

    for i = 1, #Config.Dumpsters do
        local dumpster = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, GetHashKey(Config.Dumpsters[i]), false, false, false)
        local dumpPos = GetEntityCoords(dumpster)
        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, dumpPos.x, dumpPos.y, dumpPos.z, true)

        if dist < 1.8 and canSearch then
            for i = 1, #searched do
                if searched[i] == dumpster then
                    dumpsterFound = true
                end

                if i == #searched and dumpsterFound then
                    QBCore.Functions.Notify(Config.Language.alreadysearched, 'error', 3000)
                elseif i == #searched and not dumpsterFound then
                    canSearch = false
                    QBCore.Functions.Progressbar('searching_dumpster', Config.Language.searching, (Config.SearchTime * 1000), false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = "amb@prop_human_bum_bin@base",
                        anim = 'base'
                    }, {}, {}, function()
                        TriggerServerEvent('qb-dumpsters:server:rewarditem', dumpster)
                        canSearch = true
                        table.insert(searched, dumpster)
                        ClearPedTasks(ped)
                    end, function()
                        canSearch = true
                        QBCore.Functions.Notify(Config.Language.stopsearch, 'error', 3000)
                        ClearPedTasks(ped)
                    end)
                end
            end
        end
    end
end)

RegisterNetEvent('qb-dumpsters:client:removedumpster', function(object)
    for i = 1, #searched do
        if searched[i] == object then
            table.remove(searched, i)
        end
    end
end)