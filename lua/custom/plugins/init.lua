return {
  {"iamcco/markdown-preview.nvim", ft = {"markdown"}},
  {"liuchengxu/vim-which-key"},
  {"hrsh7th/vim-eft"},
  {"numToStr/FTerm.nvim", config = require("custom.plugins.FTerm")},
  {"skywind3000/asyncrun.vim"},
  {"rhysd/accelerated-jk"},
  {"SirVer/ultisnips", after='nvim-cmp'},
  {
    "quangnguyen30192/cmp-nvim-ultisnips",
    config = function()
      require("cmp_nvim_ultisnips").setup{}
    end
  },
  {"lervag/vimtex", ft={"plaintex", "tex", "latex"}}
}
