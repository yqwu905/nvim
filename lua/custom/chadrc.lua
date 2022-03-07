-- Just an example, supposed to be placed in /lua/custom/
local M = {}

local user_plugins = require("custom.plugins")
-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {theme = "gruvchad"}

M.plugins = {
    install = user_plugins,
    options = {lspconfig = {setup_lspconf = "custom.plugins.lspconfig"}},
    default_plugin_remove = {

        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/nvim-cmp",
        "saadparwaiz1/cmp_luasnip",
    },
    default_plugin_config_replace = {
        nvim_treesitter = {
            ensure_installed = {
                "c", "cpp", "cmake", "julia", "json", "haskell", "php", "perl",
                "lua", "fortran", "html", "python", "yaml", "markdown"
            }
        },
    }
}

return M
