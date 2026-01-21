local M = {}

local config = require('bufferize.config')
local window = require('bufferize.window')

M.setup = function(opts)
    config.update_config(opts)
    M.create_commands()
end

M.create_commands = function()
    local command_name = require('bufferize.config').settings.command_name
    vim.api.nvim_create_user_command(command_name, function(opts)
        M.bufferize(opts.args)
    end, {
        nargs = '*',
        desc = 'bufferize.nvim (capture cmd)',
        complete = 'command',
    })
end

M.bufferize = function(cmd)
    if cmd == '' then
        cmd = 'messages'
    end

    window.show_window(vim.api.nvim_exec(cmd, true))
end

return M
