fx_version 'cerulean'
games { 'gta5' }

client_scripts {'client.lua'}

server_scripts  {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server.lua',
}