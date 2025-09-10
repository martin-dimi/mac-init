return {
	{
		dir = "~/.config/nvim/custom-plugins/theme-loader",
		lazy = false,
		priority = 1000,

		dependencies = {
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
									bg_gutter = "none",
								},
							},
						},
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
				},
			},
			{
				"sainnhe/everforest",
				lazy = true,
				config = function()
					vim.g.everforest_enable_italic = true
					vim.g.everforest_background = "hard"
					vim.g.everforest_better_performance = 1
				end,
			},
		},
		opts = {
			dark_theme = "kanagawa-wave", -- dragon is very cool
			light_theme = "kanagawa-lotus",
		},
	},
}
