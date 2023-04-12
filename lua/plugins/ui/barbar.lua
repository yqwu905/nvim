return {
  "romgrk/barbar.nvim",
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  lazy = false,
  opts = {
    animation = true,
    tabpages = true,
    clickable = false,
  },
}
