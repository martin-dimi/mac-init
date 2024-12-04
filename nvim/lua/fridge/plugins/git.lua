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
