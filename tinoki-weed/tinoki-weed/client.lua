local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData              = {}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------- WEEDS ------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local spawnedWeeds = 0
local weedPlants = {}
local isPickingUpWeed, isProcessingWeed = false, false
local isInSellingProgressWeed = false 
local WeedSellBlip1, WeedSellBlip2, WeedSellBlip3, WeedSellBlip4, WeedSellBlip5 = false, false, false, false, false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.Zones.WeedField.coords, true) < 50 then
			SpawnWeedPlants()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		waitTime = 1000
		local coords = GetEntityCoords(PlayerPedId())
		local WeedSellCoords = GetDistanceBetweenCoords(coords, Config.Zones.WeedSell.coords.x, Config.Zones.WeedSell.coords.y, Config.Zones.WeedSell.coords.z, true)
		local WeedSellDelivery_1 = GetDistanceBetweenCoords(coords, Config.Zones.WeedSellPoint_1.coords.x, Config.Zones.WeedSellPoint_1.coords.y, Config.Zones.WeedSellPoint_1.coords.z, true)
		local WeedSellDelivery_2 = GetDistanceBetweenCoords(coords, Config.Zones.WeedSellPoint_2.coords.x, Config.Zones.WeedSellPoint_2.coords.y, Config.Zones.WeedSellPoint_2.coords.z, true)
		local WeedSellDelivery_3 = GetDistanceBetweenCoords(coords, Config.Zones.WeedSellPoint_3.coords.x, Config.Zones.WeedSellPoint_3.coords.y, Config.Zones.WeedSellPoint_3.coords.z, true)
		local WeedSellDelivery_4 = GetDistanceBetweenCoords(coords, Config.Zones.WeedSellPoint_4.coords.x, Config.Zones.WeedSellPoint_4.coords.y, Config.Zones.WeedSellPoint_4.coords.z, true)
		local WeedSellDelivery_5 = GetDistanceBetweenCoords(coords, Config.Zones.WeedSellPoint_5.coords.x, Config.Zones.WeedSellPoint_5.coords.y, Config.Zones.WeedSellPoint_5.coords.z, true)
		
		if WeedSellCoords < 10.0 then
			waitTime = 1
			DrawText3Ds(Config.Zones.WeedSell.coords , Config.Notification4 , 0.4)
			if WeedSellCoords < 2.0 then
				if IsControlJustReleased(0, Keys['E']) then
					if not isInSellingProgressWeed then 
						isInSellingProgressWeed = true
						exports.pNotify:SendNotification({
							text = (Config.Notification6), 
							type = "success", 
							timeout = math.random(3500, 4000), 
							layout = "centerLeft", 
							queue = "left"
						})
						Wait(2500)
						exports.pNotify:SendNotification({
							text = (Config.Notification7), 
							type = "success", 
							timeout = math.random(2500, 3000), 
							layout = "centerLeft", 
							queue = "left"
						})
						WeedSellBlip1 = true 
						blip = AddBlipForCoord(Config.Zones.WeedSellPoint_1.coords)
						SetBlipRoute(blip , true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(Config.BlipName_1)
						EndTextCommandSetBlipName(blip)
					else 
						exports.pNotify:SendNotification({
							text = (Config.Notification5), 
							type = "success", 
							timeout = math.random(3500, 4000), 
							layout = "centerLeft", 
							queue = "left"
						})
					end 
				end 
			end 
		end
		
		if isInSellingProgressWeed then 
			if WeedSellBlip1 then 
				if WeedSellDelivery_1 < 10.0 then 
					waitTime = 1 
					DrawText3Ds(Config.Zones.WeedSellPoint_1.coords , Config.Notification8 , 0.4)
					if WeedSellDelivery_1 < 2.0 then 
						if IsControlJustReleased(0, Keys['E']) then
							SellingWeed()
							RemoveBlip(blip)
							WeedSellBlip1 = false 
							WeedSellBlip2 = true 
							blip = AddBlipForCoord(Config.Zones.WeedSellPoint_2.coords)
							SetBlipRoute(blip , true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(Config.BlipName_2)
							EndTextCommandSetBlipName(blip)
							exports.pNotify:SendNotification({
								text = (Config.Notification10), 
								type = "success", 
								timeout = math.random(3500, 4000), 
								layout = "centerLeft", 
								queue = "left"
							})
						end
					end 
				end 
			elseif WeedSellBlip2 then 
				if WeedSellDelivery_2 < 10.0 then 
					waitTime = 1 
					DrawText3Ds(Config.Zones.WeedSellPoint_2.coords , Config.Notification8 , 0.4)
					if WeedSellDelivery_2 < 2.0 then 
						if IsControlJustReleased(0, Keys['E']) then
							SellingWeed()
							RemoveBlip(blip)
							WeedSellBlip2 = false 
							WeedSellBlip3 = true 
							blip = AddBlipForCoord(Config.Zones.WeedSellPoint_3.coords)
							SetBlipRoute(blip , true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(Config.BlipName_3)
							EndTextCommandSetBlipName(blip)
							exports.pNotify:SendNotification({
								text = (Config.Notification10), 
								type = "success", 
								timeout = math.random(3500, 4000), 
								layout = "centerLeft", 
								queue = "left"
							})
						end
					end 
				end 
			elseif WeedSellBlip3 then 
				if WeedSellDelivery_3 < 10.0 then 
					waitTime = 1 
					DrawText3Ds(Config.Zones.WeedSellPoint_3.coords , Config.Notification8 , 0.4)
					if WeedSellDelivery_3 < 2.0 then 
						if IsControlJustReleased(0, Keys['E']) then
							SellingWeed()
							RemoveBlip(blip)
							WeedSellBlip3 = false 
							WeedSellBlip4 = true 
							blip = AddBlipForCoord(Config.Zones.WeedSellPoint_4.coords)
							SetBlipRoute(blip , true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(Config.BlipName_4)
							EndTextCommandSetBlipName(blip)
							exports.pNotify:SendNotification({
								text = (Config.Notification10), 
								type = "success", 
								timeout = math.random(3500, 4000), 
								layout = "centerLeft", 
								queue = "left"
							})
						end
					end 
				end 
			elseif WeedSellBlip4 then 
				if WeedSellDelivery_4 < 10.0 then 
					waitTime = 1 
					DrawText3Ds(Config.Zones.WeedSellPoint_4.coords , Config.Notification8 , 0.4)
					if WeedSellDelivery_4 < 2.0 then 
						if IsControlJustReleased(0, Keys['E']) then
							SellingWeed()
							RemoveBlip(blip)
							WeedSellBlip4 = false 
							WeedSellBlip5 = true 
							blip = AddBlipForCoord(Config.Zones.WeedSellPoint_5.coords)
							SetBlipRoute(blip , true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(Config.BlipName_5)
							EndTextCommandSetBlipName(blip)
							exports.pNotify:SendNotification({
								text = (Config.Notification10), 
								type = "success", 
								timeout = math.random(3500, 4000), 
								layout = "centerLeft", 
								queue = "left"
							})
						end
					end 
				end 
			elseif WeedSellBlip5 then 
				if WeedSellDelivery_5 < 10.0 then 
					waitTime = 1 
					DrawText3Ds(Config.Zones.WeedSellPoint_5.coords , Config.Notification8 , 0.4)
					if WeedSellDelivery_5 < 2.0 then 
						if IsControlJustReleased(0, Keys['E']) then
							SellingWeed()
							RemoveBlip(blip)
							WeedSellBlip5 = false 
							isInSellingProgressWeed = false 
							exports.pNotify:SendNotification({
								text = (Config.Notification9), 
								type = "success", 
								timeout = math.random(3500, 4000), 
								layout = "centerLeft", 
								queue = "left"
							})
						end
					end 
				end 
			end 
		end 
		Citizen.Wait(waitTime)
	end
end)

RegisterNetEvent('tinoki-weed:harvest')
AddEventHandler('tinoki-weed:harvest', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObjectWeed, nearbyIDWeed
	
	for i=1, #weedPlants, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(weedPlants[i]), false) < Config.DistancePlayerToPlant then
			nearbyObjectWeed, nearbyIDWeed = weedPlants[i], i
		end
	end
		
	if nearbyObjectWeed and IsPedOnFoot(playerPed) then
		if not isPickingUp and not isBusy then
			isBusy = true 
			isPickingUp = true
			exports.rprogress:Custom({
				Duration = (Config.HarvestTime),
				Label = (Config.Notification13),
				Animation = {
					scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
					animationDictionary = "", -- https://alexguirre.github.io/animations-list/
				},
				DisableControls = {
					Mouse = false,
					Player = true,
					Vehicle = true
				}
			})
			Citizen.Wait(Config.HarvestTime)
			ClearPedTasks(playerPed)
			Citizen.Wait(1500)
			ESX.Game.DeleteObject(nearbyObjectWeed)
			table.remove(weedPlants, nearbyIDWeed)
			spawnedWeeds = spawnedWeeds - 1
			TriggerServerEvent('tinoki-weed:harvestCannabis')
			FreezeEntityPosition(PlayerPedId() , false )
	
			isPickingUp = false
			isBusy = false
		end
	else 
		exports.pNotify:SendNotification({
			text = (Config.Notification1), 
			type = "success", 
			timeout = math.random(3500, 4000), 
			layout = "centerLeft", 
			queue = "left"
		})
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(weedPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnWeedPlants()
	while spawnedWeeds < Config.TotalPlantInArea do
		Citizen.Wait(0)
		local weedCoords = GenerateWeedCoords()

		ESX.Game.SpawnLocalObject('prop_weed_02', weedCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(weedPlants, obj)
			spawnedWeeds = spawnedWeeds + 1
		end)
	end
end

function ValidateWeedCoord(plantCoord)
	if spawnedWeeds > 0 then
		local validate = true

		for k, v in pairs(weedPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.Zones.WeedField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateWeedCoords()
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-90, 90)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-90, 90)

		weedCoordX = Config.Zones.WeedField.coords.x + modX
		weedCoordY = Config.Zones.WeedField.coords.y + modY

		local coordZ = GetCoordZ(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateWeedCoord(coord) then
			return coord
		end
	end
end


function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end

RegisterNetEvent('tinoki-weed:pack')
AddEventHandler('tinoki-weed:pack', function()
	ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tinoki-weed_pack',
        {
            title    = 'Weed - Packing',
            align    = 'top-right',
            elements = { 
                { label = 'Pack Weed - 5 Weed/Pack', value = '1' },
            }
        },
    function(data, menu)
        local value = data.current.value

        if value == '1' then
			ESX.UI.Menu.CloseAll()
			TriggerServerEvent("tinoki-weed:pack", 1)
		end
    end,
    function(data, menu)
        menu.close()
    end)
end)

RegisterNetEvent('tinoki-weed:packing')
AddEventHandler('tinoki-weed:packing', function()
	exports.rprogress:Custom({
		Duration = (Config.PackingTime),
		Label = (Config.Notification14),
		Animation = {
			scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
			animationDictionary = "", -- https://alexguirre.github.io/animations-list/
		},
		DisableControls = {
			Mouse = false,
			Player = true,
			Vehicle = true
		}
	})
	Citizen.Wait(Config.PackingTime)
	ClearPedTasks(PlayerPedId())
end)

---------------------------------------------
-------------- SELLING PARTS ----------------
---------------------------------------------
DrawText3Ds = function(coords, text, scale)
	local x,y,z = coords.x, coords.y, coords.z
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

	local factor = (string.len(text)) / 370

	DrawRect(_x, _y + 0.0140, 0.030 + factor, 0.025, 0, 0, 0, 100)
end

function SellingWeed()
	if not isBusy then 
		isBusy = true 
		exports.rprogress:Custom({
			Duration = (Config.SellingTime),
			Label = (Config.Notification15),
			Animation = {
				scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
				animationDictionary = "", -- https://alexguirre.github.io/animations-list/
			},
			DisableControls = {
				Mouse = false,
				Player = true,
				Vehicle = true
			}
		})
		Citizen.Wait(Config.SellingTime)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent("tinoki-weed:sellWeed")
		FreezeEntityPosition(PlayerPedId() , false )
		isBusy = false
	end
end

RegisterCommand("stopsell", function()
	isBusy = false
	RemoveBlip(blip)
	isInSellingProgressWeed, WeedSellBlip1, WeedSellBlip2, WeedSellBlip3, WeedSellBlip4, WeedSellBlip5 = false, false, false, false, false, false
	exports.pNotify:SendNotification({
		text = (Config.Notification12), 
		type = "success", 
		timeout = math.random(3500, 4000), 
		layout = "centerLeft", 
		queue = "left"
	})
end)