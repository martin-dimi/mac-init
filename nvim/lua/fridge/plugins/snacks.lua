return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    explorer = { enabled = true },
    picker = {
      enabled = true,
      preset = "ivy",
      layout = {
        position = "bottom",
        preset = "ivy",
      },
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["<Tab>"] = "confirm",
              }
            }
          }
        }
      }
    },
    dim = { enabled = true },
    toggle = { enabled = true },
    input = { enabled = true },
    -- indent = { enabled = true },

    -- bigfile = { enabled = true },
    -- dashboard = { enabled = true },
    -- notifier = { enabled = true },
    -- quickfile = { enabled = true },
    -- scope = { enabled = true },
    -- scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
  },
  keys = {
    -- Picker
    { "<leader>e",       function() Snacks.explorer() end,            desc = "File Explorer" },

    -- Top Pickers & Explorer
    { "<leader><space>", function() Snacks.picker.buffers() end,      desc = "Smart Find Files" },
    { "<leader>sf",      function() Snacks.picker.files() end,        desc = "Find Files" },
    { "<leader>sg",      function() Snacks.picker.grep() end,         desc = "Grep" },
    { "<leader>.",       function() Snacks.picker.recent() end,       desc = "Recent" },
    { "<leader>sr",      function() Snacks.picker.resume() end,       desc = "Resume" },

    -- git
    { "<leader>gb",      function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl",      function() Snacks.picker.git_log() end,      desc = "Git Log" },
    { "<leader>gL",      function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gs",      function() Snacks.picker.git_status() end,   desc = "Git Status" },
    { "<leader>gS",      function() Snacks.picker.git_stash() end,    desc = "Git Stash" },
    { "<leader>gd",      function() Snacks.picker.git_diff() end,     desc = "Git Diff (Hunks)" },
    { "<leader>gf",      function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>ul")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.indent():map("<leader>ui")
        Snacks.toggle.dim():map("<leader>ud")
      end,
    })
  end,
}
