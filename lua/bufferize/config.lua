local M = {}

M.settings = {
    command_name = 'Bufferize',
    buffer_name = 'bufferize',

    window_opts = function()
        return {
            split = 'below'
        }
    end,
}

M.update_config = function(opts)
    opts = opts or {}
    M.settings = vim.tbl_extend('force', M.settings, opts)
end

return M
