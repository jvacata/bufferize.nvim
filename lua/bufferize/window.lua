local M = {}

local config = require('bufferize.config')

M.get_window_with_buffer = function(opts)
    local buf_list = vim.api.nvim_list_bufs()

    local existing_messages_buf = nil
    for _, buf_id in pairs(buf_list) do
        local name = vim.api.nvim_call_function("bufname", { buf_id })
        if name == require('bufferize.config').settings.buffer_name then
            existing_messages_buf = buf_id
            break
        end
    end
    local messages_buf = existing_messages_buf or vim.api.nvim_create_buf(false, true)

    local wins = vim.api.nvim_list_wins()
    for _, win in pairs(wins) do
        local win_buf = vim.api.nvim_win_get_buf(win)
        if win_buf == messages_buf then
            vim.api.nvim_tabpage_set_win(0, win)
            return win
        end
    end

    return vim.api.nvim_open_win(messages_buf, true, opts)
end

M.show_window = function(text)
    local lines = vim.split(text, '\n')
    local opts = config.settings.window_opts(lines)
    local winnr = M.get_window_with_buffer(opts)
    local bufnr = vim.fn.bufnr()

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
    vim.api.nvim_buf_set_name(bufnr, config.settings.buffer_name)
    vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'delete')
    vim.api.nvim_set_option_value('number', true, { win = winnr })

    return winnr
end


return M
