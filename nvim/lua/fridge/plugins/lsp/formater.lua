return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          -- Run both (sequentially) for golang.
          go = { "gofmt", "goimports", "sort-imports" },
          sql = { "sqlfmt" },
          lua = { "stylua" },

          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          javascriptreact = { "prettierd", "prettier", stop_after_first = true },
          typescriptreact = { "prettierd", "prettier", stop_after_first = true },
          css = { "prettierd", "prettier", stop_after_first = true },
          html = { "prettierd", "prettier", stop_after_first = true },

          markdown = { "prettier" },
          json = { "prettierd", "prettier", stop_after_first = true },
          yaml = { "prettierd", "prettier", stop_after_first = true },

          python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        },

        format_on_save = function()
          if vim.g.autoformat then
            return {
              lsp_fallback = true,
              lsp_format = "fallback",
              async = false, -- not recommended to change
              quiet = false, -- not recommended to change
              timeout_ms = 3000,
            }
          else
            return
          end
        end,
      })

      -- JSON Formatter for selected text
      vim.keymap.set("v", "<leader>cj", function()
        -- Save selected text
        local start_pos = vim.fn.getpos("'<")
        local end_pos = vim.fn.getpos("'>")

        -- Get lines in the selection
        local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
        local text = table.concat(lines, "\n")

        -- Run JSON formatting
        local json_ok, formatted = pcall(vim.fn.system, { "prettier", "--parser", "json" }, text)

        if json_ok and formatted then
          -- Replace selection with formatted text
          vim.api.nvim_buf_set_lines(0, start_pos[2] - 1, end_pos[2], false, vim.split(formatted, "\n"))
        else
          vim.notify("JSON formatting failed", vim.log.levels.ERROR)
        end
      end, { desc = "Format selected JSON" })
    end,
  },
}
