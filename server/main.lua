local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("weaponanim", "Weapon Animation Menu", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        TriggerClientEvent('qb-weaponanim:menu', src)
    end
end)