return {
  "neovim/nvim-lspconfig",
  ft = { "lua", "c", "cpp", "python", "rust", "typescript", "cmake", "ps1" },
  dependencies = {
    { "glepnir/lspsaga.nvim" },
  },
  config = function()
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            format = {
              enable = false,
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
                [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
          },
        },
      },
      powershell_es = {
        bundle_path = "D:/tools/PowerShellEditorServices",
        shell = "pwsh.exe",
      },
      cmake = {},
      clangd = {
        cmd = {
          "clangd",
          "--pch-storage=memory",
          "--limit-results=0",
          "--fallback-style=Huawei",
        },
      },
      pyright = {},
      emmet_ls = {},
      html = {
        init_options = {
          provideFormatter = true,
        },
      },
      tsserver = {},
      ["rust_analyzer"] = {},
    }

    local lspconfig = require "lspconfig"
    local util = require "lspconfig.util"
    local configs = require "lspconfig.configs"

    local signs = {
      Error = " ",
      Warn = " ",
      Info = " ",
      Hint = "ﴞ ",
    }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.diagnostic.config {
      signs = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      virtual_text = {
        source = true,
      },
    }

    local on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      local keymap = vim.keymap.set
      keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
      keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
      keymap("n", "<leader>lr", "<cmd>Lspsaga rename<CR>")
      keymap("n", "<leader>gr", "<cmd>Lspsaga rename ++project<CR>")
      keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
      keymap("n", "gD", "<cmd>Lspsaga goto_definition<CR>")
      keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
      keymap("n", "gT", "<cmd>Lspsaga goto_type_definition<CR>")
      keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")
      keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
      keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
      keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
      keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
      keymap("n", "[E", function()
        require("lspsaga.diagnostic"):goto_prev { severity = vim.diagnostic.severity.ERROR }
      end)
      keymap("n", "]E", function()
        require("lspsaga.diagnostic"):goto_next { severity = vim.diagnostic.severity.ERROR }
      end)
      keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
      keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
      keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }
    capabilities.offsetEncoding = { "utf-16" }

    for server, opts in pairs(servers) do
      opts.on_attach = on_attach
      opts.capabilities = capabilities
      lspconfig[server].setup(opts)
    end
  end,
}
