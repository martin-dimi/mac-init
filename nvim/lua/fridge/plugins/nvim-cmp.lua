return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
      dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
      },
    },

    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "onsails/lspkind-nvim",
  },
  config = function()
    local luasnip = require("luasnip")
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    local cmp = require("cmp")
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      experimental = {
        ghost_text = false,
      },

      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      mapping = cmp.mapping.preset.insert {
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = cmp.mapping.confirm { select = true },

        -- Scroll the documentation window [b]ack / [f]orward
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- Move left/right of snippet locations.
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'buffer',  group_index = 2 },
        { name = 'nvim_lsp', group_index = 2, entry_filter = function(entry)
          local kind = require('cmp.types').lsp.CompletionItemKind
          return entry:get_kind() ~= kind.Snippet
        end },
        { name = "copilot", group_index = 2, max_item_count = 1 },
        { name = 'path',    group_index = 2 },
        { name = 'luasnip', group_index = 2 },
      },
      formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        expandable_indicator = false,
        format = require("lspkind").cmp_format({
          mode = "symbol",
          max_width = 50,
          symbol_map = { Copilot = "" }
        })
      },
      sorting = {
        priority_weight = 2, -- Increase the influence of priorities
        comparators = {
          require("copilot_cmp.comparators").prioritize,

          -- Below is the default comparitor list and order for nvim-cmp
          cmp.config.compare.offset,
          -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    }
  end,
}
