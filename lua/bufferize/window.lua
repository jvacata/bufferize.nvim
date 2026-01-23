local M = {}

local config = require('bufferize.config')

M.show_window = function(text)
    local lines = vim.split(text, '\n')
    local opts = config.settings.window_opts()
    local bufnr, winnr = M.get_window_with_buffer(opts)

    vim.api.nvim_set_option_value('buftype', 'nowrite', { buf = bufnr })
    vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = bufnr })

    vim.api.nvim_set_option_value('modifiable', true, { buf = bufnr })
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
    vim.api.nvim_set_option_value('modifiable', false, { buf = bufnr })

    vim.api.nvim_buf_set_name(bufnr, config.settings.buffer_name)
    vim.api.nvim_set_option_value('number', true, { win = winnr })

    return winnr
end

M.get_window_with_buffer = function(opts)
    local buf_list = vim.api.nvim_list_bufs()

    local existing_messages_buf = nil
    for _, buf_id in pairs(buf_list) do
        local name = vim.api.nvim_call_function("bufname", { buf_id })
        if name == config.settings.buffer_name then
            existing_messages_buf = buf_id
            break
        end
    end
    local messages_buf_id = existing_messages_buf or vim.api.nvim_create_buf(false, true)

    local wins = vim.api.nvim_list_wins()
    for _, win_id in pairs(wins) do
        local win_currect_buf_id = vim.api.nvim_win_get_buf(win_id)
        if win_currect_buf_id == messages_buf_id then
            vim.api.nvim_tabpage_set_win(0, win_id)
            return messages_buf_id, win_id
        end
    end

    local win_id = vim.api.nvim_open_win(messages_buf_id, true, opts)

    return messages_buf_id, win_id
end

return M
