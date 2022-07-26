ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('scissors', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('disc:close' , source)
	TriggerClientEvent('tinoki-weed:harvest', source)
end)

ESX.RegisterUsableItem('zip_bag', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('disc:close' , source)
	TriggerClientEvent('tinoki-weed:pack', source)
end)

RegisterServerEvent('tinoki-weed:harvestCannabis')
AddEventHandler('tinoki-weed:harvestCannabis', function()
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local xItem = xPlayer.getInventoryItem('item_weed').count	
	
	if xItem < Config.MaxWeed then
		xPlayer.addInventoryItem('item_weed', Config.WeedFromHarvest)
	else
		TriggerClientEvent("pNotify:SendNotification", source, {text = (Config.Notification2), timeout = 5000})
	end
end)

RegisterServerEvent('tinoki-weed:pack')
AddEventHandler('tinoki-weed:pack', function(stats)
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
		
	if stats == 1 then 
		local xWeed = xPlayer.getInventoryItem('item_weed').count
		if xWeed >= Config.WeedToPack then
			xPlayer.removeInventoryItem('zip_bag', 1)
			xPlayer.removeInventoryItem('item_weed', Config.WeedToPack)
			TriggerClientEvent('tinoki-weed:packing', src)
			Citizen.Wait(Config.PackingTime)
			xPlayer.addInventoryItem('packed_weed', 1)
		else
			TriggerClientEvent("pNotify:SendNotification", source, {text = (Config.Notification3), timeout = 5000})
		end
	end
end)

RegisterServerEvent('tinoki-weed:sellWeed')
AddEventHandler('tinoki-weed:sellWeed', function()
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local weedAmount = math.random(Config.MinWeedSell, Config.MaxWeedSell)
	
	local xWeed = xPlayer.getInventoryItem('packed_weed').count
	if xWeed > weedAmount then 
		xPlayer.removeInventoryItem("packed_weed", weedAmount)
		if Config.UseBlackMoney then 
			xPlayer.addAccountMoney('black_money', Config.WeedPrice * weedAmount)
		else
			xPlayer.addMoney(Config.WeedPrice * weedAmount)
		end
	else 
		TriggerClientEvent("pNotify:SendNotification", source, {text = (Config.Notification11), timeout = 5000})
	end 
end)