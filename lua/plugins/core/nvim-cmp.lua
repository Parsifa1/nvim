return {
    'hrsh7th/nvim-cmp',
    config = function()
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end
        local luasnip = require("luasnip")
        local cmp = require("cmp")

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {    --圆角提示框
            border = "rounded",
        })
        local kind_icons = {
            Text = "",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰇽",
            Variable = "󰂡",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰅲",
        }

        cmp.setup({
            inlay_hints = { enabled = true },
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                -- Use <C-b/f> to scroll the docs
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                -- Use <C-k/j> to switch in items
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-j>'] = cmp.mapping.select_next_item(),
                -- Use <CR>(Enter) to confirm selection
                -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ['<CR>'] = cmp.mapping.confirm({ select = true }),

                -- -- A super tab
                -- -- sourc: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
                ["<Tab>"] = cmp.mapping(function(fallback)
                    -- Hint: if the completion menu is visible select next one
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }), -- i - insert mode; s - select mode
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),

            -- Let's configure the item's appearance
            -- source: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
            formatting = {
                fields = {'kind', 'abbr', 'menu' },

                -- customize the appearance of the completion menu
                format = function(entry, vim_item)
                    vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
                    -- This concatonates the icons with the name of the item kind
                    vim_item.menu = ({
                        nvim_lsp = '[Lsp]',
                        luasnip = '[Luasnip]',
                        buffer = '[File]',
                        path = '[Path]',
                    })[entry.source.name]
                    return vim_item
                end,
            },
            -- Set source precedence
            sources = cmp.config.sources({
                { name = 'nvim_lsp' }, -- For nvim-lsp
                { name = 'luasnip' },  -- For luasnip user
                { name = 'buffer' },   -- For buffer word completion
                { name = 'path' },     -- For path completion
            })
        })
    end
}
