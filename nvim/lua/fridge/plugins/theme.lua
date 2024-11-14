return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,

  config = function()
    require("catppuccin").setup {
      flavour = "mocha",
      integrations = {
        cmp = true,
        nvimtree = true,
        telescope = true,
        notify = true,
        which_key = true,
        indent_blankline = true,
        mason = true,
        lsp_trouble = true,
      },
    }
    vim.cmd [[colorscheme catppuccin]]
  end,
}
