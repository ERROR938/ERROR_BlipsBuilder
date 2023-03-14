function createBlip(name, x, y, z, color, id)

    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite (blip, id)
    SetBlipScale  (blip, 0.8)
    SetBlipDisplay(blip, 4)
    SetBlipColour (blip, color)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)

    return blip

end

function keyRegister(openname, name, key, action)
    RegisterKeyMapping(openname, name, 'keyboard', key)
    RegisterCommand(openname, function()
        if (action ~= nil) then
            action();
        end
    end, false)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        if result == "" then
            return
        end
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end

end

function getAllBlips()

    local all_blips = {}

    ESX.TriggerServerCallback("error:getAllBlips", function(blips)

        print(json.encode(blips))

        if blips then all_blips = blips end
        
    end)

    Wait(389)

    return all_blips

end