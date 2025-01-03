local custom = require "custom"

---@param direction "backward"|"forward"
local super_tab = function(direction)
    local ret = {
        function(cmp)
            local ls = require "luasnip"
            local current_node = ls.session.current_nodes[vim.api.nvim_get_current_buf()]
            if not ls.session or not current_node or ls.session.jump_active then
                return false
            end
            local current_start, current_end = current_node:get_buf_position()
            current_start[1] = current_start[1] + 1 -- (1, 0) indexed
            current_end[1] = current_end[1] + 1 -- (1, 0) indexed
            local cursor = vim.api.nvim_win_get_cursor(0)
            if
                cursor[1] < current_start[1]
                or cursor[1] > current_end[1]
                or cursor[2] < current_start[2]
                or cursor[2] > current_end[2]
            then
                ls.unlink_current()
                return false
            end
            cmp.hide()
            if direction == "backward" then
                return cmp.snippet_backward()
            elseif direction == "forward" then
                return cmp.snippet_forward()
            end
        end,
        "select_next",
        "fallback",
    }
    if direction == "backward" then
        ret[2] = "select_prev"
    end
    return ret
end

return {
    "saghen/blink.cmp",
    event = { "CursorHold", "CursorHoldI", "User AfterLoad" },
    version = "*",
    -- build = "cargo build --release",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        snippets = {
            expand = function(snippet)
                require("luasnip").lsp_expand(snippet)
            end,
            active = function(filter)
                if filter and filter.direction then
                    return require("luasnip").locally_jumpable()
                end
                return require("luasnip").in_snippet()
            end,
            jump = function(direction)
                require("luasnip").jump(direction)
            end,
        },
        completion = {
            list = {
                selection = function(ctx)
                    return ctx.mode == "cmdline" and "auto_insert" or "preselect"
                end,
            },
            trigger = {
                show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" },
            },
            menu = {
                border = "rounded",
                winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None",
                draw = {
                    treesitter = { "lsp" },
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
            },
        },
        keymap = {
            ["<C-w>"] = { "show", "hide", "show_documentation", "hide_documentation" },
            ["<CR>"] = { "accept", "fallback" },
            ["<Tab>"] = super_tab "forward",
            ["<S-Tab>"] = super_tab "backward",
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },

            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            cmdline = {
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
            },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
            kind_icons = custom.icons.kind,
        },
    },
    opts_extend = { "sources.completion.enabled_providers" },
}
