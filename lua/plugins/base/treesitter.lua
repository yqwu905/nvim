return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  run = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = {
    ensure_installed = "all",
    sync_install = true,
    highlight = {
      enable = true,
      disable = {},
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },
  },
}

