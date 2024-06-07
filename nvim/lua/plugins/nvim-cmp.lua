return {
    'hrsh7th/nvim-cmp',
    dependencies = {'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-nvim-lsp',
                    'rafamadriz/friendly-snippets', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline',
                    'hrsh7th/cmp-calc', 'hrsh7th/cmp-emoji', 'hrsh7th/cmp-nvim-lsp-signature-help', {
        "Saecki/crates.nvim",
        event = {"BufRead Cargo.toml"},
        opts = {
            completion = {
                cmp = {
                    enabled = true
                }
            }
        }
    }},
    event = 'InsertEnter',
    config = function()
        local cmp = require('cmp')
        local lspkind = require('lspkind')
        local luasnip = require('luasnip')
        local cmp_select_opts = {
            behavior = cmp.SelectBehavior.Select
        }

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            preselect = cmp.PreselectMode.None,
            completion = {
                completion = cmp.config.window.bordered({
                    winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None"
                }),
                completeopt = 'menu,menuone,noinsert,noselect'
            },
            mapping = {
                -- ['<CR>'] = cmp.mapping.confirm({
                --     select = false,
                --     behavior = cmp.ConfirmBehavior.Insert
                -- }),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<Up>'] = cmp.mapping.select_prev_item(cmp_select_opts),
                ['<Down>'] = cmp.mapping.select_next_item(cmp_select_opts),
                ['<C-y>'] = cmp.mapping.complete {},
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = LazyVim.cmp.confirm(),
                ["<S-CR>"] = LazyVim.cmp.confirm({
                    behavior = cmp.ConfirmBehavior.Replace
                }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<C-CR>"] = function(fallback)
                    cmp.abort()
                    fallback()
                end,
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, {'i', 's'}),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {'i', 's'})

            },
            sources = cmp.config.sources({{
                name = 'nvim_lsp',
                entry_filter = function(entry, ctx)
                    return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
                end
            }, {
                name = 'luasnip'
            }}, {
                {
                    name = 'buffer'
                },
                {
                    name = 'path'
                },
                {
                    name = "crates"
                },
                sources = {{
                    name = 'nvim_lsp_signature_help'
                }}
            }),
            formatting = {
                format = function(_, item)
                    local icons = require("lazyvim.config").icons.kinds
                    if icons[item.kind] then
                        item.kind = icons[item.kind] .. item.kind
                    end
                    return item
                end
            },
            window = {
                documentation = {
                    border = "rounded"
                    -- winhighlight = "Normal:CmpNormal"
                },
                completion = cmp.config.window.bordered()
            }

            -- -- disable completion in comments
            -- enabled = function()
            --   local context = require('cmp.config.context')
            --
            --   -- keep command mode completion enabled when cursor is in a comment
            --   if vim.api.nvim_get_mode().mode == 'c' then
            --     return true
            --   else
            --     return not context.in_treesitter_capture('comment') and not context.in_syntax_group('Comment')
            --   end
            -- end,
        })
        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({'/', '?'}, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {{
                name = 'buffer'
            }}
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({{
                name = 'path'
            }}, {{
                name = 'cmdline'
            }})
        })

        vim.api.nvim_create_autocmd('ModeChanged', {
            pattern = '*',
            callback = function()
                if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i') and
                    require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()] and
                    not require('luasnip').session.jump_active then
                    require('luasnip').unlink_current()
                end
            end
        })
    end
}

-- return {{
--     "hrsh7th/nvim-cmp",
--     opts = {
--         window = {
--             documentation = {
--                 border = "rounded",
--                 winhighlight = "Normal:CmpNormal"
--             },
--             completion = {
--                 border = "rounded",
--                 winhighlight = "Normal:CmpNormal"
--             }
--         }
--     }
-- }}
