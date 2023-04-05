vim.g.mapleader = " "

local utils = require "keymap.utils"

local wk = require "which-key"
local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = false,
  nowait = false,
}

local vopts = {
  mode = "v",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

wk.register({
  ["/"] = { "<cmd>lua require('Comment.api').toggle.linewise()<cr>", "toggle comment" },
  ["1"] = { "<cmd>lua require('bufferline').go_to_buffer(1, true)<cr>", "buffer 1" },
  ["2"] = { "<cmd>lua require('bufferline').go_to_buffer(2, true)<cr>", "buffer 2" },
  ["3"] = { "<cmd>lua require('bufferline').go_to_buffer(3, true)<cr>", "buffer 3" },
  ["4"] = { "<cmd>lua require('bufferline').go_to_buffer(4, true)<cr>", "buffer 4" },
  ["5"] = { "<cmd>lua require('bufferline').go_to_buffer(5, true)<cr>", "buffer 5" },
  ["6"] = { "<cmd>lua require('bufferline').go_to_buffer(6, true)<cr>", "buffer 6" },
  ["7"] = { "<cmd>lua require('bufferline').go_to_buffer(7, true)<cr>", "buffer 7" },
  ["8"] = { "<cmd>lua require('bufferline').go_to_buffer(8, true)<cr>", "buffer 8" },
  ["9"] = { "<cmd>lua require('bufferline').go_to_buffer(9, true)<cr>", "buffer 9" },
  e = {
    name = "+enter",
    c = { "<cmd>e $MYVIMRC | :cd %:p:h <CR>", "nvim config" },
    o = { "<cmd>cd D:/repos/OJ<CR>", "oj" },
    n = { "<cmd>cd D:/Note<CR>", "note" },
  },
  f = {
    name = "+find",
    a = { "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <cr>", "find all files" },
    b = { "<cmd>Telescope buffers<cr>", "buffers" },
    f = { "<cmd>Telescope find_files<cr>", "find files" },
    h = { "<cmd>Telescope help_tags<cr>", "help tags" },
    r = { "<cmd>Telescope oldfiles<cr>", "recent files" },
    w = { "<cmd>Telescope live_grep<cr>", "live grep" },
    s = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "workspace symbols" },
    t = { "<cmd>Telescope<CR>", "telescope" },
    ["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "current file" },
  },
  g = {
    name = "+git",
    b = { "<cmd>lua require'gitsigns'.blame_line{full=true}<cr>", "git blame" },
    c = { utils.commit, "git commit" },
    d = {
      name = "+git diff",
      f = { "<cmd>lua ToggleDiffView(false)<CR>", "diff file" },
      d = { "<cmd>lua ToggleDiffView(true)<CR>", "diff dir" },
      c = { "<cmd>lua :DiffviewClose<cr>", "diff close" },
    },
    g = { "<cmd>Neogit<cr>", "neogit" },
    h = { "<cmd>Telescope git_commits<cr>", "git history" },
    j = { "<cmd>Gitsigns next_hunk<cr>", "next hunk" },
    k = { "<cmd>Gitsigns prev_hunk<cr>", "previous hunk" },
    p = { "<cmd>Gitsigns preview_hunk<cr>", "git preview" },
    s = { "<cmd>:Gitsigns stage_hunk<cr>", "git stage" },
  },
  l = {
    name = "+lsp",
    i = { "<cmd>LspInfo<cr>", "LSP Info" },
    k = { "<cmd>LspStop<cr>", "LSP Stop" },
    s = { "<cmd>LspStart<cr>", "LSP Start" },
    r = { "<cmd>Lspsaga rename ++project<cr>", "rename" },
    f = { "<cmd>lua vim.lsp.buf.format({async=true})<cr>", "format" },
    a = { "<cmd>Lspsaga code_action<cr>", "code actions" },
    d = { "<cmd>Trouble<cr>", "diagnostics" },
  },
  p = {
    name = "+plugin",
    p = { "<cmd>Lazy home<cr>", "dashboard" },
  },
  q = {
    name = "+quit",
    q = { "<cmd>wqa<cr>", "quit" },
    f = { "<cmd>qa!<cr>", "force quit" },
    x = { utils.close_buffer, "close buffer" },
  },
  t = {
    name = "+theme",
    h = { "<cmd>Telescope colorscheme<cr>", "theme" },
    p = { "<cmd>TransparentToggle<cr>", "transparent" },
    m = { "<cmd>TableModeToggle<cr>", "table mode" },
  },
  u = {
    name = "+utils",
    r = { utils.async_run_code, "run" },
    c = { utils.switch_conceallevel, "switch conceallevel" },
    l = { utils.async_check_code, "lint" },
    s = { "<cmd>Lspsaga outline<cr>", "taglist" },
    p = { utils.toggle_preview, "preview" },
    i = { vim.lsp.buf.incoming_calls, "income call"},
    o = { vim.lsp.buf.outgoing_calls, "outgo call"},
  },
  x = {
    name = "trouble",
    d = { "<cmd>Trouble document_diagnostics<cr>", "document" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "workspace" },
    q = { "<cmd>Trouble quickfix<cr>", "quickfix" },
    l = { "<cmd>Trouble loclist<cr>", "loclist" },
    r = { "<cmd>TroubleRefresh<cr>", "refresh" },
    x = { "<cmd>TroubleToggle<cr>", "toggle" },
  },
}, opts)

wk.register({
  ["/"] = {
    "<esc><cmd> :lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    "toggle comment",
  },
  s = { ":<C-u>lua require('iron.core').send(nil, get_visual_selection())<cr>", "send visual" },
}, vopts)

vim.cmd [[
noremap <Tab> <cmd>BufferLineCycleNext<CR>
noremap <S-Tab> <cmd>BufferLineCyclePrev<CR>
noremap <C-n> <cmd>NvimTreeToggle<CR>
nmap s <cmd>HopWord<cr>
tnoremap <Esc> <C-\><C-n>
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <A-i> <cmd>ToggleTerm direction=float<cr>
imap <A-i> <cmd>ToggleTerm direction=float<cr>
tmap <A-i> <cmd>ToggleTerm direction=float<cr>
nmap <A-h> <cmd>ToggleTerm direction=horizontal<cr>
imap <A-h> <cmd>ToggleTerm direction=horizontal<cr>
tmap <A-h> <cmd>ToggleTerm direction=horizontal<cr>
nmap <A-v> <cmd>ToggleTerm direction=vertical<cr>
imap <A-v> <cmd>ToggleTerm direction=vertical<cr>
tmap <A-v> <cmd>ToggleTerm direction=vertical<cr>
]]

vim.keymap.set("n", "<Enter>", utils.follow_link)
vim.keymap.set("n", "<BS>", utils.jump_back)

