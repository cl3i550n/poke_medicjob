local T = Translation.Langs[Config.Lang]

Citizen.CreateThread(function()
    WarMenu.CreateMenu('medic', T.medicMenu)
    WarMenu.SetSubTitle('medic', T.selectOption)
    WarMenu.CreateSubMenu('options', 'medic', T.selectOption)
    WarMenu.CreateSubMenu('horse_options', 'medic', T.selectOption)
    WarMenu.CreateMenu('medic_house', T.medicMenu)
    WarMenu.CreateSubMenu('options_house', 'medic_house', T.selectOption)
    WarMenu.CreateSubMenu('clothes_options', 'medic_house', T.selectOption)

    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(PlayerPedId(), true)
        for k, v in pairs(Config.MedicLocations) do
            local distance = GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, false)
            if distance <= 1.5 then
                DrawTxt(T.pressTo, 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, false)
                if IsControlJustReleased(0, Config.KeyOpenMedicCabinet) then
                    TriggerServerEvent('poke_medic:getjob', 'medic_house')
                end
            end
        end
        if WarMenu.IsMenuOpened('medic') then
            if WarMenu.MenuButton(T.medicOptions, 'options') then
            elseif WarMenu.MenuButton(T.horseOptions, 'horse_options') then
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('options') then
            if WarMenu.Button(T.revivePlayer) then
                local closestPlayer, closestDistance = GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 3.0 then
                    TriggerEvent("vorp:TipBottom", T.noNearbyPlayers, 3000)
                else
                    RevivePlayer(closestPlayer)
                end
            elseif WarMenu.Button(T.healPlayer) then
                local closestPlayer, closestDistance = GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 3.0 then
                    TriggerEvent("vorp:TipBottom", T.noNearbyPlayers, 3000)
                else
                    HealPlayer(closestPlayer)
                end
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('medic_house') then
            if WarMenu.MenuButton(T.medicOptions, 'options_house') then
            elseif WarMenu.MenuButton(T.changeClothes, 'clothes_options') then
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('horse_options') then
            if WarMenu.Button(T.spawnHorse) then
                SpawnHorse()
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('options_house') then
            if WarMenu.Button(T.takeItems) then
                TriggerServerEvent('poke_medic:takeItems')
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('clothes_options') then
            if WarMenu.Button(T.civilClothes) then
                TriggerServerEvent("vorpcharacter:getPlayerSkin")
            elseif WarMenu.Button(T.doctorMale) then
                ChangeClothes(GetHashKey("CS_SDDoctor_01"))
            elseif WarMenu.Button(T.doctorFemale) then
                ChangeClothes(GetHashKey("MSP_MARY1_FEMALES_01"))
            end
            WarMenu.Display()
        elseif IsControlJustReleased(0, Config.KeyCloseMedicCabinet) then
            TriggerServerEvent('poke_medic:getjob', 'medic')
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('poke_medic:auth')
AddEventHandler('poke_medic:auth', function(type)
    WarMenu.OpenMenu(type)
end)

RegisterNetEvent('poke_medic:revive')
AddEventHandler('poke_medic:revive', function(closestPlayer)
    DoScreenFadeOut(800)

    while not IsScreenFadedOut() do
        Citizen.Wait(50)
    end

    Citizen.Wait(1200)
    TriggerEvent('vorp:resurrectPlayer', closestPlayer)
    DoScreenFadeIn(800)
end)

RegisterNetEvent('poke_medic:heal')
AddEventHandler('poke_medic:heal', function(closestPlayer)
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    local health = GetAttributeCoreValue(closestPlayerPed, 0)
    local newHealth = health + 50
    local stamina = GetAttributeCoreValue(closestPlayerPed, 1)
    local newStamina = stamina + 50
    local health2 = GetEntityHealth(closestPlayerPed)
    local newHealth2 = health2 + 50
    Citizen.InvokeNative(0xC6258F41D86676E0, closestPlayerPed, 0, newHealth)  --core
    Citizen.InvokeNative(0xC6258F41D86676E0, closestPlayerPed, 1, newStamina) --core
    SetEntityHealth(closestPlayerPed, newHealth2)
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.MedicLocations) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.x, v.y, v.z)
        SetBlipSprite(blip, -695368421, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, T.mapBlip)
    end
end)
