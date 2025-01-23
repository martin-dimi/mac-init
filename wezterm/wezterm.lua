-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.enable_tab_bar = true
config.use_fancy_tab_bar = true

config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = "RESIZE" -- disable the title bar but keep the border, works with aerospace
config.window_padding = {
  left = 10,
  right = 10,
  top = 8,
  bottom = 8,
}

-- "editor.fontLigatures": "'calt', 'ss01'",
config.font = wezterm.font({
  family = "Cascadia Code",
  harfbuzz_features = {
    "cv02", -- alternative g
    "cv24", -- not equals with slash /=
    -- "cv25", -- .- ligature
    -- "cv26", -- :- ligature
    "cv27", -- [] ligature
    -- "cv30", -- longer bar
    -- "ss01", -- alternative r
    "ss03", -- alternative & ampersand
    "ss05", -- different @ sign
    "ss07", -- =~ !~ ligatures
    "ss09"  -- >>= <<= ||= |= ligatures
  }
})
config.font_size = 14.0


-- Keybdings
config.keys = {
  { key = "d",         mods = "SUPER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = "d",         mods = "SUPER|SHIFT", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
  { key = "w",         mods = "SUPER",       action = wezterm.action { CloseCurrentPane = { confirm = false } } },

  -- Makes history-search using k/j
  { key = "k",         mods = "SUPER",       action = wezterm.action.SendKey { key = 'p', mods = 'CTRL' } },
  { key = "j",         mods = "SUPER",       action = wezterm.action.SendKey { key = 'n', mods = 'CTRL' } },

  -- Makes SUPER + SHIFT + < and SUPER + SHIFT + > move current tab MoveTabRelative=-1
  { key = "<",         mods = "SUPER|SHIFT", action = wezterm.action { MoveTabRelative = -1 } },
  { key = ">",         mods = "SUPER|SHIFT", action = wezterm.action { MoveTabRelative = 1 } },

  -- Make SUPER - h and SUPER - l move cursor back a word or forward a word
  { key = "h",         mods = "SUPER",       action = wezterm.action { SendString = "\x1Bb" } },
  { key = "l",         mods = "SUPER",       action = wezterm.action { SendString = "\x1Bf" } },

  -- Make SUPER - Backspace delete a word
  { key = "Backspace", mods = "SUPER",       action = wezterm.action { SendString = "\x1B\x08" } }
}

-- Setups pane navigation and resizging so it works with vim too
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')
smart_splits.apply_to_config(config, {
  direction_keys = { 'h', 'j', 'k', 'l' },
  modifiers = {
    move = 'CTRL',   -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = 'META', -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
})

local theme = require 'theme'
theme.apply_to_config(config)

-- config.color_scheme = 'Rosé Pine Dawn (Gogh)'
-- config.color_scheme = 'Catppuccin Macchiato'

-- local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
-- bar.apply_to_config(config)

-- and finally, return the configuration to wezterm
return config
