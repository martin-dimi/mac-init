return {
	"nvim-mini/mini.files",
	version = false,
	config = function()
		local files = require("mini.files")

		vim.keymap.set("n", "<leader>.", files.open, { desc = "[E]xplorer" })
	end,
}
