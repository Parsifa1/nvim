local custom = require "custom"

return {
    "saghen/blink.cmp",
    event = { "CursorHold", "CursorHoldI", "User AfterLoad" },
    build = "cargo build --release",

    opts = {
        completion = {
            trigger = {
                show_in_snippet = false,
                show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" },
            },
            menu = {
                show_in_snippet = false,
                border = "rounded",
                winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None",
                draw = {
                    treesitter = true,
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
            documentation = {
                auto_show = true,
                window = {
                    border = "rounded",
                    scrollbar = false,
                },
            },
            accept = {
                auto_brackets = {
                    enabled = true,
                    kind_resolution = {
                        enabled = true,
                        blocked_filetypes = { "typescriptreact", "javascriptreact", "vue", "rust" },
                    },
                },
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer", "lazydev" },
            providers = {
                lazydev = {
                    name = "Development",
                    module = "lazydev.integrations.blink",
                },
                snippets = {
                    opts = { ignored_filetypes = { "zig" } },
                },
            },
        },
        keymap = {
            ["<C-w>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<CR>"] = { "accept", "fallback" },

            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },

            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
            kind_icons = custom.icons.kind,
        },
    },
    opts_extend = { "sources.completion.enabled_providers" },
}
