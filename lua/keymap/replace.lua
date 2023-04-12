vim.g.mapleader = " "

local utils = require "keymap.utils"

local wk = require "which-key"

wk.register {
  {
    ["<leader>"] = {
      ["1"] = { "<cmd>BufferGoto 1<cr>", "buffer 1" },
      ["2"] = { "<cmd>BufferGoto 2<cr>", "buffer 2" },
      ["3"] = { "<cmd>BufferGoto 3<cr>", "buffer 3" },
      ["4"] = { "<cmd>BufferGoto 4<cr>", "buffer 4" },
      ["5"] = { "<cmd>BufferGoto 5<cr>", "buffer 5" },
      ["6"] = { "<cmd>BufferGoto 6<cr>", "buffer 6" },
      ["7"] = { "<cmd>BufferGoto 7<cr>", "buffer 7" },
      ["8"] = { "<cmd>BufferGoto 8<cr>", "buffer 8" },
      ["9"] = { "<cmd>BufferGoto 9<cr>", "buffer 9" },
      ["a"] = {},
      ["b"] = {
        b = { "<cmd>BufferPick<cr>", "buffer pick" },
        h = { "<cmd>BufferMovePrevious<cr>", "move left" },
        l = { "<cmd>BufferMoveNext<cr>", "move right" },
        p = { "<cmd>BufferPin<cr>", "buffer pin" },
      },
      ["c"] = {
        a = { "<cmd>Lspsaga code_action<cr>", "code actions" },
        c = { utils.async_check_code, "code check" },
      },
      ["d"] = {},
      ["e"] = {
        c = { "<cmd>e $MYVIMRC | :cd %:p:h <CR>", "nvim config" },
        e = { "<cmd>e!<cr>", "reload" },
        o = { "<cmd>cd D:/repos/OJ<CR>", "oj" },
        n = { "<cmd>cd D:/Note<CR>", "note" },
        p = { utils.pandoc_export, "export" },
      },
      ["f"] = {
        b = { "<cmd>Telescope buffers<cr>", "buffers" },
        f = { "<cmd>Telescope find_files<cr>", "find files" },
        h = { "<cmd>Telescope help_tags<cr>", "help tags" },
        g = { "<cmd>Telescope grep_string<cr>", "grep" },
        m = { "<cmd>lua vim.lsp.buf.format({async=true})<cr>", "format" },
        o = { "<cmd>Telescope oldfiles<cr>", "recent files" },
        p = { "<cmd>lua require('telescope').extensions.project.project {}<cr>", "project" },
        r = { "<cmd>Telescope lsp_references<cr>", "references" },
        s = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "workspace symbols" },
        w = { "<cmd>Telescope live_grep<cr>", "live grep" },
        t = { "<cmd>Telescope<CR>", "telescope" },
        ["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "current file" },
      },
      ["g"] = {
        b = { "<cmd>lua require'gitsigns'.blame_line{full=true}<cr>", "git blame" },
        -- c = { "<cmd>Neogit commit<cr>", "commit" },
        -- g = { "<cmd>Neogit<cr>", "neogit" },
        h = { "<cmd>Telescope git_commits<cr>", "git history" },
        j = { "<cmd>Gitsigns next_hunk<cr>", "next hunk" },
        k = { "<cmd>Gitsigns prev_hunk<cr>", "previous hunk" },
        p = { "<cmd>Gitsigns preview_hunk<cr>", "git preview" },
        s = { "<cmd>:Gitsigns stage_hunk<cr>", "git stage" },
        l = {
          name = "+glance",
          d = { "<cmd>Glance definitions<cr>", "definitions" },
          r = { "<cmd>Glance references<cr>", "references" },
          t = { "<cmd>Glance type_definitions<cr>", "type definitions" },
          i = { "<cmd>Glance implementations<cr>", "implementations" },
        },
      },
      ["h"] = {},
      ["i"] = {},
      ["j"] = {},
      ["k"] = {},
      ["l"] = {
        i = { "<cmd>LspInfo<cr>", "LSP Info" },
        z = { "<cmd>Lazy<cr>", "lazy" },
      },
      ["m"] = {},
      ["n"] = {},
      ["o"] = {},
      ["p"] = {
        ["i"] = { "<cmd>PasteImg<cr>", "paste image" },
        ["v"] = { utils.toggle_preview, "preview" },
        "preview",
      },
      ["q"] = {
        q = { "<cmd>wqa<cr>", "quit all" },
      },
      ["r"] = {
        m = { "<cmd>Lspsaga rename ++project<cr>", "rename" },
        r = { utils.async_run_code, "run" },
      },
      ["s"] = {
        c = { utils.switch_conceallevel, "switch conceallevel" },
        o = { "<cmd>SymbolsOutline<cr>", "taglist" },
        l = { "<cmd>ToggleTermSendCurrentLine 9<cr>", "send line" },
      },
      ["t"] = {
        d = { "<cmd>TodoTelescope<cr>", "todo" },
        m = { "<cmd>TableModeToggle<cr>", "table mode" },
        p = { "<cmd>TransparentToggle<cr>", "transparent" },
        r = {},
        s = {
          name = "+treesitter",
          h = { "<cmd>TSToggle highlight<cr>", "highlight" },
          i = { "<cmd>TSToggle indent<cr>", "indent" },
        },
      },
      ["u"] = {
        x = { "<cmd>BufferRestore<cr>", "restore buffer" },
      },
      ["v"] = {},
      ["w"] = {
        ["v"] = { "<cmd>vsp<cr>", "vsp" },
        ["s"] = { "<cmd>sp<cr>", "sp" },
        ["d"] = { "<cmd>q<cr>", "close" },
        ["r"] = {
          ["+"] = { "<cmd>res+5<cr>", "widen" },
          ["-"] = { "<cmd>res-5<cr>", "shorten" },
        },
      },
      ["x"] = { utils.close_buffer, "close buffer" },
      ["y"] = {},
      ["z"] = {},
    },
  },
  { mode = "n", prefix = "" },
}

