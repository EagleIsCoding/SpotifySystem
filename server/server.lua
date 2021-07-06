ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

ESX.RegisterServerCallback('SpotifySystem:GetMusic', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ShowPlayerMusic = {}
    MySQL.Async.fetchAll('SELECT * FROM spotify_system WHERE (owner = @owner)', {
        ['@owner'] = xPlayer.identifier
    }, function(result)
        for i = 1, #result, 1 do
            table.insert(ShowPlayerMusic, {
                id = result[i].id,
                owner = result[i].owner,
                name = result[i].name,
                url = result[i].url
            })
        end
    cb(ShowPlayerMusic)
    end)
end)

RegisterServerEvent("SpotifySystem:AddMusic")
AddEventHandler("SpotifySystem:AddMusic", function(name, music)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.execute('INSERT INTO spotify_system (owner, name, url) VALUES (@owner, @name, @url)',
	{
		['@owner'] = xPlayer.identifier,
        ['@name'] = name,
		['@url'] = music
	}, function (rowsChanged)
		TriggerClientEvent('esx:showNotification', _source, "~b~"..name.."~s~ à été ajouté sur Spotify.")
	end)	
end)