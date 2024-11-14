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
