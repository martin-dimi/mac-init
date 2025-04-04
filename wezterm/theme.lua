local wezterm = require("wezterm")

-- This is the module table that we will export
local module = {}

function Dark()
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

  -- selection colors
  mocha.selection_fg = "#1d2021" -- base
  mocha.selection_bg = "#ebdbb2" -- text

  -- tab bar colors
  mocha.tab_bar.active_tab = {
    fg_color = "#ebdbb2", -- your light text color
    bg_color = "#b15c31", -- copper orange
  }
  mocha.tab_bar.inactive_tab = {
    fg_color = mocha.foreground, -- text
    bg_color = mocha.background, -- mantle
  }

  return mocha
end

function Light()
  local latte = wezterm.color.get_builtin_schemes()["Catppuccin Latte"]
  latte.foreground = "#4c4f69" -- text
  latte.background = "#eff1f5" -- base
  latte.cursor_fg = 'white'
  latte.cursor_bg = '#1e66f5'
  latte.cursor_border = '#1e66f5'

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

  -- selection colors
  latte.selection_fg = "#eff1f5" -- base
  latte.selection_bg = "#4c4f69" -- text

  -- tab bar colors
  latte.tab_bar.active_tab = {
    fg_color = latte.ansi[5], -- text
    bg_color = latte.ansi[1], -- base
  }
  latte.tab_bar.inactive_tab = {
    fg_color = latte.foreground, -- text
    bg_color = latte.background, -- mantle
  }


  return latte
end

function module.apply_to_config(config)
  local dark = Dark()
  local light = Light()

  local theme = dark
  config.color_schemes = {
    ["Light"] = light,
    ["Dark"] = dark,
  }
  local file = io.open("/Users/fridge/.config/wezterm/colorscheme", "r")
  if file then
    local theme_name = file:read("*a")
    print("Using colorscheme: " .. theme_name)
    config.color_scheme = theme_name
    theme = config.color_schemes[config.color_scheme]
    file:close()
  else
    print("No colorscheme file found, using default")
    config.color_scheme = "Catppuccin Mocha"
  end

  return theme
end

return module
