vim.cmd "set cscopequickfix=s+,c+,d+,i+,t+,e+,a+"
local cscope_db = vim.fn.getcwd() .. "\\cscope.out"

local function update_db()
  local job = vim.fn.jobstart("cscope -bR", {
    on_exit = function()
      vim.cmd("silent cs a " .. cscope_db)
      vim.notify "Update cscope database finished!"
    end,
  })
end

vim.keymap.set("n", "<leader>ud", update_db, { silent = true })

if vim.fn.filereadable(cscope_db) == 1 then
  vim.cmd("silent cs a " .. cscope_db)

  local function find_reference()
    local word = vim.fn.expand "<cword>"
    vim.cmd "call setqflist([])"
    vim.cmd("silent cs find s " .. word)
    vim.cmd "Trouble quickfix"
    vim.cmd "TroubleRefresh"
  end

  local function find_assignment()
    vim.cmd "call setqflist([])"
    local word = vim.fn.expand "<cword>"
    vim.cmd("silent cs find a " .. word)
    vim.cmd "Trouble quickfix"
    vim.cmd "TroubleRefresh"
  end

  local function find_definition()
    local word = vim.fn.expand "<cword>"
    vim.cmd("cs find g " .. word)
  end

  vim.keymap.set("n", "ld", find_definition, { silent = true })
  vim.keymap.set("n", "lr", find_reference, { silent = true })
  vim.keymap.set("n", "la", find_assignment, { silent = true })
end

