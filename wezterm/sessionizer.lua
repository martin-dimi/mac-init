local wezterm = require("wezterm")
local module = {}
local sessionizer = wezterm.plugin.require "https://github.com/mikkasendke/sessionizer.wezterm"

function module.apply_to_config(config)
  sessionizer.apply_to_config(config, true)
  sessionizer.config = {
    show_most_recent = false,
    paths = {
      "/Users/fridge/Projects",
    },
    command_options = {
      fd_path = "/opt/homebrew/bin/fd"
    }
  }

  local function addKey(bind)
    table.insert(config.keys, bind)
  end

  config.keys = config.keys or {}
  addKey({ mods = "CTRL", key = "s", action = sessionizer.show })
  addKey({ mods = "CTRL", key = "a", action = sessionizer.show_active })
  addKey({ mods = "CTRL", key = "m", action = sessionizer.switch_to_most_recent })
end

return module
