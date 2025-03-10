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

local opts = {
    completion = {
        list = {
            selection = {
                preselect = function(ctx)
                    return ctx.mode ~= "cmdline"
                end,
                auto_insert = function(ctx)
                    return ctx.mode == "cmdline"
                end,
            },
        },
        menu = {
            border = "single",
            winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None",
            scrollbar = false,
            draw = {
                treesitter = { "lsp" },
                columns = function(ctx)
                    return ctx.mode == "cmdline" and { { "kind_icon" }, { "label" } }
                        or { { "kind_icon" }, { "label", gap = 1 }, { "provider" } }
                end,
                components = {
                    label = {
                        -- intergrate with colorful-menu
                        text = function(ctx)
                            return require("colorful-menu").blink_components_text(ctx)
                        end,
                        width = {
                            max = function(ctx)
                                return ctx.mode == "cmdline" and 22 or 60
                            end,
                        },
                        highlight = function(ctx)
                            return require("colorful-menu").blink_components_highlight(ctx)
                        end,
                    },
                    provider = {
                        text = function(ctx)
                            return "[" .. ctx.item.source_name:sub(1, 3):upper() .. "]"
                        end,
                        highlight = "Fg",
                    },
                },
            },
        },
        trigger = {
            show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" },
        },
        documentation = {
            auto_show = true,
            window = {
                border = "single",
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
        default = function()
            local success, node = pcall(vim.treesitter.get_node)
            if vim.bo.filetype == "lua" then
                return { "lsp", "path" }
            elseif
                success
                and node
                and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
            then
                return { "buffer" }
            else
                return { "lsp", "path", "snippets", "buffer" }
            end
        end,
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
        ["<C-CR>"] = { "fallback" },
        ["<Tab>"] = super_tab "forward",
        ["<S-Tab>"] = super_tab "backward",
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },

        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },
    cmdline = {
        completion = {
            menu = {
                auto_show = function()
                    return vim.fn.getcmdtype() == ":"
                end,
            },
            list = {
                selection = {
                    preselect = false,
                },
            },
        },
        keymap = {
            ["<CR>"] = {
                function(cmp)
                    return cmp.accept {
                        callback = function()
                            vim.api.nvim_feedkeys("\n", "n", true)
                        end,
                    }
                end,
                "fallback",
            },
            ["C-f"] = { "accept", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
        },
    },
    appearance = {
        use_nvim_cmp_as_default = true,
        -- nerd_font_variant = "mono",
        kind_icons = custom.icons.kind,
    },
    signature = {
        enabled = true,
        window = { border = "single" },
    },
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
    fuzzy = {
        prebuilt_binaries = {
            ignore_version_mismatch = true,
        },
    },
}

return {
    "Saghen/blink.cmp",
    dependencies = { "xzbdmw/colorful-menu.nvim" },
    event = { "CursorHold", "CursorHoldI", "CmdlineEnter", "User AfterLoad" },
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = opts,
    opts_extend = { "sources.completion.enabled_providers" },
}
