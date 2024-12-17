return {{ -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = { -- Snippet Engine & its associated nvim-cmp source
    {
        'L3MON4D3/LuaSnip',
        build = (function()
            -- Build Step is needed for regex support in snippets.
            -- This step is not supported in many windows environments.
            -- Remove the below condition to re-enable on windows.
            if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                return
            end
            return 'make install_jsregexp'
        end)(),
        dependencies = {
            -- `friendly-snippets` contains a variety of premade snippets.
            --    See the README about individual language/framework/plugin snippets:
            --    https://github.com/rafamadriz/friendly-snippets
            -- {
            --   'rafamadriz/friendly-snippets',
            --   config = function()
            --     require('luasnip.loaders.from_vscode').lazy_load()
            --   end,
            -- },
        }
    }, 'saadparwaiz1/cmp_luasnip', -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path'},
    config = function()
        -- See `:help cmp`
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        luasnip.config.setup {}

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            -- window = {
            --     completion = cmp.config.window.bordered(),
            --     documentation = cmp.config.window.bordered()
            -- },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered()
                -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                -- col_offset = -3,
                -- side_padding = 0

            },
            -- preselect = cmp.PreselectMode.,
            -- completion = {
            --     completion = cmp.config.window.bordered({
            --         winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None"
            --     }),
            --     completeopt = "menu,menuone,noinsert,noselect"
            -- },

            formatting = {
                fields = {"kind", "abbr", "menu"},
                format = function(entry, vim_item)
                    local kind = require("lspkind").cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50
                    })(entry, vim_item)
                    local strings = vim.split(kind.kind, "%s", {
                        trimempty = true
                    })
                    kind.kind = " " .. (strings[1] or "") .. " "
                    kind.menu = "    (" .. (strings[2] or "") .. ")"

                    return kind
                end
            },
            preselect = cmp.PreselectMode.None,
            mapping = cmp.mapping.preset.insert {

                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<CR>"] = cmp.mapping.confirm({
                    select = true
                }),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                ["<Esc>"] = cmp.mapping.abort(),
                ["<C-Space>"] = cmp.mapping.complete({}),
                ['<C-l>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, {'i', 's'}),
                ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, {'i', 's'})

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            },
            sources = {{
                name = 'lazydev',
                -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                group_index = 0
            }, {
                name = 'nvim_lsp'
            }, {
                name = 'luasnip'
            }, {
                name = 'path'
            }}
        }
    end
}}
-- vim: ts=2 sts=2 sw=2 et
