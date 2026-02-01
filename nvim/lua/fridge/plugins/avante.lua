return {
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			{ "folke/snacks.nvim" },
		},
		config = function()
			vim.g.opencode_opts = {
				-- Your configuration, if any — see `lua/opencode/config.lua`
			}

			-- Required for `opts.auto_reload`
			vim.opt.autoread = true

			-- Recommended keymaps
			vim.keymap.set("n", "<leader>ot", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
			vim.keymap.set("n", "<leader>oA", function() require("opencode").ask() end, { desc = "Ask opencode" })
			vim.keymap.set("n", "<leader>oa", function() require("opencode").ask("@cursor: ") end, { desc = "Ask opencode about this" })
			vim.keymap.set("v", "<leader>oa", function() require("opencode").ask("@selection: ") end, { desc = "Ask opencode about selection" })
			vim.keymap.set("n", "<leader>on", function() require("opencode").command("session_new") end, { desc = "New opencode session" })
			vim.keymap.set("n", "<leader>oy", function() require("opencode").command("messages_copy") end, { desc = "Copy last opencode response" })
			vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("messages_half_page_up") end, { desc = "Messages half page up" })
			vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("messages_half_page_down") end, { desc = "Messages half page down" })
			vim.keymap.set({ "n", "v" }, "<leader>os", function() require("opencode").select() end, { desc = "Select opencode prompt" })

			-- Example: keymap for custom prompt
			vim.keymap.set("n", "<leader>oe", function() require("opencode").prompt("Explain @cursor and its context") end, { desc = "Explain this code" })
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
