---@diagnostic disable: missing-fields
---@module "snacks"

---@class snacks.dashboard.Config
local dashboardConfig = {
  preset = {
    ---@type snacks.dashboard.Item[]
    keys = {
      { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
      { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
      { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
    },

    header = [[
███████╗██████╗ ██╗██████╗  ██████╗ ███████╗
██╔════╝██╔══██╗██║██╔══██╗██╔════╝ ██╔════╝
█████╗  ██████╔╝██║██║  ██║██║  ███╗█████╗
██╔══╝  ██╔══██╗██║██║  ██║██║   ██║██╔══╝
██║     ██║  ██║██║██████╔╝╚██████╔╝███████╗
╚═╝     ╚═╝  ╚═╝╚═╝╚═════╝  ╚═════╝ ╚══════╝
]]
  },

  sections = {
    { section = "header" },
    { section = "keys", icon = " ", title = "Keymaps", indent = 2, padding = 1 },
    { section = "projects", icon = " ", title = "Projects", padding = 1, indent = 2 },
    { section = "startup" },
  },
}

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

    lazygit = {},

    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    explorer = {
      enabled = true,
      replace_netrw = true,
    },
    picker = {
      enabled = true,
      layout = {
        position = "bottom",
        preset = "ivy",
      },
      -- formatters = {
      --   file = {
      --     filename_first = true,   -- display filename before the file path
      --   },
      -- },
      win = {
        input = {
          keys = {
            ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
          }
        },
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
      root = os.getenv("NOTES"),
      win = {
        relative = "editor",
        style = "custom_scratch",
      },
    },
    dashboard = dashboardConfig
  },
  keys = {
    -- Picker
    { "<leader>e",  function() Snacks.explorer() end,                                  desc = "File Explorer" },
    {
      "<leader><space>",
      function()
        Snacks.picker.buffers({
          win = {
            input = {
              keys = {
                ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
              }
            }
          }
        })
      end,
      desc = "Smart Find Files"
    },
    { "<leader>sf", function() Snacks.picker.files({ exclude = { "*_test.go" } }) end, desc = "Find Files" },
    { "<leader>sg", function() Snacks.picker.grep({ exclude = { "*_test.go" } }) end,  desc = "Grep" },
    { "<leader>.",  function() Snacks.picker.recent() end,                             desc = "Recent" },
    { "<leader>sr", function() Snacks.picker.resume() end,                             desc = "Resume" },
    { "<leader>sh", function() Snacks.picker.help() end,                               desc = "Help Pages" },


    { "<leader>st", function() Snacks.picker.colorschemes() end,                       desc = "Themes" },
    {
      "<leader>sG",
      function()
        -- Get a list of all directories in the workspace
        local workspace_path = vim.fn.getcwd()
        local directories = vim.fn.systemlist("find " .. workspace_path .. " -type d")

        -- Present the directories to the user for selection
        vim.ui.select(directories, {
          prompt = "Select a directory:",
          format_item = function(item)
            return item
          end,
        }, function(choice)
          if choice then
            Snacks.picker.grep({ dirs = { choice } })
          else
            print("No directory selected")
          end
        end)
      end,
      desc = "Grep in directory"
    },

    -- lsp
    { "gd",         function() Snacks.picker.lsp_definitions() end,     desc = "[G]oto [D]efinition" },
    { "gD",         function() Snacks.picker.lsp_declarations() end,    desc = "[G]oto [D]eclaration" },
    { "gr",         function() Snacks.picker.lsp_references() end,      nowait = true,                   desc = "[G]oto [R]eferences" },
    { "gI",         function() Snacks.picker.lsp_implementations() end, desc = "[G]oto [I]mplementation" },

    -- git
    { "<leader>gg", function() Snacks.lazygit.open() end,               desc = "Lazygit" },
    { "<leader>go", function() Fridge.OpenInGithub() end,               desc = "Lazygit" },
    { "<leader>gb", function() Snacks.picker.git_branches() end,        desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end,             desc = "Git Log" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end,        desc = "Git Log Line" },
    { "<leader>gs", function() Snacks.picker.git_status() end,          desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end,           desc = "Git Stash" },
    { "<leader>gd", function() Snacks.picker.git_diff() end,            desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end,        desc = "Git Log File" },

    -- Scratch
    {
      "<leader>bs",
      function()
        local scratch_dir = (os.getenv("NOTES") or "~/.notes") .. "/Daily"
        if vim.fn.isdirectory(scratch_dir) == 0 then
          vim.fn.mkdir(scratch_dir, "p")
        end
        local date = os.date("%Y-%m-%d")
        Snacks.scratch.open({
          ft = "markdown",
          file = string.format("%s/%s.md", scratch_dir, date),
        })
      end,
      desc = "Toggle Scratch Buffer"
    },
    { "<leader>bS", function() Snacks.picker.files({ cwd = os.getenv("NOTES") }) end, desc = "Select Scratch Buffer" },
  },

  init = function()
    vim.g.autoformat = true -- Sets up the default value to be true

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>ul")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ut")
        Snacks.toggle.indent():map("<leader>ui")
        Snacks.toggle.dim():map("<leader>ud")

        Snacks.toggle
            .new({
              id = "Copilot",
              name = "Copilot",
              get = function()
                local client = vim.lsp.get_active_clients({ name = "copilot" })[1]
                if not client then
                  return false
                end
                return true
              end,
              set = function(val)
                if val then
                  vim.cmd("Copilot enable")
                else
                  vim.cmd("Copilot disable")
                end
              end,
            })
            :map("<leader>uc")

        Snacks.toggle
            .new({
              id = "Format on Save",
              name = "Format on Save",
              get = function()
                return vim.g.autoformat
              end,
              set = function(_)
                vim.g.autoformat = not vim.g.autoformat
              end,
            })
            :map("<leader>uf")
      end,
    })
  end,
}
