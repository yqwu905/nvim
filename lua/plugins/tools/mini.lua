return {
  "echasnovski/mini.nvim",
  version = false,
  lazy = false,
  config = function()
    require("mini.surround").setup()
    require("mini.ai").setup()
    require("mini.cursorword").setup()
    require("mini.pairs").setup()
    require("mini.comment").setup()
    require("mini.statusline").setup()
    require("mini.jump").setup()
    require("mini.trailspace").setup()
    local indentscope = require "mini.indentscope"
    indentscope.setup {
      draw = {
        animation = indentscope.gen_animation.none(),
      },
    }
    require("mini.sessions").setup {
      autowrite = true,
    }
    require("mini.jump2d").setup {
      mappings = {
        start_jumping = "s",
      },
    }
  end,
}
