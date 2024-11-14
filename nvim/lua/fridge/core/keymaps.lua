vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- windows
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split vertically" })
keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split horizontally" })
keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>wq", "<cmd>close<CR>", { desc = "Close window" })

keymap.set("n", "<leader><Tab>", "<C-6>", { desc = "Go to prev buffer" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })

keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- buffers
keymap.set("n", "<leader>bk", "<cmd>bp<BAR>bd#<CR>", { desc = "Kill current buffer without closing window" })
