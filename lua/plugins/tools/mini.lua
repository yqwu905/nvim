return {
  "echasnovski/mini.nvim",
  version = false,
  lazy = false,
  config = function()
    require("mini.surround").setup()
    require("mini.pairs").setup()
    require("mini.comment").setup()
    require("mini.statusline").setup()
    require("mini.trailspace").setup()
    local indentscope = require "mini.indentscope"
    indentscope.setup {
      draw = {
        animation = indentscope.gen_animation.none(),
      },
    }
  end,
}
