return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},

	config = function()
		local lint = require("lint")
		local js_like = { "eslint", "biome" }
		lint.linters_by_ft = {
			linters_by_ft = {
				javascript = js_like,
				typescript = js_like,
				javascriptreact = js_like,
				typescriptreact = js_like,
			},
		}

		local lint_augroup = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				require("lint").try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>ll", function()
			require("lint").try_lint()
		end, { desc = "[L]int" })
	end,
}
