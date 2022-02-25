local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"
  local util = require('lspconfig.util')
  local configs = require('lspconfig.configs')

  configs.lsp_wl = {
    default_config = {
      cmd = {"nc", "localhost", "6536"},
      filetypes = {"mma", "wl"},
      root_dir = util.path.dirname
    }
  }

  local servers = {"clangd", "pyright", "julials", "lsp_wl"}

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    }
  end

  lspconfig.efm.setup {
    init_options = {documentFormatting = true},
    filetypes = {'lua', 'python'},
    settings = {
      rootMarkers = {".git/"},
      languages = {
        lua = {{formatCommand = "lua-format -i", formatStdin = true}},
        python = {{formatCommand = "yapf --quiet", formatStdin = true}}
      }
    }
  }

  lspconfig.texlab.setup {filetypes = {"tex", "bib", "latex", "plaintex"}}

  lspconfig.sumneko_lua.setup {
    cmd = {
      '/home/yqwu/tools/lua-language-server/bin/lua-language-server', '-E',
      '/home/yqwu/tools/lua-language-server/main.lua'
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
