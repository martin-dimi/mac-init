return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-web-devicons",
  },

  config = function()
    local which = require("which-key")
    which.setup({
      preset = "modern",

      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = true,
        group = "+"
      }
    })

    which.add({
      { '<leader>a', icon = { icon = "" }, group = '[A]I' },
      { '<leader>b', icon = { icon = "" }, group = '[B]uffers', },
      { '<leader>c', icon = { icon = "" }, group = '[C]ode' },
      { '<leader>d', icon = { icon = "" }, group = '[D]b' },
      { '<leader>e', icon = { icon = "" }, group = '[E]xplorer', },
      { '<leader>cs', icon = { icon = "󰓆" }, group = '[S]spelling' },
      { '<leader>cc', icon = { icon = "" }, group = '[C]opilot' },
      { '<leader>d', icon = { icon = "" }, group = '[D]ocument' },
      { '<leader>g', icon = { icon = "" }, group = '[G]it' },
      { '<leader>r', icon = { icon = "" }, group = '[R]ename' },
      { '<leader>s', icon = { icon = "" }, group = '[S]earch' },
      { '<leader>w', icon = { icon = "" }, group = '[W]orkspace' },
      { '<leader>t', icon = { icon = "" }, group = '[T]oggle' },
    })
  end,
}
