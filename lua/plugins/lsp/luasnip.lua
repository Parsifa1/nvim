---@diagnostic disable: assign-type-mismatch
return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "nvim-treesitter/nvim-treesitter",
            "TwIStOy/luasnip-snippets",
        },
        init = function()
            local ls = require "luasnip"
            vim.api.nvim_create_autocmd("CursorMovedI", {
                pattern = "*",
                callback = function(ev)
                    if not ls.session or not ls.session.current_nodes[ev.buf] or ls.session.jump_active then
                        return
                    end

                    local current_node = ls.session.current_nodes[ev.buf]
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
                    end
                end,
            })
        end,
        build = (function()
            -- Build Step is needed for regex support in snippets
            -- This step is not supported in many windows environments
            -- Remove the below condition to re-enable on windows
            if vim.fn.has "win32" == 1 then
                return
            end
            return "make install_jsregexp"
        end)(),
        event = "User AfterLoad",
        config = function()
            require("luasnip").config.setup { enable_autosnippets = true }
            require("luasnip.loaders.from_lua").lazy_load { paths = vim.fn.stdpath "config" .. "/lua/snippets" }
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    {
        "TwIStOy/luasnip-snippets",
        dependencies = { "L3MON4D3/LuaSnip" },
        opts = {
            disable_auto_expansion = {
                cpp = { "i32", "i64" },
            },
        },
    },
}
