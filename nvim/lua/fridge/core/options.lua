vim.cmd("let g:netrw_liststyle = 3")

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.pumheight = 10

-- tabs & indent
opt.tabstop = 2       -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2    -- 2 spaces for indent width
opt.expandtab = true  -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false

-- search
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if you include mixed caes in your search, assumes you want case sensitive

-- visual
-- opt.background = "dark" -- default to dark theme
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- Decrease update time
opt.updatetime = 250

-- random
opt.backspace = "indent,eol,start"  -- allow backspace on indent, eof or insert start position
opt.clipboard:append("unnamedplus") -- use system clipboard as default

-- split
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Enable spell checking
opt.spelllang = "en_us"
opt.spell = true
