local opt = vim.opt

opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"

opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.number = true
opt.relativenumber = true

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

opt.updatetime = 250

opt.whichwrap:append "<>[]hl"

opt.shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell"
opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
opt.shellquote = ""
opt.shellxquote = ""

require "core.neovide"

