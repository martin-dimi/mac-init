return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim',  build = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons',               enabled = vim.g.have_nerd_font },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      pickers = {
        find_files = {
          theme = "ivy",
          file_ignore_patterns = { ".*_test.go" }
        },
        grep_string = { theme = "ivy" },
        live_grep = {
          theme = "ivy",
          file_ignore_patterns = { ".*_test.go" }
        },
        diagnostics = { theme = "ivy" },
        colorscheme = {
          enable_preview = true
        },
      },

      defaults = {
        path_display = { "truncate" },
        hidden = true,
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            -- ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ['<C-d>'] = require('telescope.actions').delete_buffer
          },
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')
    pcall(telescope.load_extension, 'file_browser')

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    -- Search
    -- local builtins = require('telescope.builtin')
    -- keymap.set('n', '<leader>sh', builtins.help_tags, { desc = '[S]earch [H]elp' })
    -- keymap.set('n', '<leader>sk', builtins.keymaps, { desc = '[S]earch [K]eymaps' })
    -- keymap.set('n', '<leader>sf', builtins.find_files, { desc = '[S]earch [F]iles' })
    -- keymap.set('n', '<leader>sw', builtins.grep_string, { desc = '[S]earch current [W]ord' })
    -- keymap.set('n', '<leader>sg', builtins.live_grep, { desc = '[S]earch by [G]rep' })
    -- keymap.set('n', '<leader>sd', builtins.diagnostics, { desc = '[S]earch [D]iagnostics' })
    -- keymap.set('n', '<leader>sr', builtins.resume, { desc = '[S]earch [R]esume' })
    -- keymap.set('n', '<leader>st', builtins.colorscheme, { desc = '[S]earch [T]heme' })
    --
    -- -- Git
    -- keymap.set('n', '<leader>gb', builtins.git_branches, { desc = '[G]it [B]ranches' })
    -- keymap.set('n', '<leader>gl', builtins.git_commits, { desc = '[G]it [L]og' })
    -- keymap.set('n', '<leader>gs', builtins.git_status, { desc = '[G]it [S]tatus' })


    -- keymap.set('n', '<leader><leader>', function()
    --   builtins.buffers({ sort_mru = true, ignore_current_buffer = true })
    -- end, { desc = 'Find existing buffers' })

    -- keymap.set(
    --   'n',
    --   '<leader>.',
    --   "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
    --   { desc = 'Search Recent Files' }
    -- )

    -- Copy current file path relative to project root
    keymap.set('n', '<leader>fY', function()
      -- Get the current buffer's file path
      local current_file = vim.fn.expand('%:p')
      -- Get the relative path
      local relative_path = vim.fn.fnamemodify(current_file, ':.')
      -- Copy to clipboard
      vim.fn.setreg('+', relative_path)
      -- Notify user
      vim.notify('Copied: ' .. relative_path, vim.log.levels.INFO)
    end, { desc = 'Copy File Path' })
  end,
}
