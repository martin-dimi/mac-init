return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
  },
  build = "make tiktoken",        -- Only on MacOS or Linux
  config = function()
    -- You might also want to disable default <tab> complete mapping for copilot chat when doing this
    require('CopilotChat').setup()

    vim.keymap.set({
      "n",
      "v",
    }, "<leader>ccq", function()
      local input = vim.fn.input("Quick Chat: ")
      if input ~= "" then
        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
      end
    end, { desc = "CopilotChat - Quick chat" })
  end,
}
