require("custom.utils")
local map = require("core.utils").map

vim.cmd("nnoremap <silent> <leader> :WhichKey '<Space>'<CR>")

map("n", "<leader>cc", ":Telescope <CR>")
map("n", "<leader>q", ":wqa <CR>")

map("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>")
map("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>")
map("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>")
map("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>")
map("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>")
map("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>")
map("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>")
map("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>")
map("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>")

map("n", "<leader>mr", ":lua AsyncRunCode()<CR>")
map("n", "<leader>mc", ":lua SwitchConcealLevel()<CR>")

map("n", "<A-i>", ":lua require('FTerm').toggle()<CR>")
map("t", "<A-i>", "<C-\\><C-n>:lua require('FTerm').toggle()<CR>")

map("n", "<leader>tw", ":lua __fterm_wolfram()<CR>")
map("n", "<leader>tt", ":lua __fterm_btop()<CR>")
map("n", "<leader>tj", ":lua __fterm_julia()<CR>")
map("n", "<leader>tp", ":lua __fterm_python()<CR>")

vim.cmd [[
  nmap ; <Plug>(eft-repeat)
  xmap ; <Plug>(eft-repeat)
  omap ; <Plug>(eft-repeat)

  nmap f <Plug>(eft-f)
  xmap f <Plug>(eft-f)
  omap f <Plug>(eft-f)
  nmap F <Plug>(eft-F)
  xmap F <Plug>(eft-F)
  omap F <Plug>(eft-F)
  
  nmap t <Plug>(eft-t)
  xmap t <Plug>(eft-t)
  omap t <Plug>(eft-t)
  nmap T <Plug>(eft-T)
  xmap T <Plug>(eft-T)
  omap T <Plug>(eft-T)
]]

vim.cmd [[
  nmap j <Plug>(accelerated_jk_gj)
  nmap k <Plug>(accelerated_jk_gk)
]]

