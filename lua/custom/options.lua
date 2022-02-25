local M = {}

M.setup = function(domain, key, value)
  vim[domain][key] = value
end

return M
