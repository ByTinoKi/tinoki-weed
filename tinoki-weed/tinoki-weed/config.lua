Config = {}

Config.Zones = {
	WeedField = {coords = vector3(3368.3132,5463.4199,17.4387), radius = 50.0}, -- Coordinate for Weed Plant to Spawn within Radius,
	WeedSell = {coords = vector3(244.699996,374.500000,105.699996), radius = 0.0}, -- Coordinate for Weed Selling
	WeedSellPoint_1 = {coords = vector3(320.600006,-1759.500000,29.300000), radius = 0.0}, -- Coordinate for Weed Selling Delivery 1
	WeedSellPoint_2 = {coords = vector3(-716.299988,-864.299988,23.200000), radius = 0.0}, -- Coordinate for Weed Selling Delivery 2
	WeedSellPoint_3 = {coords = vector3(-1223.800048,-711.299988,22.400000), radius = 0.0}, -- Coordinate for Weed Selling Delivery 3
	WeedSellPoint_4 = {coords = vector3(-1356.800048,-211.199996,43.700000), radius = 0.0}, -- Coordinate for Weed Selling Delivery 4
	WeedSellPoint_5 = {coords = vector3(-1308.900024,448.899994,100.599998), radius = 0.0}, -- Coordinate for Weed Selling Delivery 5
}

Config.TotalPlantInArea = 25 -- How many Plants to spawn in the radius area.
Config.DistancePlayerToPlant = 1 -- How far player from the plant to be able to harvest.
Config.HarvestTime = 5000 -- Time in ms 1000 = 1 second
Config.PackingTime = 5000 -- Time in ms 1000 = 1 second
Config.SellingTime = 5000 -- Time in ms 1000 = 1 second
Config.MaxWeed = 100 -- Max Weed on inventory

Config.WeedFromHarvest = 3 -- How many Weed per harvest 
Config.WeedToPack = 5 -- How many Weed per pack
Config.MinWeedSell = 2 -- Minimum Weed to randomise sell, Value must be lower than MaxWeedSell
Config.MaxWeedSell = 3 -- Maximum Weed to randomise sell, Value must be higher than MinWeedSell

Config.UseBlackMoney = false -- Set to true for Black Money, false for Normal Money
Config.WeedPrice = 100 -- Price per Weed

Config.BlipName_1 = "Weed Delivery 1" -- Name on the Map
Config.BlipName_2 = "Weed Delivery 2" -- Name on the Map
Config.BlipName_3 = "Weed Delivery 3" -- Name on the Map
Config.BlipName_4 = "Weed Delivery 4" -- Name on the Map
Config.BlipName_5 = "Weed Delivery 5" -- Name on the Map

--Notifications
Config.Notification1 = "No plant nearby!" 
Config.Notification2 = "You dont have enough space to carry more this item!" 
Config.Notification3 = "You dont have enough Weed, you need 5 to make a Pack of Weed!" 
Config.Notification4 = "[E] Start weed run"
Config.Notification5 = "You already start the progress, go to the delivery area to Sell the Weed!"

Config.Notification6 = "You start the selling progress, go to the delivery area to Sell the Weed!"
Config.Notification7 = "Use command /stopsell to Stop the Selling Progress."
Config.Notification8 = "[E]Deliver Weed"
Config.Notification9 = "You successfuly delivered all the Weed! Congrats!"
Config.Notification10 = "You successfuly delivered the Weed, go to the next Destination!"

Config.Notification11 = "You dont have enough Weed to Sell!"
Config.Notification12 = "You stop the Weed Delivery progress." 
Config.Notification13 = "Cutting plant..."
Config.Notification14 = "Packing weed..."
Config.Notification15 = "Deliver weed..."