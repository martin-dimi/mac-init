return {
	"stevearc/oil.nvim",
	-- Optional dependencies
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	},
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,

	opts = {},
	config = function(_, opts)
		require("oil").setup({})

		-- Set up keymaps
		-- --
		-- vim.keymap.set("n", "<leader>.", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
	end,
}
