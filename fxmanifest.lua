fx_version('cerulean')
games({ 'gta5' })

shared_script 'config.lua'

server_scripts({

    "server/server.lua"

});

client_scripts({

    "client/cl_*.lua",
    "lib/pmenu.lua"

});