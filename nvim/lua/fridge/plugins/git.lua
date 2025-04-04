return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
      "echasnovski/mini.pick",         -- optional
    },
    config = function()
      local neogit = require("neogit")
      vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
      neogit.setup({})
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      })

      vim.keymap.set('n', '<leader>gp', "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview" })
    end,
  },
  {
    "FabijanZulj/blame.nvim",
    config = function()
      local blame = require('blame')
      blame.setup {}

      vim.keymap.set('n', '<leader>gB', "<cmd>BlameToggle<CR>", { desc = "Toggle blame" })
    end,
  }

}
