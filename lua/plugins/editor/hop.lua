return {
  "phaazon/hop.nvim",
  lazy = false,
  init = function()
    vim.keymap.set("n", "s", "<cmd>HopWord<cr>")
  end,
  opts = {},
}
