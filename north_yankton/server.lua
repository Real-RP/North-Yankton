

ESX = nil
local parkedin = true

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('clearNYmoney')

AddEventHandler('clearNYmoney', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.northyanktflyprice then
    xPlayer.removeMoney(Config.northyanktflyprice)
		TriggerClientEvent('flyNY', _source)
	else
		TriggerClientEvent('aintfly', _source)
	end
end)

RegisterServerEvent('clearLSmoney')

AddEventHandler('clearLSmoney', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.lossantosflyprice then
    xPlayer.removeMoney(Config.lossantosflyprice)
		TriggerClientEvent('flyLS', _source)
	else
		TriggerClientEvent('aintfly', _source)
	end
end)

--------------------cars prices for half hours------------------------------

RegisterServerEvent('takekamachomoney')

AddEventHandler('takekamachomoney', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local carchosen = 'kamacho'

	if xPlayer.get('money') >= Config.Kamachonum then
    xPlayer.removeMoney(Config.Kamachonum)
	TriggerClientEvent("setprice", source, carchosen)
	else
		TriggerClientEvent('delete-vehicle', _source)
	end
end)

RegisterServerEvent('takeemperor3money')

AddEventHandler('takeemperor3money', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local carchosen = 'emperor3'

	if xPlayer.get('money') >= Config.Ranchernum then
    xPlayer.removeMoney(Config.Ranchernum)
	TriggerClientEvent("setprice", source, carchosen)
	else
		TriggerClientEvent('delete-vehicle', _source)
	end
end)

RegisterServerEvent('takesadler2money')

AddEventHandler('takesadler2money', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local carchosen = 'sadler2'

	if xPlayer.get('money') >= Config.Vapidnum then
    xPlayer.removeMoney(Config.Vapidnum)
	TriggerClientEvent("setprice", source, carchosen)
	else
		TriggerClientEvent('delete-vehicle', _source)
	end
end)

RegisterServerEvent('takeburrito5money')

AddEventHandler('takeburrito5money', function() --this car is in the ticket to north yankton. clear the '--' to make it possible for setting a price on it.
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	--local carchosen = 'burrito5'

	--if xPlayer.get('money') >= Config.Burritonum then
   -- xPlayer.removeMoney(Config.Burritonum)
   -- TriggerClientEvent("setprice", source, carchosen)
	--else
	--	TriggerClientEvent('delete-vehicle', _source)
--	end
end)

RegisterServerEvent('takeasea2money')

AddEventHandler('takeasea2money', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local carchosen = 'asea2'

	if xPlayer.get('money') >= Config.Aseanum then
    xPlayer.removeMoney(Config.Aseanum)
	TriggerClientEvent("setprice", source, carchosen)
	else
		TriggerClientEvent('delete-vehicle', _source)
	end
end)

RegisterServerEvent('invoice_pay')
AddEventHandler('invoice_pay', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.invoicepay then
    xPlayer.removeMoney(Config.invoicepay)
		TriggerClientEvent('solve_invoice', source)
	else
		TriggerClientEvent('aintfly', _source)
	end
end)

RegisterServerEvent('setdemoprice_300')

AddEventHandler('setdemoprice_300', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('bank') >= Config.pricedemo_300 then
    xPlayer.removeBank(Config.pricedemo_300)
	else
		TriggerClientEvent('no_money', _source)
	end
end)


RegisterServerEvent('setdemoprice_700')

AddEventHandler('setdemoprice_700', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('bank') >= Config.pricedemo_700 then
    xPlayer.removeBank(Config.pricedemo_700)
	else
		TriggerClientEvent('no_money', _source)
	end
end)

RegisterServerEvent('setdemoprice_1200')

AddEventHandler('setdemoprice_1200', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('bank') >= Config.pricedemo_1200 then
    xPlayer.removeBank(Config.pricedemo_1200)
	else
		TriggerClientEvent('no_money', _source)
	end
end)

RegisterServerEvent('get_daily_ticket')

AddEventHandler('get_daily_ticket', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local ticket = xPlayer.getInventoryItem('fly-ticket').count
	
	if ticket >= 1 then
		TriggerClientEvent('fly', _source)
		TriggerClientEvent('closemenu', _source)
	else
		TriggerClientEvent('no-daily-ticket', _source)
	end
end)

RegisterServerEvent('give_ticket')
AddEventHandler('give_ticket', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.get('money') >= Config.ticketprice then
		xPlayer.removeMoney(Config.ticketprice)
		xPlayer.addInventoryItem('fly-ticket', 1)
		TriggerClientEvent('bought_ticket', _source)
		TriggerClientEvent('closemenu', _source)
		
		
	elseif xPlayer.get('bank') >= Config.ticketprice then
		xPlayer.removeBank(Config.ticketprice)
		xPlayer.addInventoryItem('fly-ticket', 1)
		TriggerClientEvent('bought_ticket', _source)
		TriggerClientEvent('closemenu', _source)
		
		
	else
		TriggerClientEvent('no_money_or_bank', _source)
	end
end)

RegisterServerEvent('bug_report')
AddEventHandler('bug_report', function(msg)
	
	print(msg)
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if os.date("%H:%M") == "00:00" then
			TriggerClientEvent("check_ticket", -1)
			print("Daily tickets gets deleted...")
			MySQL.Async.execute("DELETE FROM user_inventory WHERE item = @item", { ['@item'] = "fly-ticket"})
		end
		
		Wait(1500)
	end
end)

RegisterServerEvent('clear_item')
AddEventHandler('clear_item', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local stuff = xPlayer.getInventoryItem(item).count
	
	if stuff >= 1 then
		xPlayer.removeInventoryItem(item, stuff)
	end
end)

RegisterServerEvent('get_job_ticket')

AddEventHandler('get_job_ticket', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
		
		
		for i = 0, #Config.WLjobs do
			if Config.WLjobs[i] == xPlayer.job.name then
				TriggerClientEvent("fly", _source)
				return
			end
		end
		
		TriggerClientEvent("nolegaljob", _source)
		
end)