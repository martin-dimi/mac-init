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

        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

        map("[d", vim.diagnostic.goto_prev, '[D]iagnostics: Go to previous')
        map("]d", vim.diagnostic.goto_next, '[D]iagnostics: Go to next')
        map("K", vim.lsp.buf.hover, '[D]iagnostics: Show documentation')
      end,
    })

    -- Change the Diagnostic symbols in the sign column (gutter)
    vim.diagnostic.config({
      virtual_text = true,
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
