return {
  {"iamcco/markdown-preview.nvim", ft = {"markdown"}},
  {"liuchengxu/vim-which-key"},
  {"hrsh7th/vim-eft"},
  {"numToStr/FTerm.nvim", config = require("custom.plugins.FTerm")},
  {"skywind3000/asyncrun.vim"},
  {"rhysd/accelerated-jk"},
  {"SirVer/ultisnips", after='nvim-cmp'},
  {"lervag/vimtex", ft={"plaintex", "tex", "latex"}},
  {"hrsh7th/nvim-cmp", config = require("custom.plugins.nvim_cmp")},
}
