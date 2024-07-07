fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
game 'gta5'

lua54 'yes'

name 'yoda_oxyruns'
author 'YodaThings'
version '1.0.0'

shared_script {
    '@ox_lib/init.lua',
}

client_scripts {
    'config.lua',
    'client/client.lua',
    'client/cl_buyers.lua',
}

server_script {
    'config.lua',
    'server/server.lua',
}
