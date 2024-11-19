local wezterm = require("wezterm")

-- This is the module table that we will export
local module = {}

function module.apply_to_config(config)
  local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]

  -- Apply your custom Neovim colors
  custom.foreground = "#ebdbb2" -- text
  custom.background = "#1d2021" -- base

  -- Ansi Colors
  custom.ansi = {
    "#1d2021", -- black (base)
    "#ea6962", -- red
    "#a9b665", -- green
    "#d8a657", -- yellow
    "#7daea3", -- blue
    "#d3869b", -- magenta (pink/mauve)
    "#89b482", -- cyan (teal)
    "#ebdbb2", -- white (text)
  }

  -- Bright Ansi Colors
  custom.brights = {
    "#928374", -- bright black (overlay1)
    "#ea6962", -- bright red (red)
    "#a9b665", -- bright green
    "#d8a657", -- bright yellow
    "#7daea3", -- bright blue
    "#d3869b", -- bright magenta
    "#89b482", -- bright cyan
    "#ebdbb2", -- bright white
  }

  -- tab bar colors
  custom.tab_bar.background = "#141617"            -- crust
  custom.tab_bar.inactive_tab.bg_color = "#191b1c" -- mantle
  custom.tab_bar.new_tab.bg_color = "#191b1c"      -- mantle
  custom.tab_bar.active_tab.bg_color = "#1d2021"   -- base

  -- selection colors
  custom.selection_fg = "#1d2021" -- base
  custom.selection_bg = "#ebdbb2" -- text

  config.color_schemes = {
    ["CustomCatppuccin"] = custom,
  }
  config.color_scheme = "CustomCatppuccin"


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
