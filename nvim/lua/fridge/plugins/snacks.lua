---@module "snacks"
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  ---@type snacks.Config
  opts = {
    styles = {
      custom_scratch = {
        relative = "editor",
        width = 0.95,
        height = 0.95,
        buf = 1,
      }
    },

    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    explorer = { enabled = true },
    picker = {
      enabled = true,
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
    scratch = {
      enabled = true,
      root = "~/.scratch",
      win = {
        relative = "editor",
        style = "custom_scratch",
      },
    },
  },
  keys = {
    -- Picker
    { "<leader>e",       function() Snacks.explorer() end,                                desc = "File Explorer" },
    { "<leader><space>", function() Snacks.picker.buffers() end,                          desc = "Smart Find Files" },
    { "<leader>sf",      function() Snacks.picker.files({ exclude = { "*_test.go" } }) end, desc = "Find Files" },
    { "<leader>sg",      function() Snacks.picker.grep({ exclude = { "*_test.go" } }) end, desc = "Grep" },
    { "<leader>.",       function() Snacks.picker.recent() end,                           desc = "Recent" },
    { "<leader>sr",      function() Snacks.picker.resume() end,                           desc = "Resume" },
    { "<leader>sh",      function() Snacks.picker.help() end,                             desc = "Help Pages" },
    { "<leader>st",      function() Snacks.picker.colorschemes() end,                     desc = "Themes" },

    -- git
    { "<leader>gb",      function() Snacks.picker.git_branches() end,                     desc = "Git Branches" },
    { "<leader>gl",      function() Snacks.picker.git_log() end,                          desc = "Git Log" },
    { "<leader>gL",      function() Snacks.picker.git_log_line() end,                     desc = "Git Log Line" },
    { "<leader>gs",      function() Snacks.picker.git_status() end,                       desc = "Git Status" },
    { "<leader>gS",      function() Snacks.picker.git_stash() end,                        desc = "Git Stash" },
    { "<leader>gd",      function() Snacks.picker.git_diff() end,                         desc = "Git Diff (Hunks)" },
    { "<leader>gf",      function() Snacks.picker.git_log_file() end,                     desc = "Git Log File" },

    -- Scratch
    {
      "<leader>bs",
      function()
        local scratch_dir = vim.fn.expand("~/.scratch")
        if vim.fn.isdirectory(scratch_dir) == 0 then
          vim.fn.mkdir(scratch_dir, "p")
        end
        local date = os.date("%d-%m-%Y")
        Snacks.scratch.open({
          ft = "markdown",
          file = string.format("%s/%s.md", scratch_dir, date),
        })
      end,
      desc = "Toggle Scratch Buffer"
    },
    { "<leader>bS", function() Snacks.picker.files({ cwd = "~/.scratch" }) end, desc = "Select Scratch Buffer" },
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
