---@diagnostic disable: assign-type-mismatch
return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "nvim-treesitter/nvim-treesitter",
            "TwIStOy/luasnip-snippets",
        },
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
