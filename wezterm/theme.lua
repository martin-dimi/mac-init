local wezterm = require("wezterm")

-- This is the module table that we will export
local module = {}

function module.apply_to_config(config)
  -- Dark theme (Mocha)
  local mocha = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
  mocha.foreground = "#ebdbb2" -- text
  mocha.background = "#1d2021" -- base
  mocha.ansi = {
    "#1d2021",                 -- black (base)
    "#ea6962",                 -- red
    "#a9b665",                 -- green
    "#d8a657",                 -- yellow
    "#7daea3",                 -- blue
    "#d3869b",                 -- magenta (pink/mauve)
    "#89b482",                 -- cyan (teal)
    "#ebdbb2",                 -- white (text)
  }
  mocha.brights = {
    "#928374", -- bright black (overlay1)
    "#ea6962", -- bright red (red)
    "#a9b665", -- bright green
    "#d8a657", -- bright yellow
    "#7daea3", -- bright blue
    "#d3869b", -- bright magenta
    "#89b482", -- bright cyan
    "#ebdbb2", -- bright white
  }

  -- Mocha tab bar colors
  mocha.tab_bar.background = "#141617"            -- crust
  mocha.tab_bar.inactive_tab.bg_color = "#191b1c" -- mantle
  mocha.tab_bar.new_tab.bg_color = "#191b1c"      -- mantle
  mocha.tab_bar.active_tab.bg_color = "#1d2021"   -- base

  -- Mocha selection colors
  mocha.selection_fg = "#1d2021" -- base
  mocha.selection_bg = "#ebdbb2" -- text

  -- Light theme (Latte)
  local latte = wezterm.color.get_builtin_schemes()["Catppuccin Latte"]
  latte.foreground = "#4c4f69" -- text
  latte.background = "#eff1f5" -- base

  -- Latte ANSI Colors
  latte.ansi = {
    "#bcc0cc", -- black (surface1)
    "#d20f39", -- red
    "#40a02b", -- green
    "#df8e1d", -- yellow
    "#1e66f5", -- blue
    "#ea76cb", -- magenta (pink)
    "#179299", -- cyan (teal)
    "#4c4f69", -- white (text)
  }

  -- Latte Bright Colors
  latte.brights = {
    "#acb0be", -- bright black (surface2)
    "#d20f39", -- bright red
    "#40a02b", -- bright green
    "#df8e1d", -- bright yellow
    "#1e66f5", -- bright blue
    "#ea76cb", -- bright magenta
    "#179299", -- bright cyan
    "#4c4f69", -- bright white
  }

  -- Latte tab bar colors
  latte.tab_bar.background = "#dce0e8"            -- crust
  latte.tab_bar.inactive_tab.bg_color = "#e6e9ef" -- mantle
  latte.tab_bar.new_tab.bg_color = "#e6e9ef"      -- mantle
  latte.tab_bar.active_tab.bg_color = "#eff1f5"   -- base

  -- Latte selection colors
  latte.selection_fg = "#eff1f5" -- base
  latte.selection_bg = "#4c4f69" -- text

  config.color_schemes = {
    ["Catppuccin Mocha Custom"] = mocha,
    ["Catppuccin Latte Custom"] = latte,
  }

  -- Set your default theme here
  config.color_scheme = "Catppuccin Mocha Custom" -- or "Catppuccin Latte Custom"
  -- config.color_scheme = "Catppuccin Latte Custom" -- or "Catppuccin Latte Custom"

  -- local theme = require('rosepine').dawn
  -- config.colors = theme.colors()
  -- config.window_frame = theme.window_frame() -- needed only if using fancy tab bar

  wezterm.plugin.require("https://github.com/nekowinston/wezterm-bar").apply_to_config(config, {
    position = "top",
    max_width = 32,
    dividers = false, -- or "slant_left", "arrows", "rounded", false
    indicator = {
      leader = { enabled = false },
      mode = { enabled = false },
    },
    tabs = {
      numerals = "arabic",        -- or "roman"
      pane_count = "superscript", -- or "subscript", false
      brackets = {
        active = { "", ":" },
        inactive = { "", ":" },
      },
    },
    clock = {           -- note that this overrides the whole set_right_status
      enabled = false,
      format = "%H:%M", -- use https://wezfurlong.org/wezterm/config/lua/wezterm.time/Time/format.html
    },
  })
end

return module
