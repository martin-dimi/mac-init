return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "meuter/lualine-so-fancy.nvim",
  },
  lazy = false,

  config = function()
    local lualine = require("lualine")

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = "auto",
        -- globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {
            "alfa-nvim",
            "help",
            "neo-tree",
            "Trouble",
            "spectre_panel",
            "toggleterm",
          },
          winbar = {},
        },
      },

      -- +-------------------------------------------------+
      -- | A | B | C                             X | Y | Z |
      -- +-------------------------------------------------+
      sections = {
        lualine_a = {},
        lualine_b = {
          -- "fancy_branch",
        },
        lualine_c = {
          {
            "filename",
            -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory
            path = 4, -- 2 for full path
            symbols = {
              modified = "  ",
              -- readonly = "  ",
              -- unnamed = "  ",
            },
          },
          { "fancy_diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
          { "fancy_searchcount" },
        },
        lualine_x = {
          "fancy_lsp_servers",
          "filetype"
          -- "fancy_diff",
          -- "progress",
        },
        lualine_y = {},
        lualine_z = {},
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "neo-tree", "lazy" },
    })
  end,
}
