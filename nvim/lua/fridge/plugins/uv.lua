return {
	"benomahony/uv.nvim",
	-- Optional filetype to lazy load when you open a python file
	-- ft = { python }
	-- Optional dependency, but recommended:
	dependencies = {
		"folke/snacks.nvim",
	},
	opts = {
		-- Auto-activate virtual environments when found
		auto_activate_venv = true,
		notify_activate_venv = true,

		-- Auto commands for directory changes
		auto_commands = true,

		-- Integration with snacks picker
		picker_integration = true,
	},
}
