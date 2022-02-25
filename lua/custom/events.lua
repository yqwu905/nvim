vim.api.nvim_command('autocmd BufNewFile,BufRead *.wls set filetype=mma')
vim.api.nvim_command('autocmd BufNewFile,BufRead *.wl set filetype=mma')
vim.api.nvim_command('autocmd BufNewFile,BufRead *.m set filetype=mma')

vim.api.nvim_command('autocmd FileType mma AsyncRun wolframscript -f ' ..
                         '~/tools/lsp-wl/init.wls --tcp-server=6536')

vim.api.nvim_command(
    'autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 1000)')

vim.api.nvim_command(
    'autocmd BufWritePre *.py.in lua vim.lsp.buf.formatting_sync(nil, 1000)')

vim.api.nvim_command(
    'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)')
