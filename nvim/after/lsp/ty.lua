-- ty LSP for Python (nvim 0.11+)
--
-- TODO: Once ty is available in Mason:
--   1. Delete this file
--   2. Remove vim.lsp.enable("ty") from lua/fridge/plugins/lsp/lsp.lua
--   3. Add "ty" to ensure_installed in lsp.lua

return {
  cmd = { "ty", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", ".git" },
}
