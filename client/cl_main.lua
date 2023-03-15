ESX = nil
playerData = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	playerData = ESX.GetPlayerData()
end)

local blip = {}

local mainMenu = {}

mainMenu.Base = {

    Header = {"commonmenu", "interaction_bgd"},
    Color = {color_Green},
    HeaderColor = {12, 0, 75},
    Title = 'Blips Builder'
}

mainMenu.Data = {currentMenu = "intéractions"}

mainMenu.Events = {

    onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)

        if btn.name == "Id du ~b~blip" then 

            blip.id = KeyboardInput("Id du blip", "", 4)

            if blip.id == nil then return end

            blip.id = tonumber(blip.id)

        end

        if btn.name == "Couleur du ~b~blip" then 

            blip.color = KeyboardInput("Couleur du blip", "", 2)

            if blip.color == nil then return end

            blip.color = tonumber(blip.color)

        end

        if btn.name == "Nom du ~b~blip" then 

            blip.name = KeyboardInput("Nom du blip", "", 150)

            if blip.name == nil then return end

        end

        if btn.name == "Position du ~b~blip" then 

            blip.pos = GetEntityCoords(PlayerPedId())

        end

        if btn.name == "~g~Valider le blip" then

            if not blip.id or not blip.color or not blip.name or not blip.pos then ESX.ShowNotification("~r~Informations manquantes") return end

            TriggerServerEvent("error:CreateBlip", blip)

            blip = {}

            ESX.ShowNotification("~g~Vous venez de crée le blip")

        end

    end
}

mainMenu.Menu = {

    ['intéractions'] = {

        b = {

            {name = "Id du ~b~blip", ask = "→", askX = true},
            {name = "Couleur du ~b~blip", ask = "→", askX = true},
            {name = "Nom du ~b~blip", ask = "→", askX = true},
            {name = "Position du ~b~blip", ask = "→", askX = true},
            {name = "~g~Valider le blip", ask = "→", askX = true},

        },

    }

}

keyRegister("blips-builder", "Blips Builder", "F4", function()

    ESX.TriggerServerCallback("error:checkPerms", function(cb)

        for k,v in pairs(Config.perms) do 

            if cb == v then 

                CreateMenu(mainMenu)

            end

        end
        
    end)

end)

CreateThread(function()

    local blips = getAllBlips()

    for k,v in pairs(blips) do 

        createBlip(v.name, v.pos.x, v.pos.y, v.pos.z, v.color, v.id)

    end

end)