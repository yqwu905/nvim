return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
  opts = {
    ensure_installed = { "lua-language-server" }, -- not an option from mason.nvim

    PATH = "skip",

    ui = {
      icons = {
        package_pending = " ",
        package_installed = " ",
        package_uninstalled = " ﮊ",
      },

      keymaps = {
        toggle_server_expand = "<CR>",
        install_server = "i",
        update_server = "u",
        check_server_version = "c",
        update_all_servers = "U",
        check_outdated_servers = "C",
        uninstall_server = "X",
        cancel_installation = "<C-c>",
      },
    },

    max_concurrent_installers = 10,
  },
  config = function(_, opts)
    require("mason").setup(opts)
    local install_list = require("core.config").lsp
  end,
}
