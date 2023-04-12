local M = {}

M.lsp = {
  lua = {
    "stylua",
    "lua-language-server",
  },
  c = {
    "clangd",
  },
  python = {
    "pyright",
    "yapf",
  },
  rust = {
    "rust-analyzer",
    "rustfmt",
  },
}

return M
