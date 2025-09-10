return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")
			-- Run biome instead of biome-check to not do things like organiseImports
			local js_like = { "biome-check", "prettierd", "prettier", stop_after_first = true }

			conform.setup({
				formatters = {
					biome = { require_cwd = true },
					["biome-check"] = { require_cwd = true },
					prettierd = { require_cwd = true },
					prettier = { require_cwd = true },
				},
				formatters_by_ft = {
					-- Run both (sequentially) for golang.
					go = { "gofmt", "goimports" },
					sql = { "sqlfmt" },
					lua = { "stylua" },

					javascript = js_like,
					typescript = js_like,
					javascriptreact = js_like,
					typescriptreact = js_like,
					css = js_like,
					html = js_like,

					markdown = { "prettier" },
					json = js_like,
					yaml = js_like,
				},

				format_on_save = function()
					if vim.g.autoformat then
						return {
							lsp_fallback = true,
							lsp_format = "fallback",
							async = false, -- not recommended to change
							quiet = false, -- not recommended to change
							timeout_ms = 3000,
						}
					else
						return
					end
				end,
			})

			-- JSON Formatter for selected text
			vim.keymap.set("v", "<leader>cj", function()
				-- Save selected text
				local start_pos = vim.fn.getpos("'<")
				local end_pos = vim.fn.getpos("'>")

				-- Get lines in the selection
				local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
				local text = table.concat(lines, "\n")

				-- Run JSON formatting
				local json_ok, formatted = pcall(vim.fn.system, { "prettier", "--parser", "json" }, text)

				if json_ok and formatted then
					-- Replace selection with formatted text
					vim.api.nvim_buf_set_lines(0, start_pos[2] - 1, end_pos[2], false, vim.split(formatted, "\n"))
				else
					vim.notify("JSON formatting failed", vim.log.levels.ERROR)
				end
			end, { desc = "Format selected JSON" })
		end,
	},
}
