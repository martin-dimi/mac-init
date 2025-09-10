local M = {}

-- Simple function to open current file/selection in GitHub browser
-- If normal mode => open on current line
-- If visual mode => open on selected lines
function M.open_in_github()
	local Job = require("plenary.job")

	-- Get repo root
	local repo_root = Job:new({ command = "git", args = { "rev-parse", "--show-toplevel" } }):sync()[1]
	if not repo_root then return end

	-- Get current branch name (or HEAD SHA if in detached HEAD)
	local branch = Job:new({ command = "git", args = { "rev-parse", "--abbrev-ref", "HEAD" } }):sync()[1]
	if branch == "HEAD" then branch = Job:new({ command = "git", args = { "rev-parse", "HEAD" } }):sync()[1] end

	-- Get GitHub remote URL and transform it
	local remote_url = Job:new({ command = "git", args = { "config", "--get", "remote.origin.url" } }):sync()[1]
	if not remote_url then return end

	-- Convert SSH to HTTPS if needed
	local github_url = remote_url:gsub("git@github.com:", "https://github.com/")
	github_url = github_url:gsub("%.git$", "")

	-- Get current file and relative path
	local filepath = vim.api.nvim_buf_get_name(0)
	local relpath = filepath:gsub(repo_root .. "/", "")

	-- Determine current mode
	local mode = vim.fn.mode()
	local line_range = ""

	if mode == "v" or mode == "V" or mode == "" then
		-- Visual mode: get selected range
		local start_line = vim.fn.line("v")
		local end_line = vim.fn.line(".")
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end
		line_range = string.format("#L%d-L%d", start_line, end_line)
	else
		-- Normal mode: current line
		local line = vim.fn.line(".")
		line_range = "#L" .. line
	end

	local final_url = string.format("%s/blob/%s/%s%s", github_url, branch, relpath, line_range)

	-- Open in default browser (macOS/Linux)
	os.execute(string.format("xdg-open '%s' 2>/dev/null || open '%s'", final_url, final_url))
end

return M
