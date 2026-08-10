return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim" }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup()

		vim.lsp.config("astro", {
			before_init = function(_, config)
				local function has_typescript_sdk(tsdk)
					return vim.iter({ "tsserverlibrary.js", "typescript.js", "tsserver.js" }):any(function(filename) return vim.uv.fs_stat(vim.fs.joinpath(tsdk, filename)) ~= nil end)
				end

				local tsdk = require("lspconfig.util").get_typescript_server_path(config.root_dir)
				if not has_typescript_sdk(tsdk) then
					local npm_root = vim.fn.systemlist("npm root -g")
					if vim.v.shell_error == 0 and npm_root[1] then tsdk = vim.fs.joinpath(npm_root[1], "typescript", "lib") end
				end

				config.init_options.typescript.tsdk = tsdk
			end,
		})
		vim.lsp.enable("astro")

		vim.lsp.config("tailwindcss", {
			settings = {
				tailwindCSS = {
					classAttributes = {
						"class",
						"className",
						"headerClassName",
						"contentContainerClassName",
						"columnWrapperClassName",
						"endFillColorClassName",
						"imageClassName",
						"tintColorClassName",
						"ios_backgroundColorClassName",
						"thumbColorClassName",
						"trackColorOnClassName",
						"trackColorOffClassName",
						"selectionColorClassName",
						"cursorColorClassName",
						"underlineColorAndroidClassName",
						"placeholderTextColorClassName",
						"selectionHandleColorClassName",
						"colorsClassName",
						"progressBackgroundColorClassName",
						"titleColorClassName",
						"underlayColorClassName",
						"colorClassName",
						"drawerBackgroundColorClassName",
						"statusBarBackgroundColorClassName",
						"backdropColorClassName",
						"backgroundColorClassName",
						"ListFooterComponentClassName",
						"ListHeaderComponentClassName",
					},
					classFunctions = {
						"useResolveClassNames",
					},
				},
			},
		})

		-- TODO: ty LSP for Python (not in mason yet)
		vim.lsp.enable("ty")
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Lua
				"lua_ls",
				"stylua",

				-- Golang
				"gopls",
				"goimports",

				-- Web stuff
				"astro",
				"ts_ls",
				"tailwindcss",
				"html",
				"emmet_ls",
				"cssls",
				"eslint",
				"biome",

				-- Misc
				"jsonls",
				"dockerls",

				-- Python
				"ruff",
				"mypy",
			},
		})

		-- Change the Diagnostic symbols in the sign column (gutter)
		vim.diagnostic.config({
			virtual_text = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = "󰠠 ",
					[vim.diagnostic.severity.HINT] = " ",
				},
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
				end

				local bufnr = ev.buf
				local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
				if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr) then vim.lsp.inline_completion.enable(true, { bufnr = bufnr }) end

				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

				map("[d", vim.diagnostic.goto_prev, "[D]iagnostics: Go to previous")
				map("]d", vim.diagnostic.goto_next, "[D]iagnostics: Go to next")
				map("K", vim.lsp.buf.hover, "[D]iagnostics: Show documentation")
			end,
		})
	end,
}
