return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "tpope/vim-dotenv", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1

		vim.keymap.set("n", "<leader>du", "<cmd>DBUIToggle<CR>", { desc = "Toggle DBUI" })

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "dbui", "sql", "mysql", "plsql" },
			callback = function() vim.keymap.set("n", "<leader>dw", "<PLUG>(DBUI_SaveQuery)", { desc = "Save Query", buffer = true }) end,
		})
	end,
}
