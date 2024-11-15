-- return {
--   "supermaven-inc/supermaven-nvim",
--   config = function()
--     require("supermaven-nvim").setup({})
--   end,
-- }

-- return {
--   "github/copilot.vim",
-- }
--

--
-- return {
--   "zbirenbaum/copilot.lua",
--   cmd = "Copilot",
--   build = ":Copilot auth",
--   event = "InsertEnter",
--   opts = {
--     suggestion = {
--       enabled = not vim.g.ai_cmp,
--       auto_trigger = true,
--       keymap = {
--         accept = false, -- handled by nvim-cmp / blink.cmp
--         next = "<C-]>",
--         prev = "<C-[>",
--       },
--     },
--     panel = { enabled = false },
--     filetypes = {
--       markdown = true,
--       help = true,
--     },
--   },
-- }

return {
  "zbirenbaum/copilot-cmp",
  dependencies = { {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end
  } },
  config = function()
    require("copilot_cmp").setup()
  end
}
