local opts = function()
    local luasnip = require "luasnip"
    local cmp = require "cmp"
    vim.o.pumheight = 15

    cmp.setup {
        inlay_hints = { enabled = true },
        preselect = cmp.PreselectMode.None,
        window = {
            completion = cmp.config.window.bordered { border = "single", scrollbar = false },
            documentation = cmp.config.window.bordered { border = "single", scrollbar = false },
        },
        performance = {
            debounce = 10,
        },
        completion = {
            completeopt = vim.o.completeopt,
        },

        mapping = cmp.mapping.preset.insert {
            ["<CR>"] = cmp.mapping.confirm { select = true },
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { "c" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "c" }),
        },

        --lspkind
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                local kind = require("lspkind").cmp_format { mode = "symbol", maxwidth = 50 } (entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                local menu = {
                    luasnip = "[SNP]",
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[VIM]",
                    buffer = "[BUF]",
                    async_path = "[PTH]",
                    calc = "[CLC]",
                    latex_symbols = "[TEX]",
                    orgmode = "[ORG]",
                }
                kind.kind = (strings[1] or "")
                kind.menu = menu[entry.source.name]
                kind.abbr = string.sub(kind.abbr, 1, 20)
                return kind
            end,
        },
        sorting = {
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,
                cmp.config.compare.recently_used,
                cmp.config.compare.locality,
                cmp.config.compare.kind,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
    }

    -- for cmp-smdline
    cmp.setup.cmdline(":", {
        completion = {
            completeopt = "menu,menuone,noselect",
        },
        sources = cmp.config.sources({
            { name = "async_path" },
        }, {
            { name = "cmdline" },
        }, {
            { name = "cmdline_history" },
        }),
    })
end

return {
    "hrsh7th/nvim-cmp",
    -- enabled = false,
    dependencies = {
        { "FelipeLema/cmp-async-path", url = "https://codeberg.org/FelipeLema/cmp-async-path" },
        "hrsh7th/cmp-cmdline",
        "dmitmel/cmp-cmdline-history",
        "onsails/lspkind.nvim",
    },
    event = { "CursorHold", "CursorHoldI", "User AfterLoad" },
    config = opts,
}
