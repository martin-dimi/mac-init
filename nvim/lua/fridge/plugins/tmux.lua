return {
  'mrjones2014/smart-splits.nvim',
  lazy = false,
  config = function()
    local splits = require('smart-splits')
    splits.setup()

    vim.keymap.set('n', '<C-h>', splits.move_cursor_left)
    vim.keymap.set('n', '<C-j>', splits.move_cursor_down)
    vim.keymap.set('n', '<C-k>', splits.move_cursor_up)
    vim.keymap.set('n', '<C-l>', splits.move_cursor_right)
    vim.keymap.set('n', '<C-\\>', splits.move_cursor_previous)
  end
}
