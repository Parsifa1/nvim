local custom = require "custom"

return {
    "saghen/blink.cmp",
    event = { "CursorHold", "CursorHoldI", "User AfterLoad" },
    build = "cargo build --release",

    opts = {
        snippets = {
            expand = function(snippet)
                require("luasnip").lsp_expand(snippet)
            end,
            active = function(filter)
                if filter and filter.direction then
                    return require("luasnip").expand_or_locally_jumpable()
                end
                return require("luasnip").in_snippet()
            end,
            jump = function(direction)
                require("luasnip").jump(direction)
            end,
        },
        completion = {
            trigger = {
                show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" },
            },
            menu = {
                border = "rounded",
                winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None",
                draw = {
                    treesitter = true,
                    columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "provider" } },
                    components = {
                        provider = {
                            text = function(ctx)
                                if ctx.item.source_name == "Luasnip" then
                                    return "[SNI]"
                                else
                                    return "[" .. ctx.item.source_name:sub(1, 3):upper() .. "]"
                                end
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
        signature = {
            enabled = true,
            window = {
                border = "rounded",
            },
        },
        sources = {
            default = { "lsp", "path", "luasnip", "buffer", "lazydev" },
            providers = {
                lazydev = {
                    name = "Development",
                    module = "lazydev.integrations.blink",
                },
                luasnip = {
                    name = "Luasnip",
                    module = "blink.cmp.sources.luasnip",
                    score_offset = 0,
                },
            },
        },
        keymap = {
            ["<C-w>"] = { "show", "hide", "show_documentation", "hide_documentation" },
            ["<CR>"] = { "accept", "fallback" },

            ["<Tab>"] = {
                function(cmp)
                    if cmp.snippet_active() then
                        cmp.hide()
                        return cmp.snippet_forward()
                    else
                        return cmp.select_next()
                    end
                end,
                "fallback",
            },
            ["<S-Tab>"] = {
                function(cmp)
                    if cmp.snippet_active() then
                        cmp.hide()
                        return cmp.snippet_backward()
                    else
                        return cmp.select_prev()
                    end
                end,
                "fallback",
            },
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
