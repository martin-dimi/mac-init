local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config, theme)
  local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
  tabline.setup({
    options = {
      theme = theme,
      theme_overrides = {
        normal_mode = {
          b = { fg = theme.ansi[5], bg = theme.ansi[1] },
          c = { fg = theme.foreground, bg = theme.background },
        },
        tab = {
          active = {
            fg = theme.foreground, -- text
            bg = theme.ansi[6],    -- base
          },
          inactive = {
            fg = theme.foreground, -- text
            bg = theme.background, -- mantle
          },
        },
      },
    },
    sections = {
      tabline_a = {},
      tabline_b = { 'workspace' },
      tabline_c = { ' ' },
      tab_active = {
        'index',
        { 'cwd', padding = { left = 0, right = 1 } },
      },
      tab_inactive = {
        'index',
        { 'cwd', padding = { left = 0, right = 1 } },
      },
      tabline_x = { 'ram', 'cpu' },
      tabline_y = { 'datetime', 'battery' },
      tabline_z = {},
    }
  })
  tabline.apply_to_config(config)
end

return module
