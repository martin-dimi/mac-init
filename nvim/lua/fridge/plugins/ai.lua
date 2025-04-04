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

    vim.keymap.set("n", "<leader>cct", "<cmd>Copilot toggle<CR>", { desc = "Toggle Copilot" })
  end
}
