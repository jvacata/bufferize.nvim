local M = {}

local config = require('bufferize.config')
local window = require('bufferize.window')
local string = require('bufferize.string')

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

    local exec_cmd_func = function()
        return vim.api.nvim_exec2(cmd, { output = true })
    end

    local ok, result = pcall(exec_cmd_func)
    local output_msg

    if not ok then
        output_msg = 'Call ' .. cmd .. ' failed:' .. result
    elseif result ~= nil and string.is_not_empty(result.output) then
        output_msg = result.output
    else
        output_msg = 'No output from command: ' .. cmd
    end

    window.show_window(output_msg)
end

return M
