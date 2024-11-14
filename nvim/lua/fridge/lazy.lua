local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth',               -- Detect tabstop and shiftwidth automatically
  "nvim-lua/plenary.nvim",          -- lua functions that many plugins use
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation

  { import = "fridge.plugins" },
  { import = "fridge.plugins.lsp" }
}, {
  change_detection = {
    notify = false,
  },
  checker = {
    enabled = true,
    notify = false,
  },
})
