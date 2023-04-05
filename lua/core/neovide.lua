if vim.g.neovide then
  -- Helper function for transparency formatting
  -- local alpha = function()
  --   return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
  -- end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  -- vim.g.neovide_transparency = 0.7
  -- vim.g.transparency = 0.7
  -- vim.g.neovide_background_color = "#e1e2e7" .. alpha()
  vim.g.neovide_scroll_animation_length = 0.2
  -- vim.g.neovide_profiler = true
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_cursor_animation_length = 0.06
  vim.g.neovide_no_idle = true
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.o.guifont = "JetBrainsMono Nerd Font:h12"
end

