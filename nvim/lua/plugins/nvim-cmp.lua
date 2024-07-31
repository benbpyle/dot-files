return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "rafamadriz/friendly-snippets",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    {
      "Saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      opts = {
        completion = {
          cmp = {
            enabled = true,
          },
        },
      },
    },
  },
  event = "InsertEnter",
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local luasnip = require("luasnip")
    local cmp_select_opts = {
      behavior = cmp.SelectBehavior.Select,
    }

    cmp.setup({
      -- disable completion in comments
      enabled = function()
        if
          require("cmp.config.context").in_treesitter_capture("comment") == true
          or require("cmp.config.context").in_syntax_group("Comment")
        then
          return false
        else
          return true
        end
      end,
      -- enabled = function()
      --     local in_prompt = vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt'
      --     if in_prompt then -- this will disable cmp in the Telescope window (taken from the default config)
      --         return false
      --     end
      --     local context = require("cmp.config.context")
      --     return not (context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment"))
      -- end,

      sorting = {
        -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,

          -- copied from cmp-under, but I don't think I need the plugin for this.
          -- I might add some more of my own.
          function(entry1, entry2)
            local _, entry1_under = entry1.completion_item.label:find("^_+")
            local _, entry2_under = entry2.completion_item.label:find("^_+")
            entry1_under = entry1_under or 0
            entry2_under = entry2_under or 0
            if entry1_under > entry2_under then
              return false
            elseif entry1_under < entry2_under then
              return true
            end
          end,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },

      -- sorting = {
      --   comparators = {
      --     cmp.config.compare.offset,
      --     cmp.config.compare.exact,
      --     cmp.config.compare.score,
      --     cmp.config.compare.recently_used,
      --     cmp.config.compare.kind,
      --   },
      -- },
      -- snippet = {
      --     expand = function(args)
      --         luasnip.lsp_expand(args.body)
      --     end
      -- },
      preselect = cmp.PreselectMode.None,
      completion = {
        completion = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
        }),
        completeopt = "menu,menuone,noinsert,noselect",
      },

      mapping = cmp.mapping.preset.insert({
        -- Select the [n]ext item
        -- ["<C-n>"] = cmp.mapping.select_next_item(),
        -- -- Select the [p]revious item
        -- ["<C-p>"] = cmp.mapping.select_prev_item(),

        -- Scroll the documentation window [b]ack / [f]orward
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Accept ([y]es) the completion.
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        -- ["<C-y>"] = cmp.mapping.confirm({
        --   select = true,
        -- }),

        -- If you prefer more traditional completion keymaps,
        -- you can uncomment the following lines
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Esc>"] = cmp.mapping.abort(),
        -- Manually trigger a completion from nvim-cmp.
        --  Generally you don't need this, because nvim-cmp will display
        --  completions whenever it has completion options available.
        ["<C-Space>"] = cmp.mapping.complete({}),

        -- Think of <c-l> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      }),
      sources = cmp.config.sources({

        { name = "path" },
        { name = "nvim_lsp", keyword_length = 1 },
        { name = "buffer", keyword_length = 3 },
        { name = "luasnip", keyword_length = 2 },
        -- {
        --   name = "luasnip",
        --   keyword_length = 2,
        -- },
        -- {
        --   name = "path",
        -- }, -- file paths
        -- {
        --   name = "nvim_lsp",
        --   entry_filter = function(entry, ctx)
        --     if entry:get_kind() == 15 then
        --       return false
        --     end
        --     return true
        --   end,
        --   keyword_length = 3,
        -- },
        -- {
        --   name = "nvim_lsp_signature_help",
        -- }, -- display function signatures with current parameter emphasized
        -- {
        --   name = "nvim_lua",
        --   keyword_length = 2,
        -- }, -- complete neovim's Lua runtime API such vim.lsp.*
        -- {
        --   name = "buffer",
        --   keyword_length = 2,
        -- }, -- source current buffer
        -- {
        --   name = "vsnip",
        --   keyword_length = 2,
        -- }, -- nvim-cmp source for vim-vsnip
        -- {
        --   name = "calc",
        -- },
      }),
      formatting = {
        format = function(_, item)
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end
          return item
        end,
      },
      window = {
        documentation = {
          --cmp.config.window.bordered(),
          border = "rounded",
          winhighlight = "Normal:CmpNormal",
        },
        completion = cmp.config.window.bordered(),
      },
    })
    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { {
        name = "buffer",
      } },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ {
        name = "path",
      } }, { {
        name = "cmdline",
      } }),
    })

    -- vim.api.nvim_create_autocmd('ModeChanged', {
    --     pattern = '*',
    --     callback = function()
    --         if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i') and
    --             require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()] and
    --             not require('luasnip').session.jump_active then
    --             require('luasnip').unlink_current()
    --         end
    --     end
    -- })
  end,
}
