local M = {}

local git = require("fridge.utils.git")
local path = require("fridge.utils.path")

-- Merge git functions
for k, v in pairs(git) do
	M[k] = v
end

-- Merge path functions
for k, v in pairs(path) do
	M[k] = v
end

return M