local nmap = function(...)
  vim.keymap.set("n", ...)
end
local tmap = function(...)
  vim.keymap.set("t", ...)
end
local vmap = function(...)
  vim.keymap.set("v", ...)
end
local imap = function(...)
  vim.keymap.set("i", ...)
end

nmap("<enter>", utils.follow_link)
nmap("<bs>", utils.jump_back)
nmap("<tab>", "<cmd>BufferNext<CR>")
nmap("<s-tab>", "<cmd>BufferPrevious<cr>")
nmap("<c-n>", "<cmd>NvimTreeToggle<cr>")
nmap("<c-s>", "<cmd>update<cr>")
nmap("<c-h>", "<c-w>h")
nmap("<c-j>", "<c-w>j")
nmap("<c-k>", "<c-w>k")
nmap("<c-l>", "<c-w>l")
nmap("<a-i>", "<cmd>ToggleTerm direction=float<cr>")
nmap("<a-h>", "<cmd>ToggleTerm direction=horizontal<cr>")
nmap("<a-v>", "<cmd>ToggleTerm direction=vertical<cr>")
nmap("<esc>", "<cmd>noh<cr>")
tmap("<esc>", "<c-\\><c-n>")
tmap("<a-i>", "<cmd>ToggleTerm direction=float<cr>")
tmap("<a-h>", "<cmd>ToggleTerm direction=horizontal<cr>")
tmap("<a-v>", "<cmd>ToggleTerm direction=vertical<cr>")
imap("<c-s>", "<c-o><cmd>update<cr>")
imap("<a-i>", "<cmd>ToggleTerm direction=float<cr>")
imap("<a-h>", "<cmd>ToggleTerm direction=horizontal<cr>")
imap("<a-v>", "<cmd>ToggleTerm direction=vertical<cr>")
imap("<c-h>", "<left>")
imap("<c-j>", "<down>")
imap("<c-k>", "<up>")
imap("<c-l>", "<right>")
