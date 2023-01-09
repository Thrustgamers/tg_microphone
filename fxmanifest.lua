fx_version 'adamant'
game 'gta5'
lua54 'yes'
description 'Microphone script using ox_lib'
author 'Thrustgamers#5626'
version '1.1.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
	'client.lua',
    'config.lua'
}

dependencies {
	'ox_lib',
}