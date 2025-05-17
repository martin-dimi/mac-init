return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "saghen/blink.cmp" },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = 'LSP: ' .. desc })
        end

        -- NOTE: To jump back, press <C-t>.
        -- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        -- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        -- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        -- map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        --
        -- map('<leader>D', require('telescope.builtin').diagnostics({ bufnr = 0 }), '[D]iagnostics')
        map("[d", vim.diagnostic.goto_prev, '[D]iagnostics: Go to previous')
        map("]d", vim.diagnostic.goto_next, '[D]iagnostics: Go to next')
        map("K", vim.lsp.buf.hover, '[D]iagnostics: Show documentation')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map("<leader>rs", ":LspRestart<CR>", '[D]iagnostics: Restart LSP')
      end,
    })


    -- Change the Diagnostic symbols in the sign column (gutter)
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.INFO] = "󰠠 ",
          [vim.diagnostic.severity.HINT] = " ",
        }
      }
    })
  end,
}
