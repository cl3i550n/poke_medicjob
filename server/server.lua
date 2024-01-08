local T = Translation.Langs[Config.Lang]

VORPCore = {}
TriggerEvent("getCore", function(core)
    VORPCore = core
end)

local Inventory = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent('poke_medic:getjob')
AddEventHandler('poke_medic:getjob', function(type)
    local _source = source
    local user = VORPCore.getUser(_source)
    local character = user.getUsedCharacter

    if character.job == Config.Job then
        TriggerClientEvent('poke_medic:auth', _source, type)
    else
        VORPCore.NotifyRightTip(_source, T.doNotPermission, 3000)
    end
end)

RegisterServerEvent('poke_medic:revivePlayer')
AddEventHandler('poke_medic:revivePlayer', function(closestPlayer)
    local _source = source

    for _, item in pairs(Config.itemsForRevivePlayer) do
        local itemCount = Inventory.getItemCount(_source, item.item)

        if itemCount >= item.amount then
            Inventory.subItem(_source, item.item, item.amount)
            TriggerClientEvent('poke_medic:revive', closestPlayer)
        else
            VORPCore.NotifyRightTip(_source, T.doNotHave .. " " .. item.label, 3000)
        end
    end
end)

RegisterServerEvent('poke_medic:healPlayer')
AddEventHandler('poke_medic:healPlayer', function(closestPlayer)
    local _source = source

    for _, item in pairs(Config.itemsForHealPlayer) do
        local itemCount = Inventory.getItemCount(_source, item.item)

        if itemCount >= item.amount then
            Inventory.subItem(_source, item.item, item.amount)
            TriggerClientEvent('poke_medic:heal', closestPlayer)
        else
            VORPCore.NotifyRightTip(_source, T.doNotHave .. " " .. item.label, 3000)
        end
    end
end)

RegisterServerEvent('poke_medic:takeItems')
AddEventHandler('poke_medic:takeItems', function()
    local _source = source
    local totalItemsToAdd = 0

    for _, itemConfig in pairs(Config.itemsForMedic) do
        totalItemsToAdd = totalItemsToAdd + itemConfig.givAmount
    end

    if not Inventory.canCarryItems(_source, totalItemsToAdd) then
        return VORPCore.NotifyRightTip(_source, T.invFullItems, 30000)
    end

    for _, itemConfig in pairs(Config.itemsForMedic) do
        if not Inventory.canCarryItem(_source, itemConfig.item, itemConfig.givAmount) then
            return VORPCore.NotifyRightTip(_source, T.itemsFull .. " " .. itemConfig.label, 30000)
        end
        Inventory.addItem(_source, itemConfig.item, itemConfig.givAmount)
    end
end)
