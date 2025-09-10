local HOME = os.getenv("HOME")

local getTheme = function()
	local filename = vim.fn.expand(HOME .. "/.config/wezterm/colorscheme")
	local file = io.open(filename, "r")
	assert(file)
	local theme = file:read("*all")
	file:close()
	return theme
end

local setTheme = function(theme)
	local filename = vim.fn.expand(HOME .. "/.config/wezterm/colorscheme")
	local file = io.open(filename, "w")
	assert(file)
	file:write(theme)
	file:close()
end

local M = {}

M.setup = function(opts)
	opts = opts or {}

	-- If no default theme (like catppuccin-mocha) is set, throw an error
	if not opts.dark_theme then error("No default dark theme specified. Please set opts.dark_theme in theme-loader setup.") end

	if not opts.light_theme then error("No default light theme specified. Please set opts.light_theme in theme-loader setup.") end

	local theme = getTheme()
	if theme == "Light" then
		vim.cmd.colorscheme(opts.light_theme)
	else
		vim.cmd.colorscheme(opts.dark_theme)
	end

	vim.api.nvim_create_autocmd("OptionSet", {
		group = vim.api.nvim_create_augroup("wezterm_background", { clear = true }),
		pattern = "background", -- Listen specifically for changes to the 'background' option
		callback = function()
			if vim.o.background == "light" then
				setTheme("Light")
			else
				setTheme("Dark")
			end
		end,
	})
end

return M
