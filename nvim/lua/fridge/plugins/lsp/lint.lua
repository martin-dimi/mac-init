return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },

  opts = {
    -- Event to trigger linters
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      python = { "ruff" },
      -- Use the "*" filetype to run linters on all filetypes.
      -- ['*'] = { 'global linter' },
      -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
      -- ['_'] = { 'fallback linter' },
      -- ["*"] = { "typos" },
    },
    -- LazyVim extension to easily override linter options
    -- or add custom linters.
    ---@type table<string,table>
    linters = {
      eslint_d = {
        condition = function(ctx)
          return vim.fs.find({ ".eslintrc.js" }, { path = ctx.filename, upward = true })[1]
        end,
      },
    },
  },
  config = function(_, opts)
    local M = {}

    local lint = require("lint")
    for name, linter in pairs(opts.linters) do
      if type(linter) == "table" and type(lint.linters[name]) == "table" then
        lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
        if type(linter.prepend_args) == "table" then
          lint.linters[name].args = lint.linters[name].args or {}
          vim.list_extend(lint.linters[name].args, linter.prepend_args)
        end
      else
        lint.linters[name] = linter
      end
    end
    lint.linters_by_ft = opts.linters_by_ft

    function M.debounce(ms, fn)
      local timer = vim.uv.new_timer()
      return function(...)
        local argv = { ... }
        timer:start(ms, 0, function()
          timer:stop()
          vim.schedule_wrap(fn)(unpack(argv))
        end)
      end
    end

    function M.lint()
      -- Use nvim-lint's logic first:
      -- * checks if linters exist for the full filetype first
      -- * otherwise will split filetype by "." and add all those linters
      -- * this differs from conform.nvim which only uses the first filetype that has a formatter
      local names = lint._resolve_linter_by_ft(vim.bo.filetype)

      -- Create a copy of the names table to avoid modifying the original.
      names = vim.list_extend({}, names)

      -- Add fallback linters.
      if #names == 0 then
        vim.list_extend(names, lint.linters_by_ft["_"] or {})
      end

      -- Add global linters.
      vim.list_extend(names, lint.linters_by_ft["*"] or {})

      -- Filter out linters that don't exist or don't match the condition.
      local ctx = { filename = vim.api.nvim_buf_get_name(0) }
      ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
      names = vim.tbl_filter(function(name)
        local linter = lint.linters[name]
        if not linter then
          vim.notify("Linter not found: " .. name, vim.log.levels.WARN, { title = "nvim-lint" })
        end
        return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
      end, names)

      -- Run linters.
      if #names > 0 then
        lint.try_lint(names)
      end
    end

    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = M.debounce(100, M.lint),
    })
  end,
}


--   {
--   "mfussenegger/nvim-lint",
--   event = {
--     "BufReadPre",
--     "BufNewFile",
--   },
--   config = function()
--     local lint = require("lint");
--
--     lint.linters_by_ft = {
--       javascript = { "eslint_d" },
--       typescript = { "eslint_d" },
--       javascriptreact = { "eslint_d" },
--       typescriptreact = { "eslint_d" },
--       python = { "ruff" },
--     }
--
--     local function find_nearest_node_modules_dir()
--       -- current buffer dir
--       local current_dir = vim.fn.expand('%:p:h')
--       while current_dir ~= "/" do
--         if vim.fn.isdirectory(current_dir .. "/node_modules") == 1 then
--           return current_dir
--         end
--         current_dir = vim.fn.fnamemodify(current_dir, ":h")
--       end
--       return nil
--     end
--
--     local function debounce(ms, fn)
--       ---@diagnostic disable-next-line: undefined-field
--       local timer = vim.uv.new_timer()
--       return function(...)
--         local argv = { ... }
--         timer:start(ms, 0, function()
--           timer:stop()
--           vim.schedule_wrap(fn)(unpack(argv))
--         end)
--       end
--     end
--
--
--     local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
--     vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
--       group = lint_augroup,
--       callback = debounce(100, function()
--         lint.try_lint()
--       end),
--     })
--
--
--
--     -- Toggle linting
--     vim.keymap.set("n", "<leader>ue", function()
--       if lint.is_linting() then
--         lint.stop()
--         vim.notify("Linting stopped", vim.log.levels.INFO)
--       else
--         lint.try_lint()
--         vim.notify("Linting started", vim.log.levels.INFO)
--       end
--     end, { desc = "Toggle linting" })
--
--
--     -- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
--     -- vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
--     --   group = lint_augroup,
--     --   callback = debounce(100, function()
--     --     local ft = vim.bo.filetype
--     --     local js_types = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
--     --     if not vim.tbl_contains(js_types, ft) then
--     --       lint.try_lint()
--     --       return
--     --     end
--     --     local original_cwd = vim.fn.getcwd()
--     --     local node_modules_dir = find_nearest_node_modules_dir()
--     --     if node_modules_dir then
--     --       vim.cmd("cd " .. node_modules_dir)
--     --     end
--     --     lint.try_lint()
--     --     vim.cmd("cd " .. original_cwd)
--     --   end),
--     -- })
--   end
-- }
