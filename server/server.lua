ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("error:checkPerms", function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)

    cb(xPlayer.getGroup())

end)

RegisterNetEvent("error:CreateBlip", function(blip)

    local file = json.decode(LoadResourceFile(GetCurrentResourceName(), "config.json"))

    if not file then file = {} end

    if not file[blip.name] then file[blip.name] = blip end

    SaveResourceFile(GetCurrentResourceName(), "config.json", json.encode(file), -1)

end)

ESX.RegisterServerCallback("error:getAllBlips", function(source, cb)

    cb(json.decode(LoadResourceFile(GetCurrentResourceName(), "config.json")))

end)