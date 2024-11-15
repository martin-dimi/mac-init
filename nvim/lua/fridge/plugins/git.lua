return {
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
}

-- return {
--   "kdheepak/lazygit.nvim",
--   lazy = true,
--   cmd = {
--     "LazyGit",
--     "LazyGitConfig",
--     "LazyGitCurrentFile",
--     "LazyGitFilter",
--     "LazyGitFilterCurrentFile",
--   },
--   -- optional for floating window border decoration
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--   },
--   -- setting the keybinding for LazyGit with 'keys' is recommended in
--   -- order to load the plugin when the command is run for the first time
--   keys = {
--     { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
--   }
-- }
