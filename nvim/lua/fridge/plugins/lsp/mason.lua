return {
  "williamboman/mason.nvim",
  dependencies = {
    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      automatic_installation = true,
      ensure_installed = {
        "gopls",
        "lua_ls",

        -- Web stuff
        "ts_ls",
        "html",
        "emmet_ls",
        "cssls",
        "tailwindcss",

        -- Python
        "ruff",
        "pyright",

        "jsonls",
        "dockerls",
      },
    })
  end,
}
