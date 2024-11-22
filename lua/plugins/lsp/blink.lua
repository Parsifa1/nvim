local custom = require "custom"

return {
    "saghen/blink.cmp",
    event = { "CursorHold", "CursorHoldI", "User AfterLoad" },
    build = "cargo build --release",

    opts = {
        sources = {
            completion = {
                enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev", },
            },
            providers = {
                lsp = {
                    name = "LSP",
                    fallback_for = {
                        "lazydev",
                    },
                },
                lazydev = {
                    name = "Development",
                    module = "lazydev.integrations.blink",
                },
            },
        },
        keymap = {
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<CR>"] = { "accept", "fallback" },

            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },

            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },

            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        },
        windows = {
            autocomplete = {
                border = "rounded",
                winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None",
                draw = {
                    columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "provider" } },
                    components = {
                        provider = {
                            text = function(ctx)
                                return "[" .. ctx.item.source_name:sub(1, 3):upper() .. "]"
                            end,
                        },
                    },
                },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
            update_delay_ms = 0,
            border = "rounded",
            scrollbar = false,
        },
        highlight = {
            use_nvim_cmp_as_default = true,
        },
        nerd_font_variant = "mono",
        kind_icons = custom.icons.kind,
    },
    opts_extend = { "sources.completion.enabled_providers" },
}
