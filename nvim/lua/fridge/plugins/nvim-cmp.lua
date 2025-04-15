return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "fang2hou/blink-copilot",
    "Kaiser-Yang/blink-cmp-avante",
  },
  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = "super-tab",

      ["<C-k>"] = { 'select_prev', 'fallback_to_mappings' },
      ["<C-j>"] = { 'select_next', 'fallback_to_mappings' },
      ["<C-.>"] = { 'show', 'show_documentation', 'hide_documentation' },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    completion = {
      documentation = { auto_show = false },
      ghost_text = { enabled = true },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "avante", "lsp", "copilot", "path", "snippets", "buffer" },
      providers = {
        copilot = { name = "copilot", module = "blink-copilot", score_offset = 100, async = true, },
        avante = { name = 'Avante', module = 'blink-cmp-avante', opts = {} }
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}


-- return {
--   {
--     "hrsh7th/nvim-cmp",
--     event = "InsertEnter",
--     dependencies = {
--       {
--         "L3MON4D3/LuaSnip",
--         build = "make install_jsregexp",
--         dependencies = {
--           "saadparwaiz1/cmp_luasnip",
--           "rafamadriz/friendly-snippets",
--         },
--       },
--
--       "hrsh7th/cmp-nvim-lsp",
--       "hrsh7th/cmp-path",
--       "onsails/lspkind-nvim",
--     },
--     config = function()
--       local luasnip = require("luasnip")
--       require('luasnip.loaders.from_vscode').lazy_load()
--       luasnip.config.setup {}
--
--       local cmp = require("cmp")
--       cmp.setup {
--         snippet = {
--           expand = function(args)
--             luasnip.lsp_expand(args.body)
--           end,
--         },
--
--         experimental = {
--           ghost_text = false,
--         },
--
--         -- For an understanding of why these mappings were
--         -- chosen, you will need to read `:help ins-completion`
--         --
--         -- No, but seriously. Please read `:help ins-completion`, it is really good!
--         mapping = cmp.mapping.preset.insert {
--           ['<C-j>'] = cmp.mapping.select_next_item(),
--           ['<C-k>'] = cmp.mapping.select_prev_item(),
--           ['<CR>'] = cmp.mapping.confirm { select = true },
--           ['<Tab>'] = cmp.mapping.confirm { select = true },
--
--           -- Scroll the documentation window [b]ack / [f]orward
--           ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--           ['<C-f>'] = cmp.mapping.scroll_docs(4),
--           ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--           ['<C-u>'] = cmp.mapping.scroll_docs(4),
--
--           -- Move left/right of snippet locations.
--           ['<C-l>'] = cmp.mapping(function()
--             if luasnip.expand_or_locally_jumpable() then
--               luasnip.expand_or_jump()
--             end
--           end, { 'i', 's' }),
--           ['<C-h>'] = cmp.mapping(function()
--             if luasnip.locally_jumpable(-1) then
--               luasnip.jump(-1)
--             end
--           end, { 'i', 's' }),
--         },
--         sources = {
--           { name = 'nvim_lsp', group_index = 2, entry_filter = function(entry)
--             local kind = require('cmp.types').lsp.CompletionItemKind
--             return entry:get_kind() ~= kind.Snippet
--           end },
--           { name = 'buffer',  group_index = 2 },
--           { name = 'luasnip', group_index = 2 },
--           { name = "copilot", group_index = 2, max_item_count = 1 },
--           { name = 'path',    group_index = 2 },
--         },
--         formatting = {
--           fields = { 'menu', 'abbr', 'kind' },
--           expandable_indicator = false,
--           format = require("lspkind").cmp_format({
--             mode = "symbol",
--             max_width = 50,
--             symbol_map = { Copilot = "" }
--           })
--         },
--         sorting = {
--           priority_weight = 2, -- Increase the influence of priorities
--           comparators = {
--             require("copilot_cmp.comparators").prioritize,
--
--             -- Below is the default comparitor list and order for nvim-cmp
--             cmp.config.compare.offset,
--             -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
--             cmp.config.compare.exact,
--             cmp.config.compare.score,
--             cmp.config.compare.recently_used,
--             cmp.config.compare.locality,
--             cmp.config.compare.kind,
--             cmp.config.compare.sort_text,
--             cmp.config.compare.length,
--             cmp.config.compare.order,
--           },
--         },
--       }
--     end,
--   }
-- }
