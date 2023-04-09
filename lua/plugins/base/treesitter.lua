return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  run = ":TSUpdate",
  opts = {
    ensure_installed = "all",
    sync_install = true,
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = { enable = true },
  },
}
