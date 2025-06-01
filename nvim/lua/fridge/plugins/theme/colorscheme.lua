return {
  {
    dir = "~/.config/nvim/custom-plugins/theme-loader",
    lazy = false,
    priority = 1000,

    dependencies = {
      {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        opts = {
          integrations = {
            blink_cmp = true,
            gitsigns = true,
            treesitter = true,
            notify = false,
            copilot_vim = true,
            snacks = {
              enabled = false,
              indent_scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
            },
            telescope = {
              enabled = true,
              -- style = "nvchad"
            },
            lsp_trouble = true,
            which_key = true,
            nvim_surround = true,
            render_markdown = true,
            native_lsp = {
              enabled = true,
              virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
                ok = { "italic" },
              },
              underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
                ok = { "underline" },
              },
              inlay_hints = {
                background = true,
              },
            },
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
          },
        }
        -- config = function()
        --   SetupCatppuccin()
        -- end
      },
      {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        opts = {
          overrides = function(colors)
            local theme = colors.theme
            return {
              Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency,,
              PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
              PmenuSbar = { bg = theme.ui.bg_m1 },
              PmenuThumb = { bg = "#C0A36E" },
            }
          end,
          colors = {
            theme = {
              all = {
                ui = {
                  bg_gutter = "none"
                }
              }
            }
          },
        },
      },
      {
        "webhooked/kanso.nvim",
        lazy = true,
      },
      {
        "sainnhe/gruvbox-material",
        lazy = true,
      },
      {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
        opts = {
          variant = "main",
        }
      }
    },
    opts = {
      dark_theme = "kanagawa-wave",
      light_theme = "kanagawa-lotus",
    }
  }
}
