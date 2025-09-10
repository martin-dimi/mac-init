local M = {}

function M.find_up_path(files, startpath) return vim.fs.find(files, { path = startpath, upward = true })[1] end

return M
