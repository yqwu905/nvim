local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"

  local servers = {"clangd", "pyright"}

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    }
  end

  lspconfig.sumneko_lua.setup {
    cmd = {
      'C:\\tools\\lua-language-server\\bin\\lua-language-server.exe', '-E',
      'C:\\tools\\lua-language-server\\main.lua'
    },
    on_attach = attach,
    capabilities = capabilities,
    settings = {
       Lua = {
          diagnostics = {
             globals = { "vim" },
          },
          workspace = {
             library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
             },
             maxPreload = 100000,
             preloadFileSize = 10000,
          },
       },
    },
  }
end

return M
