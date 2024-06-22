local QBCore = exports['qb-core']:GetCoreObject()
local AimAnim = nil

RegisterNetEvent("qb-weaponanim:menu", function()
    local dialog = exports['qb-input']:ShowInput({
        header = "Weapon Animation",
        submitText = "Done",
        inputs = {
            {
                text = "Animation",
                name = "anim",
                type = "select",
                options = {
                    { value = "nil", text = "🛡️ Default" },
                    { value = "gangster", text = "🥷 Gangster"},
                    { value = "hillbilly", text = "🤠 Hill Billy"},
                },
            },
        }
    })

    if dialog ~= nil then
        AimAnim = tostring(dialog.anim)
    end
end)

CreateThread(function()
    while true do
        Player = PlayerPedId(), DecorGetInt(PlayerPedId())
        ped = PlayerPedId()
        if AimAnim == "gangster" then
            if CheckWeapon2(ped) then
                inVeh = IsPedInVehicle(PlayerPedId(-1), GetVehiclePedIsIn(PlayerPedId(-1), false), false)
                local _, hash = GetCurrentPedWeapon(Player, 1)
                if not inVeh then
                    loadAnimDict("combat@aim_variations@1h@gang")
                    if IsPlayerFreeAiming(PlayerId()) or (IsControlPressed(0, 24) and GetAmmoInClip(Player, hash) > 0) then
                        if not IsEntityPlayingAnim(Player, "combat@aim_variations@1h@gang", "aim_variation_a", 3) then
                            TaskPlayAnim(Player, "combat@aim_variations@1h@gang", "aim_variation_a", 8.0, -8.0, -1, 49, 0, 0, 0, 0)
                            SetEnableHandcuffs(Player, true)
                        end
                    elseif IsEntityPlayingAnim(Player, "combat@aim_variations@1h@gang", "aim_variation_a", 3) then
                        ClearPedTasks(Player)
                        SetEnableHandcuffs(Player, false)
                    end
                    Citizen.Wait(50)
                end
                Citizen.Wait(50)
            end
        elseif AimAnim == "hillbilly" then
            if CheckWeapon2(ped) then
                inVeh = IsPedInVehicle(PlayerPedId(-1), GetVehiclePedIsIn(PlayerPedId(-1), false), false)
                local _, hash = GetCurrentPedWeapon(Player, 1)
                if not inVeh then
                    loadAnimDict("combat@aim_variations@1h@hillbilly")
                    if IsPlayerFreeAiming(PlayerId()) or (IsControlPressed(0, 24) and GetAmmoInClip(Player, hash) > 0) then
                        if not IsEntityPlayingAnim(Player, "combat@aim_variations@1h@hillbilly", "aim_variation_a", 3) then
                            TaskPlayAnim(Player, "combat@aim_variations@1h@hillbilly", "aim_variation_a", 8.0, -8.0, -1, 49, 0, 0, 0, 0)
                            SetEnableHandcuffs(Player, true)
                        end
                    elseif IsEntityPlayingAnim(Player, "combat@aim_variations@1h@hillbilly", "aim_variation_a", 3) then
                        ClearPedTasks(Player)
                        SetEnableHandcuffs(Player, false)
                    end
                    Citizen.Wait(50)
                end
                Citizen.Wait(50)
            end
        end
        Citizen.Wait(80)
    end
end)

CreateThread(function()
    while true do
        if blocked then
            DisableControlAction(1, 25, true)
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            DisableControlAction(1, 23, true)
            DisablePlayerFiring(ped, true)
        end
        Citizen.Wait(100)
    end
end)

function CheckWeapon(ped)
    if IsEntityDead(ped) then
        blocked = false
        return false
    else
        for i = 1, #Config.DrawingWeapons do
            if GetHashKey(Config.DrawingWeapons[i]) == GetSelectedPedWeapon(ped) then
                return true
            end
        end
        return false
    end
end

function CheckWeapon2(ped)
    if IsEntityDead(ped) then
        blocked = false
        return false
    else
        for i = 1, #Config.AimWeapons do
            if GetHashKey(Config.AimWeapons[i]) == GetSelectedPedWeapon(ped) then
                return true
            end
        end
        return false
    end
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(50)
    end
end
