return {
  "jose-elias-alvarez/null-ls.nvim",
  ft = { "lua", "c", "cpp", "python", "rust" },
  config = function()
    local null_ls = require "null-ls"
    null_ls.setup {
      on_init = function(new_client, _)
        new_client.offset_encoding = "utf-16"
      end,
      sources = {
        null_ls.builtins.formatting.yapf,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.rustfmt,
        -- null_ls.builtins.diagnostics.actionlint,
        -- null_ls.builtins.diagnostics.cpplint,
        -- null_ls.builtins.diagnostics.flake8,
      },
    }
  end,
}

