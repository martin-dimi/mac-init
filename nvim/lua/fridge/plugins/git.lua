return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			})

			vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview" })
		end,
	},
	{
		"FabijanZulj/blame.nvim",
		config = function()
			local blame = require("blame")
			blame.setup({})

			vim.keymap.set("n", "<leader>gB", "<cmd>BlameToggle<CR>", { desc = "Toggle blame" })
		end,
	},
}
