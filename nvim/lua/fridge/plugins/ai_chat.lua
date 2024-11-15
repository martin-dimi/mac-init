return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    mappings = {
      ask = "<leader>cca",     -- ask
      edit = "<leader>cce",    -- edit
      refresh = "<leader>ccr", -- refresh
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua",      -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },

  keys = function(_, keys)
    ---@type avante.Config
    local opts =
        require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["avante.nvim"], "opts", false)

    local mappings = {
      {
        opts.mappings.ask,
        function() require("avante.api").ask() end,
        desc = "avante: ask",
        mode = { "n", "v" },
      },
      {
        opts.mappings.refresh,
        function() require("avante.api").refresh() end,
        desc = "avante: refresh",
        mode = "v",
      },
      {
        opts.mappings.edit,
        function() require("avante.api").edit() end,
        desc = "avante: edit",
        mode = { "n", "v" },
      },
    }
    mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
    return vim.list_extend(mappings, keys)
  end,
}


-- return {
--   "CopilotC-Nvim/CopilotChat.nvim",
--   branch = "canary",
--   dependencies = {
--     { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
--     { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
--   },
--   build = "make tiktoken",        -- Only on MacOS or Linux
--   config = function()
--     -- You might also want to disable default <tab> complete mapping for copilot chat when doing this
--     require('CopilotChat').setup()
--
--     vim.keymap.set({
--       "n",
--       "v",
--     }, "<leader>ccq", function()
--       local input = vim.fn.input("Quick Chat: ")
--       if input ~= "" then
--         require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
--       end
--     end, { desc = "CopilotChat - Quick chat" })
--   end,
-- }
