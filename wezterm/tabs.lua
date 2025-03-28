local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config, theme)
  local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
  tabline.setup({
    options = { theme = theme },
    sections = {
      tabline_a = {},
      tabline_b = { 'workspace' },
      tabline_c = { ' ' },
      tab_active = {
        'index',
        { 'cwd',    padding = { left = 0, right = 1 } },
        { 'zoomed', padding = 0 },
      },
      tab_inactive = { 'index', { 'process', padding = { left = 0, right = 1 } } },
      tabline_x = { 'ram', 'cpu' },
      tabline_y = { 'datetime', 'battery' },
      tabline_z = {},
    }
  })
  tabline.apply_to_config(config)
end

return module

-- config.enable_tab_bar = true
-- config.use_fancy_tab_bar = true
-- -- config.color_scheme = "Catppuccin Mocha Custom"
--
-- local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
-- bar.apply_to_config(config, {
--   separator = {
--     space = 1,
--     left_icon = "",
--     right_icon = "",
--     field_icon = "",
--   },
--   modules = {
--     spotify = { enabled = false },
--     workspace = { enabled = true },
--     leader = { enabled = false },
--     pane = { enabled = false },
--     username = { enabled = false },
--     hostname = { enabled = false },
--     clock = { enabled = true },
--     cwd = { enabled = true },
--   },
-- })
