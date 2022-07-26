fx_version 'cerulean'
games { 'gta5' }

author 'TinoKi'
description 'Weed script'

client_scripts {
	'@es_extended/locale.lua',
	'client.lua',
	'config.lua',
}

server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'server.lua',
	'config.lua',
}

escrow_ignore {
	'script/config.lua'
  }

  lua54 'yes'