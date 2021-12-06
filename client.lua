local QBCore = exports['qb-core']:GetCoreObject()

local searched = {3423423424}
local canSearch = true
local dumpsters = {218085040, 666561306, -58485588, -206690185, 1511880420, 682791951}
local searchTime = 14000

CreateThread(function(time)
    while true do
        Wait(0)
        if canSearch then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local dumpsterFound = false

            for i = 1, #dumpsters do
                local dumpster = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, dumpsters[i], false, false, false)
                local dumpPos = GetEntityCoords(dumpster)
                local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, dumpPos.x, dumpPos.y, dumpPos.z, true)
                local playerPed = PlayerPedId()
                if dist < 1.8 then
                    QBCore.Functions.DrawText3D(dumpPos.x, dumpPos.y, dumpPos.z + 1.0, 'Press [~g~E~w~] to search the Trash Bin')
                    if IsControlJustReleased(0, 54) then
                        for i = 1, #searched do
                            if searched[i] == dumpster then
                                dumpsterFound = true
                            end
                            if i == #searched and dumpsterFound then
                                QBCore.Functions.Notify('This Trash Bin has already been searched', 'error')
                            elseif i == #searched and not dumpsterFound then
                                canSearch = false
                                QBCore.Functions.Progressbar('searching_dumpster', "Searching Dumpster...", math.random(10000,15000), false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "amb@prop_human_bum_bin@base",
                                    anim = 'base'
                                }, {}, {}, function()
                                    TriggerServerEvent('qb-dumpsters:startdumpsterTimer', dumpster)
                                    table.insert(searched, dumpster)
                                    TriggerServerEvent('qb-dumpsters:server:rewarditem')
                                    ClearPedTasks(ped)
                                    canSearch = true
                                end, function()
                                    QBCore.Functions.Notify('You stopped searching the dumpster...', 'error')
                                    canSearch = true
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('qb-dumpsters:removedumpster')
AddEventHandler('qb-dumpsters:removedumpster', function(object)
    for i = 1, #searched do
        if searched[i] == object then
            table.remove(searched, i)
        end
    end
end)