---@diagnostic disable missing-fields
return {
    'hrsh7th/nvim-cmp',
    -- lazy = true,
    dependencies = {
        {'saadparwaiz1/cmp_luasnip'},
        {'onsails/lspkind.nvim'}
    },
    event = 'InsertEnter',
    config = function()
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local luasnip = require("luasnip")
        local cmp = require("cmp")
        local custom = require 'custom'
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {    --圆角提示框
            border = "rounded",
        })
        cmp.setup({
            inlay_hints = { enabled = true },
            window = {
                completion = {
                    border = custom.border,
                    col_offset = -3,
                },
                documentation = {
                    border = custom.border,
                },
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                -- Use <C-b/f> to scroll the docs
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                -- Use <C-k/j> to switch in items
                -- ['<C-k>'] = cmp.mapping.select_prev_item(),
                -- ['<C-j>'] = cmp.mapping.select_next_item(),
                -- Use <CR>(Enter) to confirm selection
                ['<CR>'] = cmp.mapping.confirm({ select = true }),

                -- -- A super tab
                -- -- sourc: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

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

            -- source: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
            formatting = {
                fields = {'kind', 'abbr', 'menu' },

                format = require 'lspkind'.cmp_format {
                    mode = "symbol",
                    maxwidth = 50,
                    menu = {
                        luasnip = "[SNP]",
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[VIM]",
                        buffer = "[BUF]",
                        path = "[PTH]",
                        -- calc = "[CLC]",
                        -- latex_symbols = "[TEX]",
                        -- orgmode = "[ORG]",
                    },
                },
            },
            -- Set source precedence
            sources = cmp.config.sources({
                { name = 'nvim_lsp' }, -- For nvim-lsp
                { name = 'luasnip' },  -- For luasnip user
                { name = 'buffer',
                option = { keyword_length = 5, }
            },   -- For buffer word completion
            { name = 'path' },

        })
    })
end
}
