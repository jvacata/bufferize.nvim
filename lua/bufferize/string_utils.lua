local M = {}

M.is_not_empty = function(s)
    return s ~= nil and #s > 0
end

return M
