return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				help = true,
			},
		},
	},
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for `snacks` provider.
			---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				-- Set port equal to the one in opencode's config.
				port = 10670,
			}

			-- Required for `opts.events.reload`.
			vim.o.autoread = true

			vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
			vim.keymap.set({ "n", "t" }, "<leader>ot", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
		end,
	},

	-- {
	-- 	"yetone/avante.nvim",
	-- 	event = "VeryLazy",
	-- 	version = false, -- Never set this value to "*"! Never!
	-- 	opts = {
	-- 		provider = "mistral",
	-- 		providers = {
	-- 			mistral = {
	-- 				api_key_name = "MISTRAL_API_KEY",
	-- 				endpoint = "https://api.mistral.ai/v1/",
	-- 				model = "mistral-large-latest",
	-- 				extra_request_body = {
	-- 					max_tokens = 4096, -- to avoid using max_completion_tokens
	-- 				},
	-- 				__inherited_from = "openai",
	-- 			},
	-- 			claude = {
	-- 				endpoint = "https://api.anthropic.com",
	-- 				model = "claude-sonnet-4-20250514",
	-- 				extra_request_body = {
	-- 					temperature = 0.75,
	-- 					max_tokens = 20480,
	-- 				},
	-- 			},
	-- 			openai = {
	-- 				endpoint = "https://api.openai.com/v1",
	-- 				model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
	-- 				extra_request_body = {
	-- 					temperature = 0,
	-- 					max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
	-- 				},
	-- 			},
	-- 		},
	-- 		windows = {
	-- 			ask = {
	-- 				floating = false,
	-- 				border = { " ", " ", " ", " ", " ", " ", " ", " " },
	-- 				start_insert = false,
	-- 			},
	-- 		},
	-- 		selector = {
	-- 			provider = "snacks",
	-- 		},
	-- 	},
	-- 	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- 	build = "make",
	-- 	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		--- The below dependencies are optional,
	-- 		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	-- 		"zbirenbaum/copilot.lua", -- for providers='copilot'
	-- 		"folke/snacks.nvim", -- for input provider snacks
	-- 		{
	-- 			-- support for image pasting
	-- 			"HakonHarnes/img-clip.nvim",
	-- 			event = "VeryLazy",
	-- 			opts = {
	-- 				-- recommended settings
	-- 				default = {
	-- 					embed_image_as_base64 = false,
	-- 					prompt_for_file_name = false,
	-- 					drag_and_drop = {
	-- 						insert_mode = true,
	-- 					},
	-- 					-- required for Windows users
	-- 					use_absolute_path = true,
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },
}
