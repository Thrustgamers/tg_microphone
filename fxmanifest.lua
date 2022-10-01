fx_version 'adamant'
game 'gta5'
lua54 'yes'
description 'Microphone script for esx using ox_lib'
author 'Thrustgamers#5626'

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