return {
  "iamcco/markdown-preview.nvim",
  build = { "cd app && yarn install" },
  ft = { "markdown" },
  cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
  config = function()
    local cssfile = "notion-light-enhanced.css"
    vim.g.mkdp_markdown_css = string.format("%s/static/%s", vim.fn.stdpath "config", cssfile)
  end,
}

