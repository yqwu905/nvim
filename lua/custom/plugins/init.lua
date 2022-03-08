return {
    {"iamcco/markdown-preview.nvim", ft = {"markdown"}},
    {"liuchengxu/vim-which-key"},
    {"hrsh7th/vim-eft"},
    {"numToStr/FTerm.nvim", config = require("custom.plugins.FTerm")},
    {"skywind3000/asyncrun.vim"},
    {"rhysd/accelerated-jk"},
    {"SirVer/ultisnips", after = 'nvim-cmp'},
    {"lervag/vimtex"},
    {"preservim/vim-markdown"},
    {"hrsh7th/nvim-cmp", config = require("custom.plugins.nvim_cmp")},
    {
      "sindrets/diffview.nvim",
      requires = 'nvim-lua/plenary.nvim',
    },
    {
      "rcarriga/nvim-notify",
      config = function()
        vim.notify = require('notify')
        require('telescope').load_extension('notify')
      end
    },
    {
      "preservim/vim-markdown",
      config = function()
        vim.g.vim_markdown_math = 1
      end
    },
    {"mattn/emmet-vim", ft='html'},
}
